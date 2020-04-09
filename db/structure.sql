SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: active_admin_comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_admin_comments (
    id bigint NOT NULL,
    namespace character varying,
    body text,
    resource_type character varying,
    resource_id bigint,
    author_type character varying,
    author_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_admin_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_admin_comments_id_seq OWNED BY public.active_admin_comments.id;


--
-- Name: activity_pub_followers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.activity_pub_followers (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    metadata text NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: admin_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_users (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: collection_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.collection_items (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    collection_id uuid NOT NULL,
    item_id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: collections; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.collections (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name character varying NOT NULL,
    user_id uuid NOT NULL,
    is_public boolean DEFAULT false NOT NULL,
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: decks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.decks (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name character varying,
    user_id uuid NOT NULL,
    is_public boolean DEFAULT false NOT NULL,
    description character varying,
    image_url character varying,
    tags character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: flash_cards; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.flash_cards (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    question text NOT NULL,
    answer text NOT NULL,
    level integer DEFAULT 1 NOT NULL,
    url character varying,
    last_practiced_at timestamp without time zone,
    practice_count integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    next_practice_due_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    user_id uuid NOT NULL,
    deck_id uuid NOT NULL
);


--
-- Name: idea_sets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.idea_sets (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    description text
);


--
-- Name: item_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.item_types (
    id character varying NOT NULL,
    display_name_plural character varying
);


--
-- Name: items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.items (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name character varying NOT NULL,
    item_type_id character varying NOT NULL,
    estimated_time integer,
    time_unit character varying DEFAULT 'minutes'::character varying NOT NULL,
    required_expertise integer,
    idea_set_id uuid NOT NULL,
    user_id uuid NOT NULL,
    year integer,
    image_url character varying,
    inspirational_score integer,
    educational_score integer,
    challenging_score integer,
    entertaining_score integer,
    visual_score integer,
    interactive_score integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    typical_age_range character varying,
    description text,
    metadata json DEFAULT '"{}"'::json NOT NULL
);


--
-- Name: links; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.links (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    url character varying NOT NULL,
    item_id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: people; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.people (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name character varying NOT NULL,
    description text,
    website character varying,
    email character varying,
    twitter character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    metadata json DEFAULT '"{}"'::json NOT NULL,
    goodreads character varying,
    image_url character varying
);


--
-- Name: person_idea_sets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.person_idea_sets (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    person_id uuid NOT NULL,
    idea_set_id uuid NOT NULL,
    role character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: recommendations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.recommendations (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    item_id uuid NOT NULL,
    person_id uuid NOT NULL,
    idea_set_id uuid NOT NULL,
    metadata text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reviews (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    item_id uuid NOT NULL,
    status character varying,
    inspirational_score integer,
    educational_score integer,
    challenging_score integer,
    entertaining_score integer,
    visual_score integer,
    interactive_score integer,
    notes text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    overall_score integer,
    is_posted_on_social_media boolean DEFAULT false
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: topic_idea_sets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.topic_idea_sets (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    topic_id uuid NOT NULL,
    idea_set_id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    rating integer
);


--
-- Name: topic_relations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.topic_relations (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    from_id uuid NOT NULL,
    to_id uuid NOT NULL,
    kind character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: topics; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.topics (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name character varying NOT NULL,
    search_index character varying NOT NULL,
    gitter_room character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    display_name character varying,
    user_id uuid
);


--
-- Name: user_topics; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_topics (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    topic_id uuid NOT NULL,
    action character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    value integer,
    by_user_id uuid
);


--
-- Name: user_user_relations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_user_relations (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    from_user_id uuid NOT NULL,
    to_user_id uuid NOT NULL,
    action character varying DEFAULT 'follow'::character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: user_vouchers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_vouchers (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    user_id bigint NOT NULL,
    voucher_id bigint NOT NULL,
    status character varying NOT NULL,
    expires_at date,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    nickname character varying NOT NULL,
    auth0_uid character varying NOT NULL,
    authinfo text NOT NULL,
    image_url character varying,
    bio character varying,
    description text,
    score integer DEFAULT 100 NOT NULL,
    role character varying DEFAULT 'regular'::character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    random_fav_topic boolean DEFAULT false NOT NULL,
    random_fav_item_types character varying,
    referrer character varying,
    post_reviews_to_twitter boolean DEFAULT false NOT NULL,
    unsubscribe boolean DEFAULT false NOT NULL,
    goodreads_token character varying
);


--
-- Name: vouchers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.vouchers (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    user_id bigint NOT NULL,
    code character varying NOT NULL,
    max_limit integer,
    payment_ref character varying,
    domain character varying,
    price integer,
    period_days integer,
    internal_description character varying,
    status character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: active_admin_comments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_admin_comments ALTER COLUMN id SET DEFAULT nextval('public.active_admin_comments_id_seq'::regclass);


--
-- Name: active_admin_comments active_admin_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_admin_comments
    ADD CONSTRAINT active_admin_comments_pkey PRIMARY KEY (id);


--
-- Name: activity_pub_followers activity_pub_followers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.activity_pub_followers
    ADD CONSTRAINT activity_pub_followers_pkey PRIMARY KEY (id);


--
-- Name: admin_users admin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: collection_items collection_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.collection_items
    ADD CONSTRAINT collection_items_pkey PRIMARY KEY (id);


--
-- Name: collections collections_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.collections
    ADD CONSTRAINT collections_pkey PRIMARY KEY (id);


--
-- Name: decks decks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.decks
    ADD CONSTRAINT decks_pkey PRIMARY KEY (id);


--
-- Name: flash_cards flash_cards_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.flash_cards
    ADD CONSTRAINT flash_cards_pkey PRIMARY KEY (id);


--
-- Name: idea_sets idea_sets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.idea_sets
    ADD CONSTRAINT idea_sets_pkey PRIMARY KEY (id);


--
-- Name: item_types item_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_types
    ADD CONSTRAINT item_types_pkey PRIMARY KEY (id);


--
-- Name: items items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_pkey PRIMARY KEY (id);


--
-- Name: links links_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.links
    ADD CONSTRAINT links_pkey PRIMARY KEY (id);


--
-- Name: people people_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people
    ADD CONSTRAINT people_pkey PRIMARY KEY (id);


--
-- Name: person_idea_sets person_idea_sets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_idea_sets
    ADD CONSTRAINT person_idea_sets_pkey PRIMARY KEY (id);


--
-- Name: recommendations recommendations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recommendations
    ADD CONSTRAINT recommendations_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: topic_idea_sets topic_idea_sets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_idea_sets
    ADD CONSTRAINT topic_idea_sets_pkey PRIMARY KEY (id);


--
-- Name: topic_relations topic_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_relations
    ADD CONSTRAINT topic_relations_pkey PRIMARY KEY (id);


--
-- Name: topics topics_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topics
    ADD CONSTRAINT topics_pkey PRIMARY KEY (id);


--
-- Name: user_topics user_topics_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_topics
    ADD CONSTRAINT user_topics_pkey PRIMARY KEY (id);


--
-- Name: user_user_relations user_user_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_user_relations
    ADD CONSTRAINT user_user_relations_pkey PRIMARY KEY (id);


--
-- Name: user_vouchers user_vouchers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_vouchers
    ADD CONSTRAINT user_vouchers_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: vouchers vouchers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vouchers
    ADD CONSTRAINT vouchers_pkey PRIMARY KEY (id);


--
-- Name: index_active_admin_comments_on_author_type_and_author_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_admin_comments_on_author_type_and_author_id ON public.active_admin_comments USING btree (author_type, author_id);


--
-- Name: index_active_admin_comments_on_namespace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_admin_comments_on_namespace ON public.active_admin_comments USING btree (namespace);


--
-- Name: index_active_admin_comments_on_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_admin_comments_on_resource_type_and_resource_id ON public.active_admin_comments USING btree (resource_type, resource_id);


--
-- Name: index_activity_pub_followers_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_activity_pub_followers_on_user_id ON public.activity_pub_followers USING btree (user_id);


--
-- Name: index_admin_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_admin_users_on_email ON public.admin_users USING btree (email);


--
-- Name: index_admin_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_admin_users_on_reset_password_token ON public.admin_users USING btree (reset_password_token);


--
-- Name: index_collection_items_on_collection_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_collection_items_on_collection_id ON public.collection_items USING btree (collection_id);


--
-- Name: index_collection_items_on_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_collection_items_on_item_id ON public.collection_items USING btree (item_id);


--
-- Name: index_collections_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_collections_on_user_id ON public.collections USING btree (user_id);


--
-- Name: index_decks_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_decks_on_user_id ON public.decks USING btree (user_id);


--
-- Name: index_decks_on_user_id_and_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_decks_on_user_id_and_name ON public.decks USING btree (user_id, name);


--
-- Name: index_flash_cards_on_deck_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_flash_cards_on_deck_id ON public.flash_cards USING btree (deck_id);


--
-- Name: index_items_on_idea_set_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_items_on_idea_set_id ON public.items USING btree (idea_set_id);


--
-- Name: index_items_on_item_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_items_on_item_type_id ON public.items USING btree (item_type_id);


--
-- Name: index_items_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_items_on_user_id ON public.items USING btree (user_id);


--
-- Name: index_links_on_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_links_on_item_id ON public.links USING btree (item_id);


--
-- Name: index_person_idea_sets_on_idea_set_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_person_idea_sets_on_idea_set_id ON public.person_idea_sets USING btree (idea_set_id);


--
-- Name: index_person_idea_sets_on_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_person_idea_sets_on_person_id ON public.person_idea_sets USING btree (person_id);


--
-- Name: index_recommendations_on_idea_set_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_recommendations_on_idea_set_id ON public.recommendations USING btree (idea_set_id);


--
-- Name: index_recommendations_on_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_recommendations_on_item_id ON public.recommendations USING btree (item_id);


--
-- Name: index_recommendations_on_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_recommendations_on_person_id ON public.recommendations USING btree (person_id);


--
-- Name: index_reviews_on_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_reviews_on_item_id ON public.reviews USING btree (item_id);


--
-- Name: index_reviews_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_reviews_on_user_id ON public.reviews USING btree (user_id);


--
-- Name: index_reviews_on_user_id_and_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_reviews_on_user_id_and_item_id ON public.reviews USING btree (user_id, item_id);


--
-- Name: index_topic_idea_sets_on_idea_set_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_topic_idea_sets_on_idea_set_id ON public.topic_idea_sets USING btree (idea_set_id);


--
-- Name: index_topic_idea_sets_on_topic_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_topic_idea_sets_on_topic_id ON public.topic_idea_sets USING btree (topic_id);


--
-- Name: index_topic_idea_sets_on_topic_id_and_idea_set_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_topic_idea_sets_on_topic_id_and_idea_set_id ON public.topic_idea_sets USING btree (topic_id, idea_set_id);


--
-- Name: index_topic_relations_on_from_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_topic_relations_on_from_id ON public.topic_relations USING btree (from_id);


--
-- Name: index_topic_relations_on_to_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_topic_relations_on_to_id ON public.topic_relations USING btree (to_id);


--
-- Name: index_topics_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_topics_on_name ON public.topics USING btree (name);


--
-- Name: index_topics_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_topics_on_user_id ON public.topics USING btree (user_id);


--
-- Name: index_user_topics_on_by_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_topics_on_by_user_id ON public.user_topics USING btree (by_user_id);


--
-- Name: index_user_topics_on_topic_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_topics_on_topic_id ON public.user_topics USING btree (topic_id);


--
-- Name: index_user_topics_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_topics_on_user_id ON public.user_topics USING btree (user_id);


--
-- Name: index_user_topics_on_user_id_and_by_user_id_and_action; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_user_topics_on_user_id_and_by_user_id_and_action ON public.user_topics USING btree (user_id, by_user_id, action);


--
-- Name: index_user_user_relations_on_from_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_user_relations_on_from_user_id ON public.user_user_relations USING btree (from_user_id);


--
-- Name: index_user_user_relations_on_to_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_user_relations_on_to_user_id ON public.user_user_relations USING btree (to_user_id);


--
-- Name: index_user_vouchers_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_vouchers_on_user_id ON public.user_vouchers USING btree (user_id);


--
-- Name: index_user_vouchers_on_voucher_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_vouchers_on_voucher_id ON public.user_vouchers USING btree (voucher_id);


--
-- Name: index_vouchers_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_vouchers_on_user_id ON public.vouchers USING btree (user_id);


--
-- Name: trgm_items_name_indx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX trgm_items_name_indx ON public.items USING gist (name public.gist_trgm_ops);


--
-- Name: user_topics fk_rails_0aa5b25f82; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_topics
    ADD CONSTRAINT fk_rails_0aa5b25f82 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: user_user_relations fk_rails_10bcd883e4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_user_relations
    ADD CONSTRAINT fk_rails_10bcd883e4 FOREIGN KEY (from_user_id) REFERENCES public.users(id);


--
-- Name: reviews fk_rails_1b37fb5a2a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT fk_rails_1b37fb5a2a FOREIGN KEY (item_id) REFERENCES public.items(id);


--
-- Name: flash_cards fk_rails_1c774d0179; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.flash_cards
    ADD CONSTRAINT fk_rails_1c774d0179 FOREIGN KEY (deck_id) REFERENCES public.decks(id);


--
-- Name: collection_items fk_rails_29c02f6872; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.collection_items
    ADD CONSTRAINT fk_rails_29c02f6872 FOREIGN KEY (item_id) REFERENCES public.items(id);


--
-- Name: activity_pub_followers fk_rails_3ce6f9a7a2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.activity_pub_followers
    ADD CONSTRAINT fk_rails_3ce6f9a7a2 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: topic_relations fk_rails_4e9299d5db; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_relations
    ADD CONSTRAINT fk_rails_4e9299d5db FOREIGN KEY (to_id) REFERENCES public.topics(id);


--
-- Name: topic_idea_sets fk_rails_4fb9cd9cdf; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_idea_sets
    ADD CONSTRAINT fk_rails_4fb9cd9cdf FOREIGN KEY (topic_id) REFERENCES public.topics(id);


--
-- Name: recommendations fk_rails_5057f7d09a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recommendations
    ADD CONSTRAINT fk_rails_5057f7d09a FOREIGN KEY (idea_set_id) REFERENCES public.idea_sets(id);


--
-- Name: decks fk_rails_5d31349cbe; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.decks
    ADD CONSTRAINT fk_rails_5d31349cbe FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: items fk_rails_6bed0f90a5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT fk_rails_6bed0f90a5 FOREIGN KEY (item_type_id) REFERENCES public.item_types(id);


--
-- Name: reviews fk_rails_74a66bd6c5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT fk_rails_74a66bd6c5 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: recommendations fk_rails_776fd0ec01; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recommendations
    ADD CONSTRAINT fk_rails_776fd0ec01 FOREIGN KEY (item_id) REFERENCES public.items(id);


--
-- Name: topics fk_rails_7b812cfb44; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topics
    ADD CONSTRAINT fk_rails_7b812cfb44 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: topic_idea_sets fk_rails_853a6f5036; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_idea_sets
    ADD CONSTRAINT fk_rails_853a6f5036 FOREIGN KEY (idea_set_id) REFERENCES public.idea_sets(id);


--
-- Name: collections fk_rails_9b33697360; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.collections
    ADD CONSTRAINT fk_rails_9b33697360 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: recommendations fk_rails_a7499a8cff; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recommendations
    ADD CONSTRAINT fk_rails_a7499a8cff FOREIGN KEY (person_id) REFERENCES public.people(id);


--
-- Name: collection_items fk_rails_b1a778644b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.collection_items
    ADD CONSTRAINT fk_rails_b1a778644b FOREIGN KEY (collection_id) REFERENCES public.collections(id);


--
-- Name: user_topics fk_rails_bfe29ea272; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_topics
    ADD CONSTRAINT fk_rails_bfe29ea272 FOREIGN KEY (topic_id) REFERENCES public.topics(id);


--
-- Name: person_idea_sets fk_rails_c3b7c63f2d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_idea_sets
    ADD CONSTRAINT fk_rails_c3b7c63f2d FOREIGN KEY (idea_set_id) REFERENCES public.idea_sets(id);


--
-- Name: user_topics fk_rails_d399e7a245; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_topics
    ADD CONSTRAINT fk_rails_d399e7a245 FOREIGN KEY (by_user_id) REFERENCES public.users(id);


--
-- Name: items fk_rails_d4b6334db2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT fk_rails_d4b6334db2 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: user_user_relations fk_rails_d52301166a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_user_relations
    ADD CONSTRAINT fk_rails_d52301166a FOREIGN KEY (to_user_id) REFERENCES public.users(id);


--
-- Name: items fk_rails_d85b4d9a08; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT fk_rails_d85b4d9a08 FOREIGN KEY (idea_set_id) REFERENCES public.idea_sets(id);


--
-- Name: person_idea_sets fk_rails_dc3ce95beb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_idea_sets
    ADD CONSTRAINT fk_rails_dc3ce95beb FOREIGN KEY (person_id) REFERENCES public.people(id);


--
-- Name: links fk_rails_e1bb872bea; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.links
    ADD CONSTRAINT fk_rails_e1bb872bea FOREIGN KEY (item_id) REFERENCES public.items(id);


--
-- Name: topic_relations fk_rails_f2d3454ee0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topic_relations
    ADD CONSTRAINT fk_rails_f2d3454ee0 FOREIGN KEY (from_id) REFERENCES public.topics(id);


--
-- Name: flash_cards fk_rails_f949b3ea79; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.flash_cards
    ADD CONSTRAINT fk_rails_f949b3ea79 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20190318163043'),
('20190319060555'),
('20190323161504'),
('20190323161545'),
('20190323161740'),
('20190323161823'),
('20190323164142'),
('20190323164144'),
('20190323181309'),
('20190519045414'),
('20190519061036'),
('20190604140829'),
('20190610164206'),
('20190616171344'),
('20190625190258'),
('20190625194234'),
('20190705003038'),
('20190706110136'),
('20190706175347'),
('20190714025449'),
('20190717185003'),
('20190725101714'),
('20190725173959'),
('20190807061505'),
('20190807165023'),
('20190821060649'),
('20190917115933'),
('20191021073641'),
('20191101144409'),
('20191101172456'),
('20191105105946'),
('20191108051151'),
('20191114042350'),
('20200112192301'),
('20200212205915'),
('20200213173853'),
('20200222193438'),
('20200223073231'),
('20200305015533'),
('20200330145935');


