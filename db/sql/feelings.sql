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
-- Name: feelings; Type: TABLE; Schema: public; Owner: webservice; Tablespace:
--

CREATE TABLE feelings (
    id integer NOT NULL,
    user_id integer NOT NULL,
    level integer,
    description character varying(4096),
    at date,
    comments_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.feelings OWNER TO webservice;

--
-- Name: feelings_id_seq; Type: SEQUENCE; Schema: public; Owner: webservice
--

CREATE SEQUENCE feelings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.feelings_id_seq OWNER TO webservice;

--
-- Name: feelings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: webservice
--

ALTER SEQUENCE feelings_id_seq OWNED BY feelings.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: webservice
--

ALTER TABLE ONLY feelings ALTER COLUMN id SET DEFAULT nextval('feelings_id_seq'::regclass);


--
-- Name: feelings_pkey; Type: CONSTRAINT; Schema: public; Owner: webservice; Tablespace:
--

ALTER TABLE ONLY feelings
    ADD CONSTRAINT feelings_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

