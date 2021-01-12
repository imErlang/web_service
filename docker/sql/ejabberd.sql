--
-- PostgreSQL database dump
--

-- Dumped from database version 11.10 (Debian 11.10-1.pgdg90+1)
-- Dumped by pg_dump version 11.10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: qto_char(timestamp with time zone, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.qto_char(timestamp with time zone, text) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $_$select to_char($1, $2);$_$;


ALTER FUNCTION public.qto_char(timestamp with time zone, text) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: admin_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_user (
    username character varying(255) NOT NULL,
    priority text NOT NULL
);


ALTER TABLE public.admin_user OWNER TO postgres;

--
-- Name: client_config_sync; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_config_sync (
    id integer NOT NULL,
    username character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    configkey character varying(255) NOT NULL,
    subkey character varying(255) NOT NULL,
    configinfo text NOT NULL,
    version bigint DEFAULT 1,
    operate_plat character varying(50) NOT NULL,
    create_time timestamp with time zone DEFAULT now(),
    update_time timestamp with time zone DEFAULT now(),
    isdel smallint DEFAULT 0
);


ALTER TABLE public.client_config_sync OWNER TO postgres;

--
-- Name: TABLE client_config_sync; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.client_config_sync IS '客户端漫游用户配置表';


--
-- Name: COLUMN client_config_sync.username; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.client_config_sync.username IS '用户用户名';


--
-- Name: COLUMN client_config_sync.host; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.client_config_sync.host IS '用户域名';


--
-- Name: COLUMN client_config_sync.configkey; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.client_config_sync.configkey IS '漫游数据key';


--
-- Name: COLUMN client_config_sync.subkey; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.client_config_sync.subkey IS '漫游数据子key';


--
-- Name: COLUMN client_config_sync.configinfo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.client_config_sync.configinfo IS '漫游数据';


--
-- Name: COLUMN client_config_sync.version; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.client_config_sync.version IS '版本号';


--
-- Name: COLUMN client_config_sync.operate_plat; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.client_config_sync.operate_plat IS '操作平台';


--
-- Name: COLUMN client_config_sync.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.client_config_sync.create_time IS '创建时间';


--
-- Name: COLUMN client_config_sync.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.client_config_sync.update_time IS '更新时间';


--
-- Name: COLUMN client_config_sync.isdel; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.client_config_sync.isdel IS '是否删除或取消';


--
-- Name: client_config_sync_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.client_config_sync_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.client_config_sync_id_seq OWNER TO postgres;

--
-- Name: client_config_sync_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.client_config_sync_id_seq OWNED BY public.client_config_sync.id;


--
-- Name: client_upgrade; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_upgrade (
    id integer NOT NULL,
    client_type character varying(20) NOT NULL,
    platform character varying(50) NOT NULL,
    version integer DEFAULT 0 NOT NULL,
    copywriting character varying(500) NOT NULL,
    grayscale_status integer DEFAULT 0 NOT NULL,
    grayscale_value integer DEFAULT 0,
    upgrade_status integer DEFAULT 0 NOT NULL,
    upgrade_url character varying(200) NOT NULL,
    create_time timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    md5_key character varying(100) DEFAULT ''::character varying,
    stop_status integer DEFAULT 0,
    stop_reason character varying(500) DEFAULT ''::character varying,
    updated_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.client_upgrade OWNER TO postgres;

--
-- Name: COLUMN client_upgrade.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.client_upgrade.id IS '自增id';


--
-- Name: COLUMN client_upgrade.client_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.client_upgrade.client_type IS '客户端类型 qtalk,qchat';


--
-- Name: COLUMN client_upgrade.platform; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.client_upgrade.platform IS '平台Android,ios';


--
-- Name: COLUMN client_upgrade.version; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.client_upgrade.version IS '版本号';


--
-- Name: COLUMN client_upgrade.copywriting; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.client_upgrade.copywriting IS '更新文案';


--
-- Name: COLUMN client_upgrade.grayscale_status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.client_upgrade.grayscale_status IS '灰度测试状态 0:否 1:是';


--
-- Name: COLUMN client_upgrade.grayscale_value; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.client_upgrade.grayscale_value IS '灰度量';


--
-- Name: COLUMN client_upgrade.upgrade_status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.client_upgrade.upgrade_status IS '更新状态 0:强制更新 1:选择更新';


--
-- Name: COLUMN client_upgrade.upgrade_url; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.client_upgrade.upgrade_url IS '更新地址';


--
-- Name: COLUMN client_upgrade.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.client_upgrade.create_time IS '创建时间';


--
-- Name: COLUMN client_upgrade.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.client_upgrade.update_time IS '更新时间';


--
-- Name: COLUMN client_upgrade.md5_key; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.client_upgrade.md5_key IS '文件MD5';


--
-- Name: COLUMN client_upgrade.stop_status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.client_upgrade.stop_status IS '是否停止更新,0:否,1:是';


--
-- Name: COLUMN client_upgrade.stop_reason; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.client_upgrade.stop_reason IS '停止更新原因';


--
-- Name: COLUMN client_upgrade.updated_count; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.client_upgrade.updated_count IS '已更新量';


--
-- Name: client_upgrade_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.client_upgrade_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.client_upgrade_id_seq OWNER TO postgres;

--
-- Name: client_upgrade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.client_upgrade_id_seq OWNED BY public.client_upgrade.id;


--
-- Name: data_board_day; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.data_board_day (
    id integer NOT NULL,
    activity numeric DEFAULT 0 NOT NULL,
    client_online_time jsonb NOT NULL,
    start_count numeric DEFAULT 0 NOT NULL,
    client_version jsonb NOT NULL,
    day_msg_count numeric DEFAULT 0 NOT NULL,
    day_msg_average numeric DEFAULT 0 NOT NULL,
    department_data jsonb NOT NULL,
    hire_type_data jsonb NOT NULL,
    create_time date DEFAULT CURRENT_DATE NOT NULL,
    platform_activity jsonb,
    dep_activity jsonb,
    hire_type_activity jsonb
);


ALTER TABLE public.data_board_day OWNER TO postgres;

--
-- Name: COLUMN data_board_day.activity; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.data_board_day.activity IS '活跃数';


--
-- Name: COLUMN data_board_day.client_online_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.data_board_day.client_online_time IS '客户端在线时间';


--
-- Name: COLUMN data_board_day.start_count; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.data_board_day.start_count IS '启动次数';


--
-- Name: COLUMN data_board_day.client_version; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.data_board_day.client_version IS '客户端版本统计';


--
-- Name: COLUMN data_board_day.day_msg_count; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.data_board_day.day_msg_count IS '每天消息量';


--
-- Name: COLUMN data_board_day.day_msg_average; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.data_board_day.day_msg_average IS '每天平均消息量';


--
-- Name: COLUMN data_board_day.department_data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.data_board_day.department_data IS '部门数据统计';


--
-- Name: COLUMN data_board_day.hire_type_data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.data_board_day.hire_type_data IS '人员类型统计';


--
-- Name: COLUMN data_board_day.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.data_board_day.create_time IS '创建时间';


--
-- Name: COLUMN data_board_day.platform_activity; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.data_board_day.platform_activity IS '平台活跃数';


--
-- Name: COLUMN data_board_day.dep_activity; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.data_board_day.dep_activity IS '部门活跃数';


--
-- Name: COLUMN data_board_day.hire_type_activity; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.data_board_day.hire_type_activity IS '人员类型活跃数';


--
-- Name: data_board_day_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.data_board_day_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data_board_day_id_seq OWNER TO postgres;

--
-- Name: data_board_day_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.data_board_day_id_seq OWNED BY public.data_board_day.id;


--
-- Name: destroy_muc_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.destroy_muc_info (
    muc_name text NOT NULL,
    nick_name text,
    reason text,
    id bigint NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.destroy_muc_info OWNER TO postgres;

--
-- Name: destroy_muc_info_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.destroy_muc_info_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.destroy_muc_info_id_seq OWNER TO postgres;

--
-- Name: destroy_muc_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.destroy_muc_info_id_seq OWNED BY public.destroy_muc_info.id;


--
-- Name: find_application_table; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.find_application_table (
    id integer NOT NULL,
    application_type integer NOT NULL,
    visible_range text,
    application_name text NOT NULL,
    application_class text NOT NULL,
    application_icon text NOT NULL,
    application_version integer NOT NULL,
    ios_version integer,
    android_version integer,
    ios_bundle text,
    android_bundle text,
    application_desc text,
    create_time timestamp without time zone DEFAULT now(),
    update_time timestamp without time zone DEFAULT now(),
    disable_flag smallint DEFAULT 0 NOT NULL,
    member_id integer NOT NULL,
    h5_action text,
    entrance text,
    properties text,
    module text,
    show_native_nav boolean,
    nav_title text,
    valid_platform text,
    visible_platform smallint,
    bundle_name text,
    h5_action_ios text,
    h5_action_android text,
    delete_flag smallint DEFAULT 0 NOT NULL,
    native_flag smallint DEFAULT 0 NOT NULL,
    app_uuid character varying(50)
);


ALTER TABLE public.find_application_table OWNER TO postgres;

--
-- Name: COLUMN find_application_table.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.find_application_table.id IS '自增id';


--
-- Name: COLUMN find_application_table.application_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.find_application_table.application_type IS '应用类型，2RN应用，3 H5应用';


--
-- Name: COLUMN find_application_table.visible_range; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.find_application_table.visible_range IS '可见性范围，空标识全员可见';


--
-- Name: COLUMN find_application_table.application_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.find_application_table.application_name IS '应用名称';


--
-- Name: COLUMN find_application_table.application_class; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.find_application_table.application_class IS '应用分类';


--
-- Name: COLUMN find_application_table.application_icon; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.find_application_table.application_icon IS '应用图标';


--
-- Name: COLUMN find_application_table.application_version; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.find_application_table.application_version IS '应用版本号';


--
-- Name: COLUMN find_application_table.ios_version; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.find_application_table.ios_version IS 'ios版本号';


--
-- Name: COLUMN find_application_table.android_version; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.find_application_table.android_version IS '安卓版本号';


--
-- Name: COLUMN find_application_table.ios_bundle; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.find_application_table.ios_bundle IS 'iosbundle包，h5应用的话对应的是h5的地址';


--
-- Name: COLUMN find_application_table.android_bundle; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.find_application_table.android_bundle IS 'android的bundle包，h5应用对应的是地址';


--
-- Name: COLUMN find_application_table.application_desc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.find_application_table.application_desc IS '应用描述';


--
-- Name: COLUMN find_application_table.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.find_application_table.create_time IS '创建时间';


--
-- Name: COLUMN find_application_table.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.find_application_table.update_time IS '更新时间';


--
-- Name: COLUMN find_application_table.disable_flag; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.find_application_table.disable_flag IS '禁用标志位';


--
-- Name: COLUMN find_application_table.member_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.find_application_table.member_id IS '在群组的id';


--
-- Name: COLUMN find_application_table.h5_action; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.find_application_table.h5_action IS 'h5页面地址';


--
-- Name: COLUMN find_application_table.entrance; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.find_application_table.entrance IS 'RN应用的入口地址';


--
-- Name: COLUMN find_application_table.properties; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.find_application_table.properties IS '额外初始属性 map的json';


--
-- Name: COLUMN find_application_table.module; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.find_application_table.module IS 'RN应用的程序入口';


--
-- Name: COLUMN find_application_table.show_native_nav; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.find_application_table.show_native_nav IS '是否显示导航';


--
-- Name: COLUMN find_application_table.nav_title; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.find_application_table.nav_title IS '导航title h5应用不生效';


--
-- Name: COLUMN find_application_table.valid_platform; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.find_application_table.valid_platform IS '可适配的客户端类型，IOS Angroid PC';


--
-- Name: COLUMN find_application_table.visible_platform; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.find_application_table.visible_platform IS 'ios|Android|pc(101):5';


--
-- Name: COLUMN find_application_table.bundle_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.find_application_table.bundle_name IS 'bundle 包的文件名 不同于applicaName';


--
-- Name: COLUMN find_application_table.h5_action_ios; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.find_application_table.h5_action_ios IS 'ios h5的页面地址';


--
-- Name: COLUMN find_application_table.h5_action_android; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.find_application_table.h5_action_android IS 'h5 android页面地址';


--
-- Name: COLUMN find_application_table.delete_flag; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.find_application_table.delete_flag IS '删除标记位，1删除 0未删除';


--
-- Name: COLUMN find_application_table.native_flag; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.find_application_table.native_flag IS '原生应用标记0是自定义，1是原生应用禁止修改';


--
-- Name: COLUMN find_application_table.app_uuid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.find_application_table.app_uuid IS '应用的UUID';


--
-- Name: find_application_table_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.find_application_table_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.find_application_table_id_seq OWNER TO postgres;

--
-- Name: find_application_table_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.find_application_table_id_seq OWNED BY public.find_application_table.id;


--
-- Name: find_class_table; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.find_class_table (
    id integer NOT NULL,
    group_name character varying(200) NOT NULL,
    group_icon character varying(200) NOT NULL
);


ALTER TABLE public.find_class_table OWNER TO postgres;

--
-- Name: TABLE find_class_table; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.find_class_table IS '应用分类表';


--
-- Name: COLUMN find_class_table.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.find_class_table.id IS '自增ID';


--
-- Name: COLUMN find_class_table.group_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.find_class_table.group_name IS '分组名称';


--
-- Name: COLUMN find_class_table.group_icon; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.find_class_table.group_icon IS '分组封面';


--
-- Name: find_class_table_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.find_class_table_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.find_class_table_id_seq OWNER TO postgres;

--
-- Name: find_class_table_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.find_class_table_id_seq OWNED BY public.find_class_table.id;


--
-- Name: flogin_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flogin_user (
    id integer NOT NULL,
    username character varying(1000) NOT NULL,
    create_time timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.flogin_user OWNER TO postgres;

--
-- Name: flogin_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.flogin_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.flogin_user_id_seq OWNER TO postgres;

--
-- Name: flogin_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.flogin_user_id_seq OWNED BY public.flogin_user.id;


--
-- Name: fresh_empl_entering; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fresh_empl_entering (
    id bigint NOT NULL,
    user_id character varying(20) NOT NULL,
    user_name character varying(20) NOT NULL,
    hire_flag smallint DEFAULT 1 NOT NULL,
    join_date date NOT NULL,
    send_state smallint DEFAULT 0 NOT NULL,
    sn character varying(15) NOT NULL,
    manager character varying(20) NOT NULL,
    manager_mail character varying(50) NOT NULL,
    dep1 character varying(20) NOT NULL,
    dep2 character varying(20),
    dep3 character varying(20),
    dep4 character varying(20),
    dep5 character varying(20),
    job character varying(20),
    job_code character varying(20) NOT NULL,
    probation_date date NOT NULL,
    version smallint DEFAULT 0 NOT NULL,
    create_time timestamp with time zone DEFAULT now(),
    update_time timestamp with time zone DEFAULT now()
);


ALTER TABLE public.fresh_empl_entering OWNER TO postgres;

--
-- Name: TABLE fresh_empl_entering; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.fresh_empl_entering IS '表名';


--
-- Name: COLUMN fresh_empl_entering.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.fresh_empl_entering.id IS '唯一主键';


--
-- Name: COLUMN fresh_empl_entering.user_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.fresh_empl_entering.user_id IS 'qtalkid';


--
-- Name: COLUMN fresh_empl_entering.user_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.fresh_empl_entering.user_name IS '姓名';


--
-- Name: COLUMN fresh_empl_entering.hire_flag; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.fresh_empl_entering.hire_flag IS '入职状态，0：已入职，1：未入职，2：推迟入职，3：待定入职';


--
-- Name: COLUMN fresh_empl_entering.join_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.fresh_empl_entering.join_date IS '入职日期';


--
-- Name: COLUMN fresh_empl_entering.send_state; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.fresh_empl_entering.send_state IS '消息发送状态，0：未发送，1：已发送';


--
-- Name: COLUMN fresh_empl_entering.sn; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.fresh_empl_entering.sn IS '员工号';


--
-- Name: COLUMN fresh_empl_entering.manager; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.fresh_empl_entering.manager IS '主管号';


--
-- Name: COLUMN fresh_empl_entering.manager_mail; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.fresh_empl_entering.manager_mail IS '主管邮箱';


--
-- Name: COLUMN fresh_empl_entering.dep1; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.fresh_empl_entering.dep1 IS '一级部门';


--
-- Name: COLUMN fresh_empl_entering.job; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.fresh_empl_entering.job IS '岗位名称';


--
-- Name: COLUMN fresh_empl_entering.job_code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.fresh_empl_entering.job_code IS '岗位编码';


--
-- Name: COLUMN fresh_empl_entering.probation_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.fresh_empl_entering.probation_date IS '转正日期';


--
-- Name: COLUMN fresh_empl_entering.version; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.fresh_empl_entering.version IS '入职日期修改次数';


--
-- Name: fresh_empl_entering_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fresh_empl_entering_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fresh_empl_entering_id_seq OWNER TO postgres;

--
-- Name: fresh_empl_entering_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fresh_empl_entering_id_seq OWNED BY public.fresh_empl_entering.id;


--
-- Name: host_info; Type: TABLE; Schema: public; Owner: postgres
--

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
-- Name: host_users; Type: TABLE; Schema: public; Owner: postgres
--

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
-- Name: invite_spool; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invite_spool (
    username text NOT NULL,
    inviter text NOT NULL,
    body text NOT NULL,
    "timestamp" integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    host text DEFAULT 'ejabhost1'::text NOT NULL,
    ihost text DEFAULT 'ejabhost1'::text NOT NULL
);


ALTER TABLE public.invite_spool OWNER TO postgres;

--
-- Name: iplimit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.iplimit (
    ip text NOT NULL,
    created_at timestamp(6) without time zone DEFAULT now() NOT NULL,
    descriptions text DEFAULT now() NOT NULL,
    name text DEFAULT 'ALL'::text NOT NULL,
    priority text DEFAULT '1'::text NOT NULL,
    manager text
);


ALTER TABLE public.iplimit OWNER TO postgres;

--
-- Name: irc_custom; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.irc_custom (
    jid text NOT NULL,
    host text NOT NULL,
    data text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.irc_custom OWNER TO postgres;

--
-- Name: last; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.last (
    username text NOT NULL,
    seconds text NOT NULL,
    state text NOT NULL
);


ALTER TABLE public.last OWNER TO postgres;

--
-- Name: login_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.login_data (
    id integer NOT NULL,
    username character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    resource character varying(255) NOT NULL,
    platform character varying(255) NOT NULL,
    ip inet,
    login_time timestamp with time zone DEFAULT now(),
    logout_at timestamp with time zone DEFAULT now(),
    record_type character varying(255) NOT NULL
);


ALTER TABLE public.login_data OWNER TO postgres;

--
-- Name: TABLE login_data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.login_data IS 'qtalk登录记录';


--
-- Name: COLUMN login_data.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.login_data.id IS '登录记录ID';


--
-- Name: COLUMN login_data.username; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.login_data.username IS '用户名';


--
-- Name: COLUMN login_data.host; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.login_data.host IS 'host';


--
-- Name: COLUMN login_data.resource; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.login_data.resource IS 'resource';


--
-- Name: COLUMN login_data.platform; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.login_data.platform IS '平台';


--
-- Name: COLUMN login_data.ip; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.login_data.ip IS '登录ip地址';


--
-- Name: COLUMN login_data.login_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.login_data.login_time IS '登录时间';


--
-- Name: COLUMN login_data.logout_at; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.login_data.logout_at IS '退出时间';


--
-- Name: COLUMN login_data.record_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.login_data.record_type IS '类型';


--
-- Name: login_data_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.login_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.login_data_id_seq OWNER TO postgres;

--
-- Name: login_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.login_data_id_seq OWNED BY public.login_data.id;


--
-- Name: meeting_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.meeting_info (
    id integer NOT NULL,
    meeting_id character varying(255) NOT NULL,
    meeting_name character varying(255) NOT NULL,
    meeting_remarks text DEFAULT ''::text,
    meeting_intr text DEFAULT ''::text,
    meeting_locale character varying(255) NOT NULL,
    meeting_room character varying(255) NOT NULL,
    schedule_time timestamp with time zone DEFAULT now(),
    meeting_date date NOT NULL,
    begin_time timestamp with time zone NOT NULL,
    end_time timestamp with time zone NOT NULL,
    inviter character varying(255) NOT NULL,
    member character varying(255) NOT NULL,
    mem_action integer DEFAULT 0,
    remind_flag integer DEFAULT 0,
    refuse_reason text,
    canceled boolean DEFAULT false
);


ALTER TABLE public.meeting_info OWNER TO postgres;

--
-- Name: TABLE meeting_info; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.meeting_info IS '存储会议提醒信息表';


--
-- Name: COLUMN meeting_info.meeting_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.meeting_info.meeting_id IS '会议ID';


--
-- Name: COLUMN meeting_info.meeting_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.meeting_info.meeting_name IS '会议名称';


--
-- Name: COLUMN meeting_info.meeting_remarks; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.meeting_info.meeting_remarks IS '会议备注';


--
-- Name: COLUMN meeting_info.meeting_intr; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.meeting_info.meeting_intr IS '会议内容';


--
-- Name: COLUMN meeting_info.meeting_locale; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.meeting_info.meeting_locale IS '会议地点';


--
-- Name: COLUMN meeting_info.meeting_room; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.meeting_info.meeting_room IS '会议室名字';


--
-- Name: COLUMN meeting_info.schedule_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.meeting_info.schedule_time IS '会议预约时间';


--
-- Name: COLUMN meeting_info.meeting_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.meeting_info.meeting_date IS '会议日期';


--
-- Name: COLUMN meeting_info.begin_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.meeting_info.begin_time IS '会议开始时间';


--
-- Name: COLUMN meeting_info.end_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.meeting_info.end_time IS '会议结束时间';


--
-- Name: COLUMN meeting_info.inviter; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.meeting_info.inviter IS '会议邀请者';


--
-- Name: COLUMN meeting_info.member; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.meeting_info.member IS '会议被邀请者';


--
-- Name: COLUMN meeting_info.mem_action; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.meeting_info.mem_action IS '参会人员反馈';


--
-- Name: COLUMN meeting_info.remind_flag; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.meeting_info.remind_flag IS '提醒状态';


--
-- Name: COLUMN meeting_info.refuse_reason; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.meeting_info.refuse_reason IS '参会者拒绝参会的原因';


--
-- Name: COLUMN meeting_info.canceled; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.meeting_info.canceled IS '会议是否取消';


--
-- Name: meeting_info_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.meeting_info_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.meeting_info_id_seq OWNER TO postgres;

--
-- Name: meeting_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.meeting_info_id_seq OWNED BY public.meeting_info.id;


--
-- Name: motd; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.motd (
    username text NOT NULL,
    xml text,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.motd OWNER TO postgres;

--
-- Name: msg_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.msg_history (
    m_from character varying(255),
    m_to character varying(255),
    m_body text,
    create_time timestamp with time zone DEFAULT (now())::timestamp(3) without time zone,
    id bigint NOT NULL,
    read_flag smallint DEFAULT 0,
    msg_id text,
    from_host text,
    to_host text,
    realfrom character varying(255),
    realto character varying(255),
    msg_type character varying(255),
    update_time timestamp with time zone DEFAULT now()
);


ALTER TABLE public.msg_history OWNER TO postgres;

--
-- Name: msg_history_backup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.msg_history_backup (
    m_from character varying(255),
    m_to character varying(255),
    m_body text,
    create_time timestamp with time zone DEFAULT (now())::timestamp(3) without time zone,
    id bigint NOT NULL,
    read_flag smallint DEFAULT 0,
    msg_id text,
    from_host text,
    to_host text,
    realfrom character varying(255),
    realto character varying(255),
    msg_type character varying(255),
    update_time timestamp with time zone DEFAULT now()
);


ALTER TABLE public.msg_history_backup OWNER TO postgres;

--
-- Name: msg_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.msg_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.msg_history_id_seq OWNER TO postgres;

--
-- Name: msg_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.msg_history_id_seq OWNED BY public.msg_history.id;


--
-- Name: msgview_old; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.msgview_old AS
 SELECT msg_history.m_from,
    msg_history.create_time AS s_date
   FROM public.msg_history;


ALTER TABLE public.msgview_old OWNER TO postgres;

--
-- Name: muc_last; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.muc_last (
    muc_name text NOT NULL,
    create_time text,
    last_msg_time text DEFAULT '0'::text
);


ALTER TABLE public.muc_last OWNER TO postgres;

--
-- Name: muc_registered; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.muc_registered (
    jid text NOT NULL,
    host text NOT NULL,
    nick text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.muc_registered OWNER TO postgres;

--
-- Name: muc_room; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.muc_room (
    name text NOT NULL,
    host text NOT NULL,
    opts text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.muc_room OWNER TO postgres;

--
-- Name: muc_room_backup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.muc_room_backup (
    name text NOT NULL,
    host text NOT NULL,
    opts text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.muc_room_backup OWNER TO postgres;

--
-- Name: muc_room_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.muc_room_history (
    muc_room_name character varying(255),
    nick character varying(255),
    packet text,
    have_subject boolean,
    size character varying(255),
    create_time timestamp with time zone DEFAULT (now())::timestamp(3) without time zone,
    id bigint NOT NULL,
    host text DEFAULT 'ejabhost1'::text,
    msg_id text
);


ALTER TABLE public.muc_room_history OWNER TO postgres;

--
-- Name: muc_room_history_backup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.muc_room_history_backup (
    muc_room_name character varying(255),
    nick character varying(255),
    packet text,
    have_subject boolean,
    size character varying(255),
    create_time timestamp with time zone DEFAULT (now())::timestamp(3) without time zone,
    id bigint NOT NULL,
    host text,
    msg_id text
);


ALTER TABLE public.muc_room_history_backup OWNER TO postgres;

--
-- Name: muc_room_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.muc_room_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.muc_room_history_id_seq OWNER TO postgres;

--
-- Name: muc_room_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.muc_room_history_id_seq OWNED BY public.muc_room_history.id;


--
-- Name: muc_room_users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.muc_room_users_id_seq
    START WITH 1542632
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.muc_room_users_id_seq OWNER TO postgres;

--
-- Name: muc_room_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.muc_room_users (
    muc_name character varying(200) NOT NULL,
    username character varying(200) NOT NULL,
    host character varying(200) NOT NULL,
    subscribe_flag text DEFAULT '0'::text NOT NULL,
    id bigint DEFAULT nextval('public.muc_room_users_id_seq'::regclass) NOT NULL,
    date bigint DEFAULT 0,
    login_date integer,
    domain text DEFAULT 'conference.ejabhost1'::text NOT NULL,
    update_time timestamp with time zone DEFAULT now()
);


ALTER TABLE public.muc_room_users OWNER TO postgres;

--
-- Name: COLUMN muc_room_users.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.muc_room_users.update_time IS '更新时间';


--
-- Name: muc_user_mark; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.muc_user_mark (
    muc_name text NOT NULL,
    user_name text NOT NULL,
    login_date integer NOT NULL,
    logout_date integer,
    id bigint NOT NULL
);


ALTER TABLE public.muc_user_mark OWNER TO postgres;

--
-- Name: muc_user_mark_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.muc_user_mark_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.muc_user_mark_id_seq OWNER TO postgres;

--
-- Name: muc_user_mark_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.muc_user_mark_id_seq OWNED BY public.muc_user_mark.id;


--
-- Name: muc_vcard_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.muc_vcard_info (
    muc_name text NOT NULL,
    show_name text NOT NULL,
    muc_desc text,
    muc_title text,
    muc_pic text DEFAULT '/file/v2/download/eb574c5a1d33c72ba14fc1616cde3a42.png'::text,
    show_name_pinyin character varying(1000) DEFAULT 'xinjianqunliao|xjql'::character varying,
    update_time timestamp with time zone DEFAULT (now())::timestamp(3) with time zone NOT NULL,
    version integer DEFAULT 1
);


ALTER TABLE public.muc_vcard_info OWNER TO postgres;

--
-- Name: notice_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notice_history (
    id bigint NOT NULL,
    msg_id text NOT NULL,
    m_from text NOT NULL,
    m_body text NOT NULL,
    create_time timestamp with time zone DEFAULT (now())::timestamp(3) without time zone NOT NULL,
    host text DEFAULT 'ejabhost1'::text NOT NULL
);


ALTER TABLE public.notice_history OWNER TO postgres;

--
-- Name: notice_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notice_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notice_history_id_seq OWNER TO postgres;

--
-- Name: notice_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notice_history_id_seq OWNED BY public.notice_history.id;


--
-- Name: persistent_logins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.persistent_logins (
    username character varying(64) NOT NULL,
    series character varying(64) NOT NULL,
    token character varying(64) NOT NULL,
    last_used timestamp without time zone NOT NULL
);


ALTER TABLE public.persistent_logins OWNER TO postgres;

--
-- Name: privacy_default_list; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.privacy_default_list (
    username text NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.privacy_default_list OWNER TO postgres;

--
-- Name: privacy_list; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.privacy_list (
    username text NOT NULL,
    name text NOT NULL,
    id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.privacy_list OWNER TO postgres;

--
-- Name: privacy_list_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.privacy_list_data (
    id bigint,
    t character(1) NOT NULL,
    value text NOT NULL,
    action character(1) NOT NULL,
    ord numeric NOT NULL,
    match_all boolean NOT NULL,
    match_iq boolean NOT NULL,
    match_message boolean NOT NULL,
    match_presence_in boolean NOT NULL,
    match_presence_out boolean NOT NULL
);


ALTER TABLE public.privacy_list_data OWNER TO postgres;

--
-- Name: privacy_list_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.privacy_list_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.privacy_list_id_seq OWNER TO postgres;

--
-- Name: privacy_list_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.privacy_list_id_seq OWNED BY public.privacy_list.id;


--
-- Name: private_storage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.private_storage (
    username text NOT NULL,
    namespace text NOT NULL,
    data text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.private_storage OWNER TO postgres;

--
-- Name: pubsub_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pubsub_item (
    nodeid bigint,
    itemid text,
    publisher text,
    creation text,
    modification text,
    payload text
);


ALTER TABLE public.pubsub_item OWNER TO postgres;

--
-- Name: pubsub_node; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pubsub_node (
    host text,
    node text,
    parent text,
    type text,
    nodeid integer NOT NULL
);


ALTER TABLE public.pubsub_node OWNER TO postgres;

--
-- Name: pubsub_node_nodeid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pubsub_node_nodeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pubsub_node_nodeid_seq OWNER TO postgres;

--
-- Name: pubsub_node_nodeid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pubsub_node_nodeid_seq OWNED BY public.pubsub_node.nodeid;


--
-- Name: pubsub_node_option; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pubsub_node_option (
    nodeid bigint,
    name text,
    val text
);


ALTER TABLE public.pubsub_node_option OWNER TO postgres;

--
-- Name: pubsub_node_owner; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pubsub_node_owner (
    nodeid bigint,
    owner text
);


ALTER TABLE public.pubsub_node_owner OWNER TO postgres;

--
-- Name: pubsub_state; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pubsub_state (
    nodeid bigint,
    jid text,
    affiliation character(1),
    subscriptions text,
    stateid integer NOT NULL
);


ALTER TABLE public.pubsub_state OWNER TO postgres;

--
-- Name: pubsub_state_stateid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pubsub_state_stateid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pubsub_state_stateid_seq OWNER TO postgres;

--
-- Name: pubsub_state_stateid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pubsub_state_stateid_seq OWNED BY public.pubsub_state.stateid;


--
-- Name: pubsub_subscription_opt; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pubsub_subscription_opt (
    subid text,
    opt_name character varying(32),
    opt_value text
);


ALTER TABLE public.pubsub_subscription_opt OWNER TO postgres;

--
-- Name: push_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.push_info (
    id integer NOT NULL,
    user_name character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    mac_key character varying(255),
    platname character varying(255),
    pkgname character varying(255),
    os character varying(50) NOT NULL,
    version character varying(50),
    create_time timestamp with time zone DEFAULT now(),
    update_at timestamp with time zone DEFAULT now(),
    show_content smallint DEFAULT 1,
    push_flag integer DEFAULT 0
);


ALTER TABLE public.push_info OWNER TO postgres;

--
-- Name: TABLE push_info; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.push_info IS '存储用户推送信息表';


--
-- Name: COLUMN push_info.user_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.push_info.user_name IS '用户用户名';


--
-- Name: COLUMN push_info.host; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.push_info.host IS '用户域名';


--
-- Name: COLUMN push_info.mac_key; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.push_info.mac_key IS '用户上传唯一key,给指定key发送push';


--
-- Name: COLUMN push_info.platname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.push_info.platname IS 'adr端平台名称，如mipush';


--
-- Name: COLUMN push_info.pkgname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.push_info.pkgname IS 'adr端应用包名';


--
-- Name: COLUMN push_info.os; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.push_info.os IS '平台系统 ios或android';


--
-- Name: COLUMN push_info.version; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.push_info.version IS '版本号';


--
-- Name: COLUMN push_info.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.push_info.create_time IS '创建时间';


--
-- Name: COLUMN push_info.update_at; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.push_info.update_at IS '更新时间';


--
-- Name: COLUMN push_info.show_content; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.push_info.show_content IS '是否显示推送详细内容，默认值1：显示，0：不显示';


--
-- Name: COLUMN push_info.push_flag; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.push_info.push_flag IS '是否push标志位';


--
-- Name: push_info_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.push_info_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.push_info_id_seq OWNER TO postgres;

--
-- Name: push_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.push_info_id_seq OWNED BY public.push_info.id;


--
-- Name: qcloud_main; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qcloud_main (
    id integer NOT NULL,
    q_user character varying(255),
    q_type integer,
    q_title text,
    q_introduce text,
    q_content text,
    q_time bigint,
    q_state integer DEFAULT 1
);


ALTER TABLE public.qcloud_main OWNER TO postgres;

--
-- Name: TABLE qcloud_main; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.qcloud_main IS 'Evernote主列表存储表';


--
-- Name: COLUMN qcloud_main.q_user; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.qcloud_main.q_user IS '信息所属用户';


--
-- Name: COLUMN qcloud_main.q_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.qcloud_main.q_type IS '信息类型';


--
-- Name: COLUMN qcloud_main.q_title; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.qcloud_main.q_title IS '标题';


--
-- Name: COLUMN qcloud_main.q_introduce; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.qcloud_main.q_introduce IS '介绍';


--
-- Name: COLUMN qcloud_main.q_content; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.qcloud_main.q_content IS '内容';


--
-- Name: COLUMN qcloud_main.q_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.qcloud_main.q_time IS '最后修改时间';


--
-- Name: COLUMN qcloud_main.q_state; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.qcloud_main.q_state IS '信息状态标记(正常、收藏、废纸篓、删除)';


--
-- Name: qcloud_main_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qcloud_main_history (
    id integer NOT NULL,
    q_id integer,
    qh_content text,
    qh_time bigint,
    qh_state integer DEFAULT 1
);


ALTER TABLE public.qcloud_main_history OWNER TO postgres;

--
-- Name: TABLE qcloud_main_history; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.qcloud_main_history IS 'Evernote主列表操作历史';


--
-- Name: COLUMN qcloud_main_history.q_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.qcloud_main_history.q_id IS '主列表ID';


--
-- Name: COLUMN qcloud_main_history.qh_content; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.qcloud_main_history.qh_content IS '操作内容';


--
-- Name: COLUMN qcloud_main_history.qh_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.qcloud_main_history.qh_time IS '操作时间';


--
-- Name: COLUMN qcloud_main_history.qh_state; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.qcloud_main_history.qh_state IS '状态';


--
-- Name: qcloud_main_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.qcloud_main_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.qcloud_main_history_id_seq OWNER TO postgres;

--
-- Name: qcloud_main_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.qcloud_main_history_id_seq OWNED BY public.qcloud_main_history.id;


--
-- Name: qcloud_main_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.qcloud_main_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.qcloud_main_id_seq OWNER TO postgres;

--
-- Name: qcloud_main_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.qcloud_main_id_seq OWNED BY public.qcloud_main.id;


--
-- Name: qcloud_sub; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qcloud_sub (
    id integer NOT NULL,
    q_id bigint NOT NULL,
    qs_user character varying(255),
    qs_type integer,
    qs_title text,
    qs_introduce text,
    qs_content text,
    qs_time bigint,
    qs_state integer DEFAULT 1
);


ALTER TABLE public.qcloud_sub OWNER TO postgres;

--
-- Name: TABLE qcloud_sub; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.qcloud_sub IS 'Evernote子列表存储表';


--
-- Name: COLUMN qcloud_sub.q_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.qcloud_sub.q_id IS '主列表ID';


--
-- Name: COLUMN qcloud_sub.qs_user; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.qcloud_sub.qs_user IS '信息所属用户';


--
-- Name: COLUMN qcloud_sub.qs_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.qcloud_sub.qs_type IS '信息类型';


--
-- Name: COLUMN qcloud_sub.qs_title; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.qcloud_sub.qs_title IS '标题';


--
-- Name: COLUMN qcloud_sub.qs_introduce; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.qcloud_sub.qs_introduce IS '介绍';


--
-- Name: COLUMN qcloud_sub.qs_content; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.qcloud_sub.qs_content IS '内容';


--
-- Name: COLUMN qcloud_sub.qs_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.qcloud_sub.qs_time IS '最后修改时间';


--
-- Name: COLUMN qcloud_sub.qs_state; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.qcloud_sub.qs_state IS '信息状态标记(正常、收藏、废纸篓、删除)';


--
-- Name: qcloud_sub_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qcloud_sub_history (
    id integer NOT NULL,
    qs_id integer,
    qh_content text,
    qh_time bigint,
    qh_state integer DEFAULT 1
);


ALTER TABLE public.qcloud_sub_history OWNER TO postgres;

--
-- Name: TABLE qcloud_sub_history; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.qcloud_sub_history IS 'Evernote子列表操作历史';


--
-- Name: COLUMN qcloud_sub_history.qs_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.qcloud_sub_history.qs_id IS '主列表ID';


--
-- Name: COLUMN qcloud_sub_history.qh_content; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.qcloud_sub_history.qh_content IS '操作内容';


--
-- Name: COLUMN qcloud_sub_history.qh_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.qcloud_sub_history.qh_time IS '操作时间';


--
-- Name: COLUMN qcloud_sub_history.qh_state; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.qcloud_sub_history.qh_state IS '状态';


--
-- Name: qcloud_sub_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.qcloud_sub_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.qcloud_sub_history_id_seq OWNER TO postgres;

--
-- Name: qcloud_sub_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.qcloud_sub_history_id_seq OWNED BY public.qcloud_sub_history.id;


--
-- Name: qcloud_sub_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.qcloud_sub_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.qcloud_sub_id_seq OWNER TO postgres;

--
-- Name: qcloud_sub_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.qcloud_sub_id_seq OWNED BY public.qcloud_sub.id;


--
-- Name: qtalk_config; Type: TABLE; Schema: public; Owner: postgres
--

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
-- Name: qtalk_user_comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qtalk_user_comment (
    id bigint NOT NULL,
    from_user character varying(20) NOT NULL,
    to_user character varying(20) NOT NULL,
    create_time timestamp with time zone NOT NULL,
    comment character varying(500),
    grade boolean NOT NULL
);


ALTER TABLE public.qtalk_user_comment OWNER TO postgres;

--
-- Name: COLUMN qtalk_user_comment.from_user; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.qtalk_user_comment.from_user IS '点评人';


--
-- Name: COLUMN qtalk_user_comment.to_user; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.qtalk_user_comment.to_user IS '被点评人';


--
-- Name: COLUMN qtalk_user_comment.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.qtalk_user_comment.create_time IS '点评时间';


--
-- Name: COLUMN qtalk_user_comment.comment; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.qtalk_user_comment.comment IS '点评内容';


--
-- Name: COLUMN qtalk_user_comment.grade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.qtalk_user_comment.grade IS 'true 赞 fasle 扁';


--
-- Name: qtalk_user_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.qtalk_user_comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.qtalk_user_comment_id_seq OWNER TO postgres;

--
-- Name: qtalk_user_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.qtalk_user_comment_id_seq OWNED BY public.qtalk_user_comment.id;


--
-- Name: recv_msg_option; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recv_msg_option (
    username text NOT NULL,
    rec_msg_opt smallint DEFAULT (2)::smallint,
    version integer
);


ALTER TABLE public.recv_msg_option OWNER TO postgres;

--
-- Name: revoke_msg_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.revoke_msg_history (
    m_from text,
    m_to text,
    m_body text,
    id bigint NOT NULL,
    m_timestamp bigint DEFAULT date_part('epoch'::text, now()),
    msg_id text,
    create_time timestamp with time zone DEFAULT now()
);


ALTER TABLE public.revoke_msg_history OWNER TO postgres;

--
-- Name: revoke_msg_history_backup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.revoke_msg_history_backup (
    m_from text,
    m_to text,
    m_body text,
    id bigint NOT NULL,
    m_timestamp bigint DEFAULT date_part('epoch'::text, now()),
    msg_id text,
    create_time timestamp with time zone DEFAULT now()
);


ALTER TABLE public.revoke_msg_history_backup OWNER TO postgres;

--
-- Name: revoke_msg_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.revoke_msg_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.revoke_msg_history_id_seq OWNER TO postgres;

--
-- Name: revoke_msg_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.revoke_msg_history_id_seq OWNED BY public.revoke_msg_history.id;


--
-- Name: s2s_mapped_host; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.s2s_mapped_host (
    domain character varying(255) NOT NULL,
    host character varying(255) NOT NULL,
    port integer,
    priority character varying(255) NOT NULL,
    weight character varying(255) NOT NULL
);


ALTER TABLE public.s2s_mapped_host OWNER TO postgres;

--
-- Name: scheduling_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scheduling_info (
    id integer NOT NULL,
    scheduling_id character varying(255) NOT NULL,
    scheduling_name character varying(255) NOT NULL,
    scheduling_type character varying(255) DEFAULT '0'::character varying,
    scheduling_remarks text DEFAULT ''::text,
    scheduling_intr text DEFAULT ''::text,
    scheduling_appointment text DEFAULT ''::text,
    scheduling_locale character varying(255) NOT NULL,
    scheduling_locale_id character varying(255) NOT NULL,
    scheduling_room character varying(255) NOT NULL,
    scheduling_room_id character varying(255) NOT NULL,
    schedule_time timestamp with time zone DEFAULT (now())::timestamp(3) with time zone,
    scheduling_date date NOT NULL,
    begin_time timestamp with time zone NOT NULL,
    end_time timestamp with time zone NOT NULL,
    inviter character varying(255) NOT NULL,
    member character varying(255) NOT NULL,
    mem_action character varying(255) DEFAULT '0'::character varying,
    remind_flag character varying(255) DEFAULT '0'::character varying,
    action_remark text DEFAULT ''::text,
    canceled boolean DEFAULT false,
    update_time timestamp with time zone DEFAULT (now())::timestamp(3) with time zone
);


ALTER TABLE public.scheduling_info OWNER TO postgres;

--
-- Name: COLUMN scheduling_info.scheduling_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.scheduling_info.scheduling_id IS '行程ID';


--
-- Name: COLUMN scheduling_info.scheduling_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.scheduling_info.scheduling_name IS '行程名字';


--
-- Name: COLUMN scheduling_info.scheduling_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.scheduling_info.scheduling_type IS '行程类型，1是会议，2是约会';


--
-- Name: COLUMN scheduling_info.scheduling_remarks; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.scheduling_info.scheduling_remarks IS '行程备注';


--
-- Name: COLUMN scheduling_info.scheduling_intr; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.scheduling_info.scheduling_intr IS '行程简介';


--
-- Name: COLUMN scheduling_info.scheduling_appointment; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.scheduling_info.scheduling_appointment IS '行程介绍';


--
-- Name: COLUMN scheduling_info.scheduling_locale; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.scheduling_info.scheduling_locale IS '行程地点';


--
-- Name: COLUMN scheduling_info.scheduling_locale_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.scheduling_info.scheduling_locale_id IS '行程地点编号';


--
-- Name: COLUMN scheduling_info.scheduling_room; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.scheduling_info.scheduling_room IS '行程房间';


--
-- Name: COLUMN scheduling_info.scheduling_room_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.scheduling_info.scheduling_room_id IS '行程房间编号';


--
-- Name: COLUMN scheduling_info.schedule_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.scheduling_info.schedule_time IS '行程约定的时间';


--
-- Name: COLUMN scheduling_info.scheduling_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.scheduling_info.scheduling_date IS '行程日期';


--
-- Name: COLUMN scheduling_info.begin_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.scheduling_info.begin_time IS '行程开始时间';


--
-- Name: COLUMN scheduling_info.end_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.scheduling_info.end_time IS '行程结束时间';


--
-- Name: COLUMN scheduling_info.inviter; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.scheduling_info.inviter IS '行程邀请者';


--
-- Name: COLUMN scheduling_info.member; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.scheduling_info.member IS '行程参与者';


--
-- Name: COLUMN scheduling_info.mem_action; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.scheduling_info.mem_action IS '行程参与者接受状态';


--
-- Name: COLUMN scheduling_info.remind_flag; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.scheduling_info.remind_flag IS '行程参与者提醒标志，0未提醒，1开始前15分钟已提醒，2结束前15分钟已提醒';


--
-- Name: COLUMN scheduling_info.action_remark; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.scheduling_info.action_remark IS '行程参与者接受时的备注';


--
-- Name: COLUMN scheduling_info.canceled; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.scheduling_info.canceled IS '行程是否被取消';


--
-- Name: COLUMN scheduling_info.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.scheduling_info.update_time IS '行程更新时间';


--
-- Name: scheduling_info_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.scheduling_info_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.scheduling_info_id_seq OWNER TO postgres;

--
-- Name: scheduling_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.scheduling_info_id_seq OWNED BY public.scheduling_info.id;


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
-- Name: startalk_dep_table; Type: TABLE; Schema: public; Owner: postgres
--

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
-- Name: startalk_role_class; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.startalk_role_class (
    id integer NOT NULL,
    role_class character varying(200) NOT NULL,
    available_flag integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.startalk_role_class OWNER TO postgres;

--
-- Name: TABLE startalk_role_class; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.startalk_role_class IS '角色分组';


--
-- Name: COLUMN startalk_role_class.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.startalk_role_class.id IS '自增id';


--
-- Name: COLUMN startalk_role_class.role_class; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.startalk_role_class.role_class IS '角色分组';


--
-- Name: COLUMN startalk_role_class.available_flag; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.startalk_role_class.available_flag IS '可用标志 1是可用 0表示不可用';


--
-- Name: startalk_role_class_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.startalk_role_class_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.startalk_role_class_id_seq OWNER TO postgres;

--
-- Name: startalk_role_class_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.startalk_role_class_id_seq OWNED BY public.startalk_role_class.id;


--
-- Name: startalk_user_role_table; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.startalk_user_role_table (
    id integer NOT NULL,
    role_name text NOT NULL,
    available_flag integer DEFAULT 1 NOT NULL,
    class_id integer NOT NULL
);


ALTER TABLE public.startalk_user_role_table OWNER TO postgres;

--
-- Name: TABLE startalk_user_role_table; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.startalk_user_role_table IS 'startalk用户角色表';


--
-- Name: COLUMN startalk_user_role_table.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.startalk_user_role_table.id IS '主键自增id';


--
-- Name: COLUMN startalk_user_role_table.role_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.startalk_user_role_table.role_name IS '角色名';


--
-- Name: COLUMN startalk_user_role_table.available_flag; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.startalk_user_role_table.available_flag IS '可用标志位,1可用 0 不可用';


--
-- Name: COLUMN startalk_user_role_table.class_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.startalk_user_role_table.class_id IS '角色所属组别的ID';


--
-- Name: startalk_user_role_table_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.startalk_user_role_table_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.startalk_user_role_table_id_seq OWNER TO postgres;

--
-- Name: startalk_user_role_table_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.startalk_user_role_table_id_seq OWNED BY public.startalk_user_role_table.id;


--
-- Name: statistic_qtalk_click_event; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.statistic_qtalk_click_event (
    id bigint NOT NULL,
    client_platform character varying(100),
    client_version character varying(100),
    client_brand character varying(100),
    client_model character varying(100),
    click_event character varying(100),
    click_day date,
    click_cnt bigint,
    del_flag integer DEFAULT 0 NOT NULL,
    create_time timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.statistic_qtalk_click_event OWNER TO postgres;

--
-- Name: TABLE statistic_qtalk_click_event; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.statistic_qtalk_click_event IS '点击统计数据表';


--
-- Name: COLUMN statistic_qtalk_click_event.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.statistic_qtalk_click_event.id IS '主键';


--
-- Name: COLUMN statistic_qtalk_click_event.client_platform; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.statistic_qtalk_click_event.client_platform IS '所属平台';


--
-- Name: COLUMN statistic_qtalk_click_event.client_version; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.statistic_qtalk_click_event.client_version IS '客户端版本号';


--
-- Name: COLUMN statistic_qtalk_click_event.client_brand; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.statistic_qtalk_click_event.client_brand IS '客户端品牌';


--
-- Name: COLUMN statistic_qtalk_click_event.client_model; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.statistic_qtalk_click_event.client_model IS '客户端型号';


--
-- Name: COLUMN statistic_qtalk_click_event.click_event; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.statistic_qtalk_click_event.click_event IS '点击事件';


--
-- Name: COLUMN statistic_qtalk_click_event.click_day; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.statistic_qtalk_click_event.click_day IS '日期(天)';


--
-- Name: COLUMN statistic_qtalk_click_event.del_flag; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.statistic_qtalk_click_event.del_flag IS '删除标识 0 - 未删除 1 - 删除';


--
-- Name: COLUMN statistic_qtalk_click_event.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.statistic_qtalk_click_event.create_time IS '创建时间';


--
-- Name: statistic_qtalk_click_event_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.statistic_qtalk_click_event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.statistic_qtalk_click_event_id_seq OWNER TO postgres;

--
-- Name: statistic_qtalk_click_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.statistic_qtalk_click_event_id_seq OWNED BY public.statistic_qtalk_click_event.id;


--
-- Name: sys_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_permission (
    id integer NOT NULL,
    url character varying(200) NOT NULL,
    describe character varying(100) NOT NULL,
    create_time timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    status integer DEFAULT 0,
    sub_permission_ids integer[],
    navigation_flag integer DEFAULT 0
);


ALTER TABLE public.sys_permission OWNER TO postgres;

--
-- Name: COLUMN sys_permission.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_permission.id IS '自增id';


--
-- Name: COLUMN sys_permission.url; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_permission.url IS '权限地址';


--
-- Name: COLUMN sys_permission.describe; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_permission.describe IS '权限描述';


--
-- Name: COLUMN sys_permission.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_permission.create_time IS '创建时间';


--
-- Name: COLUMN sys_permission.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_permission.update_time IS '更新时间';


--
-- Name: COLUMN sys_permission.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_permission.status IS '0:导航栏不显示,1:导航栏显示';


--
-- Name: COLUMN sys_permission.sub_permission_ids; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_permission.sub_permission_ids IS '子权限id列表';


--
-- Name: COLUMN sys_permission.navigation_flag; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_permission.navigation_flag IS '是否映射导航栏';


--
-- Name: sys_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_permission_id_seq OWNER TO postgres;

--
-- Name: sys_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_permission_id_seq OWNED BY public.sys_permission.id;


--
-- Name: sys_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_role (
    id integer NOT NULL,
    describe character varying(100) NOT NULL,
    create_time timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time timestamp(6) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    role_name character varying(100)
);


ALTER TABLE public.sys_role OWNER TO postgres;

--
-- Name: COLUMN sys_role.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_role.id IS '自增id';


--
-- Name: COLUMN sys_role.describe; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_role.describe IS '角色描述';


--
-- Name: COLUMN sys_role.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_role.create_time IS '创建时间';


--
-- Name: COLUMN sys_role.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_role.update_time IS '更新时间';


--
-- Name: COLUMN sys_role.role_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_role.role_name IS '角色名称';


--
-- Name: sys_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_role_id_seq OWNER TO postgres;

--
-- Name: sys_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_role_id_seq OWNED BY public.sys_role.id;


--
-- Name: sys_role_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_role_permission (
    id integer NOT NULL,
    role_id integer,
    permission_id integer
);


ALTER TABLE public.sys_role_permission OWNER TO postgres;

--
-- Name: COLUMN sys_role_permission.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_role_permission.id IS '自增id';


--
-- Name: COLUMN sys_role_permission.role_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_role_permission.role_id IS '角色id';


--
-- Name: COLUMN sys_role_permission.permission_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_role_permission.permission_id IS '权限id';


--
-- Name: sys_role_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_role_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_role_permission_id_seq OWNER TO postgres;

--
-- Name: sys_role_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_role_permission_id_seq OWNED BY public.sys_role_permission.id;


--
-- Name: sys_user_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_user_role (
    id integer NOT NULL,
    role_id integer,
    user_id character varying(60) NOT NULL
);


ALTER TABLE public.sys_user_role OWNER TO postgres;

--
-- Name: COLUMN sys_user_role.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_user_role.id IS '自增id';


--
-- Name: COLUMN sys_user_role.role_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_user_role.role_id IS '角色id';


--
-- Name: COLUMN sys_user_role.user_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_user_role.user_id IS '用户id';


--
-- Name: sys_user_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_user_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_user_role_id_seq OWNER TO postgres;

--
-- Name: sys_user_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_user_role_id_seq OWNED BY public.sys_user_role.id;


--
-- Name: t_client_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_client_log (
    id bigint NOT NULL,
    u_id character varying(20),
    u_domain character varying(20),
    d_os character varying(10),
    d_brand character varying(100),
    d_model character varying(30),
    d_plat character varying(10),
    d_ip character varying(15),
    d_lat character varying(30),
    d_lgt character varying(40),
    l_type character varying(10),
    l_sub_type character varying(10),
    l_report_time character varying(50),
    l_data text,
    l_device_data jsonb,
    l_user_data jsonb,
    l_version_code character varying(50),
    l_version_name character varying(50),
    create_time timestamp without time zone DEFAULT now(),
    l_client_event character varying(50),
    d_platform character varying(50),
    l_event_id character varying(500),
    l_current_page character varying(50)
);


ALTER TABLE public.t_client_log OWNER TO postgres;

--
-- Name: COLUMN t_client_log.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_client_log.id IS '主键id';


--
-- Name: COLUMN t_client_log.u_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_client_log.u_id IS '用户id';


--
-- Name: COLUMN t_client_log.u_domain; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_client_log.u_domain IS '域名 eg:ejabhost1';


--
-- Name: COLUMN t_client_log.d_os; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_client_log.d_os IS '操作系统 LINUX、Android、Mac、iOS、PC64、android';


--
-- Name: COLUMN t_client_log.d_brand; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_client_log.d_brand IS '客户端手机品牌';


--
-- Name: COLUMN t_client_log.d_model; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_client_log.d_model IS '客户端机型';


--
-- Name: COLUMN t_client_log.d_plat; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_client_log.d_plat IS '客户端平台 startalk';


--
-- Name: COLUMN t_client_log.d_ip; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_client_log.d_ip IS '客户端ip地址';


--
-- Name: COLUMN t_client_log.d_lat; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_client_log.d_lat IS '经纬度';


--
-- Name: COLUMN t_client_log.d_lgt; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_client_log.d_lgt IS '经纬度';


--
-- Name: COLUMN t_client_log.l_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_client_log.l_type IS '日志类型，CAT、COD、ACT、CRA、FIL';


--
-- Name: COLUMN t_client_log.l_sub_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_client_log.l_sub_type IS '日志子类型';


--
-- Name: COLUMN t_client_log.l_report_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_client_log.l_report_time IS '上报时间';


--
-- Name: COLUMN t_client_log.l_data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_client_log.l_data IS '原始日志';


--
-- Name: COLUMN t_client_log.l_device_data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_client_log.l_device_data IS '设备日志';


--
-- Name: COLUMN t_client_log.l_user_data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_client_log.l_user_data IS '用户日志';


--
-- Name: COLUMN t_client_log.l_version_code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_client_log.l_version_code IS '版本编号 221';


--
-- Name: COLUMN t_client_log.l_version_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_client_log.l_version_name IS '版本名称 3.1.5';


--
-- Name: COLUMN t_client_log.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_client_log.create_time IS '创建时间';


--
-- Name: COLUMN t_client_log.l_client_event; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_client_log.l_client_event IS '事件名称 eg：搜索、拉取历史耗时';


--
-- Name: COLUMN t_client_log.d_platform; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_client_log.d_platform IS '所属平台，与d_os类型，只是经过了转小写处理, ios/linux/mac/pc32/pc64/android ';


--
-- Name: COLUMN t_client_log.l_event_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_client_log.l_event_id IS '事件id';


--
-- Name: COLUMN t_client_log.l_current_page; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_client_log.l_current_page IS '当前页';


--
-- Name: t_client_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.t_client_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.t_client_log_id_seq OWNER TO postgres;

--
-- Name: t_client_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.t_client_log_id_seq OWNED BY public.t_client_log.id;


--
-- Name: t_dict_client_brand; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_dict_client_brand (
    id bigint NOT NULL,
    brand character varying(100),
    platform character varying(100),
    del_flag integer DEFAULT 0 NOT NULL,
    create_time timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.t_dict_client_brand OWNER TO postgres;

--
-- Name: TABLE t_dict_client_brand; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.t_dict_client_brand IS '品牌渠道字典表';


--
-- Name: COLUMN t_dict_client_brand.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_dict_client_brand.id IS '主键';


--
-- Name: COLUMN t_dict_client_brand.brand; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_dict_client_brand.brand IS '客户端手机品牌';


--
-- Name: COLUMN t_dict_client_brand.platform; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_dict_client_brand.platform IS '品牌所属平台';


--
-- Name: COLUMN t_dict_client_brand.del_flag; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_dict_client_brand.del_flag IS '删除标识 0 - 未删除 1 - 删除';


--
-- Name: COLUMN t_dict_client_brand.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_dict_client_brand.create_time IS '创建时间';


--
-- Name: t_dict_client_brand_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.t_dict_client_brand_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.t_dict_client_brand_id_seq OWNER TO postgres;

--
-- Name: t_dict_client_brand_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.t_dict_client_brand_id_seq OWNED BY public.t_dict_client_brand.id;


--
-- Name: t_dict_client_event; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_dict_client_event (
    id bigint NOT NULL,
    event character varying(100),
    del_flag integer DEFAULT 0 NOT NULL,
    create_time timestamp with time zone DEFAULT now() NOT NULL,
    platform character varying(100)
);


ALTER TABLE public.t_dict_client_event OWNER TO postgres;

--
-- Name: TABLE t_dict_client_event; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.t_dict_client_event IS '点击事件字典表';


--
-- Name: COLUMN t_dict_client_event.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_dict_client_event.id IS '主键';


--
-- Name: COLUMN t_dict_client_event.event; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_dict_client_event.event IS '事件';


--
-- Name: COLUMN t_dict_client_event.del_flag; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_dict_client_event.del_flag IS '删除标识 0 - 未删除 1 - 删除';


--
-- Name: COLUMN t_dict_client_event.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_dict_client_event.create_time IS '创建时间';


--
-- Name: t_dict_client_event_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.t_dict_client_event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.t_dict_client_event_id_seq OWNER TO postgres;

--
-- Name: t_dict_client_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.t_dict_client_event_id_seq OWNED BY public.t_dict_client_event.id;


--
-- Name: t_dict_client_model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_dict_client_model (
    id bigint NOT NULL,
    client_model character varying(100),
    client_brand character varying(100),
    platform character varying(100),
    del_flag integer DEFAULT 0 NOT NULL,
    create_time timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.t_dict_client_model OWNER TO postgres;

--
-- Name: TABLE t_dict_client_model; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.t_dict_client_model IS '机型字典表';


--
-- Name: COLUMN t_dict_client_model.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_dict_client_model.id IS '主键';


--
-- Name: COLUMN t_dict_client_model.client_model; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_dict_client_model.client_model IS '机型';


--
-- Name: COLUMN t_dict_client_model.client_brand; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_dict_client_model.client_brand IS '品牌';


--
-- Name: COLUMN t_dict_client_model.platform; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_dict_client_model.platform IS '所属平台';


--
-- Name: COLUMN t_dict_client_model.del_flag; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_dict_client_model.del_flag IS '删除标识 0 - 未删除 1 - 删除';


--
-- Name: COLUMN t_dict_client_model.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_dict_client_model.create_time IS '创建时间';


--
-- Name: t_dict_client_model_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.t_dict_client_model_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.t_dict_client_model_id_seq OWNER TO postgres;

--
-- Name: t_dict_client_model_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.t_dict_client_model_id_seq OWNED BY public.t_dict_client_model.id;


--
-- Name: t_dict_client_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_dict_client_version (
    id bigint NOT NULL,
    client_version character varying(100),
    platform character varying(100),
    del_flag integer DEFAULT 0 NOT NULL,
    create_time timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.t_dict_client_version OWNER TO postgres;

--
-- Name: TABLE t_dict_client_version; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.t_dict_client_version IS '客户端版本字典表';


--
-- Name: COLUMN t_dict_client_version.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_dict_client_version.id IS '主键';


--
-- Name: COLUMN t_dict_client_version.client_version; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_dict_client_version.client_version IS 'qtalk客户端版本';


--
-- Name: COLUMN t_dict_client_version.platform; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_dict_client_version.platform IS '所属平台';


--
-- Name: COLUMN t_dict_client_version.del_flag; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_dict_client_version.del_flag IS '删除标识 0 - 未删除 1 - 删除';


--
-- Name: COLUMN t_dict_client_version.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_dict_client_version.create_time IS '创建时间';


--
-- Name: t_dict_client_version_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.t_dict_client_version_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.t_dict_client_version_id_seq OWNER TO postgres;

--
-- Name: t_dict_client_version_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.t_dict_client_version_id_seq OWNED BY public.t_dict_client_version.id;


--
-- Name: user_friends; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_friends (
    username text NOT NULL,
    friend text NOT NULL,
    relationship smallint,
    version integer,
    host text DEFAULT 'ejabhost1'::text NOT NULL,
    userhost character varying(255) DEFAULT 'ejabhost1'::character varying
);


ALTER TABLE public.user_friends OWNER TO postgres;

--
-- Name: user_register_mucs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_register_mucs (
    username text NOT NULL,
    muc_name text NOT NULL,
    domain character varying(200) NOT NULL,
    created_at timestamp with time zone DEFAULT (now())::timestamp(3) with time zone NOT NULL,
    registed_flag integer DEFAULT 1,
    host text DEFAULT 'ejabhost1'::text NOT NULL
);


ALTER TABLE public.user_register_mucs OWNER TO postgres;

--
-- Name: user_register_mucs_backup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_register_mucs_backup (
    username text NOT NULL,
    muc_name text NOT NULL,
    domain character varying(200) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    registed_flag integer DEFAULT 1
);


ALTER TABLE public.user_register_mucs_backup OWNER TO postgres;

--
-- Name: user_relation_opts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_relation_opts (
    username text NOT NULL,
    rec_msg_opt smallint DEFAULT (2)::smallint,
    vld_friend_opt smallint DEFAULT (1)::smallint,
    validate_quetion text,
    validate_answer text,
    vesion smallint,
    userhost text DEFAULT 'ejabhost1'::text
);


ALTER TABLE public.user_relation_opts OWNER TO postgres;

--
-- Name: vcard_version; Type: TABLE; Schema: public; Owner: postgres
--

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
-- Name: vpn_account_list; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vpn_account_list (
    id bigint NOT NULL,
    username text NOT NULL,
    pin_code text DEFAULT ''::text,
    password text NOT NULL,
    is_enabled character varying(1) DEFAULT 'n'::character varying NOT NULL,
    create_timestamp double precision DEFAULT date_part('epoch'::text, now()) NOT NULL,
    expire_timestamp double precision DEFAULT (date_part('epoch'::text, (now() + '3 mons'::interval)) - (1)::double precision) NOT NULL,
    CONSTRAINT vpn_account_list_is_enabled_check CHECK (((is_enabled)::text = ANY (ARRAY[('d'::character varying)::text, ('n'::character varying)::text, ('y'::character varying)::text])))
);


ALTER TABLE public.vpn_account_list OWNER TO postgres;

--
-- Name: vpn_account_list_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vpn_account_list_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vpn_account_list_id_seq OWNER TO postgres;

--
-- Name: vpn_account_list_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vpn_account_list_id_seq OWNED BY public.vpn_account_list.id;


--
-- Name: warn_msg_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.warn_msg_history (
    id bigint NOT NULL,
    m_from character varying(255),
    m_to character varying(255),
    read_flag smallint DEFAULT 0,
    msg_id text,
    from_host text,
    to_host text,
    m_body text,
    create_time timestamp with time zone DEFAULT now()
);


ALTER TABLE public.warn_msg_history OWNER TO postgres;

--
-- Name: warn_msg_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.warn_msg_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.warn_msg_history_id_seq OWNER TO postgres;

--
-- Name: warn_msg_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.warn_msg_history_id_seq OWNED BY public.warn_msg_history.id;


--
-- Name: warn_msg_history_backup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.warn_msg_history_backup (
    id bigint DEFAULT nextval('public.warn_msg_history_id_seq'::regclass) NOT NULL,
    m_from character varying(255),
    m_to character varying(255),
    read_flag smallint DEFAULT 0,
    msg_id text,
    from_host text,
    to_host text,
    m_body text,
    create_time timestamp with time zone DEFAULT now()
);


ALTER TABLE public.warn_msg_history_backup OWNER TO postgres;

--
-- Name: white_list; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.white_list (
    username text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    single_flag text DEFAULT '1'::text
);


ALTER TABLE public.white_list OWNER TO postgres;

--
-- Name: client_config_sync id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_config_sync ALTER COLUMN id SET DEFAULT nextval('public.client_config_sync_id_seq'::regclass);


--
-- Name: client_upgrade id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_upgrade ALTER COLUMN id SET DEFAULT nextval('public.client_upgrade_id_seq'::regclass);


--
-- Name: data_board_day id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_board_day ALTER COLUMN id SET DEFAULT nextval('public.data_board_day_id_seq'::regclass);


--
-- Name: destroy_muc_info id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.destroy_muc_info ALTER COLUMN id SET DEFAULT nextval('public.destroy_muc_info_id_seq'::regclass);


--
-- Name: find_application_table id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.find_application_table ALTER COLUMN id SET DEFAULT nextval('public.find_application_table_id_seq'::regclass);


--
-- Name: find_class_table id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.find_class_table ALTER COLUMN id SET DEFAULT nextval('public.find_class_table_id_seq'::regclass);


--
-- Name: flogin_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flogin_user ALTER COLUMN id SET DEFAULT nextval('public.flogin_user_id_seq'::regclass);


--
-- Name: fresh_empl_entering id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fresh_empl_entering ALTER COLUMN id SET DEFAULT nextval('public.fresh_empl_entering_id_seq'::regclass);


--
-- Name: host_info id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.host_info ALTER COLUMN id SET DEFAULT nextval('public.host_info_id_seq'::regclass);


--
-- Name: host_users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.host_users ALTER COLUMN id SET DEFAULT nextval('public.host_users_id_seq'::regclass);


--
-- Name: login_data id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login_data ALTER COLUMN id SET DEFAULT nextval('public.login_data_id_seq'::regclass);


--
-- Name: meeting_info id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meeting_info ALTER COLUMN id SET DEFAULT nextval('public.meeting_info_id_seq'::regclass);


--
-- Name: msg_history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.msg_history ALTER COLUMN id SET DEFAULT nextval('public.msg_history_id_seq'::regclass);


--
-- Name: muc_room_history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.muc_room_history ALTER COLUMN id SET DEFAULT nextval('public.muc_room_history_id_seq'::regclass);


--
-- Name: muc_user_mark id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.muc_user_mark ALTER COLUMN id SET DEFAULT nextval('public.muc_user_mark_id_seq'::regclass);


--
-- Name: notice_history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notice_history ALTER COLUMN id SET DEFAULT nextval('public.notice_history_id_seq'::regclass);


--
-- Name: privacy_list id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.privacy_list ALTER COLUMN id SET DEFAULT nextval('public.privacy_list_id_seq'::regclass);


--
-- Name: pubsub_node nodeid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pubsub_node ALTER COLUMN nodeid SET DEFAULT nextval('public.pubsub_node_nodeid_seq'::regclass);


--
-- Name: pubsub_state stateid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pubsub_state ALTER COLUMN stateid SET DEFAULT nextval('public.pubsub_state_stateid_seq'::regclass);


--
-- Name: push_info id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.push_info ALTER COLUMN id SET DEFAULT nextval('public.push_info_id_seq'::regclass);


--
-- Name: qcloud_main id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qcloud_main ALTER COLUMN id SET DEFAULT nextval('public.qcloud_main_id_seq'::regclass);


--
-- Name: qcloud_main_history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qcloud_main_history ALTER COLUMN id SET DEFAULT nextval('public.qcloud_main_history_id_seq'::regclass);


--
-- Name: qcloud_sub id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qcloud_sub ALTER COLUMN id SET DEFAULT nextval('public.qcloud_sub_id_seq'::regclass);


--
-- Name: qcloud_sub_history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qcloud_sub_history ALTER COLUMN id SET DEFAULT nextval('public.qcloud_sub_history_id_seq'::regclass);


--
-- Name: qtalk_config id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qtalk_config ALTER COLUMN id SET DEFAULT nextval('public.qtalk_config_id_seq'::regclass);


--
-- Name: qtalk_user_comment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qtalk_user_comment ALTER COLUMN id SET DEFAULT nextval('public.qtalk_user_comment_id_seq'::regclass);


--
-- Name: revoke_msg_history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revoke_msg_history ALTER COLUMN id SET DEFAULT nextval('public.revoke_msg_history_id_seq'::regclass);


--
-- Name: scheduling_info id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scheduling_info ALTER COLUMN id SET DEFAULT nextval('public.scheduling_info_id_seq'::regclass);


--
-- Name: startalk_dep_setting id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.startalk_dep_setting ALTER COLUMN id SET DEFAULT nextval('public.startalk_dep_setting_id_seq'::regclass);


--
-- Name: startalk_dep_table id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.startalk_dep_table ALTER COLUMN id SET DEFAULT nextval('public.startalk_dep_table_id_seq'::regclass);


--
-- Name: startalk_role_class id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.startalk_role_class ALTER COLUMN id SET DEFAULT nextval('public.startalk_role_class_id_seq'::regclass);


--
-- Name: startalk_user_role_table id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.startalk_user_role_table ALTER COLUMN id SET DEFAULT nextval('public.startalk_user_role_table_id_seq'::regclass);


--
-- Name: statistic_qtalk_click_event id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statistic_qtalk_click_event ALTER COLUMN id SET DEFAULT nextval('public.statistic_qtalk_click_event_id_seq'::regclass);


--
-- Name: sys_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_permission ALTER COLUMN id SET DEFAULT nextval('public.sys_permission_id_seq'::regclass);


--
-- Name: sys_role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_role ALTER COLUMN id SET DEFAULT nextval('public.sys_role_id_seq'::regclass);


--
-- Name: sys_role_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_role_permission ALTER COLUMN id SET DEFAULT nextval('public.sys_role_permission_id_seq'::regclass);


--
-- Name: sys_user_role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_user_role ALTER COLUMN id SET DEFAULT nextval('public.sys_user_role_id_seq'::regclass);


--
-- Name: t_client_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_client_log ALTER COLUMN id SET DEFAULT nextval('public.t_client_log_id_seq'::regclass);


--
-- Name: t_dict_client_brand id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_dict_client_brand ALTER COLUMN id SET DEFAULT nextval('public.t_dict_client_brand_id_seq'::regclass);


--
-- Name: t_dict_client_event id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_dict_client_event ALTER COLUMN id SET DEFAULT nextval('public.t_dict_client_event_id_seq'::regclass);


--
-- Name: t_dict_client_model id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_dict_client_model ALTER COLUMN id SET DEFAULT nextval('public.t_dict_client_model_id_seq'::regclass);


--
-- Name: t_dict_client_version id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_dict_client_version ALTER COLUMN id SET DEFAULT nextval('public.t_dict_client_version_id_seq'::regclass);


--
-- Name: vcard_version id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vcard_version ALTER COLUMN id SET DEFAULT nextval('public.vcard_version_id_seq'::regclass);


--
-- Name: vpn_account_list id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vpn_account_list ALTER COLUMN id SET DEFAULT nextval('public.vpn_account_list_id_seq'::regclass);


--
-- Name: warn_msg_history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.warn_msg_history ALTER COLUMN id SET DEFAULT nextval('public.warn_msg_history_id_seq'::regclass);


--
-- Name: admin_user admin_user_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_user
    ADD CONSTRAINT admin_user_pk PRIMARY KEY (username);


--
-- Name: client_config_sync client_config_sync_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_config_sync
    ADD CONSTRAINT client_config_sync_pkey PRIMARY KEY (id);


--
-- Name: client_upgrade client_upgrade_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_upgrade
    ADD CONSTRAINT client_upgrade_pkey PRIMARY KEY (id);


--
-- Name: data_board_day data_board_day_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_board_day
    ADD CONSTRAINT data_board_day_pkey PRIMARY KEY (id);


--
-- Name: destroy_muc_info destroy_muc_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.destroy_muc_info
    ADD CONSTRAINT destroy_muc_info_pkey PRIMARY KEY (id);


--
-- Name: find_application_table find_application_table_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.find_application_table
    ADD CONSTRAINT find_application_table_pk PRIMARY KEY (id);


--
-- Name: find_class_table find_class_table_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.find_class_table
    ADD CONSTRAINT find_class_table_pk PRIMARY KEY (id);


--
-- Name: flogin_user flogin_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flogin_user
    ADD CONSTRAINT flogin_user_pkey PRIMARY KEY (id);


--
-- Name: fresh_empl_entering fresh_empl_entering_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fresh_empl_entering
    ADD CONSTRAINT fresh_empl_entering_pkey PRIMARY KEY (id);


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
-- Name: last last_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.last
    ADD CONSTRAINT last_pkey PRIMARY KEY (username);


--
-- Name: login_data login_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login_data
    ADD CONSTRAINT login_data_pkey PRIMARY KEY (id);


--
-- Name: meeting_info meeting_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meeting_info
    ADD CONSTRAINT meeting_info_pkey PRIMARY KEY (id);


--
-- Name: motd motd_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motd
    ADD CONSTRAINT motd_pkey PRIMARY KEY (username);


--
-- Name: msg_history_backup msg_history_backup_tmp_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.msg_history_backup
    ADD CONSTRAINT msg_history_backup_tmp_pkey PRIMARY KEY (id);


--
-- Name: muc_last muc_last_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.muc_last
    ADD CONSTRAINT muc_last_pkey PRIMARY KEY (muc_name);


--
-- Name: muc_room_history_backup muc_room_history_2016_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.muc_room_history_backup
    ADD CONSTRAINT muc_room_history_2016_pkey PRIMARY KEY (id);


--
-- Name: muc_room_history muc_room_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.muc_room_history
    ADD CONSTRAINT muc_room_history_pkey PRIMARY KEY (id);


--
-- Name: muc_room_users muc_room_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.muc_room_users
    ADD CONSTRAINT muc_room_users_pkey PRIMARY KEY (id);


--
-- Name: muc_user_mark muc_user_mark_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.muc_user_mark
    ADD CONSTRAINT muc_user_mark_pkey PRIMARY KEY (id);


--
-- Name: muc_vcard_info muc_vcard_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.muc_vcard_info
    ADD CONSTRAINT muc_vcard_info_pkey PRIMARY KEY (muc_name);


--
-- Name: notice_history notice_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notice_history
    ADD CONSTRAINT notice_history_pkey PRIMARY KEY (id);


--
-- Name: persistent_logins persistent_logins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persistent_logins
    ADD CONSTRAINT persistent_logins_pkey PRIMARY KEY (series);


--
-- Name: iplimit pk_iplimit; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.iplimit
    ADD CONSTRAINT pk_iplimit PRIMARY KEY (ip, name, priority);


--
-- Name: user_friends pk_user_friends; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_friends
    ADD CONSTRAINT pk_user_friends PRIMARY KEY (username, friend, host);


--
-- Name: privacy_default_list privacy_default_list_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.privacy_default_list
    ADD CONSTRAINT privacy_default_list_pkey PRIMARY KEY (username);


--
-- Name: privacy_list privacy_list_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.privacy_list
    ADD CONSTRAINT privacy_list_id_key UNIQUE (id);


--
-- Name: pubsub_node pubsub_node_nodeid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pubsub_node
    ADD CONSTRAINT pubsub_node_nodeid_key UNIQUE (nodeid);


--
-- Name: pubsub_state pubsub_state_stateid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pubsub_state
    ADD CONSTRAINT pubsub_state_stateid_key UNIQUE (stateid);


--
-- Name: push_info push_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.push_info
    ADD CONSTRAINT push_info_pkey PRIMARY KEY (id);


--
-- Name: qcloud_main_history qcloud_main_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qcloud_main_history
    ADD CONSTRAINT qcloud_main_history_pkey PRIMARY KEY (id);


--
-- Name: qcloud_main qcloud_main_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qcloud_main
    ADD CONSTRAINT qcloud_main_pkey PRIMARY KEY (id);


--
-- Name: qcloud_sub_history qcloud_sub_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qcloud_sub_history
    ADD CONSTRAINT qcloud_sub_history_pkey PRIMARY KEY (id);


--
-- Name: qcloud_sub qcloud_sub_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qcloud_sub
    ADD CONSTRAINT qcloud_sub_pkey PRIMARY KEY (id);


--
-- Name: qtalk_config qtalk_config_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qtalk_config
    ADD CONSTRAINT qtalk_config_pkey PRIMARY KEY (id);


--
-- Name: qtalk_user_comment qtalk_user_comment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qtalk_user_comment
    ADD CONSTRAINT qtalk_user_comment_pkey PRIMARY KEY (id);


--
-- Name: recv_msg_option recv_msg_option_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recv_msg_option
    ADD CONSTRAINT recv_msg_option_pkey PRIMARY KEY (username);


--
-- Name: revoke_msg_history_backup revoke_msg_history_backup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revoke_msg_history_backup
    ADD CONSTRAINT revoke_msg_history_backup_pkey PRIMARY KEY (id);


--
-- Name: revoke_msg_history revoke_msg_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revoke_msg_history
    ADD CONSTRAINT revoke_msg_history_pkey PRIMARY KEY (id);


--
-- Name: s2s_mapped_host s2s_mapped_host_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.s2s_mapped_host
    ADD CONSTRAINT s2s_mapped_host_pkey PRIMARY KEY (domain, host);


--
-- Name: scheduling_info scheduling_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scheduling_info
    ADD CONSTRAINT scheduling_info_pkey PRIMARY KEY (id);


--
-- Name: startalk_dep_setting startalk_dep_setting_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.startalk_dep_setting
    ADD CONSTRAINT startalk_dep_setting_pkey PRIMARY KEY (id);


--
-- Name: startalk_dep_table startalk_dep_table_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.startalk_dep_table
    ADD CONSTRAINT startalk_dep_table_pk PRIMARY KEY (id);


--
-- Name: startalk_role_class startalk_role_class_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.startalk_role_class
    ADD CONSTRAINT startalk_role_class_pk PRIMARY KEY (id);


--
-- Name: startalk_user_role_table startalk_user_role_table_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.startalk_user_role_table
    ADD CONSTRAINT startalk_user_role_table_pk PRIMARY KEY (id);


--
-- Name: startalk_user_role_table startalk_user_role_table_pk_2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.startalk_user_role_table
    ADD CONSTRAINT startalk_user_role_table_pk_2 UNIQUE (role_name, class_id);


--
-- Name: statistic_qtalk_click_event statistic_qtalk_click_event_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statistic_qtalk_click_event
    ADD CONSTRAINT statistic_qtalk_click_event_pkey PRIMARY KEY (id);


--
-- Name: sys_permission sys_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_permission
    ADD CONSTRAINT sys_permission_pkey PRIMARY KEY (id);


--
-- Name: sys_role_permission sys_role_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_role_permission
    ADD CONSTRAINT sys_role_permission_pkey PRIMARY KEY (id);


--
-- Name: sys_role sys_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_role
    ADD CONSTRAINT sys_role_pkey PRIMARY KEY (id);


--
-- Name: sys_user_role sys_user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_user_role
    ADD CONSTRAINT sys_user_role_pkey PRIMARY KEY (id);


--
-- Name: t_client_log t_client_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_client_log
    ADD CONSTRAINT t_client_log_pkey PRIMARY KEY (id);


--
-- Name: t_dict_client_brand t_dict_client_brand_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_dict_client_brand
    ADD CONSTRAINT t_dict_client_brand_pkey PRIMARY KEY (id);


--
-- Name: t_dict_client_event t_dict_client_event_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_dict_client_event
    ADD CONSTRAINT t_dict_client_event_pkey PRIMARY KEY (id);


--
-- Name: t_dict_client_model t_dict_client_model_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_dict_client_model
    ADD CONSTRAINT t_dict_client_model_pkey PRIMARY KEY (id);


--
-- Name: t_dict_client_version t_dict_client_version_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_dict_client_version
    ADD CONSTRAINT t_dict_client_version_pkey PRIMARY KEY (id);


--
-- Name: t_dict_client_brand uk_tbcb_unique_index_brand; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_dict_client_brand
    ADD CONSTRAINT uk_tbcb_unique_index_brand UNIQUE (brand);


--
-- Name: t_dict_client_version uk_tbcv_unique_index_version; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_dict_client_version
    ADD CONSTRAINT uk_tbcv_unique_index_version UNIQUE (client_version);


--
-- Name: user_register_mucs_backup user_register_mucs_backup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_register_mucs_backup
    ADD CONSTRAINT user_register_mucs_backup_pkey PRIMARY KEY (muc_name, username);


--
-- Name: user_register_mucs user_register_mucs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_register_mucs
    ADD CONSTRAINT user_register_mucs_pkey PRIMARY KEY (muc_name, username);


--
-- Name: user_relation_opts user_relation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_relation_opts
    ADD CONSTRAINT user_relation_pkey PRIMARY KEY (username);


--
-- Name: vcard_version vcard_version_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vcard_version
    ADD CONSTRAINT vcard_version_pkey PRIMARY KEY (id);


--
-- Name: vpn_account_list vpn_account_list_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vpn_account_list
    ADD CONSTRAINT vpn_account_list_pkey PRIMARY KEY (id);


--
-- Name: vpn_account_list vpn_account_list_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vpn_account_list
    ADD CONSTRAINT vpn_account_list_username_key UNIQUE (username);


--
-- Name: warn_msg_history_backup warn_msg_history_backup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.warn_msg_history_backup
    ADD CONSTRAINT warn_msg_history_backup_pkey PRIMARY KEY (id);


--
-- Name: warn_msg_history warn_msg_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.warn_msg_history
    ADD CONSTRAINT warn_msg_history_pkey PRIMARY KEY (id);


--
-- Name: white_list white_list_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.white_list
    ADD CONSTRAINT white_list_pkey PRIMARY KEY (username);


--
-- Name: client_config_sync_configkey__idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX client_config_sync_configkey__idx ON public.client_config_sync USING btree (configkey);


--
-- Name: client_config_sync_host__idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX client_config_sync_host__idx ON public.client_config_sync USING btree (host);


--
-- Name: client_config_sync_operate_plat__idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX client_config_sync_operate_plat__idx ON public.client_config_sync USING btree (operate_plat);


--
-- Name: client_config_sync_update_time__idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX client_config_sync_update_time__idx ON public.client_config_sync USING btree (update_time);


--
-- Name: client_config_sync_username__idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX client_config_sync_username__idx ON public.client_config_sync USING btree (username);


--
-- Name: client_config_sync_username_host_configkey_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX client_config_sync_username_host_configkey_idx ON public.client_config_sync USING btree (username, host, configkey);


--
-- Name: client_config_sync_username_host_configkey_subkey_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX client_config_sync_username_host_configkey_subkey_idx ON public.client_config_sync USING btree (username, host, configkey, subkey);


--
-- Name: client_config_sync_username_host_configkey_subkey_version_i_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX client_config_sync_username_host_configkey_subkey_version_i_idx ON public.client_config_sync USING btree (username, host, configkey, subkey, version, isdel);


--
-- Name: client_config_sync_username_host_configkey_subkey_version_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX client_config_sync_username_host_configkey_subkey_version_idx ON public.client_config_sync USING btree (username, host, configkey, subkey, version);


--
-- Name: client_config_sync_username_host_configkey_subkey_version_isdel; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX client_config_sync_username_host_configkey_subkey_version_isdel ON public.client_config_sync USING btree (username, host, configkey, subkey, version, isdel);


--
-- Name: client_config_sync_username_host_configkey_version_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX client_config_sync_username_host_configkey_version_idx ON public.client_config_sync USING btree (username, host, configkey, version);


--
-- Name: client_config_sync_username_host_configkey_version_isdel_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX client_config_sync_username_host_configkey_version_isdel_idx ON public.client_config_sync USING btree (username, host, configkey, version, isdel);


--
-- Name: client_config_sync_username_host_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX client_config_sync_username_host_idx ON public.client_config_sync USING btree (username, host);


--
-- Name: client_config_sync_version__idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX client_config_sync_version__idx ON public.client_config_sync USING btree (version);


--
-- Name: client_upgrade_client_type_platform_version_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX client_upgrade_client_type_platform_version_uindex ON public.client_upgrade USING btree (client_type, platform, version);


--
-- Name: destroy_muc_info_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX destroy_muc_info_created_at_idx ON public.destroy_muc_info USING btree (created_at);


--
-- Name: destroy_muc_info_muc_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX destroy_muc_info_muc_index ON public.destroy_muc_info USING btree (muc_name);


--
-- Name: destroy_muc_info_muc_name_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX destroy_muc_info_muc_name_created_at_idx ON public.destroy_muc_info USING btree (muc_name, created_at);


--
-- Name: destroy_muc_info_nick_name_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX destroy_muc_info_nick_name_created_at_idx ON public.destroy_muc_info USING btree (nick_name, created_at);


--
-- Name: destroy_muc_info_nick_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX destroy_muc_info_nick_name_idx ON public.destroy_muc_info USING btree (nick_name);


--
-- Name: event_platform_unique_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX event_platform_unique_idx ON public.t_dict_client_event USING btree (event, platform);


--
-- Name: find_application_table_application_name_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX find_application_table_application_name_index ON public.find_application_table USING btree (application_name);


--
-- Name: find_application_table_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX find_application_table_id_uindex ON public.find_application_table USING btree (id);


--
-- Name: find_class_table_group_name_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX find_class_table_group_name_uindex ON public.find_class_table USING btree (group_name);


--
-- Name: find_class_table_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX find_class_table_id_uindex ON public.find_class_table USING btree (id);


--
-- Name: fresh_empl_entering_user_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX fresh_empl_entering_user_id_idx ON public.fresh_empl_entering USING btree (user_id);


--
-- Name: host_users_hire_flag_user_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX host_users_hire_flag_user_name_idx ON public.host_users USING btree (hire_flag, user_name);


--
-- Name: host_users_host_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX host_users_host_id_idx ON public.host_users USING btree (host_id);


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
-- Name: i_irc_custom_jid_host; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX i_irc_custom_jid_host ON public.irc_custom USING btree (jid, host);


--
-- Name: i_muc_registered_jid_host; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX i_muc_registered_jid_host ON public.muc_registered USING btree (jid, host);


--
-- Name: i_muc_registered_nick; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i_muc_registered_nick ON public.muc_registered USING btree (nick);


--
-- Name: i_muc_room_history_host_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i_muc_room_history_host_idx ON public.muc_room_history USING btree (host);


--
-- Name: i_muc_room_name_host; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX i_muc_room_name_host ON public.muc_room USING btree (name, host);


--
-- Name: i_privacy_list_username; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i_privacy_list_username ON public.privacy_list USING btree (username);


--
-- Name: i_privacy_list_username_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX i_privacy_list_username_name ON public.privacy_list USING btree (username, name);


--
-- Name: i_private_storage_username; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i_private_storage_username ON public.private_storage USING btree (username);


--
-- Name: i_private_storage_username_namespace; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX i_private_storage_username_namespace ON public.private_storage USING btree (username, namespace);


--
-- Name: i_pubsub_item_itemid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i_pubsub_item_itemid ON public.pubsub_item USING btree (itemid);


--
-- Name: i_pubsub_item_tuple; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX i_pubsub_item_tuple ON public.pubsub_item USING btree (nodeid, itemid);


--
-- Name: i_pubsub_node_option_nodeid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i_pubsub_node_option_nodeid ON public.pubsub_node_option USING btree (nodeid);


--
-- Name: i_pubsub_node_owner_nodeid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i_pubsub_node_owner_nodeid ON public.pubsub_node_owner USING btree (nodeid);


--
-- Name: i_pubsub_node_parent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i_pubsub_node_parent ON public.pubsub_node USING btree (parent);


--
-- Name: i_pubsub_node_tuple; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX i_pubsub_node_tuple ON public.pubsub_node USING btree (host, node);


--
-- Name: i_pubsub_state_jid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i_pubsub_state_jid ON public.pubsub_state USING btree (jid);


--
-- Name: i_pubsub_state_tuple; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX i_pubsub_state_tuple ON public.pubsub_state USING btree (nodeid, jid);


--
-- Name: i_pubsub_subscription_opt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX i_pubsub_subscription_opt ON public.pubsub_subscription_opt USING btree (subid, opt_name);


--
-- Name: i_user_register_mucs_user_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX i_user_register_mucs_user_idx ON public.user_register_mucs USING btree (username);


--
-- Name: idx_tb_data_board; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_tb_data_board ON public.data_board_day USING btree (create_time);


--
-- Name: index_cloud_id_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_cloud_id_user ON public.qcloud_main USING btree (q_user, id);


--
-- Name: index_cloud_sub_user_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_cloud_sub_user_time ON public.qcloud_sub USING btree (q_id, qs_time);


--
-- Name: index_cloud_sub_user_time_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_cloud_sub_user_time_type ON public.qcloud_sub USING btree (q_id, qs_time, qs_type);


--
-- Name: index_cloud_user_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_cloud_user_time ON public.qcloud_main USING btree (q_user, q_time);


--
-- Name: index_cloud_user_time_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_cloud_user_time_type ON public.qcloud_main USING btree (q_user, q_time, q_type);


--
-- Name: invite_spool_username_inviter_host_ihost_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX invite_spool_username_inviter_host_ihost_idx ON public.invite_spool USING btree (username, inviter, host, ihost);


--
-- Name: login_data_login_time_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX login_data_login_time_idx ON public.login_data USING btree (login_time);


--
-- Name: login_data_logout_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX login_data_logout_at_idx ON public.login_data USING btree (logout_at);


--
-- Name: login_data_record_type_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX login_data_record_type_idx ON public.login_data USING btree (record_type);


--
-- Name: login_data_username_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX login_data_username_idx ON public.login_data USING btree (username);


--
-- Name: meeting_info_meeting_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX meeting_info_meeting_id_idx ON public.meeting_info USING btree (meeting_id);


--
-- Name: meeting_info_meeting_id_inviter_member_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX meeting_info_meeting_id_inviter_member_idx ON public.meeting_info USING btree (meeting_id, inviter, member);


--
-- Name: msg_history_backup_msg_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX msg_history_backup_msg_id_idx ON public.msg_history_backup USING btree (msg_id) WHERE (create_time >= '2017-12-05 16:00:00+00'::timestamp with time zone);


--
-- Name: msg_history_backup_msg_id_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX msg_history_backup_msg_id_idx1 ON public.msg_history_backup USING btree (msg_id);


--
-- Name: msg_history_backup_realfrom_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX msg_history_backup_realfrom_idx ON public.msg_history_backup USING btree (realfrom);


--
-- Name: msg_history_backup_realto_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX msg_history_backup_realto_idx ON public.msg_history_backup USING btree (realto);


--
-- Name: msg_history_backup_tmp_create_time_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX msg_history_backup_tmp_create_time_idx ON public.msg_history_backup USING btree (create_time);


--
-- Name: msg_history_backup_tmp_create_time_m_from_from_host_m_to_to_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX msg_history_backup_tmp_create_time_m_from_from_host_m_to_to_idx ON public.msg_history_backup USING btree (create_time, m_from, from_host, m_to, to_host);


--
-- Name: msg_history_backup_tmp_create_time_m_from_m_to_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX msg_history_backup_tmp_create_time_m_from_m_to_idx ON public.msg_history_backup USING btree (create_time, m_from, m_to);


--
-- Name: msg_history_backup_tmp_m_from_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX msg_history_backup_tmp_m_from_idx ON public.msg_history_backup USING btree (m_from);


--
-- Name: msg_history_backup_tmp_m_from_m_to_create_time_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX msg_history_backup_tmp_m_from_m_to_create_time_idx ON public.msg_history_backup USING btree (m_from, m_to, create_time);


--
-- Name: msg_history_backup_tmp_m_from_m_to_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX msg_history_backup_tmp_m_from_m_to_id_idx ON public.msg_history_backup USING btree (m_from, m_to, id);


--
-- Name: msg_history_backup_tmp_m_to_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX msg_history_backup_tmp_m_to_idx ON public.msg_history_backup USING btree (m_to);


--
-- Name: msg_history_create_time_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX msg_history_create_time_idx1 ON public.msg_history USING btree (create_time);


--
-- Name: msg_history_create_time_m_from_m_to_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX msg_history_create_time_m_from_m_to_idx1 ON public.msg_history USING btree (create_time, m_from, m_to);


--
-- Name: msg_history_from_host_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX msg_history_from_host_idx ON public.msg_history USING btree (from_host);


--
-- Name: msg_history_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX msg_history_id_idx ON public.msg_history USING btree (id);


--
-- Name: msg_history_m_from_from_host_create_time_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX msg_history_m_from_from_host_create_time_idx ON public.msg_history USING btree (m_from, from_host, create_time);


--
-- Name: msg_history_m_from_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX msg_history_m_from_idx ON public.msg_history USING btree (m_from);


--
-- Name: msg_history_m_from_m_to_create_time_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX msg_history_m_from_m_to_create_time_idx ON public.msg_history USING btree (m_from, m_to, create_time);


--
-- Name: msg_history_m_from_m_to_from_host_to_host_create_time_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX msg_history_m_from_m_to_from_host_to_host_create_time_idx ON public.msg_history USING btree (m_from, m_to, from_host, to_host, create_time);


--
-- Name: msg_history_m_from_m_to_id_create_time_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX msg_history_m_from_m_to_id_create_time_idx ON public.msg_history USING btree (m_from, m_to, id, create_time);


--
-- Name: msg_history_m_from_m_to_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX msg_history_m_from_m_to_id_idx ON public.msg_history USING btree (m_from, m_to, id);


--
-- Name: msg_history_m_to_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX msg_history_m_to_idx ON public.msg_history USING btree (m_to);


--
-- Name: msg_history_m_to_to_host_create_time_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX msg_history_m_to_to_host_create_time_idx ON public.msg_history USING btree (m_to, to_host, create_time);


--
-- Name: msg_history_msg_id_idx3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX msg_history_msg_id_idx3 ON public.msg_history USING btree (msg_id);


--
-- Name: msg_history_read_flag_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX msg_history_read_flag_idx ON public.msg_history USING btree (read_flag);


--
-- Name: msg_history_realfrom_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX msg_history_realfrom_idx ON public.msg_history USING btree (realfrom);


--
-- Name: msg_history_realto_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX msg_history_realto_idx ON public.msg_history USING btree (realto);


--
-- Name: muc_room_backup_host_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX muc_room_backup_host_idx ON public.muc_room_backup USING btree (host);


--
-- Name: muc_room_backup_name_host_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX muc_room_backup_name_host_idx ON public.muc_room_backup USING btree (name, host);


--
-- Name: muc_room_history_2016_muc_room_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX muc_room_history_2016_muc_room_name_idx ON public.muc_room_history_backup USING btree (muc_room_name);


--
-- Name: muc_room_history_backup_create_time_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX muc_room_history_backup_create_time_idx ON public.muc_room_history_backup USING btree (create_time);


--
-- Name: muc_room_history_backup_create_time_muc_room_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX muc_room_history_backup_create_time_muc_room_name_idx ON public.muc_room_history_backup USING btree (create_time, muc_room_name);


--
-- Name: muc_room_history_backup_create_time_nick_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX muc_room_history_backup_create_time_nick_idx ON public.muc_room_history_backup USING btree (create_time, nick);


--
-- Name: muc_room_history_backup_msg_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX muc_room_history_backup_msg_id_idx ON public.muc_room_history_backup USING btree (msg_id) WHERE (create_time >= '2017-12-05 16:00:00+00'::timestamp with time zone);


--
-- Name: muc_room_history_backup_msg_id_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX muc_room_history_backup_msg_id_idx1 ON public.muc_room_history_backup USING btree (msg_id);


--
-- Name: muc_room_history_create_time_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX muc_room_history_create_time_idx ON public.muc_room_history USING btree (create_time);


--
-- Name: muc_room_history_create_time_msg_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX muc_room_history_create_time_msg_id_idx ON public.muc_room_history USING btree (create_time, msg_id);


--
-- Name: muc_room_history_create_time_nick_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX muc_room_history_create_time_nick_idx ON public.muc_room_history USING btree (create_time, nick);


--
-- Name: muc_room_history_msg_id_idx2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX muc_room_history_msg_id_idx2 ON public.muc_room_history USING btree (msg_id);


--
-- Name: muc_room_history_muc_room_name_create_time_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX muc_room_history_muc_room_name_create_time_idx ON public.muc_room_history USING btree (muc_room_name, create_time);


--
-- Name: muc_room_history_muc_room_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX muc_room_history_muc_room_name_idx ON public.muc_room_history USING btree (muc_room_name);


--
-- Name: muc_room_history_nick_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX muc_room_history_nick_idx ON public.muc_room_history USING btree (nick);


--
-- Name: muc_room_host_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX muc_room_host_idx ON public.muc_room USING btree (host);


--
-- Name: muc_room_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX muc_room_name_idx ON public.muc_room USING btree (name);


--
-- Name: muc_room_users_date_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX muc_room_users_date_idx ON public.muc_room_users USING btree (date);


--
-- Name: muc_room_users_muc_name_username_date_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX muc_room_users_muc_name_username_date_idx ON public.muc_room_users USING btree (muc_name, username, date);


--
-- Name: muc_room_users_muc_name_username_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX muc_room_users_muc_name_username_idx ON public.muc_room_users USING btree (muc_name, username);


--
-- Name: muc_room_users_username_date_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX muc_room_users_username_date_idx ON public.muc_room_users USING btree (username, date);


--
-- Name: muc_room_users_username_host_date_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX muc_room_users_username_host_date_idx ON public.muc_room_users USING btree (username, host, date);


--
-- Name: muc_room_users_username_host_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX muc_room_users_username_host_idx1 ON public.muc_room_users USING btree (username, host);


--
-- Name: muc_room_users_username_host_muc_name_domain_date_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX muc_room_users_username_host_muc_name_domain_date_idx ON public.muc_room_users USING btree (username, host, muc_name, domain, date);


--
-- Name: muc_room_users_username_host_muc_name_domain_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX muc_room_users_username_host_muc_name_domain_idx ON public.muc_room_users USING btree (username, host, muc_name, domain);


--
-- Name: muc_room_users_username_host_mucname_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX muc_room_users_username_host_mucname_idx ON public.muc_room_users USING btree (username, host, muc_name);


--
-- Name: muc_room_users_username_host_update_time_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX muc_room_users_username_host_update_time_idx ON public.muc_room_users USING btree (username, host, update_time);


--
-- Name: muc_room_users_username_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX muc_room_users_username_idx ON public.muc_room_users USING btree (username);


--
-- Name: muc_user_mark_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX muc_user_mark_index ON public.muc_user_mark USING btree (muc_name, user_name);


--
-- Name: notice_history_create_time_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notice_history_create_time_idx ON public.notice_history USING btree (create_time);


--
-- Name: notice_history_host_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notice_history_host_idx ON public.notice_history USING btree (host);


--
-- Name: notice_history_m_from_create_time_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notice_history_m_from_create_time_idx ON public.notice_history USING btree (m_from, create_time);


--
-- Name: notice_history_m_from_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notice_history_m_from_idx ON public.notice_history USING btree (m_from);


--
-- Name: push_info_user_name_host_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX push_info_user_name_host_idx ON public.push_info USING btree (user_name, host);


--
-- Name: push_info_user_name_host_os_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX push_info_user_name_host_os_idx ON public.push_info USING btree (user_name, host, os);


--
-- Name: push_info_user_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX push_info_user_name_idx ON public.push_info USING btree (user_name);


--
-- Name: qcloud_main_history_q_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX qcloud_main_history_q_id_idx ON public.qcloud_main_history USING btree (q_id);


--
-- Name: qcloud_sub_history_qs_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX qcloud_sub_history_qs_id_idx ON public.qcloud_sub_history USING btree (qs_id);


--
-- Name: qcloud_sub_q_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX qcloud_sub_q_id_idx ON public.qcloud_sub USING btree (q_id);


--
-- Name: qtalk_config_config_key_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX qtalk_config_config_key_uindex ON public.qtalk_config USING btree (config_key);


--
-- Name: qtalk_config_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX qtalk_config_id_uindex ON public.qtalk_config USING btree (id);


--
-- Name: qtalk_user_comment_from_user_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX qtalk_user_comment_from_user_idx ON public.qtalk_user_comment USING btree (from_user);


--
-- Name: qtalk_user_comment_to_user_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX qtalk_user_comment_to_user_idx ON public.qtalk_user_comment USING btree (to_user);


--
-- Name: qtalk_user_comment_uniq_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX qtalk_user_comment_uniq_key ON public.qtalk_user_comment USING btree (from_user, to_user, public.qto_char(create_time, 'YYYY-WW'::text));


--
-- Name: revoke_msg_history_backup_create_time_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX revoke_msg_history_backup_create_time_idx ON public.revoke_msg_history_backup USING btree (create_time);


--
-- Name: revoke_msg_history_create_time_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX revoke_msg_history_create_time_idx ON public.revoke_msg_history USING btree (create_time);


--
-- Name: revoke_msg_history_msg_id_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX revoke_msg_history_msg_id_idx1 ON public.revoke_msg_history USING btree (msg_id);


--
-- Name: scheduling_info_begin_time_end_time_member_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX scheduling_info_begin_time_end_time_member_idx ON public.scheduling_info USING btree (begin_time, end_time, member);


--
-- Name: scheduling_info_begin_time_mem_action_remind_flag_canceled_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX scheduling_info_begin_time_mem_action_remind_flag_canceled_idx ON public.scheduling_info USING btree (begin_time, mem_action, remind_flag, canceled);


--
-- Name: scheduling_info_end_time_mem_action_remind_flag_canceled_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX scheduling_info_end_time_mem_action_remind_flag_canceled_idx ON public.scheduling_info USING btree (end_time, mem_action, remind_flag, canceled);


--
-- Name: scheduling_info_inviter_member_scheduling_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX scheduling_info_inviter_member_scheduling_id_idx ON public.scheduling_info USING btree (inviter, member, scheduling_id);


--
-- Name: scheduling_info_scheduling_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX scheduling_info_scheduling_id_idx ON public.scheduling_info USING btree (scheduling_id);


--
-- Name: scheduling_info_scheduling_id_member_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX scheduling_info_scheduling_id_member_idx ON public.scheduling_info USING btree (scheduling_id, member);


--
-- Name: scheduling_info_update_time_member_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX scheduling_info_update_time_member_idx ON public.scheduling_info USING btree (update_time, member);


--
-- Name: startalk_dep_setting_setting_name_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX startalk_dep_setting_setting_name_uindex ON public.startalk_dep_setting USING btree (setting_name);


--
-- Name: startalk_dep_table_depname_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX startalk_dep_table_depname_uindex ON public.startalk_dep_table USING btree (dep_name);


--
-- Name: startalk_dep_table_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX startalk_dep_table_id_uindex ON public.startalk_dep_table USING btree (id);


--
-- Name: startalk_role_class_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX startalk_role_class_id_uindex ON public.startalk_role_class USING btree (id);


--
-- Name: startalk_role_class_role_class_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX startalk_role_class_role_class_uindex ON public.startalk_role_class USING btree (role_class);


--
-- Name: startalk_user_role_table_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX startalk_user_role_table_id_uindex ON public.startalk_user_role_table USING btree (id);


--
-- Name: sys_user_role_user_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX sys_user_role_user_id_uindex ON public.sys_user_role USING btree (user_id);


--
-- Name: t_dict_client_brand_brand_platform_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX t_dict_client_brand_brand_platform_idx ON public.t_dict_client_brand USING btree (brand, platform);


--
-- Name: t_dict_client_model_client_model_client_brand_platform_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX t_dict_client_model_client_model_client_brand_platform_idx ON public.t_dict_client_model USING btree (client_model, client_brand, platform);


--
-- Name: t_dict_client_version_client_version_platform_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX t_dict_client_version_client_version_platform_idx ON public.t_dict_client_version USING btree (client_version, platform);


--
-- Name: user_friends_username_userhost_friend_host_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX user_friends_username_userhost_friend_host_idx ON public.user_friends USING btree (username, userhost, friend, host);


--
-- Name: user_register_mucs_backup_created_at_username_registed_flag_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_register_mucs_backup_created_at_username_registed_flag_idx ON public.user_register_mucs_backup USING btree (created_at, username, registed_flag);


--
-- Name: user_register_mucs_backup_username_domain_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_register_mucs_backup_username_domain_idx ON public.user_register_mucs_backup USING btree (username, domain);


--
-- Name: user_register_mucs_backup_username_domain_muc_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_register_mucs_backup_username_domain_muc_name_idx ON public.user_register_mucs_backup USING btree (username, domain, muc_name);


--
-- Name: user_register_mucs_backup_username_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_register_mucs_backup_username_idx ON public.user_register_mucs_backup USING btree (username);


--
-- Name: user_register_mucs_backup_username_registed_flag_domain_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_register_mucs_backup_username_registed_flag_domain_idx ON public.user_register_mucs_backup USING btree (username, registed_flag, domain);


--
-- Name: user_register_mucs_created_at_username_registed_flag_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_register_mucs_created_at_username_registed_flag_idx ON public.user_register_mucs USING btree (created_at, username, registed_flag);


--
-- Name: user_register_mucs_username_domain_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_register_mucs_username_domain_idx ON public.user_register_mucs USING btree (username, domain);


--
-- Name: user_register_mucs_username_domain_muc_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_register_mucs_username_domain_muc_name_idx ON public.user_register_mucs USING btree (username, domain, muc_name);


--
-- Name: user_register_mucs_username_host_muc_name_domain_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX user_register_mucs_username_host_muc_name_domain_idx ON public.user_register_mucs USING btree (username, host, muc_name, domain);


--
-- Name: user_register_mucs_username_host_registed_flag_created_at_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_register_mucs_username_host_registed_flag_created_at_idx1 ON public.user_register_mucs USING btree (username, host, registed_flag, created_at);


--
-- Name: user_register_mucs_username_host_registed_flag_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_register_mucs_username_host_registed_flag_idx1 ON public.user_register_mucs USING btree (username, host, registed_flag);


--
-- Name: user_register_mucs_username_registed_flag_domain_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_register_mucs_username_registed_flag_domain_idx ON public.user_register_mucs USING btree (username, registed_flag, domain);


--
-- Name: vcard_version_username_host_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX vcard_version_username_host_idx ON public.vcard_version USING btree (username, host);


--
-- Name: warn_msg_history_backup_create_time_m_to_m_from_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX warn_msg_history_backup_create_time_m_to_m_from_idx ON public.warn_msg_history_backup USING btree (create_time, m_to, m_from);


--
-- Name: warn_msg_history_backup_create_time_m_to_to_host_m_from_fro_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX warn_msg_history_backup_create_time_m_to_to_host_m_from_fro_idx ON public.warn_msg_history_backup USING btree (create_time, m_to, to_host, m_from, from_host);


--
-- Name: warn_msg_history_backup_m_from_from_host_create_time_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX warn_msg_history_backup_m_from_from_host_create_time_idx ON public.warn_msg_history_backup USING btree (m_from, from_host, create_time);


--
-- Name: warn_msg_history_backup_m_from_m_to_create_time_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX warn_msg_history_backup_m_from_m_to_create_time_idx ON public.warn_msg_history_backup USING btree (m_from, m_to, create_time);


--
-- Name: warn_msg_history_backup_m_to_id_create_time_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX warn_msg_history_backup_m_to_id_create_time_idx ON public.warn_msg_history_backup USING btree (m_to, id, create_time) WHERE (((m_from)::text = 'qunar-message'::text) AND (from_host = 'ejabhost1'::text) AND (to_host = 'ejabhost1'::text));


--
-- Name: warn_msg_history_backup_m_to_id_create_time_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX warn_msg_history_backup_m_to_id_create_time_idx1 ON public.warn_msg_history_backup USING btree (m_to, id DESC, create_time);


--
-- Name: warn_msg_history_backup_m_to_to_host_create_time_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX warn_msg_history_backup_m_to_to_host_create_time_idx ON public.warn_msg_history_backup USING btree (m_to, to_host, create_time);


--
-- Name: warn_msg_history_backup_msg_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX warn_msg_history_backup_msg_id_idx ON public.warn_msg_history_backup USING btree (msg_id);


--
-- Name: warn_msg_history_create_time_m_to_m_from_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX warn_msg_history_create_time_m_to_m_from_idx ON public.warn_msg_history USING btree (create_time, m_to, m_from);


--
-- Name: warn_msg_history_create_time_m_to_to_host_m_from_from_host_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX warn_msg_history_create_time_m_to_to_host_m_from_from_host_idx ON public.warn_msg_history USING btree (create_time, m_to, to_host, m_from, from_host);


--
-- Name: warn_msg_history_m_from_from_host_create_time_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX warn_msg_history_m_from_from_host_create_time_idx ON public.warn_msg_history USING btree (m_from, from_host, create_time);


--
-- Name: warn_msg_history_m_from_m_to_create_time_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX warn_msg_history_m_from_m_to_create_time_idx ON public.warn_msg_history USING btree (m_from, m_to, create_time);


--
-- Name: warn_msg_history_m_to_id_create_time_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX warn_msg_history_m_to_id_create_time_idx ON public.warn_msg_history USING btree (m_to, id, create_time) WHERE (((m_from)::text = 'qunar-message'::text) AND (from_host = 'ejabhost1'::text) AND (to_host = 'ejabhost1'::text));


--
-- Name: warn_msg_history_m_to_id_create_time_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX warn_msg_history_m_to_id_create_time_idx1 ON public.warn_msg_history USING btree (m_to, id DESC, create_time);


--
-- Name: warn_msg_history_m_to_to_host_create_time_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX warn_msg_history_m_to_to_host_create_time_idx ON public.warn_msg_history USING btree (m_to, to_host, create_time);


--
-- Name: warn_msg_history_msg_id_idx2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX warn_msg_history_msg_id_idx2 ON public.warn_msg_history USING btree (msg_id);


--
-- Name: warn_msg_history_read_flag_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX warn_msg_history_read_flag_idx ON public.warn_msg_history USING btree (read_flag) WHERE (read_flag <> '3'::smallint);


--
-- Name: privacy_list_data privacy_list_data_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.privacy_list_data
    ADD CONSTRAINT privacy_list_data_id_fkey FOREIGN KEY (id) REFERENCES public.privacy_list(id) ON DELETE CASCADE;


--
-- Name: pubsub_item pubsub_item_nodeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pubsub_item
    ADD CONSTRAINT pubsub_item_nodeid_fkey FOREIGN KEY (nodeid) REFERENCES public.pubsub_node(nodeid) ON DELETE CASCADE;


--
-- Name: pubsub_node_option pubsub_node_option_nodeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pubsub_node_option
    ADD CONSTRAINT pubsub_node_option_nodeid_fkey FOREIGN KEY (nodeid) REFERENCES public.pubsub_node(nodeid) ON DELETE CASCADE;


--
-- Name: pubsub_node_owner pubsub_node_owner_nodeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pubsub_node_owner
    ADD CONSTRAINT pubsub_node_owner_nodeid_fkey FOREIGN KEY (nodeid) REFERENCES public.pubsub_node(nodeid) ON DELETE CASCADE;


--
-- Name: pubsub_state pubsub_state_nodeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pubsub_state
    ADD CONSTRAINT pubsub_state_nodeid_fkey FOREIGN KEY (nodeid) REFERENCES public.pubsub_node(nodeid) ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM postgres;


--
-- Name: TABLE fresh_empl_entering; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.fresh_empl_entering FROM postgres;


--
-- Name: SEQUENCE fresh_empl_entering_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.fresh_empl_entering_id_seq FROM postgres;


--
-- Name: TABLE host_info; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.host_info FROM postgres;


--
-- Name: SEQUENCE host_info_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.host_info_id_seq FROM postgres;


--
-- Name: TABLE host_users; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.host_users FROM postgres;


--
-- Name: SEQUENCE host_users_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.host_users_id_seq FROM postgres;


--
-- Name: TABLE msg_history_backup; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.msg_history_backup FROM postgres;


--
-- Name: TABLE muc_room_history_backup; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.muc_room_history_backup FROM postgres;


--
-- Name: TABLE qcloud_main; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.qcloud_main FROM postgres;


--
-- Name: TABLE qcloud_main_history; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.qcloud_main_history FROM postgres;


--
-- Name: SEQUENCE qcloud_main_history_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.qcloud_main_history_id_seq FROM postgres;


--
-- Name: SEQUENCE qcloud_main_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.qcloud_main_id_seq FROM postgres;


--
-- Name: TABLE qcloud_sub; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.qcloud_sub FROM postgres;


--
-- Name: TABLE qcloud_sub_history; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.qcloud_sub_history FROM postgres;


--
-- Name: SEQUENCE qcloud_sub_history_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.qcloud_sub_history_id_seq FROM postgres;


--
-- Name: SEQUENCE qcloud_sub_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.qcloud_sub_id_seq FROM postgres;


--
-- Name: TABLE revoke_msg_history_backup; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.revoke_msg_history_backup FROM postgres;


--
-- Name: TABLE scheduling_info; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.scheduling_info FROM postgres;


--
-- Name: SEQUENCE scheduling_info_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.scheduling_info_id_seq FROM postgres;


--
-- Name: TABLE warn_msg_history; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.warn_msg_history FROM postgres;


--
-- Name: SEQUENCE warn_msg_history_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE public.warn_msg_history_id_seq FROM postgres;


--
-- Name: TABLE warn_msg_history_backup; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE public.warn_msg_history_backup FROM postgres;


--
-- PostgreSQL database dump complete
--

