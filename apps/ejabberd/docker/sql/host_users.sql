CREATE TABLE public.host_users (
    id bigint NOT NULL,
    host_id bigint NOT NULL,
    user_id text NOT NULL,
    user_name text NOT NULL,
    department text NOT NULL,
    tel text,
    email text,
    dep1 text NOT NULL,
    dep2 text DEFAULT ''::text,
    dep3 text DEFAULT ''::text,
    dep4 text DEFAULT ''::text,
    dep5 text DEFAULT ''::text,
    pinyin text,
    frozen_flag smallint DEFAULT 0 NOT NULL,
    version integer DEFAULT 1 NOT NULL,
    user_type character(1) DEFAULT 'U'::bpchar,
    hire_flag smallint DEFAULT 1 NOT NULL,
    gender smallint DEFAULT 0 NOT NULL,
    password text,
    initialpwd smallint DEFAULT 1 NOT NULL,
    pwd_salt character varying(200),
    leader character varying(200),
    hrbp character varying(200),
    user_role integer DEFAULT 0 NOT NULL,
    approve_flag integer DEFAULT 1,
    user_desc character varying(1024),
    user_origin integer DEFAULT 0,
    hire_type character varying(50) DEFAULT '未知'::character varying,
    admin_flag character varying(20) DEFAULT '0'::character varying,
    create_time timestamp without time zone DEFAULT (now())::timestamp(3) without time zone,
    ps_deptid text DEFAULT 'QUNAR'::text
);


ALTER TABLE public.host_users OWNER TO postgres;

--
-- Name: host_users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.host_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.host_users_id_seq OWNER TO postgres;

--
-- Name: host_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.host_users_id_seq OWNED BY public.host_users.id;


--
-- Name: host_users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.host_users ALTER COLUMN id SET DEFAULT nextval('public.host_users_id_seq'::regclass);


--
-- Name: host_users host_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.host_users
    ADD CONSTRAINT host_users_pkey PRIMARY KEY (id);


--
-- Name: host_users host_users_user_id_host_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.host_users
    ADD CONSTRAINT host_users_user_id_host_id_key UNIQUE (user_id, host_id);


--
-- Name: host_users_email_host_id__unique_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX host_users_email_host_id__unique_index ON public.host_users USING btree (email, host_id);


--
-- Name: host_users_hire_flag_user_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX host_users_hire_flag_user_name_idx ON public.host_users USING btree (hire_flag, user_name);


--
-- Name: host_users_host_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX host_users_host_id_idx ON public.host_users USING btree (host_id);


--
-- Name: host_users_tel_host_id_unique_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX host_users_tel_host_id_unique_index ON public.host_users USING btree (tel, host_id);


--
-- Name: host_users_user_id_host_id_unique_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX host_users_user_id_host_id_unique_index ON public.host_users USING btree (user_id, host_id);


--
-- Name: host_users_user_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX host_users_user_id_idx ON public.host_users USING btree (user_id);


--
-- Name: host_users_user_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX host_users_user_name_idx ON public.host_users USING btree (user_name);


--
-- Name: host_users_version_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX host_users_version_idx ON public.host_users USING btree (version);

--
-- Name: SEQUENCE host_users_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.host_users_id_seq FROM postgres;


--
-- PostgreSQL database dump complete
--
