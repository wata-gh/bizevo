--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: users; Type: TABLE; Schema: public; Owner: webservice; Tablespace:
--

CREATE TABLE users (
    id integer NOT NULL,
    login character varying(30) DEFAULT ''::character varying NOT NULL,
    hashed_password character varying(40) DEFAULT ''::character varying NOT NULL,
    firstname character varying(30) DEFAULT ''::character varying NOT NULL,
    lastname character varying(30) DEFAULT ''::character varying NOT NULL,
    mail character varying(60) DEFAULT ''::character varying NOT NULL,
    admin boolean DEFAULT false NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    last_login_on timestamp without time zone,
    language character varying(5) DEFAULT ''::character varying,
    auth_source_id integer,
    created_on timestamp without time zone,
    updated_on timestamp without time zone,
    type character varying(255),
    identity_url character varying(255),
    mail_notification character varying(255) DEFAULT ''::character varying NOT NULL,
    salt character varying(64)
);


ALTER TABLE public.users OWNER TO webservice;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: webservice
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO webservice;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: webservice
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: webservice
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: webservice; Tablespace:
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_users_on_auth_source_id; Type: INDEX; Schema: public; Owner: webservice; Tablespace:
--

CREATE INDEX index_users_on_auth_source_id ON users USING btree (auth_source_id);


--
-- Name: index_users_on_id_and_type; Type: INDEX; Schema: public; Owner: webservice; Tablespace:
--

CREATE INDEX index_users_on_id_and_type ON users USING btree (id, type);


--
-- Name: index_users_on_type; Type: INDEX; Schema: public; Owner: webservice; Tablespace:
--

CREATE INDEX index_users_on_type ON users USING btree (type);


--
-- PostgreSQL database dump complete
--

