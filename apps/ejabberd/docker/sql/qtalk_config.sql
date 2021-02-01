CREATE TABLE public.qtalk_config (
    id integer NOT NULL,
    config_key character varying(30) NOT NULL,
    config_value character varying(500) NOT NULL,
    create_time timestamp without time zone DEFAULT now()
);


ALTER TABLE public.qtalk_config OWNER TO postgres;

--
-- Name: COLUMN qtalk_config.config_key; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.qtalk_config.config_key IS '配置key';


--
-- Name: COLUMN qtalk_config.config_value; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.qtalk_config.config_value IS '配置值';


--
-- Name: COLUMN qtalk_config.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.qtalk_config.create_time IS '创建时间';


--
-- Name: qtalk_config_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.qtalk_config_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.qtalk_config_id_seq OWNER TO postgres;

--
-- Name: qtalk_config_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.qtalk_config_id_seq OWNED BY public.qtalk_config.id;


--
-- Name: qtalk_config id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qtalk_config ALTER COLUMN id SET DEFAULT nextval('public.qtalk_config_id_seq'::regclass);


--
-- Name: qtalk_config qtalk_config_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qtalk_config
    ADD CONSTRAINT qtalk_config_pkey PRIMARY KEY (id);


--
-- Name: qtalk_config_config_key_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX qtalk_config_config_key_uindex ON public.qtalk_config USING btree (config_key);


--
-- Name: qtalk_config_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX qtalk_config_id_uindex ON public.qtalk_config USING btree (id);


--
-- Name: DATABASE ejabberd; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON DATABASE ejabberd FROM postgres;


--
-- PostgreSQL database dump complete
--

