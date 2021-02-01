--
-- PostgreSQL database dump
--

-- Dumped from database version 11.4
-- Dumped by pg_dump version 11.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET escape_string_warning = off;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: startalk_dep_setting; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.startalk_dep_setting (
    id integer NOT NULL,
    setting_name character varying(50),
    settings character varying(500)
);


ALTER TABLE public.startalk_dep_setting OWNER TO postgres;

--
-- Name: TABLE startalk_dep_setting; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.startalk_dep_setting IS 'startalk部门可见性设置表';


--
-- Name: COLUMN startalk_dep_setting.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.startalk_dep_setting.id IS '自增主键';


--
-- Name: COLUMN startalk_dep_setting.setting_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.startalk_dep_setting.setting_name IS '默认设置，其他设置';


--
-- Name: COLUMN startalk_dep_setting.settings; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.startalk_dep_setting.settings IS '具体设置';


--
-- Name: startalk_dep_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.startalk_dep_setting_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.startalk_dep_setting_id_seq OWNER TO postgres;

--
-- Name: startalk_dep_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.startalk_dep_setting_id_seq OWNED BY public.startalk_dep_setting.id;


--
-- Name: startalk_dep_setting id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.startalk_dep_setting ALTER COLUMN id SET DEFAULT nextval('public.startalk_dep_setting_id_seq'::regclass);


--
-- Name: startalk_dep_setting startalk_dep_setting_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.startalk_dep_setting
    ADD CONSTRAINT startalk_dep_setting_pkey PRIMARY KEY (id);


--
-- Name: startalk_dep_setting_setting_name_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX startalk_dep_setting_setting_name_uindex ON public.startalk_dep_setting USING btree (setting_name);


--
-- PostgreSQL database dump complete
--
