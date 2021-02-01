CREATE TABLE public.vcard_version (
    username text NOT NULL,
    version integer DEFAULT 1,
    url text DEFAULT '/file/v2/download/8c9d42532be9316e2202ffef8fcfeba5.png'::text,
    uin character varying(30),
    id bigint NOT NULL,
    profile_version smallint DEFAULT (1)::smallint,
    mood text,
    gender integer DEFAULT 0 NOT NULL,
    host text DEFAULT 'ejabhost1'::text
);


ALTER TABLE public.vcard_version OWNER TO postgres;

--
-- Name: vcard_version_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vcard_version_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vcard_version_id_seq OWNER TO postgres;

--
-- Name: vcard_version_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vcard_version_id_seq OWNED BY public.vcard_version.id;


--
-- Name: vcard_version id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vcard_version ALTER COLUMN id SET DEFAULT nextval('public.vcard_version_id_seq'::regclass);


--
-- Name: vcard_version vcard_version_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vcard_version
    ADD CONSTRAINT vcard_version_pkey PRIMARY KEY (id);


--
-- Name: vcard_version_username_host_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX vcard_version_username_host_idx ON public.vcard_version USING btree (username, host);


--
-- Name: DATABASE postgres; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON DATABASE ejabberd FROM postgres;


--
-- PostgreSQL database dump complete
--
