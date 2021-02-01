CREATE TABLE public.startalk_dep_table (
    id integer NOT NULL,
    dep_name text NOT NULL,
    dep_level integer NOT NULL,
    dep_vp text,
    dep_hr text,
    dep_visible text,
    dep_leader text,
    parent_id integer,
    delete_flag integer DEFAULT 0 NOT NULL,
    dep_desc text,
    create_time timestamp without time zone DEFAULT now() NOT NULL,
    update_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.startalk_dep_table OWNER TO postgres;

--
-- Name: TABLE startalk_dep_table; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.startalk_dep_table IS '部门信息表';


--
-- Name: COLUMN startalk_dep_table.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.startalk_dep_table.id IS '自增ID';


--
-- Name: COLUMN startalk_dep_table.dep_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.startalk_dep_table.dep_name IS '部门名称';


--
-- Name: COLUMN startalk_dep_table.dep_level; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.startalk_dep_table.dep_level IS '部门层级';


--
-- Name: COLUMN startalk_dep_table.dep_vp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.startalk_dep_table.dep_vp IS '部门领导';


--
-- Name: COLUMN startalk_dep_table.dep_hr; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.startalk_dep_table.dep_hr IS '部门HR';


--
-- Name: COLUMN startalk_dep_table.dep_visible; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.startalk_dep_table.dep_visible IS '部门可见性';


--
-- Name: COLUMN startalk_dep_table.parent_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.startalk_dep_table.parent_id IS '父级部门的ID';


--
-- Name: COLUMN startalk_dep_table.delete_flag; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.startalk_dep_table.delete_flag IS '部门删除标记位,0是未删除 1是已删除';


--
-- Name: COLUMN startalk_dep_table.dep_desc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.startalk_dep_table.dep_desc IS '部门信息备注';


--
-- Name: COLUMN startalk_dep_table.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.startalk_dep_table.create_time IS '创建时间';


--
-- Name: COLUMN startalk_dep_table.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.startalk_dep_table.update_time IS '更新时间';


--
-- Name: startalk_dep_table_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.startalk_dep_table_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.startalk_dep_table_id_seq OWNER TO postgres;

--
-- Name: startalk_dep_table_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.startalk_dep_table_id_seq OWNED BY public.startalk_dep_table.id;


--
-- Name: startalk_dep_table id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.startalk_dep_table ALTER COLUMN id SET DEFAULT nextval('public.startalk_dep_table_id_seq'::regclass);


--
-- Name: startalk_dep_table startalk_dep_table_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.startalk_dep_table
    ADD CONSTRAINT startalk_dep_table_pk PRIMARY KEY (id);


--
-- Name: startalk_dep_table_depname_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX startalk_dep_table_depname_uindex ON public.startalk_dep_table USING btree (dep_name);


--
-- Name: startalk_dep_table_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX startalk_dep_table_id_uindex ON public.startalk_dep_table USING btree (id);


--
-- Name: DATABASE ejabberd; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON DATABASE ejabberd FROM postgres;


--
-- PostgreSQL database dump complete
--

