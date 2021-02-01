CREATE TABLE public.host_info (
    id bigint NOT NULL,
    host text NOT NULL,
    description text,
    create_time timestamp with time zone DEFAULT now() NOT NULL,
    host_type integer DEFAULT 0 NOT NULL,
    host_qrcode character varying(1000),
    need_approve integer DEFAULT 0 NOT NULL,
    host_admin text NOT NULL
);


ALTER TABLE public.host_info OWNER TO postgres;

--
-- Name: host_info_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.host_info_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.host_info_id_seq OWNER TO postgres;

--
-- Name: host_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.host_info_id_seq OWNED BY public.host_info.id;


--
-- Name: host_info id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.host_info ALTER COLUMN id SET DEFAULT nextval('public.host_info_id_seq'::regclass);


--
-- Name: host_info host_info_host_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.host_info
    ADD CONSTRAINT host_info_host_key UNIQUE (host);


--
-- Name: host_info host_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.host_info
    ADD CONSTRAINT host_info_pkey PRIMARY KEY (id);


--
-- Name: DATABASE ejabberd; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON DATABASE ejabberd FROM postgres;


--
-- Name: TABLE host_info; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.host_info FROM postgres;


--
-- Name: SEQUENCE host_info_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.host_info_id_seq FROM postgres;


--
-- PostgreSQL database dump complete
--

