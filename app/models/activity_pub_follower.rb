require 'json'

class ActivityPubFollower < ApplicationRecord
  belongs_to :user
  validates_presence_of :user
  validates_presence_of :metadata
  validates_uniqueness_of :metadata # doesn't work with json type, hence text

  def inbox
    data = JSON.parse(self.metadata)
    actor = JSON.parse(HTTP.get(data["actor"], headers: {'Accept': 'application/json'}).to_s)
    full_inbox = actor["inbox"]
  end

  def accept_follow_request!
    data = JSON.parse(self.metadata)

    doc = {
      "@context": "https://www.w3.org/ns/activitystreams",
      "type": "Accept",
      "actor": Rails.application.routes.url_helpers.actor_user_url(self),

      "object": {
        "type": data["type"],
        "actor": data["actor"],
      "object": data["object"]        }
    }

    full_inbox = self.inbox
    date = Time.now.utc.httpdate

    signature_header = ActivityPub.sign(
      Rails.application.routes.url_helpers.actor_user_url(self.user),
      URI.parse(full_inbox).path,
      URI.parse(full_inbox).path,
      date,
      ENV['ACTIVITYPUB_PRIVKEY'].to_s
    )

    HTTP.post(full_inbox,
      body: doc.to_json,
      headers: { 'Date': date, 'Signature': signature_header , 'Content-Type': 'application/json'}
    )
  end
end
