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
    CONSTRAINT vpn_account_list_is_enabled_check CHECK (((is_enabled)::text = ANY ((ARRAY['d'::character varying, 'n'::character varying, 'y'::character varying])::text[])))
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
-- Data for Name: admin_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_user (username, priority) FROM stdin;
\.


--
-- Data for Name: client_config_sync; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_config_sync (id, username, host, configkey, subkey, configinfo, version, operate_plat, create_time, update_time, isdel) FROM stdin;
27	100094z	startalk.tech	kBlackList	100095z@startalk.tech	1	44	iOS	2020-10-31 12:09:06.337025+08	2020-11-15 19:12:04.779459+08	0
32	100095z	startalk.tech	kNoticeStickJidDic	b0b5ebc6f7f240a1a92b26a1f313d03a@conference.startalk.tech	1	17	Mac	2020-10-31 12:40:35.833031+08	2020-10-31 12:40:35.833031+08	0
23	100094z	startalk.tech	kStickJidDic	chao.zhang5@startalk.tech<>chao.zhang5@startalk.tech	{"topType":1, "chatType":0}	45	iOS	2020-10-31 12:01:47.083287+08	2020-11-15 19:21:11.337329+08	1
55	100094z	startalk.tech	kStickJidDic	mumu@startalk.tech<>mumu@startalk.tech	{"topType":1, "chatType":0}	45	iOS	2020-11-14 23:37:21.858704+08	2020-11-15 19:21:11.337329+08	1
61	test01	startalk.tech	kNoticeStickJidDic	d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech	0	2	android	2020-11-18 09:03:04.338659+08	2020-11-18 09:03:23.752052+08	1
28	100095z	startalk.tech	kNoticeStickJidDic	100094z@startalk.tech	0	23	PC64	2020-10-31 12:16:23.005914+08	2020-10-31 15:06:17.806972+08	1
33	100095z	startalk.tech	kNoticeStickJidDic	100096z@startalk.tech	0	30	PC64	2020-10-31 15:13:25.301506+08	2020-10-31 15:14:09.274602+08	1
1	100096z	startalk.tech	kMarkupNames	100094z@startalk.tech	珊珊	0	android	2020-10-26 00:36:45.082993+08	2020-10-26 00:36:50.068752+08	0
34	100095z	startalk.tech	kStarContact	100096z@startalk.tech	0	35	PC64	2020-10-31 15:13:55.471665+08	2020-10-31 15:14:29.668596+08	1
36	100096z	startalk.tech	kBlackList	100095z@startalk.tech	1	3	PC64	2020-11-02 16:10:59.734005+08	2020-11-02 16:14:19.752303+08	0
35	100095z	startalk.tech	kBlackList	100096z@startalk.tech	0	42	PC64	2020-10-31 15:14:55.633355+08	2020-11-02 17:14:22.810068+08	1
37	100096z	startalk.tech	kStickJidDic	677930584d7145b6bd20b79f4bae7352@conference.startalk.tech<>677930584d7145b6bd20b79f4bae7352@conference.startalk.tech	{"topType":0,"chatType":1}	5	PC64	2020-11-02 17:15:39.419647+08	2020-11-02 17:15:43.769776+08	1
38	100096z	startalk.tech	kNoticeStickJidDic	677930584d7145b6bd20b79f4bae7352@conference.startalk.tech	1	6	PC64	2020-11-02 17:15:46.427758+08	2020-11-02 17:15:46.427758+08	0
39	100096z	startalk.tech	kNoticeStickJidDic	0229eb47b1154771866863ddab7c96b6@conference.startalk.tech	1	7	PC64	2020-11-02 17:16:18.834611+08	2020-11-02 17:16:18.834611+08	0
20	100094z	startalk.tech	kNoticeStickJidDic	b0b5ebc6f7f240a1a92b26a1f313d03a@conference.startalk.tech	1	8	android	2020-10-30 22:14:38.595374+08	2020-10-30 22:14:38.595374+08	0
21	100094z	startalk.tech	kNoticeStickJidDic	95047e5e04014cd2b2ec4b16c85f744c@conference.startalk.tech	0	13	android	2020-10-30 22:14:41.29278+08	2020-10-31 12:03:28.82111+08	1
25	100094z	startalk.tech	kBlackList	100096z@startalk.tech	1	14	android	2020-10-31 12:04:04.1434+08	2020-10-31 12:04:04.1434+08	0
31	100095z	startalk.tech	kStarContact	100094z@startalk.tech	1	48	PC64	2020-10-31 12:16:56.569986+08	2020-11-02 17:36:23.547003+08	0
18	100094z	startalk.tech	kStickJidDic	100004q@startalk.tech<>100004q@startalk.tech	{"topType":0, "chatType":0}	17	android	2020-10-30 22:13:28.182716+08	2020-10-31 12:06:56.332938+08	1
17	100094z	startalk.tech	kStickJidDic	100095z@startalk.tech<>100095z@startalk.tech	{"topType":0, "chatType":0}	18	android	2020-10-30 21:44:47.889795+08	2020-10-31 12:06:59.001445+08	1
26	100094z	startalk.tech	kStickJidDic	e68a47f141ad43df8d72bd00ae78b133@conference.startalk.tech<>e68a47f141ad43df8d72bd00ae78b133@conference.startalk.tech	{"topType":0, "chatType":1}	19	android	2020-10-31 12:06:44.731191+08	2020-10-31 12:07:02.316274+08	1
19	100094z	startalk.tech	kNoticeStickJidDic	3389f6c1bb4042a2ab0c339dec3c16a9@conference.startalk.tech	0	21	android	2020-10-30 22:14:32.262389+08	2020-10-31 12:07:16.613767+08	1
22	100094z	startalk.tech	kStarContact	100095z@startalk.tech	1	23	android	2020-10-30 22:22:09.696874+08	2020-10-31 12:08:05.930327+08	0
24	100094z	startalk.tech	kStarContact	chao.zhang5@startalk.tech	0	24	android	2020-10-31 12:02:00.725324+08	2020-10-31 12:08:41.372522+08	1
40	100004q	startalk.tech	kMarkupNames	mumu@startalk.tech	沐沐	1	android	2020-11-02 18:32:16.605407+08	2020-11-02 18:32:16.605407+08	0
41	100095z	startalk.tech	kStickJidDic	100096z@startalk.tech<>100096z@startalk.tech	{"topType":0,"chatType":0}	52	PC64	2020-11-03 09:47:27.113764+08	2020-11-03 09:47:29.486677+08	1
29	100095z	startalk.tech	kStickJidDic	100094z@startalk.tech<>100094z@startalk.tech	{"topType":0,"chatType":0}	53	PC64	2020-10-31 12:16:25.21522+08	2020-11-10 09:27:36.469923+08	1
30	100095z	startalk.tech	kBlackList	100094z@startalk.tech	0	55	PC64	2020-10-31 12:16:28.137353+08	2020-11-10 09:28:30.192182+08	1
42	100094z	startalk.tech	kNoticeStickJidDic	83d2403acedf4b39877f592244043dee@conference.startalk.tech	1	29	android	2020-11-10 09:58:09.642927+08	2020-11-10 09:58:09.642927+08	0
44	100095z	startalk.tech	kStickJidDic	83d2403acedf4b39877f592244043dee@conference.startalk.tech<>83d2403acedf4b39877f592244043dee@conference.startalk.tech	{"topType":0,"chatType":1}	58	PC64	2020-11-10 09:59:31.111476+08	2020-11-10 10:01:09.391945+08	1
45	100095z	startalk.tech	kStarContact	100095z@startalk.tech	1	59	PC64	2020-11-10 10:22:50.755895+08	2020-11-10 10:22:50.755895+08	0
43	100094z	startalk.tech	kStickJidDic	83d2403acedf4b39877f592244043dee@conference.startalk.tech<>83d2403acedf4b39877f592244043dee@conference.startalk.tech	{"topType":0,"chatType":1}	31	PC64	2020-11-10 09:58:38.849576+08	2020-11-11 10:06:16.393774+08	1
46	mumu	startalk.tech	kCollectionCacheKey	63bca108543395626b876438aa3b31f3	https://im.startalk.tech:8443/file/v2/download/39c45bc83d483502db98899ebcc1edb0.png?name=39c45bc83d483502db98899ebcc1edb0.png	1	PC64	2020-11-14 23:09:45.411507+08	2020-11-14 23:09:45.411507+08	0
47	mumu	startalk.tech	kStickJidDic	6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech<>6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech	{"topType":1,"chatType":1}	2	PC64	2020-11-14 23:14:19.535868+08	2020-11-14 23:14:19.535868+08	0
48	mumu	startalk.tech	kStickJidDic	17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech<>17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech	{"topType":1,"chatType":1}	3	PC64	2020-11-14 23:14:21.163988+08	2020-11-14 23:14:21.163988+08	0
50	mumu	startalk.tech	kStarContact	100094z@startalk.tech	1	6	PC64	2020-11-14 23:17:42.409051+08	2020-11-14 23:17:42.409051+08	0
51	mumu	startalk.tech	kNoticeStickJidDic	83d2403acedf4b39877f592244043dee@conference.startalk.tech	0	9	PC64	2020-11-14 23:17:48.584423+08	2020-11-14 23:20:21.346452+08	1
52	mumu	startalk.tech	kNoticeStickJidDic	100094z@startalk.tech	0	10	PC64	2020-11-14 23:17:51.857818+08	2020-11-14 23:20:27.958453+08	1
53	mumu	startalk.tech	kStarContact	mumu@startalk.tech	1	11	PC64	2020-11-14 23:29:13.948127+08	2020-11-14 23:29:13.948127+08	0
49	mumu	startalk.tech	kBlackList	100094z@startalk.tech	0	14	PC64	2020-11-14 23:14:40.728356+08	2020-11-14 23:33:04.37941+08	1
54	mumu	startalk.tech	kBlackList	mumu@startalk.tech	0	15	PC64	2020-11-14 23:32:38.021453+08	2020-11-14 23:37:39.560954+08	1
56	100094z	startalk.tech	kNoticeStickJidDic	mumu@startalk.tech	0	35	android	2020-11-14 23:38:13.129077+08	2020-11-14 23:38:25.704075+08	1
57	100094z	startalk.tech	kNoticeStickJidDic	cb8c771fd29a4f4f96a2de73a012c4a5@conference.startalk.tech	1	37	android	2020-11-14 23:38:59.47236+08	2020-11-14 23:38:59.47236+08	0
58	100094z	startalk.tech	kStarContact	100004q@startalk.tech	1	38	android	2020-11-14 23:47:15.780168+08	2020-11-14 23:47:15.780168+08	0
59	100094z	startalk.tech	kNoticeStickJidDic	96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech	0	40	iOS	2020-11-15 18:51:08.269854+08	2020-11-15 18:51:25.149668+08	1
60	100094z	startalk.tech	kStickJidDic	96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech<>96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech	{"topType":0,"chatType":1}	43	iOS	2020-11-15 18:51:26.601672+08	2020-11-15 18:53:51.236612+08	1
62	100013v	startalk.tech	kStickJidDic	d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech<>d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech	{"topType":1, "chatType":1}	8	android	2020-11-18 09:03:17.529539+08	2020-11-18 09:03:36.824667+08	0
63	100013v	startalk.tech	kNoticeStickJidDic	d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech	0	9	android	2020-11-18 09:03:18.912983+08	2020-11-18 09:03:37.206645+08	1
64	test01	startalk.tech	kStickJidDic	d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech<>d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech	{"topType":1, "chatType":1}	3	android	2020-11-18 09:03:43.843327+08	2020-11-18 09:03:43.843327+08	0
\.


--
-- Data for Name: client_upgrade; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_upgrade (id, client_type, platform, version, copywriting, grayscale_status, grayscale_value, upgrade_status, upgrade_url, create_time, update_time, md5_key, stop_status, stop_reason, updated_count) FROM stdin;
\.


--
-- Data for Name: data_board_day; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.data_board_day (id, activity, client_online_time, start_count, client_version, day_msg_count, day_msg_average, department_data, hire_type_data, create_time, platform_activity, dep_activity, hire_type_activity) FROM stdin;
\.


--
-- Data for Name: destroy_muc_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.destroy_muc_info (muc_name, nick_name, reason, id, created_at) FROM stdin;
6087afffae43438a88f6a7a46e969404		Owner Destroy	1	2020-10-29 16:31:49.14927
6dec5e56b25741a9ba0ad2e04766d8d4	珊珊JH,杉杉	Owner Destroy	2	2020-11-10 10:02:18.310802
b0fd2895a3a447b2ba9aa3768c4b52ec	哈哈群22	Owner Destroy	3	2020-11-14 23:13:51.301388
cb8c771fd29a4f4f96a2de73a012c4a5	珊珊JH,杉杉,沐沐	Owner Destroy	4	2020-11-14 23:39:12.411682
b9a915b72ff94cf8a71823c05cd12528	珊珊JH	Owner Destroy	5	2020-11-14 23:40:48.026299
96a85e39bcc647c4b60831060dc0f94c	测试啊啊啊啊	Owner Destroy	6	2020-11-15 18:53:51.141956
d1aa13f85c4b41768b25027ff007c81a	测试	Owner Destroy	7	2020-11-18 09:04:45.617365
\.


--
-- Data for Name: find_application_table; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.find_application_table (id, application_type, visible_range, application_name, application_class, application_icon, application_version, ios_version, android_version, ios_bundle, android_bundle, application_desc, create_time, update_time, disable_flag, member_id, h5_action, entrance, properties, module, show_native_nav, nav_title, valid_platform, visible_platform, bundle_name, h5_action_ios, h5_action_android, delete_flag, native_flag, app_uuid) FROM stdin;
\.


--
-- Data for Name: find_class_table; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.find_class_table (id, group_name, group_icon) FROM stdin;
\.


--
-- Data for Name: flogin_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flogin_user (id, username, create_time) FROM stdin;
\.


--
-- Data for Name: fresh_empl_entering; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fresh_empl_entering (id, user_id, user_name, hire_flag, join_date, send_state, sn, manager, manager_mail, dep1, dep2, dep3, dep4, dep5, job, job_code, probation_date, version, create_time, update_time) FROM stdin;
\.


--
-- Data for Name: host_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.host_info (id, host, description, create_time, host_type, host_qrcode, need_approve, host_admin) FROM stdin;
1	startalk.tech	startalk.tech	2019-10-28 22:18:14.500501+08	0	\N	0	admin
\.


--
-- Data for Name: host_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.host_users (id, host_id, user_id, user_name, department, tel, email, dep1, dep2, dep3, dep4, dep5, pinyin, frozen_flag, version, user_type, hire_flag, gender, password, initialpwd, pwd_salt, leader, hrbp, user_role, approve_flag, user_desc, user_origin, hire_type, admin_flag, create_time, ps_deptid) FROM stdin;
45	1	test05	test05	/管理员			管理员					\N	0	16	U	1	1	CRY:58e3fc10e366c31e50379e6aa32bf455	1	b6f870c0293611ebb9c55bf3c5579a8d			0	1	\N	0	未知	0	2020-11-18 00:40:53.972	QUNAR
46	1	test06	test06	/管理员			管理员					\N	0	17	U	1	1	CRY:36027def535e4af6f7cfb4fe6794e746	1	c195e0d0293611eb94e49da2fd3ff2fc			0	1	\N	0	未知	0	2020-11-18 00:41:11.781	QUNAR
47	1	test07	test07	/管理员			管理员					\N	0	18	U	1	1	CRY:5dbf8c1dd825cebfaf94ac0f147eaa6c	1	d67c8670293611ebb9c55bf3c5579a8d			0	1	\N	0	未知	0	2020-11-18 00:41:46.846	QUNAR
35	1	100004q	JH伽勒	/管理员			管理员					\N	0	11	U	1	1	CRY:8b3f4f8eae91efe21ed222fd06a94925	1	78305790169e11ebb9c55bf3c5579a8d			0	1	\N	0	未知	0	2020-10-25 08:45:44.211	QUNAR
40	1	100013v	SuniJH	/管理员			管理员					\N	0	11	U	1	2	CRY:98ff40cca858dc73dc46f46d8f79e35b	1	14334e001d8311eb90a2f1182f779775			0	1	\N	0	未知	0	2020-11-03 03:17:18.184	QUNAR
34	1	chao.zhang5	zhangchao5	/zhangchao	111111115	chao.zhang5@test.com	zhangchao					\N	0	11	U	1	1	CRY:22f9946fd1cec8f405cc8b9a9aa4bbf5	1	79a99a400ec011ebb9c55bf3c5579a8d	admin	admin	0	1	\N	0	未知	0	2020-10-15 08:29:00.278	QUNAR
38	1	100096z	勇敢	/zhangchao			zhangchao					\N	0	11	U	1	1	CRY:866c51a6ee6c5d8a1ef5561fc81e3d80	1	e327a8b016de11eb94e49da2fd3ff2fc			0	1	\N	0	未知	0	2020-10-25 16:26:51.459	QUNAR
2	1	file-transfer	文件传输助手	/智能服务助手	\N	\N	智能服务助手					file-transfer	1	11	U	1	1	CRY:fd540f073cc09aa98220bbb234153bd5	1	qtalkadmin_pwd_salt_d2bf42081aab47f4ac00697d7dd32993	\N	\N	0	1	\N	0	未知	0	2019-10-28 22:18:14.516	qtalk
37	1	100095z	杉杉	/管理员			管理员					杉杉	0	11	U	1	1	CRY:b1fa3550d9d1348f1d3d6b541c73c67f	1	3f7197b016db11eb94e49da2fd3ff2fc			0	1	\N	0	未知	0	2020-10-25 16:00:48.313	QUNAR
39	1	mumu	沐沐	/管理员			管理员					\N	0	11	U	1	1	CRY:ad009f30c1c5ec2b47bfb39fd54613cb	1	c444c7701cf111eb90a2f1182f779775			0	1	\N	0	未知	0	2020-11-02 09:57:07.059	QUNAR
36	1	100094z	珊珊JH	/管理员			管理员					\N	0	11	U	1	2	CRY:cf80256dadcd04a61dd4dbecb04b4663	1	4471756016da11ebb9c55bf3c5579a8d			0	1	\N	0	未知	0	2020-10-25 15:53:47.199	QUNAR
1	1	admin	管理员	/管理员	\N	\N	管理员					admin	0	11	U	1	1	CRY:fd540f073cc09aa98220bbb234153bd5	1	qtalkadmin_pwd_salt_d2bf42081aab47f4ac00697d7dd32993	\N	\N	0	1	\N	0	未知	0	2019-10-28 22:18:14.505	qtalk
41	1	test01	test01	/管理员			管理员					\N	0	12	U	1	1	CRY:77d207154da3be7bee48a3a6c081798f	1	7d7528a028d411ebb9a705b17364ad66			0	1	\N	0	未知	0	2020-11-17 12:57:46.803	QUNAR
42	1	test02	test02	/管理员			管理员					\N	0	13	U	1	1	CRY:f4bdb244bf42ac3d0cb0091df9af52c5	1	95d32e30293611ebb9a705b17364ad66			0	1	\N	0	未知	0	2020-11-18 00:39:58.363	QUNAR
43	1	test03	test03	/管理员			管理员					\N	0	14	U	1	1	CRY:b2884ae55b34c747294d281ea7c74828	1	a3fcd240293611ebb9c55bf3c5579a8d			0	1	\N	0	未知	0	2020-11-18 00:40:22.124	QUNAR
44	1	test04	test04	/管理员			管理员					\N	0	15	U	1	1	CRY:b2d147cadfabe28e914e9e7b709fdf39	1	ace20b00293611eb94e49da2fd3ff2fc			0	1	\N	0	未知	0	2020-11-18 00:40:37.048	QUNAR
\.


--
-- Data for Name: invite_spool; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.invite_spool (username, inviter, body, "timestamp", created_at, host, ihost) FROM stdin;
\.


--
-- Data for Name: iplimit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.iplimit (ip, created_at, descriptions, name, priority, manager) FROM stdin;
\.


--
-- Data for Name: irc_custom; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.irc_custom (jid, host, data, created_at) FROM stdin;
\.


--
-- Data for Name: last; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.last (username, seconds, state) FROM stdin;
\.


--
-- Data for Name: login_data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.login_data (id, username, host, resource, platform, ip, login_time, logout_at, record_type) FROM stdin;
1	admin	startalk.tech	V[200009]_P[Mac]_ID[cf211c2ffc6f4683a7390d6e9220d77a]_C[1]_PB	Mac	42.61.154.39	2020-10-13 05:49:45+08	2020-10-13 09:07:31+08	server
2	admin	startalk.tech	V[200009]_P[PC64]_ID[96962c7d1aee483181a57babb785d402]_C[1]_PB	PC	101.198.192.11	2020-10-13 11:34:05+08	2020-10-13 11:36:09+08	server
3	admin	startalk.tech	V[200009]_P[PC64]_ID[0d743905e78c4b05afdb2299bb54bf00]_C[1]_PB	PC	101.198.192.11	2020-10-13 11:32:53+08	2020-10-13 11:36:09+08	server
4	admin	startalk.tech	V[200009]_P[PC64]_ID[14d2f25b8d8f494d8e1d2e6e17001ecb]_C[1]_PB	PC	101.198.192.11	2020-10-13 11:38:26+08	2020-10-13 11:40:30+08	server
5	admin	startalk.tech	V[200009]_P[PC64]_ID[9a38d4debcae4fe9b47b560ecac1aaca]_C[1]_PB	PC	101.198.192.11	2020-10-13 11:49:08+08	2020-10-13 11:55:53+08	server
6	admin	startalk.tech	V[200009]_P[PC64]_ID[12033eccc5b443228a06bd4b73639282]_C[1]_PB	PC	101.198.192.11	2020-10-13 11:48:06+08	2020-10-13 11:55:53+08	server
7	admin	startalk.tech	V[200009]_P[PC64]_ID[02881283df034b8d95c3a638499c16ad]_C[1]_PB	PC	101.198.192.11	2020-10-13 11:50:03+08	2020-10-13 11:55:53+08	server
8	admin	startalk.tech	V[200009]_P[PC64]_ID[836325f054454007bde9513c2ef1887e]_C[1]_PB	PC	101.198.192.15	2020-10-13 11:55:49+08	2020-10-13 11:55:53+08	server
9	admin	startalk.tech	V[200009]_P[PC64]_ID[8519d5b628da4e2bb88c7223053d9087]_C[1]_PB	PC	101.198.192.15	2020-10-13 13:15:38+08	2020-10-13 13:15:43+08	server
10	admin	startalk.tech	V[200009]_P[PC64]_ID[8898a91bce8e420898e7e9ca71d5a1ff]_C[1]_PB	PC	101.198.192.11	2020-10-13 13:20:09+08	2020-10-13 13:21:04+08	server
11	admin	startalk.tech	V[200009]_P[PC64]_ID[d95815437a7446648d137d71c7125955]_C[1]_PB	PC	101.198.192.15	2020-10-13 13:20:51+08	2020-10-13 13:21:04+08	server
12	admin	startalk.tech	V[200009]_P[PC64]_ID[d1881ceacc054b789af9717d1d7c0c33]_C[1]_PB	PC	101.198.192.11	2020-10-13 13:24:34+08	2020-10-13 13:27:39+08	server
13	admin	startalk.tech	V[200009]_P[Mac]_ID[a87080fd61784fc0bad3c560d3852d1a]_C[1]_PB	Mac	42.61.154.39	2020-10-13 12:32:33+08	2020-10-13 15:53:17+08	server
14	admin	startalk.tech	V[200009]_P[Mac]_ID[7702413575c248d881daca85ec2c5dcb]_C[1]_PB	Mac	42.61.154.39	2020-10-13 17:08:03+08	2020-10-14 03:09:02+08	server
15	admin	startalk.tech	V[200009]_P[PC64]_ID[14b61ba95d754e71a82583348e6c7492]_C[1]_PB	PC	101.198.192.11	2020-10-15 15:30:18+08	2020-10-15 15:33:33+08	server
16	chao.zhang5	startalk.tech	V[200009]_P[PC64]_ID[117a5a2cd568433aa1e4fe8a79f51c76]_C[1]_PB	PC	101.198.192.11	2020-10-15 16:30:17+08	2020-10-16 00:21:58+08	server
17	chao.zhang5	startalk.tech	V[200009]_P[PC64]_ID[5b2bb5edef0242b4b85b768ef8c9a132]_C[1]_PB	PC	101.198.192.11	2020-10-15 16:29:16+08	2020-10-16 00:41:04+08	server
18	chao.zhang5	startalk.tech	V[200009]_P[PC64]_ID[301166e5a0fe44e7a7fd607f85b54aa1]_C[1]_PB	PC	101.198.192.11	2020-10-15 16:29:42+08	2020-10-16 09:55:25+08	server
19	admin	startalk.tech	V[240]_P[Android]_D[MIX 2]_ID[6b8802b3-8632-47ba-8e9e-f21eba6146b8]_PB	Android	42.61.154.39	2020-10-25 16:40:01+08	2020-10-25 16:45:51+08	server
20	100004q	startalk.tech	V[240]_P[Android]_D[MIX 2]_ID[57f8a79a-e73c-436d-949e-33907e9cdd5c]_PB	Android	42.61.154.39	2020-10-25 16:46:12+08	2020-10-25 16:46:50+08	server
21	100004q	startalk.tech	V[240]_P[Android]_D[MIX 2]_ID[552e8520-0f60-40bd-b68a-4f8b84064582]_PB	Android	42.61.154.39	2020-10-25 16:47:01+08	2020-10-25 18:28:01+08	server
22	100094z	startalk.tech	V[200010]_P[PC64]_ID[581e2d9f3fdc4f328529875c9db540b6]_C[1]_PB	PC	115.192.101.150	2020-10-25 23:54:01+08	2020-10-25 23:54:15+08	server
23	100094z	startalk.tech	V[200010]_P[PC64]_ID[4ee22bac7a2f4825891ef433813774da]_C[1]_PB	PC	115.192.101.150	2020-10-25 23:54:55+08	2020-10-25 23:55:03+08	server
24	100094z	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[5c5d60f5-0271-4d62-87ac-3566a87e08e1]_PB	Android	115.192.101.150	2020-10-25 23:59:05+08	2020-10-26 00:15:01+08	server
25	100094z	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[c4fc8379-c8bf-4a98-9199-31c675de2f09]_PB	Android	115.192.101.150	2020-10-26 00:21:57+08	2020-10-26 00:22:41+08	server
26	100004q	startalk.tech	V[254]_P[Android]_D[MuMu]_ID[29c8b4f6-7394-41bd-85fa-9a4eaa4c39d8]_PB	Android	42.61.154.39	2020-10-26 00:00:33+08	2020-10-26 00:27:54+08	server
27	100096z	startalk.tech	V[254]_P[Android]_D[MuMu]_ID[19a5627d-adbb-4a73-be1b-7829b26f6086]_PB	Android	115.192.101.150	2020-10-26 00:28:39+08	2020-10-26 01:04:48+08	server
28	100094z	startalk.tech	V[254]_P[Android]_D[MuMu]_ID[6e542a11-2330-4b5c-9aee-2c3387aa37cc]_PB	Android	115.192.101.150	2020-10-26 00:11:57+08	2020-10-26 01:04:48+08	server
29	100095z	startalk.tech	V[254]_P[Android]_D[MuMu]_ID[595a7e87-30fc-40f6-a4d3-e777266038b0]_PB	Android	115.192.101.150	2020-10-26 00:13:06+08	2020-10-26 02:34:42+08	server
30	100094z	startalk.tech	V[200010]_P[PC64]_ID[6959bd0c17f246148a8d8808f2aeb2c1]_C[1]_PB	PC	115.192.101.150	2020-10-26 18:02:38+08	2020-10-26 18:02:48+08	server
31	100094z	startalk.tech	V[200010]_P[PC64]_ID[e7bd41b379af4e8db6ebfb1aafde56dd]_C[1]_PB	PC	101.198.192.15	2020-10-26 18:05:29+08	2020-10-26 18:05:33+08	server
32	100004q	startalk.tech	V[254]_P[Android]_D[MuMu]_ID[fc26588e-e326-473c-a95e-8d4a0c15ab9b]_PB	Android	42.61.154.39	2020-10-26 18:18:15+08	2020-10-26 18:18:23+08	server
33	100094z	startalk.tech	1287027252766952582	unknown	101.198.192.11	2020-10-26 18:19:03+08	2020-10-26 18:19:22+08	server
34	chao.zhang5	startalk.tech	V[200010]_P[PC64]_ID[03871912908649eeaf16b287aa517559]_C[1]_PB	PC	101.198.192.15	2020-10-26 18:04:56+08	2020-10-26 18:39:55+08	server
35	100094z	startalk.tech	2423884267144400190	unknown	101.198.192.11	2020-10-26 18:19:23+08	2020-10-26 19:21:57+08	server
36	100094z	startalk.tech	394886956012323898	unknown	101.198.192.11	2020-10-26 19:21:59+08	2020-10-26 19:22:34+08	server
37	100094z	startalk.tech	12229594515076111106	unknown	101.198.192.15	2020-10-26 19:22:49+08	2020-10-26 19:23:40+08	server
38	100094z	startalk.tech	V[200010]_P[PC64]_ID[3b0485cfb26e4aa3929c5c79f26e5663]_C[1]_PB	PC	101.198.192.15	2020-10-26 19:24:02+08	2020-10-26 19:24:07+08	server
39	100094z	startalk.tech	V[200010]_P[PC64]_ID[64b3989d4b554f32bbba19d9d4629273]_C[1]_PB	PC	101.198.192.11	2020-10-26 19:25:57+08	2020-10-26 19:26:01+08	server
40	100094z	startalk.tech	V[200010]_P[PC64]_ID[edd9116dd0a147ee9184907705c0c10e]_C[1]_PB	PC	101.198.192.15	2020-10-26 19:28:18+08	2020-10-26 19:28:23+08	server
41	100094z	startalk.tech	23397226845069813114	unknown	101.198.192.15	2020-10-26 19:29:59+08	2020-10-26 19:32:30+08	server
42	100094z	startalk.tech	24850270208797589122	unknown	101.198.192.11	2020-10-26 19:37:39+08	2020-10-26 19:37:42+08	server
43	100094z	startalk.tech	V[246]_P[Android]_D[OPPO A83]_ID[651f59a9-07c4-4006-897f-0efa12db2de8]_PB	Android	223.104.3.173	2020-10-26 19:52:16+08	2020-10-26 20:04:36+08	server
44	100094z	startalk.tech	V[246]_P[Android]_D[OPPO A83]_ID[4f536a6c-89fc-4e57-ba71-7d5bbec507b4]_PB	Android	223.104.3.173	2020-10-26 20:09:37+08	2020-10-26 20:09:41+08	server
45	100094z	startalk.tech	V[246]_P[Android]_D[OPPO A83]_ID[6ad6eda7-a346-4315-b76c-e73b2690dc2d]_PB	Android	223.104.3.173	2020-10-26 20:19:42+08	2020-10-26 20:30:23+08	server
46	100094z	startalk.tech	V[200010]_P[PC64]_ID[d7441a55eb99456d90f13c31ced2e693]_C[1]_PB	PC	101.198.192.15	2020-10-28 19:17:13+08	2020-10-28 19:17:19+08	server
47	100094z	startalk.tech	V[200010]_P[PC64]_ID[bc3e8ff591af4321a5e2bd9efa974ba3]_C[1]_PB	PC	101.198.192.15	2020-10-28 19:18:54+08	2020-10-28 19:18:58+08	server
48	100094z	startalk.tech	V[200010]_P[PC64]_ID[6c0ee99c052749938873c5e0f964563e]_C[1]_PB	PC	101.198.192.11	2020-10-28 19:23:18+08	2020-10-28 19:26:09+08	server
49	100094z	startalk.tech	V[200010]_P[PC64]_ID[f9e7c524404545a1bdebede9e6caa976]_C[1]_PB	PC	101.198.192.11	2020-10-28 19:26:06+08	2020-10-28 19:26:09+08	server
50	100094z	startalk.tech	V[246]_P[Android]_D[OPPO A83]_ID[45e646d2-6050-4a45-b94d-3a4a60814c2b]_PB	Android	223.104.3.182	2020-10-28 19:45:31+08	2020-10-28 20:02:03+08	server
51	100094z	startalk.tech	V[246]_P[Android]_D[OPPO A83]_ID[fe65093b-8824-4d57-9542-7819f6caa5f0]_PB	Android	223.104.3.182	2020-10-28 20:07:05+08	2020-10-28 20:07:08+08	server
52	100094z	startalk.tech	V[246]_P[Android]_D[OPPO A83]_ID[e3589af4-ce34-4db6-890d-32b5a868afa1]_PB	Android	223.104.3.182	2020-10-28 20:17:09+08	2020-10-28 20:17:14+08	server
53	100094z	startalk.tech	V[246]_P[Android]_D[OPPO A83]_ID[bd52e196-adc6-4e6b-97df-60e3280f2086]_PB	Android	223.104.3.187	2020-10-29 11:19:14+08	2020-10-29 11:20:49+08	server
54	100094z	startalk.tech	V[200010]_P[PC64]_ID[b9d1ac611b6a47838ce3179c20f853f0]_C[1]_PB	PC	101.198.192.11	2020-10-28 19:35:21+08	2020-10-29 11:24:05+08	server
55	100094z	startalk.tech	V[200010]_P[PC64]_ID[5a281d6577004880a3fa90bbe16d9e75]_C[1]_PB	PC	101.198.192.15	2020-10-28 19:37:43+08	2020-10-29 11:24:05+08	server
56	100094z	startalk.tech	V[246]_P[Android]_D[OPPO A83]_ID[decfa7ed-6f73-4161-a939-2a4851471eee]_PB	Android	223.104.3.187	2020-10-29 11:18:30+08	2020-10-29 11:28:40+08	server
57	100094z	startalk.tech	V[246]_P[Android]_D[OPPO A83]_ID[9b27fb25-af39-411e-8f09-1649d9e91213]_PB	Android	223.104.3.187	2020-10-29 11:19:59+08	2020-10-29 11:29:24+08	server
58	100094z	startalk.tech	V[246]_P[Android]_D[OPPO A83]_ID[87930ba9-f793-44ec-ab9b-d7e52e805516]_PB	Android	223.104.3.187	2020-10-29 11:29:24+08	2020-10-29 11:30:33+08	server
59	100094z	startalk.tech	V[246]_P[Android]_D[OPPO A83]_ID[884711c4-4eaf-4978-a700-fdda83130c2c]_PB	Android	223.104.3.187	2020-10-29 11:28:40+08	2020-10-29 11:32:13+08	server
60	100094z	startalk.tech	V[246]_P[Android]_D[OPPO A83]_ID[0f2de813-943b-4b89-a1eb-a658b8efffc2]_PB	Android	223.104.3.187	2020-10-29 11:23:36+08	2020-10-29 11:33:02+08	server
61	100094z	startalk.tech	V[246]_P[Android]_D[OPPO A83]_ID[d0d1ff5e-3d5e-44bf-b6a0-0d6f5bf08d4b]_PB	Android	223.104.3.187	2020-10-29 11:20:42+08	2020-10-29 11:33:06+08	server
62	100094z	startalk.tech	V[246]_P[Android]_D[OPPO A83]_ID[4957ccda-7eab-4483-abe0-2c57256ce949]_PB	Android	223.104.3.187	2020-10-29 11:27:55+08	2020-10-29 11:33:15+08	server
63	100094z	startalk.tech	V[246]_P[Android]_D[OPPO A83]_ID[dc073163-4363-4ad4-8158-042d18d5f634]_PB	Android	223.104.3.187	2020-10-29 11:25:47+08	2020-10-29 11:33:25+08	server
64	100094z	startalk.tech	V[246]_P[Android]_D[OPPO A83]_ID[c3101772-557a-403b-86f8-8634e695ff5e]_PB	Android	223.104.3.187	2020-10-29 11:21:56+08	2020-10-29 11:37:31+08	server
65	100094z	startalk.tech	V[246]_P[Android]_D[OPPO A83]_ID[82e0dc8a-ae6f-42fc-8d09-07f18c14df9c]_PB	Android	223.104.3.187	2020-10-29 11:22:58+08	2020-10-29 11:40:20+08	server
66	100094z	startalk.tech	V[246]_P[Android]_D[OPPO A83]_ID[fbebb220-5979-41f7-b617-f535b3e8f0b5]_PB	Android	223.104.3.187	2020-10-29 11:25:03+08	2020-10-29 11:40:37+08	server
67	100094z	startalk.tech	V[246]_P[Android]_D[OPPO A83]_ID[2925fedb-6a18-4c0c-9b8f-847cc49441ed]_PB	Android	223.104.3.187	2020-10-29 11:24:20+08	2020-10-29 11:41:00+08	server
68	100094z	startalk.tech	V[251]_P[Android]_D[MuMu]_ID[7f005c9a-4147-42cd-a21f-ce11395b5a40]_PB	Android	101.198.192.15	2020-10-29 11:43:10+08	2020-10-29 11:45:46+08	server
69	100096z	startalk.tech	V[200010]_P[PC64]_ID[845b763e79464533ab46e704a36dafd4]_C[1]_PB	PC	101.198.192.15	2020-10-29 11:44:55+08	2020-10-29 11:51:11+08	server
70	100096z	startalk.tech	V[200010]_P[PC64]_ID[978740b22a794fab9fb805ef18057027]_C[1]_PB	PC	101.198.192.11	2020-10-29 11:27:11+08	2020-10-29 11:51:11+08	server
71	100094z	startalk.tech	V[251]_P[Android]_D[MuMu]_ID[1a82dddb-055b-4fd8-ac19-3a490b901051]_PB	Android	101.198.192.11	2020-10-29 13:16:40+08	2020-10-29 13:16:44+08	server
72	100094z	startalk.tech	V[251]_P[Android]_D[MuMu]_ID[a2503e08-d9c1-486d-ad11-1b3499aa4ddc]_PB	Android	101.198.192.15	2020-10-29 13:16:44+08	2020-10-29 13:17:39+08	server
73	100096z	startalk.tech	V[200010]_P[PC64]_ID[0b30f7fdd5b54b0d9777b983d8417091]_C[1]_PB	PC	101.198.192.15	2020-10-29 13:17:48+08	2020-10-29 13:18:45+08	server
74	100095z	startalk.tech	V[254]_P[Android]_D[MuMu]_ID[39746bfc-a192-4956-a4f5-631c83be6f3a]_PB	Android	115.192.101.150	2020-10-29 14:35:15+08	2020-10-29 14:37:46+08	server
75	100094z	startalk.tech	V[251]_P[Android]_D[MuMu]_ID[07ded0cd-ebf4-4991-a4d4-4690d8074d6d]_PB	Android	101.198.192.15	2020-10-29 13:17:44+08	2020-10-29 14:44:34+08	server
76	100094z	startalk.tech	V[200010]_P[PC64]_ID[6068c636e9db48f98b68facb63b345dc]_C[1]_PB	PC	115.192.101.150	2020-10-29 14:28:24+08	2020-10-29 15:21:24+08	server
77	100094z	startalk.tech	V[200010]_P[PC64]_ID[fde79f6efac44537b855e3ea52a10c31]_C[1]_PB	PC	115.192.101.150	2020-10-29 14:30:29+08	2020-10-29 15:21:26+08	server
78	100094z	startalk.tech	V[251]_P[Android]_D[MuMu]_ID[09cd931f-af76-400c-bc56-de18b14445f8]_PB	Android	101.198.192.11	2020-10-29 16:20:26+08	2020-10-29 16:22:23+08	server
79	100094z	startalk.tech	V[251]_P[Android]_D[MuMu]_ID[26e04f52-3885-47a2-9b13-3f160097af47]_PB	Android	101.198.192.11	2020-10-29 16:22:27+08	2020-10-29 16:25:44+08	server
80	100094z	startalk.tech	V[251]_P[Android]_D[MuMu]_ID[89136b41-c2ba-45d4-ab93-bbdd5b72568c]_PB	Android	101.198.192.15	2020-10-29 16:25:48+08	2020-10-29 16:26:53+08	server
81	100094z	startalk.tech	V[251]_P[Android]_D[MuMu]_ID[905d00df-a368-4bdb-9c36-0eb55ee2950d]_PB	Android	101.198.192.11	2020-10-29 16:27:19+08	2020-10-29 17:35:38+08	server
82	100094z	startalk.tech	V[251]_P[Android]_D[MuMu]_ID[66214a85-1f87-4a79-9e73-be64884b8a75]_PB	Android	101.198.192.15	2020-10-29 17:33:43+08	2020-10-29 18:53:06+08	server
83	100095z	startalk.tech	V[254]_P[Android]_D[MuMu]_ID[1e5a96c1-4ce3-4bca-849b-a0645fe8ddcd]_PB	Android	218.72.28.35	2020-10-29 19:14:32+08	2020-10-29 19:58:16+08	server
84	100096z	startalk.tech	V[254]_P[Android]_D[MuMu]_ID[421cef96-6ae9-4ea2-8cd2-7e8bdbfcff55]_PB	Android	218.72.28.35	2020-10-29 19:59:58+08	2020-10-29 20:02:33+08	server
85	100096z	startalk.tech	V[254]_P[Android]_D[MuMu]_ID[eee4fca1-ee3e-461d-bc97-d431be1aeabc]_PB	Android	218.72.28.35	2020-10-29 20:02:38+08	2020-10-29 20:03:05+08	server
86	100094z	startalk.tech	V[251]_P[Android]_D[MuMu]_ID[6df86769-229f-4108-a51b-82e185bb5afa]_PB	Android	101.198.192.15	2020-10-29 20:06:26+08	2020-10-29 20:58:28+08	server
87	100096z	startalk.tech	V[254]_P[Android]_D[MuMu]_ID[a0dba3fe-0f14-4e1d-968f-291ca356a165]_PB	Android	218.72.28.35	2020-10-29 20:08:25+08	2020-10-29 21:01:52+08	server
88	100095z	startalk.tech	V[254]_P[Android]_D[MuMu]_ID[652a6b40-d739-4246-884d-9a07d32b156e]_PB	Android	218.72.28.35	2020-10-29 20:10:22+08	2020-10-29 22:11:34+08	server
89	100094z	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[1170457b-92dd-4019-bd61-db1b2dc15143]_PB	Android	218.72.28.35	2020-10-30 00:29:55+08	2020-10-30 00:31:42+08	server
90	100094z	startalk.tech	V[200010]_P[PC64]_ID[ea0d70e2e416449092dbf825797a30e4]_C[1]_PB	PC	218.72.28.35	2020-10-29 15:05:00+08	2020-10-30 00:35:33+08	server
91	100094z	startalk.tech	V[200010]_P[PC64]_ID[8d98d2343d9d49f09e7e94fe92edb464]_C[1]_PB	PC	218.72.28.35	2020-10-29 19:13:49+08	2020-10-30 00:35:33+08	server
92	100094z	startalk.tech	V[200010]_P[PC64]_ID[449fca9e9d1d4c71960e44fa87972dbb]_C[1]_PB	PC	218.72.28.35	2020-10-30 00:32:32+08	2020-10-30 00:35:33+08	server
93	100095z	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[f9ac3436-2e04-40e4-86fa-10917cac240e]_PB	Android	218.72.28.35	2020-10-30 00:31:51+08	2020-10-30 00:52:01+08	server
94	100004q	startalk.tech	V[240]_P[Android]_D[MIX 2]_ID[46aed1b2-c163-4fb4-bb22-c24ba60e731f]_PB	Android	42.61.154.39	2020-10-25 18:28:03+08	2020-10-30 06:49:15+08	server
95	100094z	startalk.tech	V[251]_P[Android]_D[MuMu]_ID[739818bc-98ea-43b3-a1fc-947178114789]_PB	Android	101.198.192.15	2020-10-30 20:46:01+08	2020-10-30 20:46:06+08	server
96	100094z	startalk.tech	V[251]_P[Android]_D[MuMu]_ID[e8d6e6be-3bb7-4be8-980b-feed58669ce6]_PB	Android	101.198.192.11	2020-10-30 20:46:06+08	2020-10-30 20:47:02+08	server
97	100094z	startalk.tech	V[254]_P[Android]_D[MuMu]_ID[2ed21b66-7b65-431b-9ccd-7abb6e984097]_PB	Android	101.198.192.11	2020-10-30 20:49:37+08	2020-10-30 20:50:42+08	server
98	100094z	startalk.tech	V[254]_P[Android]_D[MuMu]_ID[916cd4a0-d0f0-4f3f-8f46-12e060c0a6c3]_PB	Android	101.198.192.11	2020-10-30 20:50:45+08	2020-10-30 20:50:57+08	server
99	100094z	startalk.tech	V[254]_P[Android]_D[MuMu]_ID[20cdadf3-d9a8-487d-9108-c4299273ccad]_PB	Android	101.198.192.11	2020-10-30 20:51:02+08	2020-10-30 20:58:45+08	server
100	100094z	startalk.tech	V[254]_P[Android]_D[MuMu]_ID[8d84a711-7288-40f0-aa25-0b6363269d44]_PB	Android	101.198.192.15	2020-10-30 20:59:08+08	2020-10-30 21:00:43+08	server
101	100094z	startalk.tech	V[254]_P[Android]_D[MuMu]_ID[5707af2b-2997-4166-a9fa-8975f3eb9e3e]_PB	Android	101.198.192.11	2020-10-30 21:00:48+08	2020-10-30 22:00:40+08	server
102	100094z	startalk.tech	V[254]_P[Android]_D[MuMu]_ID[5bb90e41-2de4-4938-a0b7-939d32d36c3a]_PB	Android	101.198.192.15	2020-10-30 21:44:29+08	2020-10-30 22:13:18+08	server
103	100094z	startalk.tech	V[254]_P[Android]_D[MuMu]_ID[4eb80b7d-4bf5-42c8-a4a9-c920b8f8c6bf]_PB	Android	101.198.192.11	2020-10-30 22:13:22+08	2020-10-31 00:33:28+08	server
104	100004q	startalk.tech	V[240]_P[Android]_D[MIX 2]_ID[5332d67c-53ef-4ee5-aa14-649eaec36b24]_PB	Android	42.61.154.39	2020-10-30 06:49:14+08	2020-10-31 10:50:53+08	server
105	100094z	startalk.tech	V[246]_P[Android]_D[OPPO A83]_ID[db313566-6e07-415e-8fec-0f48f565aaba]_PB	Android	219.143.154.44	2020-10-31 11:58:33+08	2020-10-31 12:12:37+08	server
106	100094z	startalk.tech	V[246]_P[Android]_D[OPPO A83]_ID[d33994da-3713-4b18-8ade-53a7f86a0f1c]_PB	Android	219.143.154.44	2020-10-31 12:12:58+08	2020-10-31 12:13:21+08	server
107	100095z	startalk.tech	V[200010]_P[Mac]_ID[938d4869f4d24822affd74064ca57c7f]_C[1]_PB	Mac	219.143.154.44	2020-10-31 12:18:02+08	2020-10-31 12:18:32+08	server
108	100096z	startalk.tech	V[200010]_P[Mac]_ID[eb21bf666e5c452fb19c4166f70dfd1c]_C[1]_PB	Mac	219.143.154.44	2020-10-31 12:11:33+08	2020-10-31 12:18:33+08	server
109	100095z	startalk.tech	V[200010]_P[Mac]_ID[aa8a221406f644e2b28460a3f9ddb714]_C[1]_PB	Mac	219.143.154.44	2020-10-31 12:15:27+08	2020-10-31 12:18:33+08	server
110	100094z	startalk.tech	V[246]_P[Android]_D[OPPO A83]_ID[02c68ab4-28ae-43e5-85f7-bdead7f8d1ae]_PB	Android	219.143.154.44	2020-10-31 12:13:53+08	2020-10-31 12:22:12+08	server
111	100094z	startalk.tech	V[246]_P[Android]_D[OPPO A83]_ID[64b8bd82-fbd6-4aef-9ce7-263fe22c2e33]_PB	Android	219.143.154.44	2020-10-31 12:34:19+08	2020-10-31 12:43:53+08	server
112	100095z	startalk.tech	V[200010]_P[Mac]_ID[ec6698fa0a994e478b1af5e29a1af8d4]_C[1]_PB	Mac	219.143.154.44	2020-10-31 12:39:07+08	2020-10-31 12:49:05+08	server
113	100094z	startalk.tech	V[246]_P[Android]_D[OPPO A83]_ID[ffb9dd0a-3f14-44cd-a45e-d28d21ada1e5]_PB	Android	219.143.154.44	2020-10-31 12:45:35+08	2020-10-31 12:50:43+08	server
114	100094z	startalk.tech	V[246]_P[Android]_D[OPPO A83]_ID[cdc08c0b-b07c-4864-92ac-bab6eba6607d]_PB	Android	219.143.154.44	2020-10-31 12:55:46+08	2020-10-31 12:56:05+08	server
115	100094z	startalk.tech	V[246]_P[Android]_D[OPPO A83]_ID[529ec32c-126d-45bb-b5ec-171625fcd6ce]_PB	Android	219.143.154.44	2020-10-31 12:59:15+08	2020-10-31 13:04:28+08	server
116	100095z	startalk.tech	V[200010]_P[Mac]_ID[14fabc5db989440b97aadf74566738f4]_C[1]_PB	Mac	219.143.154.44	2020-10-31 12:32:04+08	2020-10-31 13:05:19+08	server
117	100095z	startalk.tech	V[200010]_P[Mac]_ID[273f9a000aa34959a10f471668e4a4ff]_C[1]_PB	Mac	219.143.154.44	2020-10-31 12:18:56+08	2020-10-31 13:05:20+08	server
118	100095z	startalk.tech	V[200010]_P[Mac]_ID[10f5419273d941dc8e69f7753d0c565a]_C[1]_PB	Mac	219.143.154.44	2020-10-31 12:30:59+08	2020-10-31 13:05:20+08	server
119	100095z	startalk.tech	V[200010]_P[Mac]_ID[e05e198cd63b417abe0ccd2c269649bc]_C[1]_PB	Mac	219.143.154.44	2020-10-31 12:26:12+08	2020-10-31 13:05:21+08	server
120	100094z	startalk.tech	V[246]_P[Android]_D[OPPO A83]_ID[7a225022-1c9b-4822-b887-1692f0086a95]_PB	Android	219.143.154.44	2020-10-31 13:09:29+08	2020-10-31 13:09:34+08	server
121	100094z	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[b727c2da-d73e-4f33-88cd-3ad43b5df816]_PB	Android	36.17.164.156	2020-10-31 14:56:47+08	2020-10-31 14:58:23+08	server
122	100095z	startalk.tech	V[254]_P[Android]_D[MuMu]_ID[725c8595-3336-4cf7-8237-f04ebb09828d]_PB	Android	218.72.28.35	2020-10-31 15:10:47+08	2020-10-31 15:11:04+08	server
123	100096z	startalk.tech	V[254]_P[Android]_D[MuMu]_ID[7309c204-3018-416f-a2cc-37514047ebd7]_PB	Android	218.72.28.35	2020-10-31 15:11:10+08	2020-10-31 15:19:02+08	server
124	100094z	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[6485ff6d-00ee-488d-b8c4-09060cba27b9]_PB	Android	36.17.164.156	2020-10-31 15:01:16+08	2020-10-31 15:26:01+08	server
125	100094z	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[94fc49ed-f2b7-44e5-adc0-9a9ea7dd3642]_PB	Android	36.17.164.156	2020-10-31 15:31:23+08	2020-10-31 15:31:34+08	server
126	100004q	startalk.tech	V[240]_P[Android]_D[MIX 2]_ID[f5cf6920-3b28-4d18-b6e2-709a883a6e11]_PB	Android	42.61.154.39	2020-10-31 10:50:52+08	2020-10-31 19:51:17+08	server
127	100095z	startalk.tech	V[200010]_P[Mac]_ID[75a6a2a1a527466f9868a59977df3c11]_C[1]_PB	Mac	219.143.154.44	2020-10-31 22:57:51+08	2020-10-31 22:58:04+08	server
128	100095z	startalk.tech	V[200010]_P[Mac]_ID[4da7486e97b14c7eb32a461875b7e284]_C[1]_PB	Mac	219.143.154.44	2020-10-31 23:00:11+08	2020-10-31 23:00:54+08	server
129	100095z	startalk.tech	V[200010]_P[Mac]_ID[7c22c71673c34e7b8259623381f37acc]_C[1]_PB	Mac	219.143.154.44	2020-10-31 23:17:06+08	2020-10-31 23:27:12+08	server
130	100095z	startalk.tech	V[200010]_P[PC64]_ID[76574580495842b287395996c3bbbdeb]_C[1]_PB	PC	218.72.28.35	2020-10-31 15:33:12+08	2020-11-01 01:32:41+08	server
131	100095z	startalk.tech	V[200010]_P[PC64]_ID[65cb05a4e94648d0a04b77fc09d92727]_C[1]_PB	PC	218.72.28.35	2020-10-31 15:03:41+08	2020-11-01 01:32:41+08	server
132	100095z	startalk.tech	V[200010]_P[PC64]_ID[0bf6432aa9dc4cb780568e0192d1e9b7]_C[1]_PB	PC	218.72.28.35	2020-10-31 15:22:00+08	2020-11-01 01:32:41+08	server
133	100096z	startalk.tech	V[200010]_P[PC64]_ID[ae4ac3aa757445ea91f5cbba43fc2676]_C[1]_PB	PC	101.198.192.15	2020-11-02 15:02:28+08	2020-11-02 15:06:05+08	server
134	100096z	startalk.tech	V[200010]_P[PC64]_ID[dff1720b1df444a59ec561c2ca329800]_C[1]_PB	PC	101.198.192.11	2020-11-02 16:06:06+08	2020-11-02 17:45:32+08	server
135	100095z	startalk.tech	V[200010]_P[PC64]_ID[0c9ff71a670f46fa848086b490f67905]_C[1]_PB	PC	101.198.192.15	2020-11-02 16:12:03+08	2020-11-02 17:45:38+08	server
136	100095z	startalk.tech	V[200010]_P[PC64]_ID[b17196f413524e9c9ca721272ab418e7]_C[1]_PB	PC	101.198.192.15	2020-11-02 16:11:22+08	2020-11-02 17:45:38+08	server
137	100094z	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[1a869f46-e6c4-47b5-a043-a2af202061fa]_PB	Android	122.233.229.123	2020-11-02 17:33:33+08	2020-11-02 17:46:47+08	server
138	100095z	startalk.tech	V[200010]_P[PC64]_ID[23654fbd1988414db2b87686ae3a9dd3]_C[1]_PB	PC	122.233.229.123	2020-11-02 17:33:54+08	2020-11-02 17:47:25+08	server
139	100094z	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[c9d32e3d-3b6e-4f2d-81d8-0db1562676fd]_PB	Android	122.233.229.123	2020-11-02 17:46:50+08	2020-11-02 17:50:16+08	server
140	100095z	startalk.tech	V[200010]_P[PC64]_ID[84e3ae5e6cf84245bc786b122b0cdb83]_C[1]_PB	PC	122.233.229.123	2020-11-02 17:47:58+08	2020-11-02 17:51:09+08	server
141	100096z	startalk.tech	V[254]_P[Android]_D[MuMu]_ID[5e84109a-bc24-4a0b-b8bd-e9077a4a6d40]_PB	Android	122.233.229.123	2020-11-02 17:48:27+08	2020-11-02 17:51:53+08	server
142	100094z	startalk.tech	V[200010]_P[PC64]_ID[29022e64ec534102bfcc48f3140b201a]_C[1]_PB	PC	101.198.192.15	2020-11-02 17:46:24+08	2020-11-02 17:53:28+08	server
143	100095z	startalk.tech	V[200010]_P[PC64]_ID[f3879bfbb7d343dc89bea43d2ebb44cd]_C[1]_PB	PC	122.233.229.123	2020-11-02 17:51:20+08	2020-11-02 17:55:06+08	server
144	100094z	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[94fbb4bc-2a2c-456c-badc-69099ba70e1b]_PB	Android	122.233.229.123	2020-11-02 17:50:36+08	2020-11-02 17:55:13+08	server
145	100096z	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[05918b91-4aca-4f99-b864-9895b130f9cb]_PB	Android	122.233.229.123	2020-11-02 17:55:22+08	2020-11-02 17:55:38+08	server
146	100004q	startalk.tech	V[240]_P[Android]_D[MIX 2]_ID[42c6dfda-4bf9-44bb-a670-02dc68c4cf46]_PB	Android	42.61.154.39	2020-10-31 19:51:16+08	2020-11-02 18:04:14+08	server
147	100004q	startalk.tech	V[240]_P[Android]_D[MIX 2]_ID[879b8969-bd68-42a2-8605-2dd38eb20c11]_PB	Android	42.61.154.39	2020-11-02 18:04:16+08	2020-11-02 18:04:23+08	server
148	100096z	startalk.tech	V[254]_P[Android]_D[MuMu]_ID[05986beb-2405-441b-86e2-1dca1e9904c4]_PB	Android	122.233.229.123	2020-11-02 17:58:34+08	2020-11-02 18:18:00+08	server
149	mumu	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[9e1eba15-327b-4201-8c57-e5b3bef61cbd]_PB	Android	36.17.176.202	2020-11-02 17:57:28+08	2020-11-02 18:18:52+08	server
150	mumu	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[9a37cd6e-bafa-4894-af99-53f9ab10196a]_PB	Android	36.17.176.202	2020-11-02 18:21:12+08	2020-11-02 18:24:25+08	server
151	100004q	startalk.tech	V[240]_P[Android]_D[MIX 2]_ID[0b71fae2-18a6-4753-97c1-f7ddd5c77cb8]_PB	Android	42.61.154.39	2020-11-02 18:04:23+08	2020-11-02 18:32:56+08	server
152	mumu	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[22cb7d2c-4361-4b84-a438-273304c29614]_PB	Android	36.17.176.202	2020-11-02 18:48:10+08	2020-11-02 18:52:29+08	server
153	mumu	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[3414aa4d-ceb2-49af-9e19-e7e166b150a7]_PB	Android	36.17.176.202	2020-11-02 18:52:39+08	2020-11-02 18:55:30+08	server
154	mumu	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[913ceb3f-3db3-4062-a7e0-25ff78369da9]_PB	Android	36.17.176.202	2020-11-02 18:55:36+08	2020-11-02 19:02:46+08	server
155	mumu	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[06282f93-e1df-4f17-8422-270126503001]_PB	Android	122.233.229.123	2020-11-02 18:58:35+08	2020-11-02 19:03:28+08	server
156	100095z	startalk.tech	V[200010]_P[PC64]_ID[b01da2fb546b4d1693eefae5aa05c1c2]_C[1]_PB	PC	36.17.176.202	2020-11-02 18:01:22+08	2020-11-02 19:09:09+08	server
157	mumu	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[3858f6ae-9b56-4f44-a2a9-fa887c09b740]_PB	Android	122.233.229.123	2020-11-02 19:22:41+08	2020-11-02 19:34:46+08	server
158	mumu	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[66ea6ef8-dad0-4e54-905c-a39dfef94d42]_PB	Android	122.233.229.123	2020-11-02 19:39:24+08	2020-11-02 19:39:35+08	server
159	100094z	startalk.tech	V[254]_P[Android]_D[MuMu]_ID[30159d30-9b44-4551-ab38-88189596e704]_PB	Android	101.198.192.15	2020-11-02 17:20:42+08	2020-11-02 20:34:39+08	server
160	mumu	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[10dc77d2-00f6-4903-b634-6b08c613b954]_PB	Android	122.233.229.123	2020-11-03 07:19:12+08	2020-11-03 07:19:17+08	server
161	100095z	startalk.tech	V[200010]_P[PC64]_ID[15296ec6501b48d5ba6b379ea776c677]_C[1]_PB	PC	101.198.192.11	2020-11-03 09:00:53+08	2020-11-03 09:22:02+08	server
162	100094z	startalk.tech	V[200010]_P[PC64]_ID[85f2f474d55b47b3b349bbe521be7817]_C[1]_PB	PC	101.198.192.15	2020-11-02 17:54:22+08	2020-11-03 09:22:02+08	server
163	100095z	startalk.tech	V[200010]_P[PC64]_ID[f3b1a3be37a14b759edb0e957eb57cc6]_C[1]_PB	PC	101.198.192.11	2020-11-02 19:23:14+08	2020-11-03 09:22:02+08	server
164	100095z	startalk.tech	V[200010]_P[PC64]_ID[0abb360cd9cb4f579d9e9ef0759323ad]_C[1]_PB	PC	101.198.192.11	2020-11-03 09:22:50+08	2020-11-03 09:46:00+08	server
165	100095z	startalk.tech	V[200010]_P[PC64]_ID[8061ddc1d87a4617b33fdb0ce79d4dc3]_C[1]_PB	PC	101.198.192.15	2020-11-03 09:24:04+08	2020-11-03 09:46:00+08	server
166	100095z	startalk.tech	V[200010]_P[PC64]_ID[4ae7839c0bcb4b4ba9f7cdec3284289f]_C[1]_PB	PC	101.198.192.11	2020-11-03 09:46:09+08	2020-11-03 09:48:01+08	server
167	100095z	startalk.tech	V[200010]_P[PC64]_ID[1dd653a879d84f43b9c0c90df1c273b0]_C[1]_PB	PC	101.198.192.11	2020-11-03 09:48:14+08	2020-11-03 09:49:27+08	server
168	100094z	startalk.tech	V[254]_P[Android]_D[MuMu]_ID[04db3aee-3357-4d80-92dd-9bcbf13e84fd]_PB	Android	101.198.192.15	2020-11-03 09:20:33+08	2020-11-03 10:05:28+08	server
169	100095z	startalk.tech	V[200010]_P[PC64]_ID[248aec22d6aa456085833f99e77dc148]_C[1]_PB	PC	122.233.229.123	2020-11-03 10:13:55+08	2020-11-03 10:14:49+08	server
170	100094z	startalk.tech	V[200010]_P[PC64]_ID[fcda6a9a9c9b4420b0c1b657c06950a5]_C[1]_PB	PC	122.233.229.123	2020-11-03 10:49:46+08	2020-11-03 10:50:23+08	server
171	100095z	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[47a9ccb4-546d-422b-86a8-4b56c7e442e4]_PB	Android	122.233.229.123	2020-11-03 10:59:04+08	2020-11-03 11:00:20+08	server
172	100095z	startalk.tech	V[200010]_P[PC64]_ID[bdef92814f2d4519a76c2d94945baef9]_C[1]_PB	PC	101.198.192.11	2020-11-03 11:20:31+08	2020-11-03 11:21:46+08	server
173	100095z	startalk.tech	V[200010]_P[PC64]_ID[fcbd348658654f91a0ba00cd08314511]_C[1]_PB	PC	101.198.192.15	2020-11-03 11:14:13+08	2020-11-03 11:21:46+08	server
174	100095z	startalk.tech	V[200010]_P[PC64]_ID[079f499feefb435ab62c7886131e93f4]_C[1]_PB	PC	101.198.192.11	2020-11-03 11:07:34+08	2020-11-03 11:21:46+08	server
175	100095z	startalk.tech	V[200010]_P[PC64]_ID[82958ae992924b75b47c27ef3ff9b438]_C[1]_PB	PC	101.198.192.11	2020-11-03 11:05:47+08	2020-11-03 11:21:46+08	server
176	100095z	startalk.tech	V[200010]_P[PC64]_ID[337b6792b3ee4c0aa81da9c8c09428f4]_C[1]_PB	PC	101.198.192.11	2020-11-03 11:08:31+08	2020-11-03 11:21:46+08	server
177	100095z	startalk.tech	V[200010]_P[PC64]_ID[3da0a59a111c477481d6f106909f2e31]_C[1]_PB	PC	101.198.192.11	2020-11-03 11:04:58+08	2020-11-03 11:21:46+08	server
178	100095z	startalk.tech	V[200010]_P[PC64]_ID[2f01b7e26caa4cbd8eddef6d02a54090]_C[1]_PB	PC	101.198.192.15	2020-11-03 11:11:40+08	2020-11-03 11:21:46+08	server
179	100013v	startalk.tech	V[200010]_P[PC64]_ID[62d7083de0a84ea49f367e3d9e2fe52e]_C[1]_PB	PC	220.184.161.75	2020-11-03 11:18:15+08	2020-11-03 11:23:23+08	server
180	100094z	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[cb537339-e547-4720-9996-b5d0012907c9]_PB	Android	122.233.229.123	2020-11-03 11:24:09+08	2020-11-03 11:24:31+08	server
181	100013v	startalk.tech	V[240]_P[Android]_D[YAL-AL10]_ID[d3abfd4a-6ad0-480e-896a-a1a409d4959e]_PB	Android	112.17.247.165	2020-11-03 11:24:40+08	2020-11-03 11:26:46+08	server
182	100095z	startalk.tech	V[200010]_P[PC64]_ID[61ad73d85756484b8bc378c428a09081]_C[1]_PB	PC	101.198.192.15	2020-11-03 11:10:18+08	2020-11-03 11:27:51+08	server
183	100095z	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[b47dd1b0-0eb6-481e-ad79-33ca3d82b8df]_PB	Android	122.233.229.123	2020-11-03 11:24:41+08	2020-11-03 11:30:47+08	server
184	100095z	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[7a04743b-a555-48a1-b0a0-adbac26bb0f1]_PB	Android	122.233.229.123	2020-11-03 11:31:01+08	2020-11-03 11:34:31+08	server
185	100095z	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[acc1f850-3eb8-4fe4-be6a-1fe507546aac]_PB	Android	122.233.229.123	2020-11-03 11:34:34+08	2020-11-03 11:38:31+08	server
186	100095z	startalk.tech	V[200010]_P[PC64]_ID[ed0ebf5ec38a4c8c8d86dae263b365e3]_C[1]_PB	PC	101.198.192.15	2020-11-03 11:22:07+08	2020-11-03 11:45:52+08	server
187	100095z	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[ee058a51-618e-4dde-857d-8fc13999f253]_PB	Android	122.233.229.123	2020-11-03 11:38:32+08	2020-11-03 11:50:11+08	server
188	100095z	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[4ac2cbf3-0162-4d20-bdbc-f519349252a4]_PB	Android	122.233.229.123	2020-11-03 11:59:25+08	2020-11-03 11:59:43+08	server
189	100013v	startalk.tech	V[240]_P[Android]_D[YAL-AL10]_ID[5c6a84e2-410c-4ae2-8af1-485b937b6391]_PB	Android	112.17.247.165	2020-11-03 12:12:35+08	2020-11-03 12:12:54+08	server
190	100013v	startalk.tech	V[240]_P[Android]_D[YAL-AL10]_ID[86c09f38-b82d-4835-bcfb-4fdd9bb8ec36]_PB	Android	112.17.247.165	2020-11-03 12:13:25+08	2020-11-03 12:13:34+08	server
191	100013v	startalk.tech	V[240]_P[Android]_D[YAL-AL10]_ID[18c72707-9a77-4fc5-8a8b-236b41709b6d]_PB	Android	112.17.247.165	2020-11-03 12:13:55+08	2020-11-03 12:14:05+08	server
192	100013v	startalk.tech	V[240]_P[Android]_D[YAL-AL10]_ID[d12db005-6d8f-4d36-96ae-39b6dc1f24e0]_PB	Android	112.17.247.165	2020-11-03 12:14:07+08	2020-11-03 12:14:25+08	server
193	100013v	startalk.tech	V[200010]_P[PC64]_ID[0567335723df471eb76c665250d32674]_C[1]_PB	PC	220.184.161.75	2020-11-03 11:23:31+08	2020-11-03 15:02:36+08	server
194	100013v	startalk.tech	V[200010]_P[PC64]_ID[c61b125b9dbc4a28bbbe6e5c108ccfd8]_C[1]_PB	PC	112.17.247.165	2020-11-03 14:46:06+08	2020-11-03 15:26:11+08	server
195	100094z	startalk.tech	V[200010]_P[PC64]_ID[391db9c901c3463f805e23a55bb2a64b]_C[1]_PB	PC	122.233.229.123	2020-11-03 11:23:29+08	2020-11-03 18:07:06+08	server
196	100013v	startalk.tech	V[200010]_P[PC64]_ID[3d1e65c3e84e4aa8b5a3195056c44151]_C[1]_PB	PC	220.184.161.75	2020-11-03 15:09:56+08	2020-11-03 20:09:08+08	server
197	100004q	startalk.tech	V[240]_P[Android]_D[MIX 2]_ID[86461dff-6bbf-4e27-a340-7d359d711a27]_PB	Android	42.61.154.39	2020-11-02 18:32:58+08	2020-11-04 09:21:33+08	server
198	100095z	startalk.tech	V[200010]_P[PC64]_ID[56480488781d4327b65eece3a6467689]_C[1]_PB	PC	101.198.192.15	2020-11-05 18:02:47+08	2020-11-05 18:30:12+08	server
199	100095z	startalk.tech	V[200010]_P[PC64]_ID[fb87b394e6f34be088e5896097558e09]_C[1]_PB	PC	101.198.192.15	2020-11-06 19:27:47+08	2020-11-06 19:50:06+08	server
200	100095z	startalk.tech	V[200010]_P[Mac]_ID[ce6d0037b913433da300eb3bd7918896]_C[1]_PB	Mac	219.143.154.44	2020-11-08 17:55:57+08	2020-11-08 19:34:18+08	server
201	100095z	startalk.tech	V[200010]_P[Mac]_ID[b30f7dda56b94e798172ee0499417909]_C[1]_PB	Mac	219.143.154.44	2020-11-08 19:17:44+08	2020-11-08 22:20:07+08	server
202	100095z	startalk.tech	V[200010]_P[Mac]_ID[a2d0f935705a4eb285577e7d3b1105af]_C[1]_PB	Mac	219.143.154.44	2020-11-08 22:03:25+08	2020-11-08 23:57:28+08	server
203	100095z	startalk.tech	V[200010]_P[Mac]_ID[48b365cff7744ccfa2ec62124dd976b9]_C[1]_PB	Mac	219.143.154.44	2020-11-08 23:41:09+08	2020-11-09 00:13:41+08	server
204	100095z	startalk.tech	V[200010]_P[Mac]_ID[87db138662b84a0ebd31a977603b5c95]_C[1]_PB	Mac	219.143.154.44	2020-11-09 00:02:09+08	2020-11-09 00:29:56+08	server
205	100095z	startalk.tech	V[200010]_P[Mac]_ID[330d722fbd354e029e430fd63b6dd764]_C[1]_PB	Mac	219.143.154.44	2020-11-09 02:10:10+08	2020-11-09 04:21:42+08	server
206	100095z	startalk.tech	V[200010]_P[PC64]_ID[0f04b5a7035b4cedbda9e9f87ca34e52]_C[1]_PB	PC	101.198.192.15	2020-11-06 19:50:12+08	2020-11-09 07:48:57+08	server
207	100095z	startalk.tech	V[200010]_P[Mac]_ID[cf4fb4e5adbf47dfbeebf653c8231096]_C[1]_PB	Mac	219.143.154.44	2020-11-09 07:08:18+08	2020-11-09 08:04:36+08	server
208	100095z	startalk.tech	V[200010]_P[Mac]_ID[1f6fb8ac61c04a0dadf2bf6802a4e9b3]_C[1]_PB	Mac	101.198.192.15	2020-11-09 16:29:10+08	2020-11-09 16:32:49+08	server
209	100095z	startalk.tech	V[200010]_P[Mac]_ID[4ca0bd151eea4d6985ad31e0cd5d9d4e]_C[1]_PB	Mac	101.198.192.15	2020-11-09 16:33:21+08	2020-11-09 16:41:23+08	server
210	100095z	startalk.tech	V[200010]_P[Mac]_ID[16062825ed38454ba75a5dae54f504e5]_C[1]_PB	Mac	101.198.192.15	2020-11-09 16:42:37+08	2020-11-09 16:42:53+08	server
211	100095z	startalk.tech	V[200010]_P[Mac]_ID[f922b6016b8b4b90bebf0714733a97c5]_C[1]_PB	Mac	101.198.192.15	2020-11-09 16:44:08+08	2020-11-09 16:49:29+08	server
212	100095z	startalk.tech	V[200010]_P[Mac]_ID[d79c3992e211416c94d449d178571880]_C[1]_PB	Mac	101.198.192.11	2020-11-09 16:51:33+08	2020-11-09 16:52:00+08	server
213	100095z	startalk.tech	V[200010]_P[PC64]_ID[b60d6958cda741788856b65d08c1bb38]_C[1]_PB	PC	101.198.192.15	2020-11-09 17:08:21+08	2020-11-09 17:09:19+08	server
214	100095z	startalk.tech	V[200010]_P[PC64]_ID[812d522240c7481d890173da6066d318]_C[1]_PB	PC	101.198.192.11	2020-11-09 17:09:20+08	2020-11-09 17:18:11+08	server
215	100095z	startalk.tech	V[200010]_P[PC64]_ID[1e81c62930a74e67b4157b09e6bbb3a8]_C[1]_PB	PC	101.198.192.15	2020-11-09 17:18:24+08	2020-11-09 17:36:17+08	server
216	100094z	startalk.tech	V[254]_P[Android]_D[MuMu]_ID[6f4698e1-3cf4-4181-9dc6-3a34155b420e]_PB	Android	101.198.192.11	2020-11-09 17:54:15+08	2020-11-09 17:55:56+08	server
217	100095z	startalk.tech	V[200010]_P[PC64]_ID[db4c987de6b2492fa4a63a169faf7d7b]_C[1]_PB	PC	101.198.192.15	2020-11-09 18:32:41+08	2020-11-09 18:34:18+08	server
218	100095z	startalk.tech	V[200010]_P[PC64]_ID[e9ad9d936fab41f8b8e419a424e41a24]_C[1]_PB	PC	101.198.192.11	2020-11-09 18:36:03+08	2020-11-09 18:39:44+08	server
219	100095z	startalk.tech	V[200010]_P[PC64]_ID[55d1fcd7471647c6b66bf64057526e63]_C[1]_PB	PC	101.198.192.11	2020-11-09 18:43:49+08	2020-11-09 19:16:07+08	server
220	100095z	startalk.tech	V[200010]_P[PC64]_ID[7b46ce89e1ef48fcb6a6e566d1b88ded]_C[1]_PB	PC	101.198.192.11	2020-11-09 19:20:54+08	2020-11-09 19:22:22+08	server
221	100095z	startalk.tech	V[200010]_P[PC64]_ID[f1d22d0827b94e898389593aa8b1c630]_C[1]_PB	PC	101.198.192.15	2020-11-09 19:23:46+08	2020-11-09 19:24:28+08	server
222	100095z	startalk.tech	V[200010]_P[PC64]_ID[b213ef34143541b195c759f564c47a9f]_C[1]_PB	PC	101.198.192.15	2020-11-09 19:32:58+08	2020-11-09 19:33:51+08	server
223	100095z	startalk.tech	V[200010]_P[PC64]_ID[e1dab5e7e7204364b37b4ca72f0ed86b]_C[1]_PB	PC	101.198.192.15	2020-11-09 19:34:50+08	2020-11-09 19:35:44+08	server
224	100095z	startalk.tech	V[200010]_P[PC64]_ID[431ccb7d3c4c4136886d9d48d885e1e0]_C[1]_PB	PC	101.198.192.15	2020-11-10 07:18:06+08	2020-11-10 07:29:33+08	server
225	100095z	startalk.tech	V[200010]_P[PC64]_ID[c1329c080d834bad8f5409daba23ca30]_C[1]_PB	PC	101.198.192.15	2020-11-10 08:04:39+08	2020-11-10 08:05:09+08	server
226	100095z	startalk.tech	V[254]_P[Android]_D[MuMu]_ID[bf26e0a5-28df-4014-8515-9ab2f4dd1a08]_PB	Android	101.198.192.11	2020-11-10 08:12:25+08	2020-11-10 08:14:00+08	server
227	100095z	startalk.tech	V[200010]_P[PC64]_ID[7a2b94cfd8c24efdacb34d03a3107259]_C[1]_PB	PC	101.198.192.11	2020-11-10 08:36:31+08	2020-11-10 08:40:19+08	server
228	100094z	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[e1379011-a12f-402e-b5cb-a8be2f01aa64]_PB	Android	218.72.31.23	2020-11-10 08:58:06+08	2020-11-10 09:22:53+08	server
229	100096z	startalk.tech	V[254]_P[Android]_D[MuMu]_ID[5c14605c-fa4b-4b23-bac3-349ee166c8ad]_PB	Android	218.72.31.23	2020-11-10 09:26:38+08	2020-11-10 09:26:51+08	server
230	100094z	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[7836f83e-0566-4979-9e6d-64c43691c5d0]_PB	Android	218.72.31.23	2020-11-10 09:28:08+08	2020-11-10 10:19:55+08	server
231	100095z	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[c484e334-0789-4330-b94f-159a23a01705]_PB	Android	218.72.31.23	2020-11-10 10:19:58+08	2020-11-10 10:20:15+08	server
232	100096z	startalk.tech	V[254]_P[Android]_D[MuMu]_ID[546b46fb-0e49-4b1c-a8c9-ac21d2e0b3a2]_PB	Android	218.72.31.23	2020-11-10 09:26:56+08	2020-11-10 10:30:24+08	server
233	100004q	startalk.tech	V[240]_P[Android]_D[MIX 2]_ID[7b31ce76-82a7-4f0d-bd03-dd3e011e720d]_PB	Android	42.61.154.39	2020-11-08 17:38:16+08	2020-11-10 11:51:03+08	server
234	100095z	startalk.tech	V[200010]_P[PC64]_ID[59b90b02440d4481beea15641315692f]_C[1]_PB	PC	218.72.31.23	2020-11-10 09:23:40+08	2020-11-10 23:20:08+08	server
235	100094z	startalk.tech	V[200010]_P[PC64]_ID[2b5bb3ef9daa4f96abd05c936854b703]_C[1]_PB	PC	218.72.31.23	2020-11-10 09:23:20+08	2020-11-10 23:20:08+08	server
236	100095z	startalk.tech	V[200010]_P[PC64]_ID[36855f32df9e4f00a7705f607ef49c15]_C[1]_PB	PC	218.72.31.23	2020-11-10 10:17:26+08	2020-11-10 23:20:08+08	server
237	100094z	startalk.tech	V[200010]_P[PC64]_ID[13616f8195a743afab1ee71a695d2ee8]_C[1]_PB	PC	101.198.192.11	2020-11-11 10:04:27+08	2020-11-11 10:26:10+08	server
238	100095z	startalk.tech	V[200010]_P[PC64]_ID[cd6f776778144d5ca0fe24afa27e4654]_C[1]_PB	PC	101.198.192.11	2020-11-11 10:04:19+08	2020-11-11 10:26:39+08	server
239	100094z	startalk.tech	V[200010]_P[PC64]_ID[a5963dd2fd6d4fe29a108ccd1320df49]_C[1]_PB	PC	101.198.192.11	2020-11-11 10:56:23+08	2020-11-11 11:03:08+08	server
240	100094z	startalk.tech	V[200010]_P[PC64]_ID[c26d013818404d059469a1f2ab4d05b6]_C[1]_PB	PC	101.198.192.15	2020-11-11 11:04:08+08	2020-11-11 12:01:53+08	server
241	100094z	startalk.tech	V[200010]_P[PC64]_ID[4ea12a2be5b941a7b673156661a28094]_C[1]_PB	PC	101.198.192.15	2020-11-11 11:45:32+08	2020-11-11 14:10:51+08	server
242	100004q	startalk.tech	V[240]_P[Android]_D[MIX 2]_ID[ec3b5c5e-894d-423e-84ad-25aa364f299b]_PB	Android	42.61.154.39	2020-11-10 11:51:15+08	2020-11-11 17:46:06+08	server
243	100004q	startalk.tech	V[240]_P[Android]_D[MIX 2]_ID[19872495-0ea8-48ce-b59a-bf4879622dff]_PB	Android	42.61.154.39	2020-11-11 17:46:06+08	2020-11-11 20:37:59+08	server
244	100004q	startalk.tech	V[240]_P[Android]_D[MIX 2]_ID[ad6340c4-8907-4b19-9e05-11b72016e8a0]_PB	Android	42.61.154.39	2020-11-11 20:37:58+08	2020-11-11 22:17:42+08	server
245	100004q	startalk.tech	V[240]_P[Android]_D[MIX 2]_ID[7ba03343-e521-4eb3-b34c-2aa8c2826c8d]_PB	Android	42.61.154.39	2020-11-11 22:17:42+08	2020-11-11 22:28:50+08	server
246	100004q	startalk.tech	V[240]_P[Android]_D[MIX 2]_ID[4d9e3e7e-5c5c-48b5-a86b-764861e91850]_PB	Android	42.61.154.39	2020-11-11 22:28:44+08	2020-11-11 22:38:17+08	server
247	mumu	startalk.tech	V[200010]_P[PC64]_ID[a64cdf51e5cf459e89f1cd5cb5f1f649]_C[1]_PB	PC	218.72.31.23	2020-11-11 10:06:59+08	2020-11-11 22:54:38+08	server
248	100004q	startalk.tech	V[254]_P[Android]_D[MuMu]_ID[1cc257d7-e984-4bd5-a192-cb6a5d94afef]_PB	Android	42.61.154.39	2020-11-12 19:18:50+08	2020-11-12 22:30:46+08	server
249	100094z	startalk.tech	V[200010]_P[PC64]_ID[4fdbb5ee9a6749f4b0c58441ae754d7d]_C[1]_PB	PC	101.198.192.11	2020-11-12 20:50:33+08	2020-11-12 22:31:24+08	server
250	mumu	startalk.tech	V[200010]_P[PC64]_ID[8b2156162ec84271b7d3ce7538a3a806]_C[1]_PB	PC	218.72.31.23	2020-11-12 22:14:23+08	2020-11-13 02:38:15+08	server
251	100004q	startalk.tech	V[254]_P[Android]_D[MuMu]_ID[d2a2aeaf-b26e-4e18-9877-50218c3f8719]_PB	Android	42.61.154.39	2020-11-13 02:17:32+08	2020-11-13 07:43:15+08	server
252	100094z	startalk.tech	V[200010]_P[PC64]_ID[10d54d850a954928a6993d541bd6a912]_C[1]_PB	PC	101.198.192.11	2020-11-13 07:56:47+08	2020-11-13 08:28:01+08	server
253	100004q	startalk.tech	V[254]_P[Android]_D[MuMu]_ID[e6e5eb27-8ad4-4b3f-8498-4d1bbf56b7c1]_PB	Android	42.61.154.39	2020-11-13 19:27:51+08	2020-11-13 19:28:17+08	server
254	100096z	startalk.tech	V[254]_P[Android]_D[MuMu]_ID[1f88e33a-6477-42e4-9bd4-30f6ad8b62aa]_PB	Android	125.118.42.104	2020-11-14 23:06:38+08	2020-11-14 23:26:15+08	server
255	100094z	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[01da71c3-1659-4bd3-83fb-0586f33a9d35]_PB	Android	125.118.42.104	2020-11-14 23:06:29+08	2020-11-14 23:54:02+08	server
256	100095z	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[79e4ceee-17d9-4da7-aee5-b92416c01349]_PB	Android	125.118.42.104	2020-11-14 23:54:10+08	2020-11-14 23:59:29+08	server
257	100095z	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[858554de-1bbc-400f-adb9-6089c035e7c9]_PB	Android	125.118.42.104	2020-11-14 23:59:33+08	2020-11-14 23:59:35+08	server
258	mumu	startalk.tech	V[200010]_P[PC64]_ID[d308341c2b594038a9e848475d4c3908]_C[1]_PB	PC	125.118.42.104	2020-11-14 23:27:21+08	2020-11-15 00:14:53+08	server
259	mumu	startalk.tech	V[200010]_P[PC64]_ID[e2c66f061d984f6ea728957b1abd6bfd]_C[1]_PB	PC	125.118.42.104	2020-11-14 23:25:16+08	2020-11-15 00:16:08+08	server
260	mumu	startalk.tech	V[200010]_P[PC64]_ID[851ffd550b4f4534adfc79f65cc443b8]_C[1]_PB	PC	125.118.42.104	2020-11-14 23:57:36+08	2020-11-15 00:16:08+08	server
261	mumu	startalk.tech	V[200010]_P[PC64]_ID[fb72733cc0cd4469ac40a2abc838c75f]_C[1]_PB	PC	125.118.42.104	2020-11-14 23:04:58+08	2020-11-15 01:14:33+08	server
262	mumu	startalk.tech	V[200010]_P[PC64]_ID[be533fa5ba6c4bed87490ec331c2edd2]_C[1]_PB	PC	125.118.42.104	2020-11-14 23:13:30+08	2020-11-15 09:49:04+08	server
263	mumu	startalk.tech	V[200010]_P[PC64]_ID[e9d44899853147748a761a032bb46619]_C[1]_PB	PC	125.118.42.104	2020-11-14 23:24:19+08	2020-11-15 09:49:04+08	server
264	mumu	startalk.tech	V[200010]_P[PC64]_ID[bda0e96ea2174ecb8cdcfe5afbcabc06]_C[1]_PB	PC	125.118.42.104	2020-11-14 23:28:04+08	2020-11-15 09:49:04+08	server
265	mumu	startalk.tech	V[200010]_P[PC64]_ID[8f6092d32b2b47cebeae742bfff5436b]_C[1]_PB	PC	125.118.42.104	2020-11-14 23:24:35+08	2020-11-15 09:49:04+08	server
266	mumu	startalk.tech	V[200010]_P[PC64]_ID[ef47e21a05274aa6b983e57773b7a4f5]_C[1]_PB	PC	125.118.42.104	2020-11-14 23:44:45+08	2020-11-15 09:49:04+08	server
267	100095z	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[7c2a3474-44e5-460a-b541-af99b8730833]_PB	Android	125.118.42.104	2020-11-15 18:16:45+08	2020-11-15 18:29:04+08	server
268	100094z	startalk.tech	V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[F0B8AAE473EB40B491C77E925CE7C667]_PB	iOS	125.118.42.104	2020-11-15 18:15:53+08	2020-11-15 18:29:56+08	server
269	100095z	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[8fe95814-612e-4988-ba96-d7e1e7c017bb]_PB	Android	36.17.178.79	2020-11-15 18:26:46+08	2020-11-15 18:33:15+08	server
270	100095z	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[10f4abac-cb54-4692-95d6-bf10475926b4]_PB	Android	125.118.42.104	2020-11-15 18:29:02+08	2020-11-15 18:34:14+08	server
271	100094z	startalk.tech	V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[75663A7CB4A64F13869B97367EF8BF13]_PB	iOS	125.118.42.104	2020-11-15 18:31:50+08	2020-11-15 18:43:00+08	server
272	100094z	startalk.tech	V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[D3AC1B7D4415412B8400318872B88EFD]_PB	iOS	125.118.42.104	2020-11-15 18:44:27+08	2020-11-15 18:54:19+08	server
273	100094z	startalk.tech	V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[1349D519EBCE4FDA8C94EA8140D1E27C]_PB	iOS	125.118.42.104	2020-11-15 18:54:22+08	2020-11-15 18:55:48+08	server
274	100094z	startalk.tech	V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[A35D7175222B4565A77D7D35B3A17F6C]_PB	iOS	125.118.42.104	2020-11-15 18:55:49+08	2020-11-15 18:58:19+08	server
275	100094z	startalk.tech	V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[B39E053741454DB987D78B756BD9E332]_PB	iOS	125.118.42.104	2020-11-15 18:58:21+08	2020-11-15 18:58:39+08	server
276	100094z	startalk.tech	V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[A3054C7048464CCD90A41AAEB7216778]_PB	iOS	125.118.42.104	2020-11-15 18:58:40+08	2020-11-15 19:04:15+08	server
277	100094z	startalk.tech	V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[BD9E89CF7C6B4561BB181EBC76D8E975]_PB	iOS	125.118.42.104	2020-11-15 19:11:42+08	2020-11-15 19:21:27+08	server
278	100094z	startalk.tech	V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[D7690400AD6B4520B341D92F6EE08884]_PB	iOS	125.118.42.104	2020-11-15 19:21:49+08	2020-11-15 19:27:02+08	server
279	100095z	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[767b96f1-cf16-42bc-a81a-7ad2ea9bf853]_PB	Android	125.118.42.104	2020-11-15 18:39:08+08	2020-11-15 19:40:38+08	server
280	100094z	startalk.tech	V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[754D26FC15B54B1E994C0139CCFAA90F]_PB	iOS	125.118.42.104	2020-11-15 19:55:17+08	2020-11-15 19:56:34+08	server
281	100094z	startalk.tech	V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[C3072FFA900E48329FE919E0E9F500A0]_PB	iOS	125.118.42.104	2020-11-15 20:06:06+08	2020-11-15 20:17:53+08	server
282	100094z	startalk.tech	V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[65EC5D9601E34A089862F3D5F5E06285]_PB	iOS	125.118.42.104	2020-11-15 20:19:52+08	2020-11-15 20:25:41+08	server
283	100094z	startalk.tech	V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[D3598472C18F4D5FAD0650ADDE876243]_PB	iOS	125.118.42.104	2020-11-15 20:27:08+08	2020-11-15 20:31:17+08	server
284	100094z	startalk.tech	V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[9D3CC208885249D98E86465A14C2A149]_PB	iOS	125.118.42.104	2020-11-15 20:56:42+08	2020-11-15 20:57:32+08	server
285	100094z	startalk.tech	V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[9B00C8D1DF3C43999EB424FA76450FC0]_PB	iOS	125.118.42.104	2020-11-16 10:58:37+08	2020-11-16 10:59:35+08	server
286	100094z	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[1232861c-7715-4b5a-8706-50eb7f7c019d]_PB	Android	125.118.42.104	2020-11-16 11:55:30+08	2020-11-16 12:02:36+08	server
287	100094z	startalk.tech	V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[32D4546491D84C63A876C90D25CA3E20]_PB	iOS	125.118.42.104	2020-11-16 12:06:27+08	2020-11-16 12:06:41+08	server
288	100094z	startalk.tech	V[240]_P[Android]_D[ART-AL00x]_ID[03443b33-ac55-471c-a6bf-c6f07e93b829]_PB	Android	125.118.42.104	2020-11-16 12:03:37+08	2020-11-16 12:13:22+08	server
289	100096z	startalk.tech	V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[D1C6A5D8AE2F40CCB13DDEFE21820404]_PB	iOS	125.118.42.104	2020-11-16 12:06:55+08	2020-11-16 12:14:05+08	server
290	100095z	startalk.tech	V[3140670]_P[iOS]_D[iPhone12,8]_S[13.6.1]_ID[6EC6FDF40B804368B2AF7CF2B86A074A]_PB	iOS	223.104.38.159	2020-11-16 13:28:06+08	2020-11-16 13:37:51+08	server
291	100095z	startalk.tech	V[3140670]_P[iOS]_D[iPhone12,8]_S[13.6.1]_ID[DC85BB334501428F9F57013921143DCF]_PB	iOS	223.104.38.159	2020-11-16 14:14:32+08	2020-11-16 14:24:29+08	server
292	100096z	startalk.tech	V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[088EEE98848B485BA9F331844CDBFF69]_PB	iOS	125.118.42.104	2020-11-16 12:24:48+08	2020-11-16 14:25:21+08	server
293	100095z	startalk.tech	V[3140670]_P[iOS]_D[iPhone12,8]_S[13.6.1]_ID[DBC3716FB01A41F398FF36D20EA85A8B]_PB	iOS	223.104.38.159	2020-11-16 15:25:11+08	2020-11-16 15:26:51+08	server
294	100095z	startalk.tech	V[3140670]_P[iOS]_D[iPhone12,8]_S[13.6.1]_ID[7570A864571749F2B68595C461C87BAC]_PB	iOS	223.104.38.159	2020-11-16 16:14:49+08	2020-11-16 16:16:48+08	server
295	100095z	startalk.tech	V[3140670]_P[iOS]_D[iPhone12,8]_S[13.6.1]_ID[2BEBB60CC63E456ABBF7D29B2E1C7C50]_PB	iOS	223.104.38.159	2020-11-16 16:25:02+08	2020-11-16 16:29:43+08	server
296	100095z	startalk.tech	V[3140670]_P[iOS]_D[iPhone12,8]_S[13.6.1]_ID[E400F153B2454BAEA2B875000611FA11]_PB	iOS	223.104.38.159	2020-11-16 16:45:19+08	2020-11-16 16:50:41+08	server
297	mumu	startalk.tech	V[200010]_P[PC64]_ID[55ee9f8429564681bf9038ec0860d0dc]_C[1]_PB	PC	125.118.42.104	2020-11-16 11:54:43+08	2020-11-16 17:02:03+08	server
298	mumu	startalk.tech	V[200010]_P[PC64]_ID[454a8d41a291440394ed87cfa5fb734e]_C[1]_PB	PC	125.118.42.104	2020-11-16 11:57:48+08	2020-11-16 17:02:03+08	server
299	mumu	startalk.tech	V[200010]_P[PC64]_ID[d9e2563c5ec04ce197228c98863db14c]_C[1]_PB	PC	125.118.42.104	2020-11-16 12:04:10+08	2020-11-16 17:02:03+08	server
300	100095z	startalk.tech	V[3140670]_P[iOS]_D[iPhone12,8]_S[13.6.1]_ID[20E2D557FE9B4ED9AEB23D151F5290DF]_PB	iOS	223.104.38.159	2020-11-16 17:01:19+08	2020-11-16 17:05:36+08	server
301	100095z	startalk.tech	V[3140670]_P[iOS]_D[iPhone12,8]_S[13.6.1]_ID[61A22D69AA0D42E3BF1EAE2A95F0CB8B]_PB	iOS	223.104.38.159	2020-11-16 17:10:11+08	2020-11-16 17:11:59+08	server
302	100095z	startalk.tech	V[3140670]_P[iOS]_D[iPhone12,8]_S[13.6.1]_ID[D8F1ACE0FAAB41C08C4714CC0C213EF4]_PB	iOS	223.104.38.159	2020-11-16 17:25:50+08	2020-11-16 17:30:04+08	server
303	100095z	startalk.tech	V[3140670]_P[iOS]_D[iPhone12,8]_S[13.6.1]_ID[42E2C1EB03F845DDAE5F922D7442E810]_PB	iOS	223.104.38.159	2020-11-16 18:12:18+08	2020-11-16 18:13:24+08	server
304	100095z	startalk.tech	V[3140670]_P[iOS]_D[iPhone12,8]_S[13.6.1]_ID[B46D8AE117484DBE912D9ABEF8AEE137]_PB	iOS	223.104.38.159	2020-11-16 18:42:15+08	2020-11-16 18:44:59+08	server
305	100095z	startalk.tech	V[3140670]_P[iOS]_D[iPhone12,8]_S[13.6.1]_ID[07DE2DB2362F49EBA09E2336139B9292]_PB	iOS	223.104.38.159	2020-11-17 13:21:11+08	2020-11-17 13:26:50+08	server
306	100095z	startalk.tech	V[3140670]_P[iOS]_D[iPhone12,8]_S[13.6.1]_ID[E621C613A680441088F48B0AE9DA4B5D]_PB	iOS	223.104.38.159	2020-11-17 14:10:32+08	2020-11-17 14:12:17+08	server
307	100095z	startalk.tech	V[3140670]_P[iOS]_D[iPhone12,8]_S[13.6.1]_ID[3C577C5C453544148EF598D2A23FB18D]_PB	iOS	223.104.38.159	2020-11-17 17:15:28+08	2020-11-17 17:17:04+08	server
308	100004q	startalk.tech	V[254]_P[Android]_D[MuMu]_ID[93e81807-1a59-4b49-acdd-5877a23b8ef2]_PB	Android	42.61.154.39	2020-11-17 21:05:43+08	2020-11-17 21:07:44+08	server
309	test01	startalk.tech	V[206]_P[Android]_D[GLK-AL00]_ID[71bc5933-a69d-4568-8a7f-28ad2d2fc251]_PB	Android	183.158.187.27	2020-11-17 21:16:48+08	2020-11-17 21:16:58+08	server
310	100013v	startalk.tech	V[206]_P[Android]_D[GLK-AL00]_ID[aa1d19f8-9c93-4de1-935d-538425233473]_PB	Android	183.158.187.27	2020-11-17 21:17:12+08	2020-11-17 21:23:04+08	server
311	100013v	startalk.tech	V[206]_P[Android]_D[GLK-AL00]_ID[f5018e5e-6ade-4f00-be33-292d6368d760]_PB	Android	183.158.187.27	2020-11-17 21:24:31+08	2020-11-17 21:28:16+08	server
312	100004q	startalk.tech	V[206]_P[Android]_D[MuMu]_ID[a7248b72-ad1c-4ae5-a6d5-803e59d2f5e4]_PB	Android	42.61.154.39	2020-11-17 21:09:14+08	2020-11-18 08:16:15+08	server
313	100013v	startalk.tech	V[206]_P[Android]_D[GLK-AL00]_ID[c1545ad0-9730-42e4-8634-4777bb44415d]_PB	Android	183.158.187.27	2020-11-18 08:34:05+08	2020-11-18 08:34:16+08	server
314	test01	startalk.tech	V[206]_P[Android]_D[YAL-AL10]_ID[8b180631-d506-42ff-9763-acd07b0c6cb4]_PB	Android	183.158.187.27	2020-11-18 08:35:42+08	2020-11-18 08:37:48+08	server
315	100013v	startalk.tech	V[206]_P[Android]_D[GLK-AL00]_ID[8b5cec17-595a-4c5d-a1b9-c4168bdb08c0]_PB	Android	183.158.187.27	2020-11-18 08:35:54+08	2020-11-18 08:43:03+08	server
316	test01	startalk.tech	V[206]_P[Android]_D[YAL-AL10]_ID[5c7ebbcb-703c-40d9-a3c4-031ac2fc5d08]_PB	Android	183.158.187.27	2020-11-18 08:43:43+08	2020-11-18 08:58:28+08	server
317	test01	startalk.tech	V[206]_P[Android]_D[YAL-AL10]_ID[451dcf69-0cb9-4d0d-9fd4-0c877769b2df]_PB	Android	183.158.187.27	2020-11-18 08:58:32+08	2020-11-18 08:58:54+08	server
318	test01	startalk.tech	V[206]_P[Android]_D[YAL-AL10]_ID[c6894d3c-961d-4108-8315-d6b5857c886d]_PB	Android	183.158.187.27	2020-11-18 08:58:57+08	2020-11-18 09:08:16+08	server
319	100013v	startalk.tech	V[206]_P[Android]_D[YAL-AL10]_ID[fb5ba805-c4de-4795-886a-b198d9a1db63]_PB	Android	183.158.187.27	2020-11-18 09:08:16+08	2020-11-18 09:08:20+08	server
320	test01	startalk.tech	V[206]_P[Android]_D[YAL-AL10]_ID[308d4653-b09c-4f03-ba2b-1f26bf5fb1a0]_PB	Android	183.158.187.27	2020-11-18 09:08:23+08	2020-11-18 09:08:29+08	server
321	100013v	startalk.tech	V[206]_P[Android]_D[YAL-AL10]_ID[c3ceaa1a-2471-49f3-a57f-4e1e5558949c]_PB	Android	183.158.187.27	2020-11-18 09:08:32+08	2020-11-18 09:08:37+08	server
322	test01	startalk.tech	V[206]_P[Android]_D[YAL-AL10]_ID[33332d63-592b-4bfd-9c5b-5241b441f1b1]_PB	Android	183.158.187.27	2020-11-18 09:08:40+08	2020-11-18 09:08:45+08	server
323	100013v	startalk.tech	V[206]_P[Android]_D[YAL-AL10]_ID[df38515e-43d0-4b03-acc4-2212c547786c]_PB	Android	183.158.187.27	2020-11-18 09:08:48+08	2020-11-18 09:08:54+08	server
324	test01	startalk.tech	V[206]_P[Android]_D[YAL-AL10]_ID[fccbb1ad-5cee-46d3-8776-74c24e09f6df]_PB	Android	183.158.187.27	2020-11-18 09:08:57+08	2020-11-18 09:11:05+08	server
325	test01	startalk.tech	V[206]_P[Android]_D[YAL-AL10]_ID[d976053d-b54b-4098-93e2-c78ceeb832dc]_PB	Android	183.158.187.27	2020-11-18 09:11:16+08	2020-11-18 09:17:26+08	server
326	100013v	startalk.tech	V[206]_P[Android]_D[GLK-AL00]_ID[7e52e5c5-7e01-4da6-83c8-19e7d30455a8]_PB	Android	183.158.187.27	2020-11-18 08:43:06+08	2020-11-18 09:20:43+08	server
327	100013v	startalk.tech	V[206]_P[Android]_D[GLK-AL00]_ID[63ada486-5cf2-4e98-bf1a-5f230804efdf]_PB	Android	183.158.187.27	2020-11-18 09:47:32+08	2020-11-18 09:47:42+08	server
328	100004q	startalk.tech	V[240]_P[Android]_D[MIX 2]_ID[5729af9e-06ff-40dd-8a93-30b95d83c576]_PB	Android	42.61.154.39	2020-11-11 22:32:29+08	2020-11-19 00:59:30+08	server
329	100094z	startalk.tech	V[200010]_P[PC64]_ID[32db219a2c6c4910879bd8eebe998419]_C[1]_PB	PC	101.198.192.11	2020-11-19 08:40:38+08	2020-11-19 09:33:49+08	server
330	100004q	startalk.tech	V[206]_P[Android]_D[MuMu]_ID[63058763-b9df-45bb-ba19-b0537e1c5040]_PB	Android	42.61.154.39	2020-11-19 08:10:27+08	2020-11-19 11:02:42+08	server
\.


--
-- Data for Name: meeting_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.meeting_info (id, meeting_id, meeting_name, meeting_remarks, meeting_intr, meeting_locale, meeting_room, schedule_time, meeting_date, begin_time, end_time, inviter, member, mem_action, remind_flag, refuse_reason, canceled) FROM stdin;
\.


--
-- Data for Name: motd; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.motd (username, xml, created_at) FROM stdin;
\.


--
-- Data for Name: msg_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.msg_history (m_from, m_to, m_body, create_time, id, read_flag, msg_id, from_host, to_host, realfrom, realto, msg_type, update_time) FROM stdin;
admin	file-transfer	<message msec_times='1602564683043' xml:lang='en' from='admin@startalk.tech' to='file-transfer@startalk.tech' type='chat' client_type='ClientTypeMac' client_ver='200009'><body id='32b51081155c4902958aa6781b9a6b8e' msgType='1'>你好</body></message>	2020-10-13 12:51:23.043+08	1	0	32b51081155c4902958aa6781b9a6b8e	startalk.tech	startalk.tech			chat	2020-10-13 12:51:23.045418+08
admin	file-transfer	<message msec_times='1602566602790' xml:lang='en' from='admin@startalk.tech' to='file-transfer@startalk.tech' type='chat' client_type='ClientTypeMac' client_ver='200009'><body id='61900f74bd43455b9aaa5fc255331b39' msgType='1'>你好</body></message>	2020-10-13 13:23:22.79+08	2	0	61900f74bd43455b9aaa5fc255331b39	startalk.tech	startalk.tech			chat	2020-10-13 13:23:22.791987+08
admin	file-transfer	<message msec_times='1603615221849' xml:lang='en' from='admin@startalk.tech' to='file-transfer@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='0867b212-ee36-455f-a10f-d7f653ac5d4d' msgType='1'>你好</body></message>	2020-10-25 16:40:21.849+08	3	0	0867b212-ee36-455f-a10f-d7f653ac5d4d	startalk.tech	startalk.tech			chat	2020-10-25 16:40:21.850629+08
100004q	admin	<message msec_times='1603615635860' xml:lang='en' from='100004q@startalk.tech' to='admin@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='174666db-5f32-46f9-9a34-4c0cda88cec2' msgType='1'>你好</body></message>	2020-10-25 16:47:15.86+08	4	0	174666db-5f32-46f9-9a34-4c0cda88cec2	startalk.tech	startalk.tech			chat	2020-10-25 16:47:15.861822+08
100004q	admin	<message msec_times='1603616054718' xml:lang='en' from='100004q@startalk.tech' to='admin@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='2932dd62-faac-4664-84fb-99e699acd261' msgType='1'>哈哈哈</body></message>	2020-10-25 16:54:14.718+08	5	0	2932dd62-faac-4664-84fb-99e699acd261	startalk.tech	startalk.tech			chat	2020-10-25 16:54:14.71951+08
100004q	100094z	<message msec_times='1603641662366' xml:lang='en' from='100004q@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='747ab96a-4277-45ae-a8c3-da73a118c97e' msgType='1'>看到吗？</body></message>	2020-10-26 00:01:02.366+08	6	3	747ab96a-4277-45ae-a8c3-da73a118c97e	startalk.tech	startalk.tech			chat	2020-10-26 00:01:02.367714+08
100094z	100004q	<message msec_times='1603641688589' xml:lang='en' from='100094z@startalk.tech' to='100004q@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='6e5fcbdd-ed3a-4cb9-b32d-b50240bf0d68' msgType='1'>可以</body></message>	2020-10-26 00:01:28.589+08	7	3	6e5fcbdd-ed3a-4cb9-b32d-b50240bf0d68	startalk.tech	startalk.tech			chat	2020-10-26 00:01:28.59068+08
100004q	100094z	<message msec_times='1603641705062' xml:lang='en' from='100004q@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='bb3cafa4-cc29-451f-8f7d-cd393d59d559' msgType='1'>好的，其他的都测一测</body></message>	2020-10-26 00:01:45.062+08	8	3	bb3cafa4-cc29-451f-8f7d-cd393d59d559	startalk.tech	startalk.tech			chat	2020-10-26 00:01:45.064234+08
100094z	100004q	<message msec_times='1603641718392' xml:lang='en' from='100094z@startalk.tech' to='100004q@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='7c191d45-1549-48e7-997d-4683ac744661' msgType='1'>好</body></message>	2020-10-26 00:01:58.392+08	9	3	7c191d45-1549-48e7-997d-4683ac744661	startalk.tech	startalk.tech			chat	2020-10-26 00:01:58.393739+08
100095z	100094z	<message msec_times='1603642431189' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='011d0f34-3a71-4697-9af9-792b0a0042ef' msgType='1'>你好</body></message>	2020-10-26 00:13:51.189+08	10	3	011d0f34-3a71-4697-9af9-792b0a0042ef	startalk.tech	startalk.tech			chat	2020-10-26 00:13:51.190481+08
100094z	100095z	<message msec_times='1603642441165' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='0b4a23e8-b5d6-40a9-8a17-70cab976a049' msgType='1'>我很好</body></message>	2020-10-26 00:14:01.165+08	11	3	0b4a23e8-b5d6-40a9-8a17-70cab976a049	startalk.tech	startalk.tech			chat	2020-10-26 00:14:01.166852+08
100095z	100094z	<message msec_times='1603642598362' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='4cce32d7-6400-4b7d-9585-16b7dcf40741' msgType='2'>{&quot;FileName&quot;:&quot;952f54de-90b8-4f7a-b558-7508b1e8426f.aar&quot;,&quot;FilePath&quot;:&quot;/data/user/10/com.qunar.im.startalk/files/qvoice/qvoice.tmp&quot;,&quot;HttpUrl&quot;:&quot;file/v2/download/36c934aa31ddf4b56779478e049d9cb2?name\\u003dqvoice.tmp&quot;,&quot;Seconds&quot;:3,&quot;s&quot;:0}</body></message>	2020-10-26 00:16:38.362+08	12	3	4cce32d7-6400-4b7d-9585-16b7dcf40741	startalk.tech	startalk.tech			chat	2020-10-26 00:16:38.363618+08
100095z	100094z	<message msec_times='1603642659589' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='735254e0-07ab-44d4-87a3-ece6e4536877' msgType='3'>[obj type=&quot;image&quot; value=&quot;file/v2/download/fa859ce443ad13e0bbf62d376dec3c09.jpg?name=fa859ce443ad13e0bbf62d376dec3c09.jpg&quot; width=1280 height=720]</body></message>	2020-10-26 00:17:39.589+08	13	3	735254e0-07ab-44d4-87a3-ece6e4536877	startalk.tech	startalk.tech			chat	2020-10-26 00:17:39.590186+08
100094z	100095z	<message msec_times='1603642690181' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='0c9ff03f-500a-4869-ad0e-9567771fe096' msgType='1'>太棒了</body></message>	2020-10-26 00:18:10.181+08	14	3	0c9ff03f-500a-4869-ad0e-9567771fe096	startalk.tech	startalk.tech			chat	2020-10-26 00:18:10.183061+08
100094z	100095z	<message msec_times='1603643243226' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='5ab6bf45-40c6-4612-ad81-55a28082a586' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-26 00:27:23.226+08	16	3	5ab6bf45-40c6-4612-ad81-55a28082a586	startalk.tech	startalk.tech			chat	2020-10-26 00:27:23.227999+08
100095z	100094z	<message msec_times='1603642856396' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='48a16426-aaec-4c04-9334-0e523cd3e719' msgType='1'>你好</body></message>	2020-10-26 00:20:56.396+08	15	3	48a16426-aaec-4c04-9334-0e523cd3e719	startalk.tech	startalk.tech			chat	2020-10-26 00:20:56.397434+08
100096z	100094z	<message msec_times='1603948714157' xml:lang='en' from='100096z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='123e41d1a75446f0b336c391a4630385' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/dyx]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-10-29 13:18:34.157+08	32	3	123e41d1a75446f0b336c391a4630385	startalk.tech	startalk.tech			chat	2020-10-29 13:18:34.158396+08
100094z	chao.zhang5	<message msec_times='1604062618477' xml:lang='en' from='100094z@startalk.tech' to='chao.zhang5@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='980957b6-70c9-4c5e-8460-95f1ff648d28' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/dyx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/dyx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/dyx]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-30 20:56:58.477+08	84	0	980957b6-70c9-4c5e-8460-95f1ff648d28	startalk.tech	startalk.tech			chat	2020-10-30 20:56:58.478521+08
100094z	100095z	<message msec_times='1603643247035' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='d784a877-7cae-4285-8c8a-5dc8641022ce' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/ka]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/ka]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-26 00:27:27.035+08	17	3	d784a877-7cae-4285-8c8a-5dc8641022ce	startalk.tech	startalk.tech			chat	2020-10-26 00:27:27.036996+08
100095z	100094z	<message msec_times='1603643257440' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='2f2da799-ec6f-4aa8-b489-9d6ac08d33e7' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-26 00:27:37.44+08	18	3	2f2da799-ec6f-4aa8-b489-9d6ac08d33e7	startalk.tech	startalk.tech			chat	2020-10-26 00:27:37.442052+08
100096z	100094z	<message msec_times='1603643513714' xml:lang='en' from='100096z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='39f8ae0b-3084-4310-845b-7900390564d5' msgType='1'>你好\n</body></message>	2020-10-26 00:31:53.714+08	19	3	39f8ae0b-3084-4310-845b-7900390564d5	startalk.tech	startalk.tech			chat	2020-10-26 00:31:53.715604+08
100096z	100094z	<message msec_times='1603643516852' xml:lang='en' from='100096z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='c7600221-ff16-4c44-a2c5-2e5d11e03e69' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/ak]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-26 00:31:56.852+08	20	3	c7600221-ff16-4c44-a2c5-2e5d11e03e69	startalk.tech	startalk.tech			chat	2020-10-26 00:31:56.853543+08
100095z	100094z	<message msec_times='1603643621022' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='f349ef4e-1afd-4477-a32c-e4fcb92aa34d' msgType='1'>哈哈哈哈</body></message>	2020-10-26 00:33:41.022+08	21	3	f349ef4e-1afd-4477-a32c-e4fcb92aa34d	startalk.tech	startalk.tech			chat	2020-10-26 00:33:41.023846+08
100094z	100096z	<message msec_times='1603643675495' xml:lang='en' from='100094z@startalk.tech' to='100096z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='dc2935a5-d07d-47a9-af17-c3ce9e0a8c27' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-26 00:34:35.495+08	22	3	dc2935a5-d07d-47a9-af17-c3ce9e0a8c27	startalk.tech	startalk.tech			chat	2020-10-26 00:34:35.496928+08
100096z	100094z	<message msec_times='1603643712907' xml:lang='en' from='100096z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='6dbcabb2-3a4d-477d-838b-1e767ca091d5' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/dzwx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/dzwx]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-26 00:35:12.907+08	23	3	6dbcabb2-3a4d-477d-838b-1e767ca091d5	startalk.tech	startalk.tech			chat	2020-10-26 00:35:12.908701+08
100096z	100094z	<message msec_times='1603643855661' xml:lang='en' from='100096z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='83f70774-b0da-475d-a538-dc3836ff6053' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/ka]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/ka]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/ka]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-26 00:37:35.661+08	24	3	83f70774-b0da-475d-a538-dc3836ff6053	startalk.tech	startalk.tech			chat	2020-10-26 00:37:35.662846+08
100096z	100094z	<message msec_times='1603643873848' xml:lang='en' from='100096z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='5ecab8db-7194-4cd2-865c-688869f532de' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/dzwx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/dzwx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/dzwx]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-26 00:37:53.848+08	25	3	5ecab8db-7194-4cd2-865c-688869f532de	startalk.tech	startalk.tech			chat	2020-10-26 00:37:53.850041+08
100096z	100094z	<message msec_times='1603643897256' xml:lang='en' from='100096z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='5039460f-2df3-4d31-b3e2-c9f237759d88' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/byqq]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-26 00:38:17.256+08	26	3	5039460f-2df3-4d31-b3e2-c9f237759d88	startalk.tech	startalk.tech			chat	2020-10-26 00:38:17.258214+08
100094z	100096z	<message msec_times='1603885873811' xml:lang='en' from='100094z@startalk.tech' to='100096z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='4e320307d4d5475a9fb0803e8b9559d2' msgType='1'>1</body></message>	2020-10-28 19:51:13.811+08	27	3	4e320307d4d5475a9fb0803e8b9559d2	startalk.tech	startalk.tech			chat	2020-10-28 19:51:13.813375+08
100094z	100096z	<message msec_times='1603885892322' xml:lang='en' from='100094z@startalk.tech' to='100096z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='74fa5df2cbdf45a29536a4efcefef901' msgType='1'>1</body></message>	2020-10-28 19:51:32.322+08	28	3	74fa5df2cbdf45a29536a4efcefef901	startalk.tech	startalk.tech			chat	2020-10-28 19:51:32.324203+08
100094z	100096z	<message msec_times='1603885898789' xml:lang='en' from='100094z@startalk.tech' to='100096z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='0ccd2662c16f45e2ad7623888a6b8064' msgType='1'>2</body></message>	2020-10-28 19:51:38.789+08	29	3	0ccd2662c16f45e2ad7623888a6b8064	startalk.tech	startalk.tech			chat	2020-10-28 19:51:38.791259+08
100096z	100094z	<message msec_times='1603948677450' xml:lang='en' from='100096z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='9e0d9e1f39e445d8851f749a92d88acc' msgType='1'>1</body></message>	2020-10-29 13:17:57.45+08	31	3	9e0d9e1f39e445d8851f749a92d88acc	startalk.tech	startalk.tech			chat	2020-10-29 13:17:57.452093+08
100096z	100094z	<message msec_times='1603942062040' xml:lang='en' from='100096z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='0c530cb140d9496f90f6963c96aa5944' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/dyx]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-10-29 11:27:42.04+08	30	3	0c530cb140d9496f90f6963c96aa5944	startalk.tech	startalk.tech			chat	2020-10-29 11:27:42.041694+08
100096z	100095z	<message msec_times='1604304665749' xml:lang='en' from='100096z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='aed4ccd06a7d411cb6d29b3aa574f249' msgType='1'>1111</body></message>	2020-11-02 16:11:05.749+08	112	3	aed4ccd06a7d411cb6d29b3aa574f249	startalk.tech	startalk.tech			chat	2020-11-02 16:11:05.750638+08
100094z	100004q	<message msec_times='1603952982499' xml:lang='en' from='100094z@startalk.tech' to='100004q@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='c3e2e48349be405889100dbf9d4eca82' msgType='1'>哈哈</body></message>	2020-10-29 14:29:42.499+08	33	3	c3e2e48349be405889100dbf9d4eca82	startalk.tech	startalk.tech			chat	2020-10-29 14:29:42.50039+08
100096z	100095z	<message msec_times='1604304738641' xml:lang='en' from='100096z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='f9ded782497a42eca60ff99584a9f900' msgType='1'>12323</body></message>	2020-11-02 16:12:18.641+08	114	3	f9ded782497a42eca60ff99584a9f900	startalk.tech	startalk.tech			chat	2020-11-02 16:12:18.643037+08
100095z	100094z	<message msec_times='1603953382385' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='b6574164-81ea-442a-b5d2-5d090687be7a' msgType='2'>{&quot;FileName&quot;:&quot;67dcdbe9-d64c-48f4-a9bc-2fbd5dcff660.aar&quot;,&quot;FilePath&quot;:&quot;/data/user/0/com.qunar.im.startalk/files/qvoice/qvoice.tmp&quot;,&quot;HttpUrl&quot;:&quot;file/v2/download/1ef9c16475dc9b480356881a9991392a?name\\u003dqvoice.tmp&quot;,&quot;Seconds&quot;:2,&quot;s&quot;:0}</body></message>	2020-10-29 14:36:22.385+08	42	3	b6574164-81ea-442a-b5d2-5d090687be7a	startalk.tech	startalk.tech			chat	2020-10-29 14:36:22.386732+08
100094z	100095z	<message msec_times='1603953323863' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='9a39ec68368942cd84d9670962b58b88' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/byx]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-10-29 14:35:23.863+08	38	3	9a39ec68368942cd84d9670962b58b88	startalk.tech	startalk.tech			chat	2020-10-29 14:35:23.865234+08
100094z	100096z	<message msec_times='1603953170527' xml:lang='en' from='100094z@startalk.tech' to='100096z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='85ae9ea468ce472b9785242b5d51a7c1' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/lzx]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-10-29 14:32:50.527+08	34	3	85ae9ea468ce472b9785242b5d51a7c1	startalk.tech	startalk.tech			chat	2020-10-29 14:32:50.529651+08
100095z	100094z	<message msec_times='1603953395288' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='fa6ef36c-eedc-4dee-817f-4d12b5a83c4e' msgType='2'>{&quot;FileName&quot;:&quot;b15d9c28-5a0e-4259-8be5-041fd3fb39bf.aar&quot;,&quot;FilePath&quot;:&quot;/data/user/0/com.qunar.im.startalk/files/qvoice/qvoice.tmp&quot;,&quot;HttpUrl&quot;:&quot;file/v2/download/e6961174a28667f9a5d6b475aeed09a8?name\\u003dqvoice.tmp&quot;,&quot;Seconds&quot;:3,&quot;s&quot;:0}</body></message>	2020-10-29 14:36:35.288+08	43	3	fa6ef36c-eedc-4dee-817f-4d12b5a83c4e	startalk.tech	startalk.tech			chat	2020-10-29 14:36:35.289898+08
100094z	100095z	<message msec_times='1603953278041' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;title&quot;:&quot;的聊天记录&quot;,&quot;desc&quot;:&quot;&quot;,&quot;linkurl&quot;:&quot;https://im.startalk.tech:8443/py/sharemsg?jdata=aHR0cHM6Ly9pbS5zdGFydGFsay50ZWNoOjg0NDMvZmlsZS92Mi9kb3dubG9hZC81ZTQzZTFkMGYwOTY1YmE1ZTI2NzRkZjI2ZTkxYjZiOT9uYW1lPTVlNDNlMWQwZjA5NjViYTVlMjY3NGRmMjZlOTFiNmI5Lg==&quot;}' id='bd4f9d41a78c4d6391d2293dca300af2' msgType='666'>收到了一个消息记录文件文件，请升级客户端查看。</body></message>	2020-10-29 14:34:38.041+08	37	3	bd4f9d41a78c4d6391d2293dca300af2	startalk.tech	startalk.tech			chat	2020-10-29 14:34:38.04376+08
100095z	100094z	<message msec_times='1603953412238' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='e90a0af0-c965-491c-b18e-4bdbc874a587' msgType='2'>{&quot;FileName&quot;:&quot;c44ec5dd-f0c4-4e25-b46e-022bf4e930b3.aar&quot;,&quot;FilePath&quot;:&quot;/data/user/0/com.qunar.im.startalk/files/qvoice/qvoice.tmp&quot;,&quot;HttpUrl&quot;:&quot;file/v2/download/dfd536eeb8e9053508763b9ae6dfc879?name\\u003dqvoice.tmp&quot;,&quot;Seconds&quot;:4,&quot;s&quot;:0}</body></message>	2020-10-29 14:36:52.238+08	44	3	e90a0af0-c965-491c-b18e-4bdbc874a587	startalk.tech	startalk.tech			chat	2020-10-29 14:36:52.239445+08
100095z	100096z	<message msec_times='1604304746535' xml:lang='en' from='100095z@startalk.tech' to='100096z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='2b8be5a571a444bba7ccf2236fb3b3d8' msgType='1'>3334</body></message>	2020-11-02 16:12:26.535+08	115	3	2b8be5a571a444bba7ccf2236fb3b3d8	startalk.tech	startalk.tech			chat	2020-11-02 16:12:26.53694+08
100095z	100094z	<message msec_times='1603953332973' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='4de9791f-d8aa-4ca2-8e40-46f04ddd6f94' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/zy]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-29 14:35:32.973+08	39	3	4de9791f-d8aa-4ca2-8e40-46f04ddd6f94	startalk.tech	startalk.tech			chat	2020-10-29 14:35:32.974713+08
100095z	100094z	<message msec_times='1603953336204' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='80d9e9f5-0e58-494c-9c0c-62490c66a9ab' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-29 14:35:36.204+08	40	3	80d9e9f5-0e58-494c-9c0c-62490c66a9ab	startalk.tech	startalk.tech			chat	2020-10-29 14:35:36.205617+08
100095z	100094z	<message msec_times='1603953337601' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='aa539d72-86b9-4cca-9169-aed61aff6df6' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/dzwx]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-29 14:35:37.601+08	41	3	aa539d72-86b9-4cca-9169-aed61aff6df6	startalk.tech	startalk.tech			chat	2020-10-29 14:35:37.602956+08
100095z	100096z	<message msec_times='1604304862396' xml:lang='en' from='100095z@startalk.tech' to='100096z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='60b975c4720a4fe39e3d75f28ded2c01' msgType='1'>1223</body></message>	2020-11-02 16:14:22.396+08	116	3	60b975c4720a4fe39e3d75f28ded2c01	startalk.tech	startalk.tech			chat	2020-11-02 16:14:22.398274+08
100095z	100094z	<message msec_times='1604304693906' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='384334b480ff4ef1b4f3ff513deaccc6' msgType='1'>1</body></message>	2020-11-02 16:11:33.906+08	113	3	384334b480ff4ef1b4f3ff513deaccc6	startalk.tech	startalk.tech			chat	2020-11-02 16:11:33.907959+08
100094z	100004q	<message msec_times='1603970257912' xml:lang='en' from='100094z@startalk.tech' to='100004q@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='11f595d7c7f949f2900c63a80f155cfa' msgType='1'>订单</body></message>	2020-10-29 19:17:37.912+08	46	3	11f595d7c7f949f2900c63a80f155cfa	startalk.tech	startalk.tech			chat	2020-10-29 19:17:37.913603+08
100004q	100094z	<message msec_times='1603990607878' xml:lang='en' from='100004q@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='2b28d440-5d16-4162-afeb-159d24713720' msgType='1'>hi</body></message>	2020-10-30 00:56:47.878+08	83	3	2b28d440-5d16-4162-afeb-159d24713720	startalk.tech	startalk.tech			chat	2020-10-30 00:56:47.879632+08
100094z	100096z	<message msec_times='1603953235766' xml:lang='en' from='100094z@startalk.tech' to='100096z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;FILEID&quot;:&quot;cd004b6968c449eb9520fc99bf73a751&quot;,&quot;FileName&quot;:&quot;头像.jpg&quot;,&quot;FileSize&quot;:&quot;27.18KB&quot;,&quot;FILEMD5&quot;:&quot;98c31df0915b1357efb2c167a178e728&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/98c31df0915b1357efb2c167a178e728.jpg?name=98c31df0915b1357efb2c167a178e728.jpg&quot;}' id='cd004b6968c449eb9520fc99bf73a751' msgType='5'>{&quot;FILEID&quot;:&quot;cd004b6968c449eb9520fc99bf73a751&quot;,&quot;FileName&quot;:&quot;头像.jpg&quot;,&quot;FileSize&quot;:&quot;27.18KB&quot;,&quot;FILEMD5&quot;:&quot;98c31df0915b1357efb2c167a178e728&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/98c31df0915b1357efb2c167a178e728.jpg?name=98c31df0915b1357efb2c167a178e728.jpg&quot;}</body></message>	2020-10-29 14:33:55.766+08	35	3	cd004b6968c449eb9520fc99bf73a751	startalk.tech	startalk.tech			chat	2020-10-29 14:33:55.768322+08
100094z	100096z	<message type='revoke' to='100096z@startalk.tech' msec_times='1603953264058'><body id='a71ed9262c5b48b8a77174fde5a7900b' msgType='-1' extendInfo='{&quot;messageId&quot;:&quot;a71ed9262c5b48b8a77174fde5a7900b&quot;,&quot;fromId&quot;:&quot;100094z@startalk.tech/V[200010]_P[PC64]_ID[fde79f6efac44537b855e3ea52a10c31]_C[1]_PB&quot;}'>[撤销一条消息]</body><stime xmlns='jabber:stime:delay' stamp='20201029T06:34:24'/></message>	2020-10-29 14:34:24.058+08	36	3	a71ed9262c5b48b8a77174fde5a7900b	startalk.tech	startalk.tech			chat	2020-10-29 14:34:21.530053+08
100094z	100095z	<message msec_times='1603973218568' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='424b5780-0049-4d82-a111-39263a599553' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-29 20:06:58.568+08	61	3	424b5780-0049-4d82-a111-39263a599553	startalk.tech	startalk.tech			chat	2020-10-29 20:06:58.570539+08
100094z	100095z	<message msec_times='1603973220086' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='472a4dd4-178a-4829-acfd-81e9aa717536' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-29 20:07:00.086+08	62	3	472a4dd4-178a-4829-acfd-81e9aa717536	startalk.tech	startalk.tech			chat	2020-10-29 20:07:00.088103+08
100094z	100095z	<message msec_times='1603989004991' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='276fc43b-ec7e-4c34-84ec-681732b5a29b' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-30 00:30:04.991+08	75	3	276fc43b-ec7e-4c34-84ec-681732b5a29b	startalk.tech	startalk.tech			chat	2020-10-30 00:30:04.993655+08
100094z	100095z	<message msec_times='1603989007340' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='0578c3b9-9a6c-4c54-9a55-aabcbacf64f6' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/hs]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/hs]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/hs]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-30 00:30:07.34+08	76	3	0578c3b9-9a6c-4c54-9a55-aabcbacf64f6	startalk.tech	startalk.tech			chat	2020-10-30 00:30:07.342233+08
100094z	100095z	<message msec_times='1603989008278' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='3fb6113e-7cdd-4bee-9b7a-c2b45a962210' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/cy]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/cy]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-30 00:30:08.278+08	77	3	3fb6113e-7cdd-4bee-9b7a-c2b45a962210	startalk.tech	startalk.tech			chat	2020-10-30 00:30:08.280468+08
100094z	100095z	<message type='revoke' to='100095z@startalk.tech' msec_times='1603970260782'><body id='d1bc3427af7540eebbd913cf42bfc797' msgType='-1' extendInfo='{&quot;messageId&quot;:&quot;d1bc3427af7540eebbd913cf42bfc797&quot;,&quot;fromId&quot;:&quot;100094z@startalk.tech/V[200010]_P[PC64]_ID[8d98d2343d9d49f09e7e94fe92edb464]_C[1]_PB&quot;}'>[撤销一条消息]</body><stime xmlns='jabber:stime:delay' stamp='20201029T11:17:40'/></message>	2020-10-29 19:17:40.782+08	45	3	d1bc3427af7540eebbd913cf42bfc797	startalk.tech	startalk.tech			chat	2020-10-29 19:17:30.525403+08
100094z	100095z	<message msec_times='1603970270360' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;title&quot;:&quot;的聊天记录&quot;,&quot;desc&quot;:&quot;&quot;,&quot;linkurl&quot;:&quot;https://im.startalk.tech:8443/py/sharemsg?jdata=aHR0cHM6Ly9pbS5zdGFydGFsay50ZWNoOjg0NDMvZmlsZS92Mi9kb3dubG9hZC9jOGIzMzNhYWQ4ZjkwOWFlOTljODg3NjNhZDc3YjkwNT9uYW1lPWM4YjMzM2FhZDhmOTA5YWU5OWM4ODc2M2FkNzdiOTA1Lg==&quot;}' id='1f1cfb58291a46179c42793766288bb7' msgType='666'>收到了一个消息记录文件文件，请升级客户端查看。</body></message>	2020-10-29 19:17:50.36+08	48	3	1f1cfb58291a46179c42793766288bb7	startalk.tech	startalk.tech			chat	2020-10-29 19:17:50.362256+08
100094z	100095z	<message type='revoke' to='100095z@startalk.tech' msec_times='1603970291663'><body id='ccf7a3cfa73d477e9a60a82c0cf0508d' msgType='-1' extendInfo='{&quot;messageId&quot;:&quot;ccf7a3cfa73d477e9a60a82c0cf0508d&quot;,&quot;fromId&quot;:&quot;100094z@startalk.tech/V[200010]_P[PC64]_ID[8d98d2343d9d49f09e7e94fe92edb464]_C[1]_PB&quot;}'>[撤销一条消息]</body><stime xmlns='jabber:stime:delay' stamp='20201029T11:18:11'/></message>	2020-10-29 19:18:11.663+08	47	3	ccf7a3cfa73d477e9a60a82c0cf0508d	startalk.tech	startalk.tech			chat	2020-10-29 19:17:43.057877+08
100094z	100095z	<message msec_times='1603970328244' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='ec00a2da77c64f0b854ddab4ce15268c' msgType='15'> 拍了拍 &quot;100095z@startalk.tech&quot;</body></message>	2020-10-29 19:18:48.244+08	49	3	ec00a2da77c64f0b854ddab4ce15268c	startalk.tech	startalk.tech			chat	2020-10-29 19:18:48.246205+08
100094z	100095z	<message type='revoke' to='100095z@startalk.tech' msec_times='1603970421288'><body id='ab54293c584845c99acaa066adca778b' msgType='-1' extendInfo='{&quot;messageId&quot;:&quot;ab54293c584845c99acaa066adca778b&quot;,&quot;fromId&quot;:&quot;100094z@startalk.tech/V[200010]_P[PC64]_ID[8d98d2343d9d49f09e7e94fe92edb464]_C[1]_PB&quot;}'>[撤销一条消息]</body><stime xmlns='jabber:stime:delay' stamp='20201029T11:20:21'/></message>	2020-10-29 19:20:21.288+08	50	3	ab54293c584845c99acaa066adca778b	startalk.tech	startalk.tech			chat	2020-10-29 19:18:57.396352+08
100094z	100095z	<message msec_times='1603970539924' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;FILEID&quot;:&quot;e280dd6330924ae5a16b9fe9711b0ec5&quot;,&quot;FileName&quot;:&quot;星语国内二维码.png&quot;,&quot;FileSize&quot;:&quot;41.28KB&quot;,&quot;FILEMD5&quot;:&quot;82e0e9495f288cbb247d2327f78f32c8&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/82e0e9495f288cbb247d2327f78f32c8.png?name=82e0e9495f288cbb247d2327f78f32c8.png&quot;}' id='e280dd6330924ae5a16b9fe9711b0ec5' msgType='5'>{&quot;FILEID&quot;:&quot;e280dd6330924ae5a16b9fe9711b0ec5&quot;,&quot;FileName&quot;:&quot;星语国内二维码.png&quot;,&quot;FileSize&quot;:&quot;41.28KB&quot;,&quot;FILEMD5&quot;:&quot;82e0e9495f288cbb247d2327f78f32c8&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/82e0e9495f288cbb247d2327f78f32c8.png?name=82e0e9495f288cbb247d2327f78f32c8.png&quot;}</body></message>	2020-10-29 19:22:19.924+08	51	3	e280dd6330924ae5a16b9fe9711b0ec5	startalk.tech	startalk.tech			chat	2020-10-29 19:22:19.92608+08
100096z	100095z	<message msec_times='1604308446137' xml:lang='en' from='100096z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='5172000c7cae406b97b4e9bbadd97e6a' msgType='1'>12223</body></message>	2020-11-02 17:14:06.137+08	117	3	5172000c7cae406b97b4e9bbadd97e6a	startalk.tech	startalk.tech			chat	2020-11-02 17:14:06.13914+08
100095z	100094z	<message msec_times='1604118866486' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeMac' client_ver='200010'><body id='229ca7aa063a45cb9f7a0cd358c72403' msgType='1'>11</body></message>	2020-10-31 12:34:26.486+08	85	3	229ca7aa063a45cb9f7a0cd358c72403	startalk.tech	startalk.tech			chat	2020-10-31 12:34:26.488682+08
100095z	100094z	<message msec_times='1603972505266' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='a6a9a2ce-e156-43ca-bb1d-681465b8993a' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/ak]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-29 19:55:05.266+08	52	3	a6a9a2ce-e156-43ca-bb1d-681465b8993a	startalk.tech	startalk.tech			chat	2020-10-29 19:55:05.267865+08
100095z	100094z	<message msec_times='1603972605948' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='27826fe0-ba1d-4b74-82a4-ef93480caa98' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/ka]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/ka]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/ka]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/ka]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-29 19:56:45.948+08	53	3	27826fe0-ba1d-4b74-82a4-ef93480caa98	startalk.tech	startalk.tech			chat	2020-10-29 19:56:45.94937+08
100096z	100095z	<message msec_times='1604308465672' xml:lang='en' from='100096z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='42420e65cabd417f8173a20b31741b8c' msgType='1'>12333</body></message>	2020-11-02 17:14:25.672+08	118	3	42420e65cabd417f8173a20b31741b8c	startalk.tech	startalk.tech			chat	2020-11-02 17:14:25.674222+08
100094z	100095z	<message msec_times='1603972615648' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='0dc07797f6f7427fa70a78e1d3b3b286' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/tp]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-10-29 19:56:55.648+08	54	3	0dc07797f6f7427fa70a78e1d3b3b286	startalk.tech	startalk.tech			chat	2020-10-29 19:56:55.65035+08
100096z	100094z	<message msec_times='1603972833649' xml:lang='en' from='100096z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='158adce3-6b26-4bb8-b528-ff75465d8a50' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/zy]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/zy]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-29 20:00:33.649+08	55	3	158adce3-6b26-4bb8-b528-ff75465d8a50	startalk.tech	startalk.tech			chat	2020-10-29 20:00:33.650895+08
100094z	100095z	<message msec_times='1604308982195' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='3d4a12d3-ac06-4133-87a7-23ac850cbd1b' msgType='1'>112</body></message>	2020-11-02 17:23:02.195+08	119	3	3d4a12d3-ac06-4133-87a7-23ac850cbd1b	startalk.tech	startalk.tech			chat	2020-11-02 17:23:02.196943+08
100095z	100094z	<message msec_times='1604118878554' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeMac' client_ver='200010'><body id='f81245a141f4449fa4118997a508dd00' msgType='1'>3</body></message>	2020-10-31 12:34:38.554+08	86	3	f81245a141f4449fa4118997a508dd00	startalk.tech	startalk.tech			chat	2020-10-31 12:34:38.556746+08
100095z	100094z	<message msec_times='1604118879636' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeMac' client_ver='200010'><body id='5fafc2d43dbb41c5a3c6340da5bf8cee' msgType='1'>4</body></message>	2020-10-31 12:34:39.636+08	87	3	5fafc2d43dbb41c5a3c6340da5bf8cee	startalk.tech	startalk.tech			chat	2020-10-31 12:34:39.639085+08
100095z	100094z	<message msec_times='1604127833639' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='cd0a2f528e4946669fa85443e22e2c3d' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/tp]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-10-31 15:03:53.639+08	96	3	cd0a2f528e4946669fa85443e22e2c3d	startalk.tech	startalk.tech			chat	2020-10-31 15:03:53.640287+08
100095z	100096z	<message msec_times='1604127888199' xml:lang='en' from='100095z@startalk.tech' to='100096z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='581a55612b3d40f782601432d8c751ee' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/tp]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-10-31 15:04:48.199+08	98	3	581a55612b3d40f782601432d8c751ee	startalk.tech	startalk.tech			chat	2020-10-31 15:04:48.200772+08
100095z	100096z	<message msec_times='1604127893154' xml:lang='en' from='100095z@startalk.tech' to='100096z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='e64923f1904349b09462ecc7b865782d' msgType='1'>gg</body></message>	2020-10-31 15:04:53.154+08	99	3	e64923f1904349b09462ecc7b865782d	startalk.tech	startalk.tech			chat	2020-10-31 15:04:53.155382+08
100094z	100095z	<message msec_times='1603973216719' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='49f8b23d-d908-414e-a1cb-efdcdf3b3a7c' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/dyx]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-29 20:06:56.719+08	60	3	49f8b23d-d908-414e-a1cb-efdcdf3b3a7c	startalk.tech	startalk.tech			chat	2020-10-29 20:06:56.721727+08
100095z	100094z	<message msec_times='1604118880112' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeMac' client_ver='200010'><body id='62dd9a8cbfab4392be850c2959aeb152' msgType='1'>5</body></message>	2020-10-31 12:34:40.112+08	88	3	62dd9a8cbfab4392be850c2959aeb152	startalk.tech	startalk.tech			chat	2020-10-31 12:34:40.115011+08
100095z	100094z	<message msec_times='1604118880842' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeMac' client_ver='200010'><body id='23236a60cf3343d08309b41fda93e7f5' msgType='1'>7</body></message>	2020-10-31 12:34:40.842+08	89	3	23236a60cf3343d08309b41fda93e7f5	startalk.tech	startalk.tech			chat	2020-10-31 12:34:40.845317+08
100095z	100094z	<message msec_times='1604118881750' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeMac' client_ver='200010'><body id='14671512ee1243439d442fd4044d9c4b' msgType='1'>7</body></message>	2020-10-31 12:34:41.75+08	90	3	14671512ee1243439d442fd4044d9c4b	startalk.tech	startalk.tech			chat	2020-10-31 12:34:41.75351+08
100096z	100094z	<message msec_times='1603972836945' xml:lang='en' from='100096z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='b8525e29-f43a-4317-8e55-bf40c45e2412' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/dzwx]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-29 20:00:36.945+08	56	3	b8525e29-f43a-4317-8e55-bf40c45e2412	startalk.tech	startalk.tech			chat	2020-10-29 20:00:36.946456+08
100096z	100094z	<message msec_times='1603972838630' xml:lang='en' from='100096z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='cfe3ce3e-3f47-4b41-9ad4-acbec900829b' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/lzx]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-29 20:00:38.63+08	57	3	cfe3ce3e-3f47-4b41-9ad4-acbec900829b	startalk.tech	startalk.tech			chat	2020-10-29 20:00:38.632207+08
100096z	100094z	<message msec_times='1603972964267' xml:lang='en' from='100096z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='12aee4ab-0a14-4655-9504-4c165afcf802' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/zy]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-29 20:02:44.267+08	58	3	12aee4ab-0a14-4655-9504-4c165afcf802	startalk.tech	startalk.tech			chat	2020-10-29 20:02:44.268485+08
100096z	100094z	<message msec_times='1603972966163' xml:lang='en' from='100096z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='653d0dd1-910f-4dcd-961b-735179ea6daf' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-29 20:02:46.163+08	59	3	653d0dd1-910f-4dcd-961b-735179ea6daf	startalk.tech	startalk.tech			chat	2020-10-29 20:02:46.165359+08
100096z	100094z	<message msec_times='1603973339814' xml:lang='en' from='100096z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='5cf6682c-7758-40a1-a950-7852ab08a487' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/ka]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/ka]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-29 20:08:59.814+08	63	3	5cf6682c-7758-40a1-a950-7852ab08a487	startalk.tech	startalk.tech			chat	2020-10-29 20:08:59.815818+08
100096z	100094z	<message msec_times='1603973345226' xml:lang='en' from='100096z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='382cc407-ac5d-4908-957d-ad91386d85c4' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/zy]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-29 20:09:05.226+08	64	3	382cc407-ac5d-4908-957d-ad91386d85c4	startalk.tech	startalk.tech			chat	2020-10-29 20:09:05.227556+08
100094z	100095z	<message msec_times='1603973432798' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='381ec144611248a7a99c1b63dd485d94' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/tp]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-10-29 20:10:32.798+08	65	3	381ec144611248a7a99c1b63dd485d94	startalk.tech	startalk.tech			chat	2020-10-29 20:10:32.80048+08
100095z	100094z	<message msec_times='1603973438891' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='22b93e82-6bee-46cf-80a7-e094cc78bec6' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/hhx]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-29 20:10:38.891+08	66	3	22b93e82-6bee-46cf-80a7-e094cc78bec6	startalk.tech	startalk.tech			chat	2020-10-29 20:10:38.892568+08
100094z	100095z	<message msec_times='1603973443871' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='b19d90efc3d34a7abcf633f132440cca' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/lzx]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-10-29 20:10:43.871+08	67	3	b19d90efc3d34a7abcf633f132440cca	startalk.tech	startalk.tech			chat	2020-10-29 20:10:43.872846+08
100094z	100095z	<message msec_times='1603973482882' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='038e96cac4ec421ba49740c68f689b86' msgType='1'>你好</body></message>	2020-10-29 20:11:22.882+08	68	3	038e96cac4ec421ba49740c68f689b86	startalk.tech	startalk.tech			chat	2020-10-29 20:11:22.884277+08
100094z	100095z	<message msec_times='1603973486593' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='260c2dd022484dd18627c1ab33f0e7a4' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/cy]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-10-29 20:11:26.593+08	69	3	260c2dd022484dd18627c1ab33f0e7a4	startalk.tech	startalk.tech			chat	2020-10-29 20:11:26.595528+08
100095z	100094z	<message msec_times='1603973491678' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='13ba8ae1-082b-4ee9-9ef0-fee5d5b99586' msgType='1'>好</body></message>	2020-10-29 20:11:31.678+08	70	3	13ba8ae1-082b-4ee9-9ef0-fee5d5b99586	startalk.tech	startalk.tech			chat	2020-10-29 20:11:31.679304+08
100095z	100094z	<message msec_times='1603973493884' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='1234a37b-89b6-4744-adbc-cc170f045b8f' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-29 20:11:33.884+08	71	3	1234a37b-89b6-4744-adbc-cc170f045b8f	startalk.tech	startalk.tech			chat	2020-10-29 20:11:33.886118+08
100094z	mumu	<message msec_times='1605368275922' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='323564df-b2ac-428a-a654-14f96b893b72' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-14 23:37:55.922+08	242	3	323564df-b2ac-428a-a654-14f96b893b72	startalk.tech	startalk.tech			chat	2020-11-14 23:37:55.923559+08
100094z	100095z	<message msec_times='1604309002757' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='ca85925b-89eb-4859-9a4f-595e6e6b2987' msgType='1'>1245</body></message>	2020-11-02 17:23:22.757+08	120	3	ca85925b-89eb-4859-9a4f-595e6e6b2987	startalk.tech	startalk.tech			chat	2020-11-02 17:23:22.758571+08
100095z	100094z	<message msec_times='1604309719001' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='6a45b3a3c7ba4368809b239f417dbeeb' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/lzx]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-11-02 17:35:19.001+08	121	3	6a45b3a3c7ba4368809b239f417dbeeb	startalk.tech	startalk.tech			chat	2020-11-02 17:35:19.003348+08
100094z	100004q	<message msec_times='1603989012241' xml:lang='en' from='100094z@startalk.tech' to='100004q@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='b9412cc0-c0c7-4e2e-ba66-eaa7df7b26b8' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-30 00:30:12.241+08	78	3	b9412cc0-c0c7-4e2e-ba66-eaa7df7b26b8	startalk.tech	startalk.tech			chat	2020-10-30 00:30:12.243607+08
100094z	100004q	<message msec_times='1603989015377' xml:lang='en' from='100094z@startalk.tech' to='100004q@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='4fd5a56a-1f46-4796-9fd1-7b3058db1b1d' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/hxqq]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/hxqq]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-30 00:30:15.377+08	79	3	4fd5a56a-1f46-4796-9fd1-7b3058db1b1d	startalk.tech	startalk.tech			chat	2020-10-30 00:30:15.379117+08
100094z	100095z	<message msec_times='1603989000690' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='2817e3a3-5e5b-4627-8972-16534abe3ced' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/dzwx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/dzwx]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-30 00:30:00.69+08	72	3	2817e3a3-5e5b-4627-8972-16534abe3ced	startalk.tech	startalk.tech			chat	2020-10-30 00:30:00.692848+08
100095z	100094z	<message msec_times='1603989119330' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='b0789791-781e-47bf-94a8-4727aa384de1' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/dzwx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/dzwx]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-30 00:31:59.33+08	80	3	b0789791-781e-47bf-94a8-4727aa384de1	startalk.tech	startalk.tech			chat	2020-10-30 00:31:59.331823+08
100094z	100095z	<message msec_times='1603989002533' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='86bd4290-004f-4cba-8f83-4891c3ddfce6' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/hhx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/hhx]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-30 00:30:02.533+08	73	3	86bd4290-004f-4cba-8f83-4891c3ddfce6	startalk.tech	startalk.tech			chat	2020-10-30 00:30:02.535938+08
100094z	100095z	<message msec_times='1603989003548' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='e06d2b4c-31b8-44de-86e3-53a8487a98c2' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/dyx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/dyx]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-30 00:30:03.548+08	74	3	e06d2b4c-31b8-44de-86e3-53a8487a98c2	startalk.tech	startalk.tech			chat	2020-10-30 00:30:03.55023+08
100095z	100094z	<message msec_times='1603989162954' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='1082217c-9890-4ee0-8096-2d8a743ac7ac' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/byqq]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/hxqq]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-30 00:32:42.954+08	81	3	1082217c-9890-4ee0-8096-2d8a743ac7ac	startalk.tech	startalk.tech			chat	2020-10-30 00:32:42.955432+08
100095z	100094z	<message msec_times='1604118883139' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeMac' client_ver='200010'><body id='cbb738058fcb4f8da51b422688bfe354' msgType='1'>889</body></message>	2020-10-31 12:34:43.139+08	91	3	cbb738058fcb4f8da51b422688bfe354	startalk.tech	startalk.tech			chat	2020-10-31 12:34:43.141693+08
100095z	100094z	<message msec_times='1604309724194' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='6a80c11dd1934cb0abdaba6405bef1f8' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/tp]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-11-02 17:35:24.194+08	122	3	6a80c11dd1934cb0abdaba6405bef1f8	startalk.tech	startalk.tech			chat	2020-11-02 17:35:24.196654+08
100094z	100095z	<message msec_times='1603989167370' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='50447982397d4762a157ec2eb9c3c22d' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/byx]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-10-30 00:32:47.37+08	82	3	50447982397d4762a157ec2eb9c3c22d	startalk.tech	startalk.tech			chat	2020-10-30 00:32:47.372411+08
100094z	100095z	<message msec_times='1604309732007' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='ae813bc8-f4e3-48c4-b00c-7bc57101a68c' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-02 17:35:32.007+08	123	3	ae813bc8-f4e3-48c4-b00c-7bc57101a68c	startalk.tech	startalk.tech			chat	2020-11-02 17:35:32.008988+08
100094z	100096z	<message msec_times='1604127435589' xml:lang='en' from='100094z@startalk.tech' to='100096z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='6aba9669-af19-41db-b8a5-b32441aa4565' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/dzwx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/dzwx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/dzwx]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-31 14:57:15.589+08	92	3	6aba9669-af19-41db-b8a5-b32441aa4565	startalk.tech	startalk.tech			chat	2020-10-31 14:57:15.590535+08
100095z	100094z	<message msec_times='1604972707867' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='525bb591ee2248b086f21ea3538b916e' msgType='1'>「 杉杉: [obj type=&quot;emoticon&quot; value=&quot;[/byqq]&quot; width=EmojiOne height=EmojiOne ] 」\n -------------------------  \n你好</body></message>	2020-11-10 09:45:07.867+08	152	3	525bb591ee2248b086f21ea3538b916e	startalk.tech	startalk.tech			chat	2020-11-10 09:45:07.868446+08
100095z	100094z	<message msec_times='1604128015945' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='b5233a75443b4e488c3890469f0fa842' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/byqq]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-10-31 15:06:55.945+08	102	3	b5233a75443b4e488c3890469f0fa842	startalk.tech	startalk.tech			chat	2020-10-31 15:06:55.946431+08
100095z	100094z	<message msec_times='1604309743074' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='6e20a25417f14c76900690a62bf5a892' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/dyx]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-11-02 17:35:43.074+08	124	3	6e20a25417f14c76900690a62bf5a892	startalk.tech	startalk.tech			chat	2020-11-02 17:35:43.076481+08
100094z	100095z	<message msec_times='1604309756318' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='f571094e-0be3-414b-96c6-f1d2a2cdb05e' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-02 17:35:56.318+08	125	3	f571094e-0be3-414b-96c6-f1d2a2cdb05e	startalk.tech	startalk.tech			chat	2020-11-02 17:35:56.320253+08
100094z	100095z	<message msec_times='1604309757600' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='ddc4ef6a-f3ec-4318-bf63-b42fc15e788b' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/hhx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-02 17:35:57.6+08	126	3	ddc4ef6a-f3ec-4318-bf63-b42fc15e788b	startalk.tech	startalk.tech			chat	2020-11-02 17:35:57.602478+08
100094z	100096z	<message msec_times='1604127879065' xml:lang='en' from='100094z@startalk.tech' to='100096z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='c4c43f32-c294-4575-96b4-bb596625e7dd' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/bm]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/bm]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/ak]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-31 15:04:39.065+08	97	3	c4c43f32-c294-4575-96b4-bb596625e7dd	startalk.tech	startalk.tech			chat	2020-10-31 15:04:39.067229+08
100094z	100096z	<message msec_times='1604127437361' xml:lang='en' from='100094z@startalk.tech' to='100096z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='e0f9dd17-0b74-41dc-9710-fd9931028237' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-31 14:57:17.361+08	93	3	e0f9dd17-0b74-41dc-9710-fd9931028237	startalk.tech	startalk.tech			chat	2020-10-31 14:57:17.362437+08
100094z	100096z	<message msec_times='1604127438909' xml:lang='en' from='100094z@startalk.tech' to='100096z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='a42e5360-b941-4aa6-887d-be9e1de9855b' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-31 14:57:18.909+08	94	3	a42e5360-b941-4aa6-887d-be9e1de9855b	startalk.tech	startalk.tech			chat	2020-10-31 14:57:18.91045+08
100095z	100096z	<message msec_times='1604127896666' xml:lang='en' from='100095z@startalk.tech' to='100096z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='e2cf214dae6f421386133229e1a5bbd1' msgType='1'>oo</body></message>	2020-10-31 15:04:56.666+08	101	3	e2cf214dae6f421386133229e1a5bbd1	startalk.tech	startalk.tech			chat	2020-10-31 15:04:56.667497+08
100095z	100096z	<message msec_times='1604127895381' xml:lang='en' from='100095z@startalk.tech' to='100096z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='33fb95d5b16c499a98ff942e3695bdd5' msgType='1'>88</body></message>	2020-10-31 15:04:55.381+08	100	3	33fb95d5b16c499a98ff942e3695bdd5	startalk.tech	startalk.tech			chat	2020-10-31 15:04:55.383065+08
100095z	100096z	<message msec_times='1604128220357' xml:lang='en' from='100095z@startalk.tech' to='100096z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='4d694a895d3f4fc4aba7b88619a0824e' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/byx]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-10-31 15:10:20.357+08	103	3	4d694a895d3f4fc4aba7b88619a0824e	startalk.tech	startalk.tech			chat	2020-10-31 15:10:20.358228+08
100094z	100095z	<message msec_times='1604309758912' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='be76cb80-27fb-4d85-9aeb-cd9e3dacb955' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/dzwx]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-02 17:35:58.912+08	127	3	be76cb80-27fb-4d85-9aeb-cd9e3dacb955	startalk.tech	startalk.tech			chat	2020-11-02 17:35:58.914451+08
100095z	100094z	<message msec_times='1604309824205' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='06327fc0da62435184f998402db25d9a' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/tp]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-11-02 17:37:04.205+08	128	3	06327fc0da62435184f998402db25d9a	startalk.tech	startalk.tech			chat	2020-11-02 17:37:04.207783+08
100095z	100094z	<message msec_times='1604309846358' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='14df8c472db84e8091f40cacba924abf' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/byqq]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-11-02 17:37:26.358+08	129	3	14df8c472db84e8091f40cacba924abf	startalk.tech	startalk.tech			chat	2020-11-02 17:37:26.360614+08
100094z	100095z	<message msec_times='1604309847990' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='4a51d61b-8499-4c71-aa8f-9bc1bb2cb3fc' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-02 17:37:27.99+08	130	3	4a51d61b-8499-4c71-aa8f-9bc1bb2cb3fc	startalk.tech	startalk.tech			chat	2020-11-02 17:37:27.992023+08
100094z	100096z	<message msec_times='1604127440869' xml:lang='en' from='100094z@startalk.tech' to='100096z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='c0c407b6-69e0-4423-b55d-0f7f5fdf28e6' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/dyx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/dyx]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-31 14:57:20.869+08	95	3	c0c407b6-69e0-4423-b55d-0f7f5fdf28e6	startalk.tech	startalk.tech			chat	2020-10-31 14:57:20.87043+08
100004q	100013v	<message msec_times='1605619101726' xml:lang='en' from='100004q@startalk.tech' to='100013v@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='c84d219e-9e34-4420-aaa3-800ea71de270' msgType='1'>这个服务器的代码是我们自己重构的</body></message>	2020-11-17 21:18:21.726+08	292	3	c84d219e-9e34-4420-aaa3-800ea71de270	startalk.tech	startalk.tech			chat	2020-11-17 21:18:21.728247+08
100095z	100096z	<message msec_times='1604128308444' xml:lang='en' from='100095z@startalk.tech' to='100096z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='500d758e77034dafb002aebdfef1d1e6' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/byx]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-10-31 15:11:48.444+08	104	3	500d758e77034dafb002aebdfef1d1e6	startalk.tech	startalk.tech			chat	2020-10-31 15:11:48.4458+08
100095z	100094z	<message msec_times='1604309867482' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='f0e4324caea348e89ffb9a5d77f55705' msgType='1'>哦哦</body></message>	2020-11-02 17:37:47.482+08	131	3	f0e4324caea348e89ffb9a5d77f55705	startalk.tech	startalk.tech			chat	2020-11-02 17:37:47.484288+08
100096z	100095z	<message msec_times='1604128313978' xml:lang='en' from='100096z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='421259c1-4734-4a6f-a98f-5e89839cf92b' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/cy]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-31 15:11:53.978+08	105	3	421259c1-4734-4a6f-a98f-5e89839cf92b	startalk.tech	startalk.tech			chat	2020-10-31 15:11:53.97994+08
100004q	mumu	<message msec_times='1604311278681' xml:lang='en' from='100004q@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='5895118a-94a8-4c51-8a1d-ed93ac70f8f2' msgType='1'>hi</body></message>	2020-11-02 18:01:18.681+08	132	3	5895118a-94a8-4c51-8a1d-ed93ac70f8f2	startalk.tech	startalk.tech			chat	2020-11-02 18:01:18.682794+08
100095z	100094z	<message msec_times='1604128331924' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='10470d4605b144f4aa2dd253521f546c' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/byqq]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-10-31 15:12:11.924+08	106	3	10470d4605b144f4aa2dd253521f546c	startalk.tech	startalk.tech			chat	2020-10-31 15:12:11.92533+08
mumu	100004q	<message msec_times='1604311286596' xml:lang='en' from='mumu@startalk.tech' to='100004q@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='1c95ec50-7db4-4453-8554-e2344d8c5b6e' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/dyx]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-02 18:01:26.596+08	133	3	1c95ec50-7db4-4453-8554-e2344d8c5b6e	startalk.tech	startalk.tech			chat	2020-11-02 18:01:26.598041+08
100094z	100096z	<message msec_times='1604128344587' xml:lang='en' from='100094z@startalk.tech' to='100096z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='29eeca49-2ba6-4a0b-bd4b-6de3c1038f6d' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/zy]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/zy]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-31 15:12:24.587+08	107	3	29eeca49-2ba6-4a0b-bd4b-6de3c1038f6d	startalk.tech	startalk.tech			chat	2020-10-31 15:12:24.589139+08
100096z	100095z	<message msec_times='1604128377598' xml:lang='en' from='100096z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='91705b03-0db7-430a-8b77-0679e5b2a335' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/hhx]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-31 15:12:57.598+08	108	3	91705b03-0db7-430a-8b77-0679e5b2a335	startalk.tech	startalk.tech			chat	2020-10-31 15:12:57.599319+08
100095z	100094z	<message msec_times='1604316204428' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='3d698d60688a4c76af4a308526c7a23e' msgType='1'>121</body></message>	2020-11-02 19:23:24.428+08	134	3	3d698d60688a4c76af4a308526c7a23e	startalk.tech	startalk.tech			chat	2020-11-02 19:23:24.42955+08
100013v	100094z	<message msec_times='1604373506472' xml:lang='en' from='100013v@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='7c8406ca69d6497ead64ccd66fa12dfa' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/fn]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-11-03 11:18:26.472+08	146	3	7c8406ca69d6497ead64ccd66fa12dfa	startalk.tech	startalk.tech			chat	2020-11-03 11:18:26.473264+08
100096z	100095z	<message msec_times='1604128411230' xml:lang='en' from='100096z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='4dc8cab9-ee16-4bba-9a63-ac27b17cc4c9' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/hhx]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-31 15:13:31.23+08	109	3	4dc8cab9-ee16-4bba-9a63-ac27b17cc4c9	startalk.tech	startalk.tech			chat	2020-10-31 15:13:31.2319+08
100096z	100095z	<message msec_times='1604128415229' xml:lang='en' from='100096z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='dbd0827a-328f-430c-b8c9-298eee884b8a' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/zy]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/zy]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/zy]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-31 15:13:35.229+08	110	3	dbd0827a-328f-430c-b8c9-298eee884b8a	startalk.tech	startalk.tech			chat	2020-10-31 15:13:35.230449+08
100094z	100013v	<message msec_times='1604373825417' xml:lang='en' from='100094z@startalk.tech' to='100013v@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='6863d57548a9436084329f434fc8b09a' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/byx]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-11-03 11:23:45.417+08	147	3	6863d57548a9436084329f434fc8b09a	startalk.tech	startalk.tech			chat	2020-11-03 11:23:45.418686+08
100096z	100095z	<message msec_times='1604128418697' xml:lang='en' from='100096z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='61232b8f-e3be-47e8-b752-67b7f2069457' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/fw]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/fw]&quot; width=EmojiOne height=0 ]</body></message>	2020-10-31 15:13:38.697+08	111	3	61232b8f-e3be-47e8-b752-67b7f2069457	startalk.tech	startalk.tech			chat	2020-10-31 15:13:38.698945+08
100095z	潮涨	<message msec_times='1604662286801' xml:lang='en' from='100095z@startalk.tech' to='潮涨@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='f0745d0b8b9f4e4e91bc630961e0cdf0' msgType='1'>1</body></message>	2020-11-06 19:31:26.801+08	148	0	f0745d0b8b9f4e4e91bc630961e0cdf0	startalk.tech	startalk.tech			chat	2020-11-06 19:31:26.802622+08
100095z	100094z	<message msec_times='1604316219124' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;FILEID&quot;:&quot;817854045d554a77bc51476fbf605175&quot;,&quot;FileName&quot;:&quot;test.txt&quot;,&quot;FileSize&quot;:&quot;0.00KB&quot;,&quot;FILEMD5&quot;:&quot;004881ebe3826cf16cfd124968f2a5bb&quot;,&quot;HttpUrl&quot;:&quot;http://47.52.208.181:8080/im_http_service/file/v2/download/004881EBE3826CF16CFD124968F2A5BB.txt&quot;}' id='817854045d554a77bc51476fbf605175' msgType='5'>{&quot;FILEID&quot;:&quot;817854045d554a77bc51476fbf605175&quot;,&quot;FileName&quot;:&quot;test.txt&quot;,&quot;FileSize&quot;:&quot;0.00KB&quot;,&quot;FILEMD5&quot;:&quot;004881ebe3826cf16cfd124968f2a5bb&quot;,&quot;HttpUrl&quot;:&quot;http://47.52.208.181:8080/im_http_service/file/v2/download/004881EBE3826CF16CFD124968F2A5BB.txt&quot;}</body></message>	2020-11-02 19:23:39.124+08	135	3	817854045d554a77bc51476fbf605175	startalk.tech	startalk.tech			chat	2020-11-02 19:23:39.126217+08
100095z	100094z	<message msec_times='1604972730348' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;title&quot;:&quot;杉杉,珊珊JH,勇敢的聊天记录&quot;,&quot;desc&quot;:&quot;&quot;,&quot;linkurl&quot;:&quot;https://im.startalk.tech:8443/py/sharemsg?jdata=&quot;}' id='6abe9692d4f54ab8ba2f9074fd5b662d' msgType='666'>收到了一个消息记录文件文件，请升级客户端查看。</body></message>	2020-11-10 09:45:30.348+08	153	3	6abe9692d4f54ab8ba2f9074fd5b662d	startalk.tech	startalk.tech			chat	2020-11-10 09:45:30.349753+08
test01	100013v	<message msec_times='1605661179913' xml:lang='en' from='test01@startalk.tech' to='100013v@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='12032ef2-7b75-400d-b216-be28754523dc' msgType='3'>[obj type=&quot;image&quot; value=&quot;file/v2/download/dec5e86a66ed1fd3fc0e3b1a68284cfa.jpg?name=dec5e86a66ed1fd3fc0e3b1a68284cfa.jpg&quot; width=1080 height=2340]</body></message>	2020-11-18 08:59:39.913+08	324	3	12032ef2-7b75-400d-b216-be28754523dc	startalk.tech	startalk.tech			chat	2020-11-18 08:59:39.9145+08
100095z	100094z	<message msec_times='1604316329051' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='d6271f13b6514e1c86dd5a33b3493785' msgType='1'>[obj type=&quot;image&quot; value=&quot;https://im.startalk.tech:8443/file/v2/download/179965160c9eb907df59620e30b01777.png?name=179965160c9eb907df59620e30b01777.png&quot; width=383 height=224]</body></message>	2020-11-02 19:25:29.051+08	136	3	d6271f13b6514e1c86dd5a33b3493785	startalk.tech	startalk.tech			chat	2020-11-02 19:25:29.052266+08
100094z	100095z	<message msec_times='1605437230870' xml:lang='en' from='100094z@startalk.tech/V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[D3AC1B7D4415412B8400318872B88EFD]_PB' to='100095z@startalk.tech' type='chat' client_type='ClientTypeiOS' client_ver='0'><body id='B6B0FB27FCE0487488EACD2DA0E6847A' msgType='1'>你好</body></message>	2020-11-15 18:47:10.87+08	266	3	B6B0FB27FCE0487488EACD2DA0E6847A	startalk.tech	startalk.tech			chat	2020-11-15 18:47:10.871536+08
100095z	100094z	<message msec_times='1604972749150' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='986e802da9904d03bb1df7bc72551e00' msgType='1'>你好</body></message>	2020-11-10 09:45:49.15+08	154	3	986e802da9904d03bb1df7bc72551e00	startalk.tech	startalk.tech			chat	2020-11-10 09:45:49.152272+08
100094z	mumu	<message msec_times='1605367269959' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='33aa9539-8861-4e1b-8d6a-474c04053bb6' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/dzwx]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-14 23:21:09.959+08	215	3	33aa9539-8861-4e1b-8d6a-474c04053bb6	startalk.tech	startalk.tech			chat	2020-11-14 23:21:09.960166+08
100095z	100094z	<message msec_times='1604362878160' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='60c7552cd06047f393629dbba41d7cef' msgType='1'>[obj type=&quot;image&quot; value=&quot;https://im.startalk.tech:8443/file/v2/download/4dec3a947af36d68ca656b6720d05ae4.png?name=4dec3a947af36d68ca656b6720d05ae4.png&quot; width=378 height=301]</body></message>	2020-11-03 08:21:18.16+08	139	3	60c7552cd06047f393629dbba41d7cef	startalk.tech	startalk.tech			chat	2020-11-03 08:21:18.161242+08
100094z	100095z	<message msec_times='1604973383449' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='2ea0fddb-5555-43c2-9da4-ea540ed5f9af' msgType='1'>[obj type=&quot;url&quot; value=&quot;www.baidu.com&quot;]</body></message>	2020-11-10 09:56:23.449+08	156	3	2ea0fddb-5555-43c2-9da4-ea540ed5f9af	startalk.tech	startalk.tech			chat	2020-11-10 09:56:23.451454+08
100094z	100095z	<message msec_times='1604973335568' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body extendInfo='{&quot;auth&quot;:true,&quot;desc&quot;:&quot;点击查看全部&quot;,&quot;linkurl&quot;:&quot;https://im.startalk.tech:8443/py/sharemsg?jdata\\u003daHR0cHM6Ly9pbS5zdGFydGFsay50ZWNoOjg0NDMvZmlsZS92Mi9kb3dubG9hZC85MWFlOTMyNzYwODU5Y2MyNThkNDIwODY5NDE1MmM0ZT9uYW1lPWN1cnJfc2hhcmVfbXNnLmpzb24mdT0xMDAwOTR6Jms9MjkwNzExNjA0OTcxNjg4Njc4NzY2&quot;,&quot;showas667&quot;:false,&quot;showbar&quot;:true,&quot;title&quot;:&quot;杉杉,珊珊JH,勇敢的聊天记录&quot;}' id='d1bf2054-d044-4911-a722-b296eae63ccc' msgType='666'>https://im.startalk.tech:8443/py/sharemsg?jdata=aHR0cHM6Ly9pbS5zdGFydGFsay50ZWNoOjg0NDMvZmlsZS92Mi9kb3dubG9hZC85MWFlOTMyNzYwODU5Y2MyNThkNDIwODY5NDE1MmM0ZT9uYW1lPWN1cnJfc2hhcmVfbXNnLmpzb24mdT0xMDAwOTR6Jms9MjkwNzExNjA0OTcxNjg4Njc4NzY2</body></message>	2020-11-10 09:55:35.568+08	155	3	d1bf2054-d044-4911-a722-b296eae63ccc	startalk.tech	startalk.tech			chat	2020-11-10 09:55:35.570346+08
100095z	100094z	<message msec_times='1604973546221' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='6f4e9c3b5f2048ad8ba30a0ed4660a4e' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/lzx]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-11-10 09:59:06.221+08	157	3	6f4e9c3b5f2048ad8ba30a0ed4660a4e	startalk.tech	startalk.tech			chat	2020-11-10 09:59:06.222356+08
100095z	100094z	<message msec_times='1604974117603' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='595f72025f1c43fb89588ec66baf5f22' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/fn]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-11-10 10:08:37.603+08	173	3	595f72025f1c43fb89588ec66baf5f22	startalk.tech	startalk.tech			chat	2020-11-10 10:08:37.605191+08
test01	100013v	<message msec_times='1605661165743' xml:lang='en' from='test01@startalk.tech' to='100013v@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='d341e99e-0ed2-44de-853c-13209d3c806b' msgType='1'>哦哦哦</body></message>	2020-11-18 08:59:25.743+08	323	3	d341e99e-0ed2-44de-853c-13209d3c806b	startalk.tech	startalk.tech			chat	2020-11-18 08:59:25.745287+08
100095z	100094z	<message msec_times='1604973833637' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='016dd248197f46249517e77512285881' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/lzx]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-11-10 10:03:53.637+08	158	3	016dd248197f46249517e77512285881	startalk.tech	startalk.tech			chat	2020-11-10 10:03:53.638759+08
100094z	mumu	<message msec_times='1605367278666' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='ac5c0fa3-608e-451f-b623-c0e8cdd4e911' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/dzwx]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-14 23:21:18.666+08	217	3	ac5c0fa3-608e-451f-b623-c0e8cdd4e911	startalk.tech	startalk.tech			chat	2020-11-14 23:21:18.667383+08
100094z	100095z	<message msec_times='1604973837207' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='6bd2487a-47b4-4901-9eed-08e947e2e041' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/bm]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-10 10:03:57.207+08	159	3	6bd2487a-47b4-4901-9eed-08e947e2e041	startalk.tech	startalk.tech			chat	2020-11-10 10:03:57.208561+08
100095z	100094z	<message msec_times='1604362489603' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;FILEID&quot;:&quot;fada57eef46e48719592ba81662b59a9&quot;,&quot;FileName&quot;:&quot;test.txt&quot;,&quot;FileSize&quot;:&quot;0.00KB&quot;,&quot;FILEMD5&quot;:&quot;004881ebe3826cf16cfd124968f2a5bb&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/004881EBE3826CF16CFD124968F2A5BB.txt&quot;}' id='fada57eef46e48719592ba81662b59a9' msgType='5'>{&quot;FILEID&quot;:&quot;fada57eef46e48719592ba81662b59a9&quot;,&quot;FileName&quot;:&quot;test.txt&quot;,&quot;FileSize&quot;:&quot;0.00KB&quot;,&quot;FILEMD5&quot;:&quot;004881ebe3826cf16cfd124968f2a5bb&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/004881EBE3826CF16CFD124968F2A5BB.txt&quot;}</body></message>	2020-11-03 08:14:49.603+08	137	3	fada57eef46e48719592ba81662b59a9	startalk.tech	startalk.tech			chat	2020-11-03 08:14:49.604233+08
100095z	100094z	<message msec_times='1604362871295' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;FILEID&quot;:&quot;75a266e53f9b41f3ba6df13caf8aafc0&quot;,&quot;FileName&quot;:&quot;test.txt&quot;,&quot;FileSize&quot;:&quot;0.00KB&quot;,&quot;FILEMD5&quot;:&quot;004881ebe3826cf16cfd124968f2a5bb&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/004881ebe3826cf16cfd124968f2a5bb?name=004881ebe3826cf16cfd124968f2a5bb.txt&quot;}' id='75a266e53f9b41f3ba6df13caf8aafc0' msgType='5'>{&quot;FILEID&quot;:&quot;75a266e53f9b41f3ba6df13caf8aafc0&quot;,&quot;FileName&quot;:&quot;test.txt&quot;,&quot;FileSize&quot;:&quot;0.00KB&quot;,&quot;FILEMD5&quot;:&quot;004881ebe3826cf16cfd124968f2a5bb&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/004881ebe3826cf16cfd124968f2a5bb?name=004881ebe3826cf16cfd124968f2a5bb.txt&quot;}</body></message>	2020-11-03 08:21:11.295+08	138	3	75a266e53f9b41f3ba6df13caf8aafc0	startalk.tech	startalk.tech			chat	2020-11-03 08:21:11.297128+08
100095z	100094z	<message msec_times='1604363011146' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='97a1a3191464409392a1897ab79d26f4' msgType='1'>[obj type=&quot;image&quot; value=&quot;https://im.startalk.tech:8443/file/v2/download/d744f0c855da6cb79fe4c6cb9cd1ef4b.png?name=d744f0c855da6cb79fe4c6cb9cd1ef4b.png&quot; width=258 height=255]</body></message>	2020-11-03 08:23:31.146+08	140	3	97a1a3191464409392a1897ab79d26f4	startalk.tech	startalk.tech			chat	2020-11-03 08:23:31.14767+08
100095z	100094z	<message msec_times='1604364848589' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='0cdee74b68ad4b74a7a17cd1e9bee1e4' msgType='1'>[obj type=&quot;image&quot; value=&quot;https://im.startalk.tech:8443/file/v2/download/81e235e7573a681a4ef9471682d381a2.png?name=81e235e7573a681a4ef9471682d381a2.png&quot; width=255 height=348]</body></message>	2020-11-03 08:54:08.589+08	141	3	0cdee74b68ad4b74a7a17cd1e9bee1e4	startalk.tech	startalk.tech			chat	2020-11-03 08:54:08.590166+08
100095z	100094z	<message msec_times='1604364858012' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='06a60a6e93894f74a21433a00017eed9' msgType='1'>11</body></message>	2020-11-03 08:54:18.012+08	142	3	06a60a6e93894f74a21433a00017eed9	startalk.tech	startalk.tech			chat	2020-11-03 08:54:18.013276+08
100095z	100094z	<message msec_times='1604364865578' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;FILEID&quot;:&quot;1be1ea8477eb424ead7ad15d3da74311&quot;,&quot;FileName&quot;:&quot;test.txt&quot;,&quot;FileSize&quot;:&quot;0.00KB&quot;,&quot;FILEMD5&quot;:&quot;004881ebe3826cf16cfd124968f2a5bb&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/004881ebe3826cf16cfd124968f2a5bb?name=004881ebe3826cf16cfd124968f2a5bb.txt&quot;}' id='1be1ea8477eb424ead7ad15d3da74311' msgType='5'>{&quot;FILEID&quot;:&quot;1be1ea8477eb424ead7ad15d3da74311&quot;,&quot;FileName&quot;:&quot;test.txt&quot;,&quot;FileSize&quot;:&quot;0.00KB&quot;,&quot;FILEMD5&quot;:&quot;004881ebe3826cf16cfd124968f2a5bb&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/004881ebe3826cf16cfd124968f2a5bb?name=004881ebe3826cf16cfd124968f2a5bb.txt&quot;}</body></message>	2020-11-03 08:54:25.578+08	143	3	1be1ea8477eb424ead7ad15d3da74311	startalk.tech	startalk.tech			chat	2020-11-03 08:54:25.579439+08
100095z	100094z	<message msec_times='1605060280913' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='47b3bee0779d46e79545ab897ecb5b8f' msgType='1'>1</body></message>	2020-11-11 10:04:40.913+08	175	3	47b3bee0779d46e79545ab897ecb5b8f	startalk.tech	startalk.tech			chat	2020-11-11 10:04:40.914361+08
100094z	100095z	<message msec_times='1604366442330' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='4e3f7198-1b2f-4daf-a8bc-e5c20b6ebf44' msgType='1'>11</body></message>	2020-11-03 09:20:42.33+08	144	3	4e3f7198-1b2f-4daf-a8bc-e5c20b6ebf44	startalk.tech	startalk.tech			chat	2020-11-03 09:20:42.33177+08
100095z	100094z	<message msec_times='1604366469618' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='fba6154d4bb8415aa0d93a5ef30fa99f' msgType='1'>[obj type=&quot;image&quot; value=&quot;https://im.startalk.tech:8443/file/v2/download/eaad4720a8786d9eb9e3173d7efc02ec.png?name=eaad4720a8786d9eb9e3173d7efc02ec.png&quot; width=667 height=625]</body></message>	2020-11-03 09:21:09.618+08	145	3	fba6154d4bb8415aa0d93a5ef30fa99f	startalk.tech	startalk.tech			chat	2020-11-03 09:21:09.619652+08
100094z	100095z	<message msec_times='1604969908131' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='95a6cebb-51be-4f39-87ae-3f9bca9ae56b' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/ka]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-10 08:58:28.131+08	149	3	95a6cebb-51be-4f39-87ae-3f9bca9ae56b	startalk.tech	startalk.tech			chat	2020-11-10 08:58:28.132584+08
100094z	100095z	<message msec_times='1604973838937' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='9383e086-194a-4564-9add-99a678510a5e' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xy]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xy]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/zy]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-10 10:03:58.937+08	160	3	9383e086-194a-4564-9add-99a678510a5e	startalk.tech	startalk.tech			chat	2020-11-10 10:03:58.938933+08
100095z	100094z	<message msec_times='1604971680089' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='68a8fd3e54dd4ef080b6bd11d094d181' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/lzx]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-11-10 09:28:00.089+08	150	3	68a8fd3e54dd4ef080b6bd11d094d181	startalk.tech	startalk.tech			chat	2020-11-10 09:28:00.090012+08
mumu	100095z	<message msec_times='1605367348743' xml:lang='en' from='mumu@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='947e8fa9b44044ba9948a3c2cbf57930' msgType='1'>[obj type=&quot;image&quot; value=&quot;https://im.startalk.tech:8443/file/v2/download/60cef28b12e68a57cd15dd0eb1a01601.png?name=60cef28b12e68a57cd15dd0eb1a01601.png&quot; width=207 height=193]</body></message>	2020-11-14 23:22:28.743+08	218	3	947e8fa9b44044ba9948a3c2cbf57930	startalk.tech	startalk.tech			chat	2020-11-14 23:22:28.74524+08
100013v	test01	<message msec_times='1605661194378' xml:lang='en' from='100013v@startalk.tech' to='test01@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='ab8396a1-15ad-48ea-b18d-b3436a94a7a3' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-18 08:59:54.378+08	325	3	ab8396a1-15ad-48ea-b18d-b3436a94a7a3	startalk.tech	startalk.tech			chat	2020-11-18 08:59:54.379349+08
100094z	100095z	<message msec_times='1604971711391' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='64e6196b-d9ba-4415-9b90-b31e97561765' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-10 09:28:31.391+08	151	3	64e6196b-d9ba-4415-9b90-b31e97561765	startalk.tech	startalk.tech			chat	2020-11-10 09:28:31.393341+08
100094z	100095z	<message msec_times='1604973868151' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='aee83a6e-6ddf-411a-9498-86223413812f' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/hhx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/hhx]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-10 10:04:28.151+08	161	3	aee83a6e-6ddf-411a-9498-86223413812f	startalk.tech	startalk.tech			chat	2020-11-10 10:04:28.152249+08
100094z	100095z	<message msec_times='1604973869828' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='07138888-5231-439e-b64d-e7f825138ee2' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/zy]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xy]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-10 10:04:29.828+08	162	3	07138888-5231-439e-b64d-e7f825138ee2	startalk.tech	startalk.tech			chat	2020-11-10 10:04:29.829885+08
100095z	100094z	<message msec_times='1604973874444' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='687a81604acf4455a1ed1ada49817c84' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/hxqq]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-11-10 10:04:34.444+08	163	3	687a81604acf4455a1ed1ada49817c84	startalk.tech	startalk.tech			chat	2020-11-10 10:04:34.445367+08
100094z	100095z	<message msec_times='1604973887076' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='a24e24e0-d792-44ad-888d-d2b67d9a4aa8' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/fw]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/fw]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/fw]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-10 10:04:47.076+08	164	3	a24e24e0-d792-44ad-888d-d2b67d9a4aa8	startalk.tech	startalk.tech			chat	2020-11-10 10:04:47.077797+08
100095z	100094z	<message msec_times='1604973891309' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='5b7b003714d64bdc822344224060f29c' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/hxqq]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-11-10 10:04:51.309+08	165	3	5b7b003714d64bdc822344224060f29c	startalk.tech	startalk.tech			chat	2020-11-10 10:04:51.310872+08
100095z	100094z	<message msec_times='1604973896132' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='795ca759ba844473b17826585f4fbf86' msgType='1'>llll</body></message>	2020-11-10 10:04:56.132+08	166	3	795ca759ba844473b17826585f4fbf86	startalk.tech	startalk.tech			chat	2020-11-10 10:04:56.133967+08
100094z	100095z	<message msec_times='1604973906481' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='f41c8244-acdc-4937-b4da-d168766ff860' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-10 10:05:06.481+08	167	3	f41c8244-acdc-4937-b4da-d168766ff860	startalk.tech	startalk.tech			chat	2020-11-10 10:05:06.482485+08
100095z	100094z	<message msec_times='1604974111950' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='3b3c3c2605de4a90af6ed38fbcc73eb4' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/byx]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-11-10 10:08:31.95+08	171	3	3b3c3c2605de4a90af6ed38fbcc73eb4	startalk.tech	startalk.tech			chat	2020-11-10 10:08:31.95188+08
100095z	100094z	<message msec_times='1604974114685' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='9cffc15b2bc648c79b7e637df004d445' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/bm]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-11-10 10:08:34.685+08	172	3	9cffc15b2bc648c79b7e637df004d445	startalk.tech	startalk.tech			chat	2020-11-10 10:08:34.686949+08
100095z	100094z	<message msec_times='1604974107596' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='398ac80811384f9dba76c826d87a0619' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/byqq]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-11-10 10:08:27.596+08	170	3	398ac80811384f9dba76c826d87a0619	startalk.tech	startalk.tech			chat	2020-11-10 10:08:27.597465+08
100095z	100094z	<message msec_times='1604974098555' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='181530a6ce4141eab29e7ad7b429df57' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/byqq]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-11-10 10:08:18.555+08	169	3	181530a6ce4141eab29e7ad7b429df57	startalk.tech	startalk.tech			chat	2020-11-10 10:08:18.556494+08
100095z	100094z	<message msec_times='1604974088493' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='805cd4000bba46229a8a42e5f7859256' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/byx]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-11-10 10:08:08.493+08	168	3	805cd4000bba46229a8a42e5f7859256	startalk.tech	startalk.tech			chat	2020-11-10 10:08:08.495283+08
100094z	100095z	<message msec_times='1605437230911' xml:lang='en' from='100094z@startalk.tech/V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[D3AC1B7D4415412B8400318872B88EFD]_PB' to='100095z@startalk.tech' type='chat' client_type='ClientTypeiOS' client_ver='0'><body id='B839688B248C4DEB88FD1B282F89B406' msgType='1'>你好</body></message>	2020-11-15 18:47:10.911+08	267	3	B839688B248C4DEB88FD1B282F89B406	startalk.tech	startalk.tech			chat	2020-11-15 18:47:10.912599+08
100004q	mumu	<message msec_times='1605007319441' xml:lang='en' from='100004q@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='17135d3d-caba-4e53-a64a-b70fcab1735c' msgType='1'>测试</body></message>	2020-11-10 19:21:59.441+08	174	3	17135d3d-caba-4e53-a64a-b70fcab1735c	startalk.tech	startalk.tech			chat	2020-11-10 19:21:59.442838+08
100094z	mumu	<message msec_times='1605367268787' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='915000c1-8fb8-43de-bdfb-e47f9f63eed8' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-14 23:21:08.787+08	214	3	915000c1-8fb8-43de-bdfb-e47f9f63eed8	startalk.tech	startalk.tech			chat	2020-11-14 23:21:08.788753+08
100094z	mumu	<message msec_times='1605367271794' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='87fc4bf8-b818-4c64-9fbb-a21281d32b63' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-14 23:21:11.794+08	216	3	87fc4bf8-b818-4c64-9fbb-a21281d32b63	startalk.tech	startalk.tech			chat	2020-11-14 23:21:11.795597+08
100094z	mumu	<message msec_times='1605367398586' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='b7ed3fa3-976c-458f-b054-a4b0e7343a5e' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-14 23:23:18.586+08	220	3	b7ed3fa3-976c-458f-b054-a4b0e7343a5e	startalk.tech	startalk.tech			chat	2020-11-14 23:23:18.587274+08
100094z	mumu	<message msec_times='1605367246929' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='7665dee0-bd38-42de-9600-8f531fd910af' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-14 23:20:46.929+08	212	3	7665dee0-bd38-42de-9600-8f531fd910af	startalk.tech	startalk.tech			chat	2020-11-14 23:20:46.930611+08
100094z	mumu	<message msec_times='1605367423367' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='f60463ab-df8d-4bcd-9299-e7f19a666e1a' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/byqq]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/byqq]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-14 23:23:43.367+08	221	3	f60463ab-df8d-4bcd-9299-e7f19a666e1a	startalk.tech	startalk.tech			chat	2020-11-14 23:23:43.368649+08
100094z	mumu	<message msec_times='1605367426657' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='7a23e98e-1ebc-4bbd-8b90-bfbdd03808f5' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/ak]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/ak]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/ak]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-14 23:23:46.657+08	222	3	7a23e98e-1ebc-4bbd-8b90-bfbdd03808f5	startalk.tech	startalk.tech			chat	2020-11-14 23:23:46.658739+08
100094z	mumu	<message msec_times='1605367428819' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='e6c52e2b-3366-453b-85c4-915e05193174' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/hhx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/hhx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/hhx]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-14 23:23:48.819+08	223	3	e6c52e2b-3366-453b-85c4-915e05193174	startalk.tech	startalk.tech			chat	2020-11-14 23:23:48.821101+08
100094z	mumu	<message msec_times='1605367467743' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='ab1682fd-21f4-46cc-b756-eb4d12a73cad' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-14 23:24:27.743+08	224	3	ab1682fd-21f4-46cc-b756-eb4d12a73cad	startalk.tech	startalk.tech			chat	2020-11-14 23:24:27.744666+08
100094z	mumu	<message msec_times='1605367527808' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='197e964e-2c06-479c-9532-d6e902a5d055' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-14 23:25:27.808+08	225	3	197e964e-2c06-479c-9532-d6e902a5d055	startalk.tech	startalk.tech			chat	2020-11-14 23:25:27.809914+08
100094z	100095z	<message msec_times='1605437230918' xml:lang='en' from='100094z@startalk.tech/V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[D3AC1B7D4415412B8400318872B88EFD]_PB' to='100095z@startalk.tech' type='chat' client_type='ClientTypeiOS' client_ver='0'><body extendInfo='{&quot;width&quot;:0,&quot;shortcut&quot;:&quot;4600afd7a10bab5f3a0cd0b29171058b&quot;,&quot;height&quot;:0,&quot;pkgid&quot;:&quot;qunar_camel&quot;,&quot;url&quot;:&quot;&quot;}' id='389473F8494E4D79B468AAAD9838DAED' msgType='30'>[obj type=&quot;emoticon&quot; value=&quot;[4600afd7a10bab5f3a0cd0b29171058b]&quot; width=qunar_camel height=0 ]</body></message>	2020-11-15 18:47:10.918+08	268	3	389473F8494E4D79B468AAAD9838DAED	startalk.tech	startalk.tech			chat	2020-11-15 18:47:10.919582+08
100094z	100095z	<message msec_times='1605437151876' xml:lang='en' from='100094z@startalk.tech/V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[D3AC1B7D4415412B8400318872B88EFD]_PB' to='100095z@startalk.tech' type='chat' client_type='ClientTypeiOS' client_ver='0'><body extendInfo='{&quot;width&quot;:0,&quot;shortcut&quot;:&quot;4600afd7a10bab5f3a0cd0b29171058b&quot;,&quot;height&quot;:0,&quot;pkgid&quot;:&quot;qunar_camel&quot;,&quot;url&quot;:&quot;&quot;}' id='EBFE9CDF3AC74BD58BE843033D1CE57B' msgType='30'>[obj type=&quot;emoticon&quot; value=&quot;[4600afd7a10bab5f3a0cd0b29171058b]&quot; width=qunar_camel height=0 ]</body></message>	2020-11-15 18:45:51.876+08	263	3	EBFE9CDF3AC74BD58BE843033D1CE57B	startalk.tech	startalk.tech			chat	2020-11-15 18:45:51.877611+08
100094z	100095z	<message msec_times='1605060294098' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;FILEID&quot;:&quot;b78e1c8ec13d40ec8d0f6433f122e986&quot;,&quot;FileName&quot;:&quot;test.txt&quot;,&quot;FileSize&quot;:&quot;0.00KB&quot;,&quot;FILEMD5&quot;:&quot;004881ebe3826cf16cfd124968f2a5bb&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/004881ebe3826cf16cfd124968f2a5bb?name=004881ebe3826cf16cfd124968f2a5bb.txt&quot;}' id='b78e1c8ec13d40ec8d0f6433f122e986' msgType='5'>{&quot;FILEID&quot;:&quot;b78e1c8ec13d40ec8d0f6433f122e986&quot;,&quot;FileName&quot;:&quot;test.txt&quot;,&quot;FileSize&quot;:&quot;0.00KB&quot;,&quot;FILEMD5&quot;:&quot;004881ebe3826cf16cfd124968f2a5bb&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/004881ebe3826cf16cfd124968f2a5bb?name=004881ebe3826cf16cfd124968f2a5bb.txt&quot;}</body></message>	2020-11-11 10:04:54.098+08	176	3	b78e1c8ec13d40ec8d0f6433f122e986	startalk.tech	startalk.tech			chat	2020-11-11 10:04:54.09938+08
100094z	file-transfer	<message msec_times='1605437970044' xml:lang='en' from='100094z@startalk.tech/V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[A3054C7048464CCD90A41AAEB7216778]_PB' to='file-transfer@startalk.tech' type='chat' client_type='ClientTypeiOS' client_ver='0'><body extendInfo='{&quot;width&quot;:0,&quot;shortcut&quot;:&quot;7d1cb7cce608af3531fff8cf93f8eca7&quot;,&quot;height&quot;:0,&quot;pkgid&quot;:&quot;qunar_camel&quot;,&quot;url&quot;:&quot;&quot;}' id='1FC212C323EB4201905E88E1EF9FE923' msgType='30'>[obj type=&quot;emoticon&quot; value=&quot;[7d1cb7cce608af3531fff8cf93f8eca7]&quot; width=qunar_camel height=0 ]</body></message>	2020-11-15 18:59:30.044+08	269	0	1FC212C323EB4201905E88E1EF9FE923	startalk.tech	startalk.tech			chat	2020-11-15 18:59:30.045955+08
100094z	100095z	<message msec_times='1605060393505' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;title&quot;:&quot;测试一家的聊天记录&quot;,&quot;desc&quot;:&quot;&quot;,&quot;linkurl&quot;:&quot;http://im.startalk.tech:8080/py/sharemsg?jdata=&quot;}' id='acc2b2584b8c40e69df14779b0e78e17' msgType='666'>收到了一个消息记录文件文件，请升级客户端查看。</body></message>	2020-11-11 10:06:33.505+08	177	3	acc2b2584b8c40e69df14779b0e78e17	startalk.tech	startalk.tech			chat	2020-11-11 10:06:33.50635+08
100094z	mumu	<message msec_times='1605367530036' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='69f8f3b9-f690-41b5-a803-b4aae88d2f32' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-14 23:25:30.036+08	226	3	69f8f3b9-f690-41b5-a803-b4aae88d2f32	startalk.tech	startalk.tech			chat	2020-11-14 23:25:30.037638+08
100094z	mumu	<message msec_times='1605367532672' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='3b609a21-6c9c-427c-aee6-5c71634965c1' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/zy]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-14 23:25:32.672+08	227	3	3b609a21-6c9c-427c-aee6-5c71634965c1	startalk.tech	startalk.tech			chat	2020-11-14 23:25:32.673526+08
mumu	100094z	<message msec_times='1605367694583' xml:lang='en' from='mumu@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='51ea2af689c146e38a57ecc8570db5ae' msgType='10'>[窗口抖动]</body></message>	2020-11-14 23:28:14.583+08	228	3	51ea2af689c146e38a57ecc8570db5ae	startalk.tech	startalk.tech			chat	2020-11-14 23:28:14.586962+08
mumu	mumu	<message msec_times='1605367785733' xml:lang='en' from='mumu@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='ba8ec33a4d724593baf9017d2e04b6c9' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/lzx]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-11-14 23:29:45.733+08	229	1	ba8ec33a4d724593baf9017d2e04b6c9	startalk.tech	startalk.tech			chat	2020-11-14 23:29:45.736663+08
mumu	mumu	<message msec_times='1605367814109' xml:lang='en' from='mumu@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='6c4ae16a2a8243f1abe557bb4e5f7542' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/lzx]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-11-14 23:30:14.109+08	230	1	6c4ae16a2a8243f1abe557bb4e5f7542	startalk.tech	startalk.tech			chat	2020-11-14 23:30:14.112294+08
mumu	mumu	<message msec_times='1605367821084' xml:lang='en' from='mumu@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='9a3cf70bc55f42eba43488bb517b6c7b' msgType='1'>999</body></message>	2020-11-14 23:30:21.084+08	231	1	9a3cf70bc55f42eba43488bb517b6c7b	startalk.tech	startalk.tech			chat	2020-11-14 23:30:21.088132+08
mumu	mumu	<message msec_times='1605367822098' xml:lang='en' from='mumu@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='b5582f1302ed442e83c8a6f6d4cf1d52' msgType='1'>99</body></message>	2020-11-14 23:30:22.098+08	232	1	b5582f1302ed442e83c8a6f6d4cf1d52	startalk.tech	startalk.tech			chat	2020-11-14 23:30:22.101629+08
100094z	100095z	<message msec_times='1605063878398' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;title&quot;:&quot;测试一家的聊天记录&quot;,&quot;desc&quot;:&quot;&quot;,&quot;linkurl&quot;:&quot;http://im.startalk.tech:8080/py/sharemsg?jdata=&quot;}' id='ebee7c87f91b418da113726faca986db' msgType='666'>收到了一个消息记录文件文件，请升级客户端查看。</body></message>	2020-11-11 11:04:38.398+08	179	1	ebee7c87f91b418da113726faca986db	startalk.tech	startalk.tech			chat	2020-11-11 11:04:38.399355+08
100094z	file-transfer	<message msec_times='1605437971212' xml:lang='en' from='100094z@startalk.tech/V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[A3054C7048464CCD90A41AAEB7216778]_PB' to='file-transfer@startalk.tech' type='chat' client_type='ClientTypeiOS' client_ver='0'><body extendInfo='{&quot;width&quot;:0,&quot;shortcut&quot;:&quot;e0ed60f27f7c104fda45b64ff3c4edb9&quot;,&quot;height&quot;:0,&quot;pkgid&quot;:&quot;qunar_camel&quot;,&quot;url&quot;:&quot;&quot;}' id='FFB88D92A6F34954B3CD70E7C4FFC232' msgType='30'>[obj type=&quot;emoticon&quot; value=&quot;[e0ed60f27f7c104fda45b64ff3c4edb9]&quot; width=qunar_camel height=0 ]</body></message>	2020-11-15 18:59:31.212+08	270	0	FFB88D92A6F34954B3CD70E7C4FFC232	startalk.tech	startalk.tech			chat	2020-11-15 18:59:31.213909+08
100094z	file-transfer	<message msec_times='1605437971393' xml:lang='en' from='100094z@startalk.tech/V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[A3054C7048464CCD90A41AAEB7216778]_PB' to='file-transfer@startalk.tech' type='chat' client_type='ClientTypeiOS' client_ver='0'><body extendInfo='{&quot;width&quot;:0,&quot;shortcut&quot;:&quot;e0ed60f27f7c104fda45b64ff3c4edb9&quot;,&quot;height&quot;:0,&quot;pkgid&quot;:&quot;qunar_camel&quot;,&quot;url&quot;:&quot;&quot;}' id='80F124C9E7D748649CC1223A4B848E16' msgType='30'>[obj type=&quot;emoticon&quot; value=&quot;[e0ed60f27f7c104fda45b64ff3c4edb9]&quot; width=qunar_camel height=0 ]</body></message>	2020-11-15 18:59:31.393+08	271	0	80F124C9E7D748649CC1223A4B848E16	startalk.tech	startalk.tech			chat	2020-11-15 18:59:31.394805+08
100094z	file-transfer	<message msec_times='1605437971898' xml:lang='en' from='100094z@startalk.tech/V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[A3054C7048464CCD90A41AAEB7216778]_PB' to='file-transfer@startalk.tech' type='chat' client_type='ClientTypeiOS' client_ver='0'><body extendInfo='{&quot;width&quot;:0,&quot;shortcut&quot;:&quot;e0ed60f27f7c104fda45b64ff3c4edb9&quot;,&quot;height&quot;:0,&quot;pkgid&quot;:&quot;qunar_camel&quot;,&quot;url&quot;:&quot;&quot;}' id='3E57A0ACCFE24A07985E476472D4CE02' msgType='30'>[obj type=&quot;emoticon&quot; value=&quot;[e0ed60f27f7c104fda45b64ff3c4edb9]&quot; width=qunar_camel height=0 ]</body></message>	2020-11-15 18:59:31.898+08	272	0	3E57A0ACCFE24A07985E476472D4CE02	startalk.tech	startalk.tech			chat	2020-11-15 18:59:31.899908+08
100095z	100094z	<message msec_times='1605438019733' xml:lang='en' from='100095z@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='1aae2b5d-7c26-4de9-826a-36b129f49bde' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/ka]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/ka]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-15 19:00:19.733+08	273	3	1aae2b5d-7c26-4de9-826a-36b129f49bde	startalk.tech	startalk.tech			chat	2020-11-15 19:00:19.735095+08
100013v	test01	<message msec_times='1605661197044' xml:lang='en' from='100013v@startalk.tech' to='test01@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='a42de078-a22c-4e2f-a90e-f1b603d2930e' msgType='1'>就好好</body></message>	2020-11-18 08:59:57.044+08	326	3	a42de078-a22c-4e2f-a90e-f1b603d2930e	startalk.tech	startalk.tech			chat	2020-11-18 08:59:57.045523+08
100004q	mumu	<message msec_times='1605179945899' xml:lang='en' from='100004q@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='07a345b4-78eb-4ce9-a8eb-2b8e65cecd05' msgType='1'>测试</body></message>	2020-11-12 19:19:05.899+08	182	3	07a345b4-78eb-4ce9-a8eb-2b8e65cecd05	startalk.tech	startalk.tech			chat	2020-11-12 19:19:05.901492+08
mumu	100095z	<message msec_times='1605190575030' xml:lang='en' from='mumu@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;title&quot;:&quot;test22的聊天记录&quot;,&quot;desc&quot;:&quot;&quot;,&quot;linkurl&quot;:&quot;https://im.startalk.tech:8443/py/sharemsg?jdata=aHR0cHM6Ly9pbS5zdGFydGFsay50ZWNoOjg0NDMvZmlsZS92Mi9kb3dubG9hZC80YWIwMWNhMTA3Yjc5M2RkMmUyYzVhZGI0Mzk5ODAwMj9uYW1lPTRhYjAxY2ExMDdiNzkzZGQyZTJjNWFkYjQzOTk4MDAyLg==&quot;}' id='210038221f5c47eaabe3918f98ad16b8' msgType='666'>收到了一个消息记录文件文件，请升级客户端查看。</body></message>	2020-11-12 22:16:15.03+08	188	1	210038221f5c47eaabe3918f98ad16b8	startalk.tech	startalk.tech			chat	2020-11-12 22:16:15.031957+08
100094z	mumu	<message msec_times='1605367229685' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='4f50161d-be1f-4393-a147-c105125e7697' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/dzwx]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-14 23:20:29.685+08	210	3	4f50161d-be1f-4393-a147-c105125e7697	startalk.tech	startalk.tech			chat	2020-11-14 23:20:29.686811+08
100094z	100095z	<message msec_times='1605439372764' xml:lang='en' from='100094z@startalk.tech/V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[D7690400AD6B4520B341D92F6EE08884]_PB' to='100095z@startalk.tech' type='chat' client_type='ClientTypeiOS' client_ver='0'><body extendInfo='{&quot;width&quot;:0,&quot;shortcut&quot;:&quot;e0ed60f27f7c104fda45b64ff3c4edb9&quot;,&quot;height&quot;:0,&quot;pkgid&quot;:&quot;qunar_camel&quot;,&quot;url&quot;:&quot;&quot;}' id='49CE83E5C3ED432986B306F3430E2443' msgType='30'>[obj type=&quot;emoticon&quot; value=&quot;[e0ed60f27f7c104fda45b64ff3c4edb9]&quot; width=qunar_camel height=0 ]</body></message>	2020-11-15 19:22:52.764+08	274	3	49CE83E5C3ED432986B306F3430E2443	startalk.tech	startalk.tech			chat	2020-11-15 19:22:52.76536+08
100094z	100095z	<message msec_times='1605439372952' xml:lang='en' from='100094z@startalk.tech/V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[D7690400AD6B4520B341D92F6EE08884]_PB' to='100095z@startalk.tech' type='chat' client_type='ClientTypeiOS' client_ver='0'><body extendInfo='{&quot;width&quot;:0,&quot;shortcut&quot;:&quot;e0ed60f27f7c104fda45b64ff3c4edb9&quot;,&quot;height&quot;:0,&quot;pkgid&quot;:&quot;qunar_camel&quot;,&quot;url&quot;:&quot;&quot;}' id='449F6736D051419B8B4EBBA647994B30' msgType='30'>[obj type=&quot;emoticon&quot; value=&quot;[e0ed60f27f7c104fda45b64ff3c4edb9]&quot; width=qunar_camel height=0 ]</body></message>	2020-11-15 19:22:52.952+08	275	3	449F6736D051419B8B4EBBA647994B30	startalk.tech	startalk.tech			chat	2020-11-15 19:22:52.953072+08
100094z	100095z	<message msec_times='1605442828250' xml:lang='en' from='100094z@startalk.tech/V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[65EC5D9601E34A089862F3D5F5E06285]_PB' to='100095z@startalk.tech' type='chat' client_type='ClientTypeiOS' client_ver='0'><body id='0B28FBB9F89F4BC797A81BC9E23AEC7B' msgType='1'>你好</body></message>	2020-11-15 20:20:28.25+08	276	3	0B28FBB9F89F4BC797A81BC9E23AEC7B	startalk.tech	startalk.tech			chat	2020-11-15 20:20:28.251471+08
100094z	100095z	<message msec_times='1605442828292' xml:lang='en' from='100094z@startalk.tech/V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[65EC5D9601E34A089862F3D5F5E06285]_PB' to='100095z@startalk.tech' type='chat' client_type='ClientTypeiOS' client_ver='0'><body id='0DB63FBE74914450B7EAE0EC856CBFC3' msgType='1'>「 珊珊JH:你好 」\n- - - - - - - - - - - - - - -\n你会ooo</body></message>	2020-11-15 20:20:28.292+08	277	3	0DB63FBE74914450B7EAE0EC856CBFC3	startalk.tech	startalk.tech			chat	2020-11-15 20:20:28.293409+08
test01	100013v	<message msec_times='1605661231724' xml:lang='en' from='test01@startalk.tech' to='100013v@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body extendInfo='{&quot;auth&quot;:true,&quot;desc&quot;:&quot;点击查看全部&quot;,&quot;linkurl&quot;:&quot;https://im.startalk.tech:8443/py/sharemsg?jdata\\u003daHR0cHM6Ly9pbS5zdGFydGFsay50ZWNoOjg0NDMvZmlsZS92Mi9kb3dubG9hZC9kM2YzZGYzMTg1YjQzNjBjYTgwMjAwYWU4N2YyZjFiZD9uYW1lPWN1cnJfc2hhcmVfbXNnLmpzb24mdT10ZXN0MDEmaz0yOTA3MTE2MDU2NjExMzc3MjI2NjY%3D&quot;,&quot;showas667&quot;:false,&quot;showbar&quot;:true,&quot;title&quot;:&quot;test01,test02的聊天记录&quot;}' id='56c20baf-c98b-4996-a4e4-017f686a71b1' msgType='666'>https://im.startalk.tech:8443/py/sharemsg?jdata=aHR0cHM6Ly9pbS5zdGFydGFsay50ZWNoOjg0NDMvZmlsZS92Mi9kb3dubG9hZC9kM2YzZGYzMTg1YjQzNjBjYTgwMjAwYWU4N2YyZjFiZD9uYW1lPWN1cnJfc2hhcmVfbXNnLmpzb24mdT10ZXN0MDEmaz0yOTA3MTE2MDU2NjExMzc3MjI2NjY%3D</body></message>	2020-11-18 09:00:31.724+08	327	3	56c20baf-c98b-4996-a4e4-017f686a71b1	startalk.tech	startalk.tech			chat	2020-11-18 09:00:31.72573+08
100094z	mumu	<message msec_times='1605367233791' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='3d7250b7-e3e8-41b8-b7cc-d4ca957308d5' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/ka]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/ka]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-14 23:20:33.791+08	211	3	3d7250b7-e3e8-41b8-b7cc-d4ca957308d5	startalk.tech	startalk.tech			chat	2020-11-14 23:20:33.792641+08
mumu	mumu	<message msec_times='1605367827374' xml:lang='en' from='mumu@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='076ae6ecef2b430cae6e561454fd7608' msgType='1'>jiii</body></message>	2020-11-14 23:30:27.374+08	233	1	076ae6ecef2b430cae6e561454fd7608	startalk.tech	startalk.tech			chat	2020-11-14 23:30:27.377563+08
mumu	mumu	<message msec_times='1605367831084' xml:lang='en' from='mumu@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='f674516d1cf5424eb0c5261a708de3c1' msgType='1'>999</body></message>	2020-11-14 23:30:31.084+08	234	1	f674516d1cf5424eb0c5261a708de3c1	startalk.tech	startalk.tech			chat	2020-11-14 23:30:31.087771+08
mumu	100094z	<message msec_times='1605366876149' xml:lang='en' from='mumu@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='d301e959b3194aa2a127cfa423a84caf' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/qq]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-11-14 23:14:36.149+08	193	3	d301e959b3194aa2a127cfa423a84caf	startalk.tech	startalk.tech			chat	2020-11-14 23:14:36.151138+08
mumu	100094z	<message msec_times='1605366882818' xml:lang='en' from='mumu@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='c7620d72ed3c4f6bbcdd8f756ffebd24' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/lzx]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-11-14 23:14:42.818+08	194	3	c7620d72ed3c4f6bbcdd8f756ffebd24	startalk.tech	startalk.tech			chat	2020-11-14 23:14:42.820056+08
mumu	100095z	<message msec_times='1605366426619' xml:lang='en' from='mumu@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='7759b22457df4d6cb13ecbba185711d6' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/byqq]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-11-14 23:07:06.619+08	192	3	7759b22457df4d6cb13ecbba185711d6	startalk.tech	startalk.tech			chat	2020-11-14 23:07:06.6207+08
mumu	mumu	<message msec_times='1605367832565' xml:lang='en' from='mumu@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='96756ed148204d4bbe6a2eb33136372e' msgType='1'>000</body></message>	2020-11-14 23:30:32.565+08	235	1	96756ed148204d4bbe6a2eb33136372e	startalk.tech	startalk.tech			chat	2020-11-14 23:30:32.569538+08
100094z	mumu	<message msec_times='1605366891148' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='fd40b4bc-ebec-405a-a57e-32603288432d' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-14 23:14:51.148+08	195	3	fd40b4bc-ebec-405a-a57e-32603288432d	startalk.tech	startalk.tech			chat	2020-11-14 23:14:51.14936+08
100094z	100095z	<message msec_times='1605442907260' xml:lang='en' from='100094z@startalk.tech/V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[65EC5D9601E34A089862F3D5F5E06285]_PB' to='100095z@startalk.tech' type='chat' client_type='ClientTypeiOS' client_ver='0'><body id='8239222A122945CC886E316D825526C0' msgType='1'>「 珊珊JH:你好 」\n- - - - - - - - - - - - - - -\n你好</body></message>	2020-11-15 20:21:47.26+08	279	3	8239222A122945CC886E316D825526C0	startalk.tech	startalk.tech			chat	2020-11-15 20:21:47.262077+08
mumu	100094z	<message msec_times='1605366895876' xml:lang='en' from='mumu@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='e7e959baa93243d3a8bba327a4b8f9c4' msgType='1'>g</body></message>	2020-11-14 23:14:55.876+08	196	3	e7e959baa93243d3a8bba327a4b8f9c4	startalk.tech	startalk.tech			chat	2020-11-14 23:14:55.877767+08
100094z	mumu	<message msec_times='1605366930854' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body extendInfo='{&quot;FILEID&quot;:&quot;a0877de2-7ced-4ed6-9196-95a46c86427e&quot;,&quot;FILEMD5&quot;:&quot;4712edca8ea1b68cf0082cdfe1b1afc5&quot;,&quot;FileName&quot;:&quot;Dream_It_Possible.mp3&quot;,&quot;FileSize&quot;:&quot;8.09M&quot;,&quot;HttpUrl&quot;:&quot;file/v2/download/4712edca8ea1b68cf0082cdfe1b1afc5?name\\u003dDream_It_Possible.mp3&quot;,&quot;LocalFile&quot;:&quot;/product/media/Pre-loaded/Music/Dream_It_Possible.mp3&quot;,&quot;noMD5&quot;:false}' id='a0877de2-7ced-4ed6-9196-95a46c86427e' msgType='5'>{&quot;FILEID&quot;:&quot;a0877de2-7ced-4ed6-9196-95a46c86427e&quot;,&quot;FILEMD5&quot;:&quot;4712edca8ea1b68cf0082cdfe1b1afc5&quot;,&quot;FileName&quot;:&quot;Dream_It_Possible.mp3&quot;,&quot;FileSize&quot;:&quot;8.09M&quot;,&quot;HttpUrl&quot;:&quot;file/v2/download/4712edca8ea1b68cf0082cdfe1b1afc5?name\\u003dDream_It_Possible.mp3&quot;,&quot;LocalFile&quot;:&quot;/product/media/Pre-loaded/Music/Dream_It_Possible.mp3&quot;,&quot;noMD5&quot;:false}</body></message>	2020-11-14 23:15:30.854+08	197	3	a0877de2-7ced-4ed6-9196-95a46c86427e	startalk.tech	startalk.tech			chat	2020-11-14 23:15:30.855782+08
100094z	mumu	<message msec_times='1605366952657' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body extendInfo='{&quot;FILEID&quot;:&quot;27dcae0c-15e0-4ffd-9689-0c406b970c84&quot;,&quot;FILEMD5&quot;:&quot;677ddc5d88ad1440efa13848d2b7fe3f&quot;,&quot;FileName&quot;:&quot;1604976902044.jpg&quot;,&quot;FileSize&quot;:&quot;121.01K&quot;,&quot;HttpUrl&quot;:&quot;file/v2/download/677ddc5d88ad1440efa13848d2b7fe3f?name\\u003d1604976902044.jpg&quot;,&quot;LocalFile&quot;:&quot;/storage/emulated/0/Pictures/1604976902044.jpg&quot;,&quot;noMD5&quot;:false}' id='27dcae0c-15e0-4ffd-9689-0c406b970c84' msgType='5'>{&quot;FILEID&quot;:&quot;27dcae0c-15e0-4ffd-9689-0c406b970c84&quot;,&quot;FILEMD5&quot;:&quot;677ddc5d88ad1440efa13848d2b7fe3f&quot;,&quot;FileName&quot;:&quot;1604976902044.jpg&quot;,&quot;FileSize&quot;:&quot;121.01K&quot;,&quot;HttpUrl&quot;:&quot;file/v2/download/677ddc5d88ad1440efa13848d2b7fe3f?name\\u003d1604976902044.jpg&quot;,&quot;LocalFile&quot;:&quot;/storage/emulated/0/Pictures/1604976902044.jpg&quot;,&quot;noMD5&quot;:false}</body></message>	2020-11-14 23:15:52.657+08	198	3	27dcae0c-15e0-4ffd-9689-0c406b970c84	startalk.tech	startalk.tech			chat	2020-11-14 23:15:52.659113+08
100094z	mumu	<message msec_times='1605366958851' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='7dcef322-de2a-4162-872c-6598ab323125' msgType='3'>[obj type=&quot;image&quot; value=&quot;file/v2/download/ee32885b7a6de076f7f4e6cb08bf4bfe.jpg?name=ee32885b7a6de076f7f4e6cb08bf4bfe.jpg&quot; width=880 height=1920]</body></message>	2020-11-14 23:15:58.851+08	199	3	7dcef322-de2a-4162-872c-6598ab323125	startalk.tech	startalk.tech			chat	2020-11-14 23:15:58.85218+08
100094z	mumu	<message msec_times='1605366967200' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='27a1f8c2-d017-4602-8fd6-6e2ca8056bbf' msgType='10'>[窗口抖动]</body></message>	2020-11-14 23:16:07.2+08	200	3	27a1f8c2-d017-4602-8fd6-6e2ca8056bbf	startalk.tech	startalk.tech			chat	2020-11-14 23:16:07.202102+08
100094z	mumu	<message msec_times='1605366983791' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='acb6d671-5ea1-44e5-b940-87407c85c4ae' msgType='3'>[obj type=&quot;image&quot; value=&quot;file/v2/download/27b7a3437738e9da2f71be2cbb788a4d.png?name=27b7a3437738e9da2f71be2cbb788a4d.png&quot; width=2822 height=12580]</body></message>	2020-11-14 23:16:23.791+08	201	3	acb6d671-5ea1-44e5-b940-87407c85c4ae	startalk.tech	startalk.tech			chat	2020-11-14 23:16:23.792918+08
100094z	mumu	<message msec_times='1605366997850' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body extendInfo='{&quot;Duration&quot;:&quot;0&quot;,&quot;FileName&quot;:&quot;video_1605367002043.mp4&quot;,&quot;FileSize&quot;:&quot;105.41K&quot;,&quot;FileUrl&quot;:&quot;file/v2/download/d69b3357146a64db27e6e5af2745630f?name\\u003dvideo_1605367002043.mp4&quot;,&quot;Height&quot;:&quot;1552&quot;,&quot;ThumbUrl&quot;:&quot;file/v2/download/2fc935749598b81396b6a619159da94d.jpg?name\\u003d2fc935749598b81396b6a619159da94d.jpg&quot;,&quot;Width&quot;:&quot;720&quot;,&quot;newVideo&quot;:false}' id='a6a6c470-9b21-45b7-9150-9a5a976ef49f' msgType='32'>{&quot;Duration&quot;:&quot;0&quot;,&quot;FileName&quot;:&quot;video_1605367002043.mp4&quot;,&quot;FileSize&quot;:&quot;105.41K&quot;,&quot;FileUrl&quot;:&quot;file/v2/download/d69b3357146a64db27e6e5af2745630f?name\\u003dvideo_1605367002043.mp4&quot;,&quot;Height&quot;:&quot;1552&quot;,&quot;ThumbUrl&quot;:&quot;file/v2/download/2fc935749598b81396b6a619159da94d.jpg?name\\u003d2fc935749598b81396b6a619159da94d.jpg&quot;,&quot;Width&quot;:&quot;720&quot;,&quot;newVideo&quot;:false}</body></message>	2020-11-14 23:16:37.85+08	202	3	a6a6c470-9b21-45b7-9150-9a5a976ef49f	startalk.tech	startalk.tech			chat	2020-11-14 23:16:37.85165+08
100094z	mumu	<message msec_times='1605367049588' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='9942f279-c930-4a75-b83f-48cb807f4b0c' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/ak]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-14 23:17:29.588+08	203	3	9942f279-c930-4a75-b83f-48cb807f4b0c	startalk.tech	startalk.tech			chat	2020-11-14 23:17:29.58969+08
100094z	mumu	<message msec_times='1605367076764' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='4830739e-fb41-498f-a115-6e9b6b55e83f' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/ka]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/ka]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-14 23:17:56.764+08	204	3	4830739e-fb41-498f-a115-6e9b6b55e83f	startalk.tech	startalk.tech			chat	2020-11-14 23:17:56.766017+08
100094z	mumu	<message msec_times='1605367078510' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='5ba6a736-98ff-45e4-98a4-40237166de83' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/dzwx]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-14 23:17:58.51+08	205	3	5ba6a736-98ff-45e4-98a4-40237166de83	startalk.tech	startalk.tech			chat	2020-11-14 23:17:58.511248+08
100094z	mumu	<message msec_times='1605367081115' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='9c8b88bb-ee63-42e1-9084-e3ba727d7cc4' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/dzwx]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-14 23:18:01.115+08	206	3	9c8b88bb-ee63-42e1-9084-e3ba727d7cc4	startalk.tech	startalk.tech			chat	2020-11-14 23:18:01.11868+08
100094z	mumu	<message msec_times='1605367091422' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='e2c82104-0f8f-4d05-a7cb-65f7d850c0b8' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/hhx]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-14 23:18:11.422+08	207	3	e2c82104-0f8f-4d05-a7cb-65f7d850c0b8	startalk.tech	startalk.tech			chat	2020-11-14 23:18:11.423443+08
mumu	100094z	<message msec_times='1605367113633' xml:lang='en' from='mumu@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='41ffe7d7b60a415982fc11796f152d50' msgType='1'>爱华</body></message>	2020-11-14 23:18:33.633+08	208	3	41ffe7d7b60a415982fc11796f152d50	startalk.tech	startalk.tech			chat	2020-11-14 23:18:33.635379+08
100094z	mumu	<message msec_times='1605367224986' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='bc0b2bdd-4517-44f4-b4d6-4a6a6e0a8bf2' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/ak]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-14 23:20:24.986+08	209	3	bc0b2bdd-4517-44f4-b4d6-4a6a6e0a8bf2	startalk.tech	startalk.tech			chat	2020-11-14 23:20:24.987571+08
100094z	mumu	<message msec_times='1605367257843' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='d6a95e8d-f77b-4e21-8b9c-4afaffc756b7' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/hhx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/hhx]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-14 23:20:57.843+08	213	3	d6a95e8d-f77b-4e21-8b9c-4afaffc756b7	startalk.tech	startalk.tech			chat	2020-11-14 23:20:57.844436+08
100094z	mumu	<message msec_times='1605437174087' xml:lang='en' from='100094z@startalk.tech/V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[D3AC1B7D4415412B8400318872B88EFD]_PB' to='mumu@startalk.tech' type='chat' client_type='ClientTypeiOS' client_ver='0'><body id='8D8F4B6A5E05492D9922749EB9137265' msgType='1'>「 珊珊JH:你好 」\n- - - - - - - - - - - - - - -\n你会ooo</body></message>	2020-11-15 18:46:14.087+08	265	3	8D8F4B6A5E05492D9922749EB9137265	startalk.tech	startalk.tech			chat	2020-11-15 18:46:14.089231+08
mumu	mumu	<message msec_times='1605367852964' xml:lang='en' from='mumu@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='e8911484861c4ad5afb3cfbe983de8ee' msgType='1'>99</body></message>	2020-11-14 23:30:52.964+08	236	1	e8911484861c4ad5afb3cfbe983de8ee	startalk.tech	startalk.tech			chat	2020-11-14 23:30:52.968354+08
mumu	100094z	<message msec_times='1605367961979' xml:lang='en' from='mumu@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='fa51d811f8d0469c91e63fd79a726052' msgType='1'>dd</body></message>	2020-11-14 23:32:41.979+08	237	3	fa51d811f8d0469c91e63fd79a726052	startalk.tech	startalk.tech			chat	2020-11-14 23:32:41.983513+08
100094z	mumu	<message msec_times='1605499470787' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='55a1d494-3fd2-4684-8516-3678b373a20e' msgType='2'>{&quot;FileName&quot;:&quot;f3d43823-fee7-4012-ade0-27c60d1059c8.aar&quot;,&quot;FilePath&quot;:&quot;/data/user/0/com.qunar.im.startalk/files/qvoice/qvoice.tmp&quot;,&quot;HttpUrl&quot;:&quot;file/v2/download/d66229db8c101fa7eb628114cbe2d626?name\\u003dqvoice.tmp&quot;,&quot;Seconds&quot;:2,&quot;s&quot;:0}</body></message>	2020-11-16 12:04:30.787+08	282	3	55a1d494-3fd2-4684-8516-3678b373a20e	startalk.tech	startalk.tech			chat	2020-11-16 12:04:30.788675+08
mumu	100094z	<message msec_times='1605367986794' xml:lang='en' from='mumu@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='40caac6595b44df6a3118cc961cdeff9' msgType='1'>订单</body></message>	2020-11-14 23:33:06.794+08	238	3	40caac6595b44df6a3118cc961cdeff9	startalk.tech	startalk.tech			chat	2020-11-14 23:33:06.798033+08
100094z	mumu	<message msec_times='1605367989010' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='b894add8-ff51-4e02-9d4b-9d9ff36b91f3' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-14 23:33:09.01+08	239	3	b894add8-ff51-4e02-9d4b-9d9ff36b91f3	startalk.tech	startalk.tech			chat	2020-11-14 23:33:09.011955+08
100094z	mumu	<message msec_times='1605499497768' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='8b86f648-9631-49c5-a01d-d27193b8220b' msgType='2'>{&quot;FileName&quot;:&quot;e2a8dfb3-5bcb-4bb4-b495-a720872e1eb2.aar&quot;,&quot;FilePath&quot;:&quot;/data/user/0/com.qunar.im.startalk/files/qvoice/qvoice.tmp&quot;,&quot;HttpUrl&quot;:&quot;file/v2/download/49f55c806b6b2fc6c2b641439b354932?name\\u003dqvoice.tmp&quot;,&quot;Seconds&quot;:2,&quot;s&quot;:0}</body></message>	2020-11-16 12:04:57.768+08	283	3	8b86f648-9631-49c5-a01d-d27193b8220b	startalk.tech	startalk.tech			chat	2020-11-16 12:04:57.770294+08
100096z	mumu	<message msec_times='1605499663826' xml:lang='en' from='100096z@startalk.tech/V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[D1C6A5D8AE2F40CCB13DDEFE21820404]_PB' to='mumu@startalk.tech' type='chat' client_type='ClientTypeiOS' client_ver='0'><body id='45B1C6DD94304C0CBDC9D3D5C2DF0337' msgType='1'>你好</body></message>	2020-11-16 12:07:43.826+08	284	3	45B1C6DD94304C0CBDC9D3D5C2DF0337	startalk.tech	startalk.tech			chat	2020-11-16 12:07:43.827507+08
mumu	100094z	<message msec_times='1605368262640' xml:lang='en' from='mumu@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='6a9095e45d13433c8549e2588bc3fb5f' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/tp]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-11-14 23:37:42.64+08	240	3	6a9095e45d13433c8549e2588bc3fb5f	startalk.tech	startalk.tech			chat	2020-11-14 23:37:42.64358+08
mumu	100094z	<message msec_times='1605368270151' xml:lang='en' from='mumu@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='7a0aef3d73b746a6aa9a77874c3f9de0' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/byqq]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-11-14 23:37:50.151+08	241	3	7a0aef3d73b746a6aa9a77874c3f9de0	startalk.tech	startalk.tech			chat	2020-11-14 23:37:50.154381+08
100094z	100095z	<message type='revoke' to='100095z@startalk.tech' msec_times='1605442912382'><body id='E0B0754888AE422C8041CA0792B7DB71' msgType='-1' extendInfo='{&quot;messageId&quot;:&quot;E0B0754888AE422C8041CA0792B7DB71&quot;,&quot;fromId&quot;:&quot;100094z@startalk.tech/V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[65EC5D9601E34A089862F3D5F5E06285]_PB&quot;}'>[撤销一条消息]</body><stime xmlns='jabber:stime:delay' stamp='20201115T12:21:52'/></message>	2020-11-15 20:21:52.382+08	278	3	E0B0754888AE422C8041CA0792B7DB71	startalk.tech	startalk.tech			chat	2020-11-15 20:21:41.945526+08
100094z	100095z	<message msec_times='1605499423020' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='32ea9fb7-052c-490b-b9bd-b05fde9198b2' msgType='2'>{&quot;FileName&quot;:&quot;eee304f8-2833-44c3-8a02-eeb57c59ac2c.aar&quot;,&quot;FilePath&quot;:&quot;/data/user/0/com.qunar.im.startalk/files/qvoice/qvoice.tmp&quot;,&quot;HttpUrl&quot;:&quot;file/v2/download/9518f391968f16a510e7afa89639ce36?name\\u003dqvoice.tmp&quot;,&quot;Seconds&quot;:4,&quot;s&quot;:0}</body></message>	2020-11-16 12:03:43.02+08	281	3	32ea9fb7-052c-490b-b9bd-b05fde9198b2	startalk.tech	startalk.tech			chat	2020-11-16 12:03:43.021901+08
100004q	100013v	<message msec_times='1605619115291' xml:lang='en' from='100004q@startalk.tech' to='100013v@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='50529e51-1bab-4d29-97d5-c0c435a27624' msgType='1'>之后，好好学习</body></message>	2020-11-17 21:18:35.291+08	293	3	50529e51-1bab-4d29-97d5-c0c435a27624	startalk.tech	startalk.tech			chat	2020-11-17 21:18:35.29268+08
test01	100013v	<message msec_times='1605660370638' xml:lang='en' from='test01@startalk.tech' to='100013v@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='cde2cf6c-9ffb-42d6-9668-cec779a10e8b' msgType='1'>怒火</body></message>	2020-11-18 08:46:10.638+08	297	3	cde2cf6c-9ffb-42d6-9668-cec779a10e8b	startalk.tech	startalk.tech			chat	2020-11-18 08:46:10.639313+08
test01	file-transfer	<message msec_times='1605662091826' xml:lang='en' from='test01@startalk.tech' to='file-transfer@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='a1db4442-a07e-4285-bade-0b9f87d657a9' msgType='3'>[obj type=&quot;image&quot; value=&quot;file/v2/download/dd9fd3b12ae3bd4fc948a034d28e4e31.jpg?name=Screenshot_20201117_202924_com.tencent.mm.jpg&quot; width=1080 height=2340]</body></message>	2020-11-18 09:14:51.826+08	334	0	a1db4442-a07e-4285-bade-0b9f87d657a9	startalk.tech	startalk.tech			chat	2020-11-18 09:14:51.828012+08
mumu	100094z	<message msec_times='1605368299244' xml:lang='en' from='mumu@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='5c951d609e3f452fb0a5e6315403a274' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/lzx]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-11-14 23:38:19.244+08	243	3	5c951d609e3f452fb0a5e6315403a274	startalk.tech	startalk.tech			chat	2020-11-14 23:38:19.248017+08
mumu	100094z	<message msec_times='1605368302443' xml:lang='en' from='mumu@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='b187cd28a051498c880e3481645e0e72' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/byqq]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-11-14 23:38:22.443+08	244	3	b187cd28a051498c880e3481645e0e72	startalk.tech	startalk.tech			chat	2020-11-14 23:38:22.447275+08
mumu	mumu	<message msec_times='1605368369181' xml:lang='en' from='mumu@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='2a07cd6fc7744ff3940a99439170cbef' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/byqq]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-11-14 23:39:29.181+08	245	1	2a07cd6fc7744ff3940a99439170cbef	startalk.tech	startalk.tech			chat	2020-11-14 23:39:29.184752+08
mumu	100094z	<message msec_times='1605368378497' xml:lang='en' from='mumu@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='801b9659b25140e19d8cd5b19382533b' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/byqq]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-11-14 23:39:38.497+08	247	3	801b9659b25140e19d8cd5b19382533b	startalk.tech	startalk.tech			chat	2020-11-14 23:39:38.500588+08
mumu	100094z	<message msec_times='1605368416415' xml:lang='en' from='mumu@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='68e59950c33d4a6488e736ac004e5c60' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/lzx]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-11-14 23:40:16.415+08	248	3	68e59950c33d4a6488e736ac004e5c60	startalk.tech	startalk.tech			chat	2020-11-14 23:40:16.418853+08
100094z	mumu	<message msec_times='1605368429776' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='e5ba27fe-f5ba-4b83-a02b-2ac6a834c0d9' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/ak]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-14 23:40:29.776+08	249	3	e5ba27fe-f5ba-4b83-a02b-2ac6a834c0d9	startalk.tech	startalk.tech			chat	2020-11-14 23:40:29.777917+08
100094z	mumu	<message msec_times='1605368431922' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='43aa4b7f-6fab-4633-a8fd-9630fb66999f' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/fn]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-14 23:40:31.922+08	250	3	43aa4b7f-6fab-4633-a8fd-9630fb66999f	startalk.tech	startalk.tech			chat	2020-11-14 23:40:31.923809+08
100094z	mumu	<message msec_times='1605368432951' xml:lang='en' from='100094z@startalk.tech' to='mumu@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='46736ec8-9d51-4512-9ac9-6df7ebe4b0b1' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-14 23:40:32.951+08	251	3	46736ec8-9d51-4512-9ac9-6df7ebe4b0b1	startalk.tech	startalk.tech			chat	2020-11-14 23:40:32.95293+08
100094z	file-transfer	<message msec_times='1605368935382' xml:lang='en' from='100094z@startalk.tech' to='file-transfer@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='57f6285c-f3f1-48ed-8953-8733436e7943' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/fn]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-14 23:48:55.382+08	252	0	57f6285c-f3f1-48ed-8953-8733436e7943	startalk.tech	startalk.tech			chat	2020-11-14 23:48:55.383627+08
100094z	100095z	<message msec_times='1605063395048' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;FILEID&quot;:&quot;9a22ff5b06584b77b014c56980e29a54&quot;,&quot;FileName&quot;:&quot;测试.xlsx&quot;,&quot;FileSize&quot;:&quot;6.19KB&quot;,&quot;FILEMD5&quot;:&quot;e3ec9e1c03e3c656c1758182a2ca881b&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/e3ec9e1c03e3c656c1758182a2ca881b?name=e3ec9e1c03e3c656c1758182a2ca881b.xlsx&quot;}' id='9a22ff5b06584b77b014c56980e29a54' msgType='5'>{&quot;FILEID&quot;:&quot;9a22ff5b06584b77b014c56980e29a54&quot;,&quot;FileName&quot;:&quot;测试.xlsx&quot;,&quot;FileSize&quot;:&quot;6.19KB&quot;,&quot;FILEMD5&quot;:&quot;e3ec9e1c03e3c656c1758182a2ca881b&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/e3ec9e1c03e3c656c1758182a2ca881b?name=e3ec9e1c03e3c656c1758182a2ca881b.xlsx&quot;}</body></message>	2020-11-11 10:56:35.048+08	178	1	9a22ff5b06584b77b014c56980e29a54	startalk.tech	startalk.tech			chat	2020-11-11 10:56:35.049979+08
100094z	100095z	<message msec_times='1605065031151' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;title&quot;:&quot;测试一家的聊天记录&quot;,&quot;desc&quot;:&quot;&quot;,&quot;linkurl&quot;:&quot;http://im.startalk.tech:8080/py/sharemsg?jdata=aHR0cHM6Ly9pbS5zdGFydGFsay50ZWNoOjg0NDMvZmlsZS92Mi9kb3dubG9hZC9lMGVlYWI4OGU1NDlhMDFhZjM5ZGJhMjBiZTRkMzA4Mz9uYW1lPWUwZWVhYjg4ZTU0OWEwMWFmMzlkYmEyMGJlNGQzMDgzLg==&quot;}' id='a9dc7f7feccf4e32b0994a50b43c52f1' msgType='666'>收到了一个消息记录文件文件，请升级客户端查看。</body></message>	2020-11-11 11:23:51.151+08	180	1	a9dc7f7feccf4e32b0994a50b43c52f1	startalk.tech	startalk.tech			chat	2020-11-11 11:23:51.152955+08
100094z	100095z	<message msec_times='1605065422333' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;title&quot;:&quot;测试一家的聊天记录&quot;,&quot;desc&quot;:&quot;&quot;,&quot;linkurl&quot;:&quot;http://im.startalk.tech:8080/py/sharemsg?jdata=aHR0cHM6Ly9pbS5zdGFydGFsay50ZWNoOjg0NDMvZmlsZS92Mi9kb3dubG9hZC84ZmI0ZmE5ZWZhZWVjMTY0M2RmZDFhN2IxODQzNTQzYj9uYW1lPThmYjRmYTllZmFlZWMxNjQzZGZkMWE3YjE4NDM1NDNiLg==&quot;}' id='8ed09fdb37034da79788fdc7eac52958' msgType='666'>收到了一个消息记录文件文件，请升级客户端查看。</body></message>	2020-11-11 11:30:22.333+08	181	1	8ed09fdb37034da79788fdc7eac52958	startalk.tech	startalk.tech			chat	2020-11-11 11:30:22.33478+08
mumu	100094z	<message msec_times='1605368373296' xml:lang='en' from='mumu@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='ffaab7c3df8340f9aa854ee366e08e43' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/hxqq]&quot; width=EmojiOne height=EmojiOne ]</body></message>	2020-11-14 23:39:33.296+08	246	3	ffaab7c3df8340f9aa854ee366e08e43	startalk.tech	startalk.tech			chat	2020-11-14 23:39:33.299818+08
100094z	100095z	<message msec_times='1605185449105' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;title&quot;:&quot;测试一家的聊天记录&quot;,&quot;desc&quot;:&quot;&quot;,&quot;linkurl&quot;:&quot;http://im.startalk.tech:8080/py/sharemsg?jdata=aHR0cHM6Ly9pbS5zdGFydGFsay50ZWNoOjg0NDMvZmlsZS92Mi9kb3dubG9hZC82ODU3ZDUwN2NhNTQzZjZjNjc1YTBiNzNkNzI4MDk4Zj9uYW1lPTY4NTdkNTA3Y2E1NDNmNmM2NzVhMGI3M2Q3MjgwOThmLg==&quot;}' id='a37b0b64d5dc47b4815d3d1d14462fa4' msgType='666'>收到了一个消息记录文件文件，请升级客户端查看。</body></message>	2020-11-12 20:50:49.105+08	183	1	a37b0b64d5dc47b4815d3d1d14462fa4	startalk.tech	startalk.tech			chat	2020-11-12 20:50:49.10672+08
100094z	100095z	<message msec_times='1605185544361' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;FILEID&quot;:&quot;c3558406cbd5406db46d982207c624fb&quot;,&quot;FileName&quot;:&quot;nodejs版本星语测试（2020.11.10）.xlsx&quot;,&quot;FileSize&quot;:&quot;15.29KB&quot;,&quot;FILEMD5&quot;:&quot;41310521928eb23a6da71debfac74cdf&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/41310521928eb23a6da71debfac74cdf?name=41310521928eb23a6da71debfac74cdf.xlsx&quot;}' id='c3558406cbd5406db46d982207c624fb' msgType='5'>{&quot;FILEID&quot;:&quot;c3558406cbd5406db46d982207c624fb&quot;,&quot;FileName&quot;:&quot;nodejs版本星语测试（2020.11.10）.xlsx&quot;,&quot;FileSize&quot;:&quot;15.29KB&quot;,&quot;FILEMD5&quot;:&quot;41310521928eb23a6da71debfac74cdf&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/41310521928eb23a6da71debfac74cdf?name=41310521928eb23a6da71debfac74cdf.xlsx&quot;}</body></message>	2020-11-12 20:52:24.361+08	184	1	c3558406cbd5406db46d982207c624fb	startalk.tech	startalk.tech			chat	2020-11-12 20:52:24.362546+08
100094z	100095z	<message msec_times='1605185566834' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;FILEID&quot;:&quot;56e7a6e22a7a4c7c847109571bfe711c&quot;,&quot;FileName&quot;:&quot;测试.xlsx&quot;,&quot;FileSize&quot;:&quot;6.19KB&quot;,&quot;FILEMD5&quot;:&quot;e3ec9e1c03e3c656c1758182a2ca881b&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/e3ec9e1c03e3c656c1758182a2ca881b?name=e3ec9e1c03e3c656c1758182a2ca881b.xlsx&quot;}' id='56e7a6e22a7a4c7c847109571bfe711c' msgType='5'>{&quot;FILEID&quot;:&quot;56e7a6e22a7a4c7c847109571bfe711c&quot;,&quot;FileName&quot;:&quot;测试.xlsx&quot;,&quot;FileSize&quot;:&quot;6.19KB&quot;,&quot;FILEMD5&quot;:&quot;e3ec9e1c03e3c656c1758182a2ca881b&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/e3ec9e1c03e3c656c1758182a2ca881b?name=e3ec9e1c03e3c656c1758182a2ca881b.xlsx&quot;}</body></message>	2020-11-12 20:52:46.834+08	185	1	56e7a6e22a7a4c7c847109571bfe711c	startalk.tech	startalk.tech			chat	2020-11-12 20:52:46.835681+08
100094z	100095z	<message msec_times='1605185717237' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;FILEID&quot;:&quot;0944d4dba497416c8e482dd9967bb1f9&quot;,&quot;FileName&quot;:&quot;test.txt&quot;,&quot;FileSize&quot;:&quot;0.00KB&quot;,&quot;FILEMD5&quot;:&quot;004881ebe3826cf16cfd124968f2a5bb&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/004881ebe3826cf16cfd124968f2a5bb?name=004881ebe3826cf16cfd124968f2a5bb.txt&quot;}' id='0944d4dba497416c8e482dd9967bb1f9' msgType='5'>{&quot;FILEID&quot;:&quot;0944d4dba497416c8e482dd9967bb1f9&quot;,&quot;FileName&quot;:&quot;test.txt&quot;,&quot;FileSize&quot;:&quot;0.00KB&quot;,&quot;FILEMD5&quot;:&quot;004881ebe3826cf16cfd124968f2a5bb&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/004881ebe3826cf16cfd124968f2a5bb?name=004881ebe3826cf16cfd124968f2a5bb.txt&quot;}</body></message>	2020-11-12 20:55:17.237+08	186	1	0944d4dba497416c8e482dd9967bb1f9	startalk.tech	startalk.tech			chat	2020-11-12 20:55:17.238575+08
100094z	100095z	<message msec_times='1605185910229' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;title&quot;:&quot;测试一家的聊天记录&quot;,&quot;desc&quot;:&quot;&quot;,&quot;linkurl&quot;:&quot;http://im.startalk.tech:8080/py/sharemsg?jdata=aHR0cHM6Ly9pbS5zdGFydGFsay50ZWNoOjg0NDMvZmlsZS92Mi9kb3dubG9hZC9jMWVkZDIyZGRlYWM0MDM1ZDExYmE2ZGUyZjk3YjAzNT9uYW1lPWMxZWRkMjJkZGVhYzQwMzVkMTFiYTZkZTJmOTdiMDM1Lg==&quot;}' id='30fdbbcf648540ab8663a1d6039c66a8' msgType='666'>收到了一个消息记录文件文件，请升级客户端查看。</body></message>	2020-11-12 20:58:30.229+08	187	1	30fdbbcf648540ab8663a1d6039c66a8	startalk.tech	startalk.tech			chat	2020-11-12 20:58:30.231335+08
mumu	100095z	<message msec_times='1605190595956' xml:lang='en' from='mumu@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;title&quot;:&quot;hhh的聊天记录&quot;,&quot;desc&quot;:&quot;&quot;,&quot;linkurl&quot;:&quot;https://im.startalk.tech:8443/py/sharemsg?jdata=aHR0cHM6Ly9pbS5zdGFydGFsay50ZWNoOjg0NDMvZmlsZS92Mi9kb3dubG9hZC9jNWFmM2ZmMmFkZjA5ZGZjMjYwYzJkNmE5Mzk4NzViYz9uYW1lPWM1YWYzZmYyYWRmMDlkZmMyNjBjMmQ2YTkzOTg3NWJjLg==&quot;}' id='6e4f7171a25b4661a0739080f79699b8' msgType='666'>收到了一个消息记录文件文件，请升级客户端查看。</body></message>	2020-11-12 22:16:35.956+08	189	1	6e4f7171a25b4661a0739080f79699b8	startalk.tech	startalk.tech			chat	2020-11-12 22:16:35.957083+08
mumu	100095z	<message msec_times='1605190672429' xml:lang='en' from='mumu@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;title&quot;:&quot;test22的聊天记录&quot;,&quot;desc&quot;:&quot;&quot;,&quot;linkurl&quot;:&quot;https://im.startalk.tech:8443/py/sharemsg?jdata=aHR0cHM6Ly9pbS5zdGFydGFsay50ZWNoOjg0NDMvZmlsZS92Mi9kb3dubG9hZC9iODVjOTBjZTdiMWJkNThmZjNjNzc2ODg3MGYyMmIxND9uYW1lPWI4NWM5MGNlN2IxYmQ1OGZmM2M3NzY4ODcwZjIyYjE0Lg==&quot;}' id='adca415ebabc49fd88e3a019042dd025' msgType='666'>收到了一个消息记录文件文件，请升级客户端查看。</body></message>	2020-11-12 22:17:52.429+08	190	1	adca415ebabc49fd88e3a019042dd025	startalk.tech	startalk.tech			chat	2020-11-12 22:17:52.431223+08
mumu	100095z	<message msec_times='1605190695545' xml:lang='en' from='mumu@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;title&quot;:&quot;JH伽勒和沐沐的聊天记录&quot;,&quot;desc&quot;:&quot;&quot;,&quot;linkurl&quot;:&quot;https://im.startalk.tech:8443/py/sharemsg?jdata=aHR0cHM6Ly9pbS5zdGFydGFsay50ZWNoOjg0NDMvZmlsZS92Mi9kb3dubG9hZC9jMDEwOTVkNTAxMDlmYWZhNjUxZjNiYTA5NDM4Mzk3Mj9uYW1lPWMwMTA5NWQ1MDEwOWZhZmE2NTFmM2JhMDk0MzgzOTcyLg==&quot;}' id='eb001ed19be14331a72000492d7ddad6' msgType='666'>收到了一个消息记录文件文件，请升级客户端查看。</body></message>	2020-11-12 22:18:15.545+08	191	1	eb001ed19be14331a72000492d7ddad6	startalk.tech	startalk.tech			chat	2020-11-12 22:18:15.546843+08
100013v	test01	<message msec_times='1605660261898' xml:lang='en' from='100013v@startalk.tech' to='test01@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='a5318036-81cb-4113-a7a8-1a4e48e9ddf3' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-18 08:44:21.898+08	295	3	a5318036-81cb-4113-a7a8-1a4e48e9ddf3	startalk.tech	startalk.tech			chat	2020-11-18 08:44:21.89955+08
mumu	100095z	<message msec_times='1605367372421' xml:lang='en' from='mumu@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='fc94cf5203f14f10ac531a467184abe6' msgType='1'>yyy</body></message>	2020-11-14 23:22:52.421+08	219	3	fc94cf5203f14f10ac531a467184abe6	startalk.tech	startalk.tech			chat	2020-11-14 23:22:52.423282+08
100094z	100095z	<message msec_times='1605435563173' xml:lang='en' from='100094z@startalk.tech/V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[F0B8AAE473EB40B491C77E925CE7C667]_PB' to='100095z@startalk.tech' type='chat' client_type='ClientTypeiOS' client_ver='0'><body extendInfo='{&quot;width&quot;:0,&quot;shortcut&quot;:&quot;ca04c6890cd7b54472afa6014649b095&quot;,&quot;height&quot;:0,&quot;pkgid&quot;:&quot;qunar_camel&quot;,&quot;url&quot;:&quot;&quot;}' id='6F18C5BD844D49E88DD3F4A892975B18' msgType='30'>[obj type=&quot;emoticon&quot; value=&quot;[ca04c6890cd7b54472afa6014649b095]&quot; width=qunar_camel height=0 ]</body></message>	2020-11-15 18:19:23.173+08	253	3	6F18C5BD844D49E88DD3F4A892975B18	startalk.tech	startalk.tech			chat	2020-11-15 18:19:23.175181+08
100095z	mumu	<message msec_times='1605507281709' xml:lang='en' from='100095z@startalk.tech/V[3140670]_P[iOS]_D[iPhone12,8]_S[13.6.1]_ID[DC85BB334501428F9F57013921143DCF]_PB' to='mumu@startalk.tech' type='chat' client_type='ClientTypeiOS' client_ver='0'><body extendInfo='{&quot;filepath&quot;:&quot;\\/var\\/mobile\\/Containers\\/Data\\/Application\\/F42CD75B-F245-484E-B9B5-1F1120128EBA\\/Library\\/Caches\\/QIMVoice\\/838FBF0F4F7D46978F83C0E561596C06.amr&quot;,&quot;FileName&quot;:&quot;838FBF0F4F7D46978F83C0E561596C06&quot;,&quot;HttpUrl&quot;:&quot;https:\\/\\/im.startalk.tech:8443\\/file\\/v2\\/download\\/E12BF598A75A7F2EF46F7565BB89D389?name=E12BF598A75A7F2EF46F7565BB89D389.amr&quot;,&quot;Seconds&quot;:2}' id='7F3F01CCE6AE4A05B7A9B7C7BFCFF564' msgType='2'>当前客户端版本不支持语音消息</body></message>	2020-11-16 14:14:41.709+08	285	0	7F3F01CCE6AE4A05B7A9B7C7BFCFF564	startalk.tech	startalk.tech			chat	2020-11-16 14:14:41.710397+08
100094z	100095z	<message msec_times='1605498937851' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body extendInfo='{&quot;FILEID&quot;:&quot;0c34b8928abf4fc596e5985f966420ae&quot;,&quot;FileName&quot;:&quot;Track1.amr&quot;,&quot;FileSize&quot;:&quot;5.13KB&quot;,&quot;FILEMD5&quot;:&quot;b3df88399069e7146280203690e28221&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/b3df88399069e7146280203690e28221?name=b3df88399069e7146280203690e28221.amr&quot;}' id='ee040014-b4a6-4d70-a38a-669f6803c3ed' msgType='5'>{&quot;FILEID&quot;:&quot;0c34b8928abf4fc596e5985f966420ae&quot;,&quot;FileName&quot;:&quot;Track1.amr&quot;,&quot;FileSize&quot;:&quot;5.13KB&quot;,&quot;FILEMD5&quot;:&quot;b3df88399069e7146280203690e28221&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/b3df88399069e7146280203690e28221?name=b3df88399069e7146280203690e28221.amr&quot;}</body></message>	2020-11-16 11:55:37.851+08	280	3	ee040014-b4a6-4d70-a38a-669f6803c3ed	startalk.tech	startalk.tech			chat	2020-11-16 11:55:37.852541+08
100013v	100004q	<message msec_times='1605619276935' xml:lang='en' from='100013v@startalk.tech' to='100004q@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='15612d6c-59c4-42f9-84e0-47ea44eafc16' msgType='1'>明白，会好好跟着的</body></message>	2020-11-17 21:21:16.935+08	294	3	15612d6c-59c4-42f9-84e0-47ea44eafc16	startalk.tech	startalk.tech			chat	2020-11-17 21:21:16.936589+08
100094z	100095z	<message msec_times='1605435566394' xml:lang='en' from='100094z@startalk.tech/V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[F0B8AAE473EB40B491C77E925CE7C667]_PB' to='100095z@startalk.tech' type='chat' client_type='ClientTypeiOS' client_ver='0'><body extendInfo='{&quot;width&quot;:0,&quot;shortcut&quot;:&quot;2af594981a571f724f684e8bf6267198&quot;,&quot;height&quot;:0,&quot;pkgid&quot;:&quot;qunar_camel&quot;,&quot;url&quot;:&quot;&quot;}' id='30BE94DDB9594A65A6F79CADB36C4935' msgType='30'>[obj type=&quot;emoticon&quot; value=&quot;[2af594981a571f724f684e8bf6267198]&quot; width=qunar_camel height=0 ]</body></message>	2020-11-15 18:19:26.394+08	254	3	30BE94DDB9594A65A6F79CADB36C4935	startalk.tech	startalk.tech			chat	2020-11-15 18:19:26.39578+08
100094z	100095z	<message msec_times='1605435566631' xml:lang='en' from='100094z@startalk.tech/V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[F0B8AAE473EB40B491C77E925CE7C667]_PB' to='100095z@startalk.tech' type='chat' client_type='ClientTypeiOS' client_ver='0'><body extendInfo='{&quot;width&quot;:0,&quot;shortcut&quot;:&quot;2af594981a571f724f684e8bf6267198&quot;,&quot;height&quot;:0,&quot;pkgid&quot;:&quot;qunar_camel&quot;,&quot;url&quot;:&quot;&quot;}' id='CC43647D520545608BA084F3EF8E1F94' msgType='30'>[obj type=&quot;emoticon&quot; value=&quot;[2af594981a571f724f684e8bf6267198]&quot; width=qunar_camel height=0 ]</body></message>	2020-11-15 18:19:26.631+08	255	3	CC43647D520545608BA084F3EF8E1F94	startalk.tech	startalk.tech			chat	2020-11-15 18:19:26.632643+08
100094z	100095z	<message msec_times='1605435572953' xml:lang='en' from='100094z@startalk.tech/V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[F0B8AAE473EB40B491C77E925CE7C667]_PB' to='100095z@startalk.tech' type='chat' client_type='ClientTypeiOS' client_ver='0'><body id='810D60092072420AB6BEE9B0506C0081' msgType='1'>😇😇</body></message>	2020-11-15 18:19:32.953+08	256	3	810D60092072420AB6BEE9B0506C0081	startalk.tech	startalk.tech			chat	2020-11-15 18:19:32.955+08
test01	100013v	<message msec_times='1605660369047' xml:lang='en' from='test01@startalk.tech' to='100013v@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='83ef7916-9fbd-4724-8f36-6731b5848477' msgType='1'>怒火</body></message>	2020-11-18 08:46:09.047+08	296	3	83ef7916-9fbd-4724-8f36-6731b5848477	startalk.tech	startalk.tech			chat	2020-11-18 08:46:09.048236+08
100094z	100095z	<message msec_times='1605436724579' xml:lang='en' from='100094z@startalk.tech/V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[75663A7CB4A64F13869B97367EF8BF13]_PB' to='100095z@startalk.tech' type='chat' client_type='ClientTypeiOS' client_ver='0'><body extendInfo='{&quot;width&quot;:0,&quot;shortcut&quot;:&quot;eda23d07c90645fe339935d393fdef5c&quot;,&quot;height&quot;:0,&quot;pkgid&quot;:&quot;qunar_camel&quot;,&quot;url&quot;:&quot;&quot;}' id='E75576856D4C4F2395E03DA609C5072F' msgType='30'>[obj type=&quot;emoticon&quot; value=&quot;[eda23d07c90645fe339935d393fdef5c]&quot; width=qunar_camel height=0 ]</body></message>	2020-11-15 18:38:44.579+08	257	3	E75576856D4C4F2395E03DA609C5072F	startalk.tech	startalk.tech			chat	2020-11-15 18:38:44.580201+08
100094z	100095z	<message msec_times='1605436736832' xml:lang='en' from='100094z@startalk.tech/V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[75663A7CB4A64F13869B97367EF8BF13]_PB' to='100095z@startalk.tech' type='chat' client_type='ClientTypeiOS' client_ver='0'><body extendInfo='{&quot;width&quot;:0,&quot;shortcut&quot;:&quot;bf63c198ffdee0619dbfb5b761e91681&quot;,&quot;height&quot;:0,&quot;pkgid&quot;:&quot;qunar_camel&quot;,&quot;url&quot;:&quot;&quot;}' id='2613CEA2340E4C96AC12402F9FA3B7DA' msgType='30'>[obj type=&quot;emoticon&quot; value=&quot;[bf63c198ffdee0619dbfb5b761e91681]&quot; width=qunar_camel height=0 ]</body></message>	2020-11-15 18:38:56.832+08	258	3	2613CEA2340E4C96AC12402F9FA3B7DA	startalk.tech	startalk.tech			chat	2020-11-15 18:38:56.833341+08
100094z	100095z	<message msec_times='1605437112546' xml:lang='en' from='100094z@startalk.tech/V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[D3AC1B7D4415412B8400318872B88EFD]_PB' to='100095z@startalk.tech' type='chat' client_type='ClientTypeiOS' client_ver='0'><body extendInfo='{&quot;FILEID&quot;:&quot;cd2dc161cd8b4b138dc4ef4cfb1d26fc&quot;,&quot;FileName&quot;:&quot;20201111_110634.m4a&quot;,&quot;FileSize&quot;:&quot;72.29KB&quot;,&quot;FILEMD5&quot;:&quot;c65ef5efdc86873d337c3610e382295f&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/c65ef5efdc86873d337c3610e382295f?name=c65ef5efdc86873d337c3610e382295f.m4a&quot;}' id='3EC08022DBFF45188BE735B3FB97E60F' msgType='5'>{&quot;FILEID&quot;:&quot;cd2dc161cd8b4b138dc4ef4cfb1d26fc&quot;,&quot;FileName&quot;:&quot;20201111_110634.m4a&quot;,&quot;FileSize&quot;:&quot;72.29KB&quot;,&quot;FILEMD5&quot;:&quot;c65ef5efdc86873d337c3610e382295f&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/c65ef5efdc86873d337c3610e382295f?name=c65ef5efdc86873d337c3610e382295f.m4a&quot;}</body></message>	2020-11-15 18:45:12.546+08	259	3	3EC08022DBFF45188BE735B3FB97E60F	startalk.tech	startalk.tech			chat	2020-11-15 18:45:12.54763+08
100094z	100095z	<message type='revoke' to='100095z@startalk.tech' msec_times='1605437126597'><body id='E93220B8D9DD462BAB7A902AB529EBEF' msgType='-1' extendInfo='{&quot;messageId&quot;:&quot;E93220B8D9DD462BAB7A902AB529EBEF&quot;,&quot;fromId&quot;:&quot;100094z@startalk.tech/V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[D3AC1B7D4415412B8400318872B88EFD]_PB&quot;}'>[撤销一条消息]</body><stime xmlns='jabber:stime:delay' stamp='20201115T10:45:26'/></message>	2020-11-15 18:45:26.597+08	260	3	E93220B8D9DD462BAB7A902AB529EBEF	startalk.tech	startalk.tech			chat	2020-11-15 18:45:12.591382+08
100004q	100094z	<message msec_times='1605618576548' xml:lang='en' from='100004q@startalk.tech' to='100094z@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='25ed843c-cbee-4af9-9913-66b73a8e28ec' msgType='1'>你好</body></message>	2020-11-17 21:09:36.548+08	287	3	25ed843c-cbee-4af9-9913-66b73a8e28ec	startalk.tech	startalk.tech			chat	2020-11-17 21:09:36.549982+08
100094z	100095z	<message msec_times='1605437137473' xml:lang='en' from='100094z@startalk.tech/V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[D3AC1B7D4415412B8400318872B88EFD]_PB' to='100095z@startalk.tech' type='chat' client_type='ClientTypeiOS' client_ver='0'><body id='721A28365E3C453EAE83068A3BF8BD9A' msgType='1'>你好</body></message>	2020-11-15 18:45:37.473+08	261	3	721A28365E3C453EAE83068A3BF8BD9A	startalk.tech	startalk.tech			chat	2020-11-15 18:45:37.475145+08
100094z	100095z	<message msec_times='1605437144059' xml:lang='en' from='100094z@startalk.tech/V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[D3AC1B7D4415412B8400318872B88EFD]_PB' to='100095z@startalk.tech' type='chat' client_type='ClientTypeiOS' client_ver='0'><body id='BCF4D5BF8B434066A0073AD550839852' msgType='1'>你好</body></message>	2020-11-15 18:45:44.059+08	262	3	BCF4D5BF8B434066A0073AD550839852	startalk.tech	startalk.tech			chat	2020-11-15 18:45:44.061198+08
100094z	mumu	<message msec_times='1605437158708' xml:lang='en' from='100094z@startalk.tech/V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[D3AC1B7D4415412B8400318872B88EFD]_PB' to='mumu@startalk.tech' type='chat' client_type='ClientTypeiOS' client_ver='0'><body id='6E7C7B21DA644426BD57A79C4D6E7882' msgType='1'>你好</body></message>	2020-11-15 18:45:58.708+08	264	3	6E7C7B21DA644426BD57A79C4D6E7882	startalk.tech	startalk.tech			chat	2020-11-15 18:45:58.709811+08
100095z	mumu	<message msec_times='1605590484150' xml:lang='en' from='100095z@startalk.tech/V[3140670]_P[iOS]_D[iPhone12,8]_S[13.6.1]_ID[07DE2DB2362F49EBA09E2336139B9292]_PB' to='mumu@startalk.tech' type='chat' client_type='ClientTypeiOS' client_ver='0'><body extendInfo='{&quot;FILEID&quot;:&quot;0c34b8928abf4fc596e5985f966420ae&quot;,&quot;FileName&quot;:&quot;Track1.amr&quot;,&quot;FileSize&quot;:&quot;5.13KB&quot;,&quot;FILEMD5&quot;:&quot;b3df88399069e7146280203690e28221&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/b3df88399069e7146280203690e28221?name=b3df88399069e7146280203690e28221.amr&quot;}' id='DDD432F02C184153ADBB1FCC4ABBC15B' msgType='5'>{&quot;FILEID&quot;:&quot;0c34b8928abf4fc596e5985f966420ae&quot;,&quot;FileName&quot;:&quot;Track1.amr&quot;,&quot;FileSize&quot;:&quot;5.13KB&quot;,&quot;FILEMD5&quot;:&quot;b3df88399069e7146280203690e28221&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/b3df88399069e7146280203690e28221?name=b3df88399069e7146280203690e28221.amr&quot;}</body></message>	2020-11-17 13:21:24.15+08	286	0	DDD432F02C184153ADBB1FCC4ABBC15B	startalk.tech	startalk.tech			chat	2020-11-17 13:21:24.152118+08
100004q	100013v	<message msec_times='1605618729433' xml:lang='en' from='100004q@startalk.tech' to='100013v@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='a449ae50-3440-4d7c-8ef1-2c7de123a91e' msgType='1'>你好</body></message>	2020-11-17 21:12:09.433+08	288	3	a449ae50-3440-4d7c-8ef1-2c7de123a91e	startalk.tech	startalk.tech			chat	2020-11-17 21:12:09.435278+08
100013v	100004q	<message msec_times='1605619072517' xml:lang='en' from='100013v@startalk.tech' to='100004q@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='922da4b7-e9da-4592-ad06-8f412415d6d8' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/dyx]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-17 21:17:52.517+08	289	3	922da4b7-e9da-4592-ad06-8f412415d6d8	startalk.tech	startalk.tech			chat	2020-11-17 21:17:52.518285+08
100004q	100013v	<message msec_times='1605619081459' xml:lang='en' from='100004q@startalk.tech' to='100013v@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='8b5ba2e8-8d0c-4fb0-a25b-6edb019a10cd' msgType='1'>看到了</body></message>	2020-11-17 21:18:01.459+08	290	3	8b5ba2e8-8d0c-4fb0-a25b-6edb019a10cd	startalk.tech	startalk.tech			chat	2020-11-17 21:18:01.461453+08
100013v	100004q	<message msec_times='1605619097366' xml:lang='en' from='100013v@startalk.tech' to='100004q@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='b3482ed9-2613-45ed-883d-58c031f09299' msgType='1'>我这边也可以</body></message>	2020-11-17 21:18:17.366+08	291	3	b3482ed9-2613-45ed-883d-58c031f09299	startalk.tech	startalk.tech			chat	2020-11-17 21:18:17.368059+08
100013v	test01	<message msec_times='1605660375251' xml:lang='en' from='100013v@startalk.tech' to='test01@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='140d00fa-7016-4600-92c2-18199dc9fcae' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/hxqq]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-18 08:46:15.251+08	298	3	140d00fa-7016-4600-92c2-18199dc9fcae	startalk.tech	startalk.tech			chat	2020-11-18 08:46:15.252659+08
100013v	test01	<message msec_times='1605660376695' xml:lang='en' from='100013v@startalk.tech' to='test01@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='79978f45-6338-4fa3-8408-d27b377e1ead' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-18 08:46:16.695+08	299	3	79978f45-6338-4fa3-8408-d27b377e1ead	startalk.tech	startalk.tech			chat	2020-11-18 08:46:16.69663+08
test01	100013v	<message msec_times='1605660379774' xml:lang='en' from='test01@startalk.tech' to='100013v@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='d0ca3723-9392-4261-886b-c839328c0f72' msgType='1'>略略略</body></message>	2020-11-18 08:46:19.774+08	300	3	d0ca3723-9392-4261-886b-c839328c0f72	startalk.tech	startalk.tech			chat	2020-11-18 08:46:19.77553+08
test01	100013v	<message msec_times='1605660382475' xml:lang='en' from='test01@startalk.tech' to='100013v@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='cdcdc332-e682-4ad0-bd14-b0a024a28dba' msgType='1'>你想干啥</body></message>	2020-11-18 08:46:22.475+08	301	3	cdcdc332-e682-4ad0-bd14-b0a024a28dba	startalk.tech	startalk.tech			chat	2020-11-18 08:46:22.477247+08
test01	100013v	<message msec_times='1605660384636' xml:lang='en' from='test01@startalk.tech' to='100013v@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='6e0cb153-64f5-4ac7-80c5-bb0880b30b20' msgType='1'>就解决</body></message>	2020-11-18 08:46:24.636+08	302	3	6e0cb153-64f5-4ac7-80c5-bb0880b30b20	startalk.tech	startalk.tech			chat	2020-11-18 08:46:24.637615+08
test01	100013v	<message msec_times='1605660395680' xml:lang='en' from='test01@startalk.tech' to='100013v@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='cb60d078-7eca-46f0-8fb4-7ec299a2b160' msgType='2'>{&quot;FileName&quot;:&quot;fad0b126-9ecf-4e0e-920b-15dd8fa432ab.aar&quot;,&quot;FilePath&quot;:&quot;/data/user/0/sdk.im.qunar.com.qtalksdkdemo/files/qvoice/qvoice.tmp&quot;,&quot;HttpUrl&quot;:&quot;file/v2/download/d38ac95f8d4275a0d3f8b585d039e3ce?name\\u003dqvoice.tmp&quot;,&quot;Seconds&quot;:2,&quot;s&quot;:0}</body></message>	2020-11-18 08:46:35.68+08	303	3	cb60d078-7eca-46f0-8fb4-7ec299a2b160	startalk.tech	startalk.tech			chat	2020-11-18 08:46:35.681989+08
test01	100013v	<message type='revoke' to='100013v@startalk.tech' msec_times='1605660449741'><body id='5ef090a5-0975-443a-94bb-9ecde6044191' msgType='-1' extendInfo='{&quot;messageId&quot;:&quot;5ef090a5-0975-443a-94bb-9ecde6044191&quot;,&quot;fromId&quot;:&quot;test01@startalk.tech/V[206]_P[Android]_D[YAL-AL10]_ID[5c7ebbcb-703c-40d9-a3c4-031ac2fc5d08]_PB&quot;}'>[撤销一条消息]</body><stime xmlns='jabber:stime:delay' stamp='20201118T00:47:29'/></message>	2020-11-18 08:47:29.741+08	306	3	5ef090a5-0975-443a-94bb-9ecde6044191	startalk.tech	startalk.tech			chat	2020-11-18 08:47:22.389281+08
test01	100013v	<message type='revoke' to='100013v@startalk.tech' msec_times='1605660451547'><body id='3a35d54c-b4dd-4c82-a61b-2241aeb94751' msgType='-1' extendInfo='{&quot;messageId&quot;:&quot;3a35d54c-b4dd-4c82-a61b-2241aeb94751&quot;,&quot;fromId&quot;:&quot;test01@startalk.tech/V[206]_P[Android]_D[YAL-AL10]_ID[5c7ebbcb-703c-40d9-a3c4-031ac2fc5d08]_PB&quot;}'>[撤销一条消息]</body><stime xmlns='jabber:stime:delay' stamp='20201118T00:47:31'/></message>	2020-11-18 08:47:31.547+08	305	3	3a35d54c-b4dd-4c82-a61b-2241aeb94751	startalk.tech	startalk.tech			chat	2020-11-18 08:47:12.200041+08
test01	100013v	<message type='revoke' to='100013v@startalk.tech' msec_times='1605660453127'><body id='bd9a79c0-fa56-4bb7-96c5-eedebebf14d8' msgType='-1' extendInfo='{&quot;messageId&quot;:&quot;bd9a79c0-fa56-4bb7-96c5-eedebebf14d8&quot;,&quot;fromId&quot;:&quot;test01@startalk.tech/V[206]_P[Android]_D[YAL-AL10]_ID[5c7ebbcb-703c-40d9-a3c4-031ac2fc5d08]_PB&quot;}'>[撤销一条消息]</body><stime xmlns='jabber:stime:delay' stamp='20201118T00:47:33'/></message>	2020-11-18 08:47:33.127+08	304	3	bd9a79c0-fa56-4bb7-96c5-eedebebf14d8	startalk.tech	startalk.tech			chat	2020-11-18 08:46:57.720461+08
test01	100013v	<message msec_times='1605660455520' xml:lang='en' from='test01@startalk.tech' to='100013v@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='56fd1123-b9fb-4be3-8e1e-478ea6513859' msgType='2'>{&quot;FileName&quot;:&quot;d057a739-8622-4e2c-96f8-250841c8a985.aar&quot;,&quot;FilePath&quot;:&quot;/data/user/0/sdk.im.qunar.com.qtalksdkdemo/files/qvoice/qvoice.tmp&quot;,&quot;HttpUrl&quot;:&quot;file/v2/download/bd779dfac17c146089aab6628f19069c?name\\u003dqvoice.tmp&quot;,&quot;Seconds&quot;:1,&quot;s&quot;:0}</body></message>	2020-11-18 08:47:35.52+08	307	3	56fd1123-b9fb-4be3-8e1e-478ea6513859	startalk.tech	startalk.tech			chat	2020-11-18 08:47:35.521703+08
test01	100013v	<message msec_times='1605660463126' xml:lang='en' from='test01@startalk.tech' to='100013v@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='70e95319-e7ae-4243-b687-5bb6d6814b51' msgType='2'>{&quot;FileName&quot;:&quot;d186615c-a9b6-4bcd-add4-349307345499.aar&quot;,&quot;FilePath&quot;:&quot;/data/user/0/sdk.im.qunar.com.qtalksdkdemo/files/qvoice/qvoice.tmp&quot;,&quot;HttpUrl&quot;:&quot;file/v2/download/cc22ae9984aeae0c6298fc7aca23d4f9?name\\u003dqvoice.tmp&quot;,&quot;Seconds&quot;:1,&quot;s&quot;:0}</body></message>	2020-11-18 08:47:43.126+08	308	3	70e95319-e7ae-4243-b687-5bb6d6814b51	startalk.tech	startalk.tech			chat	2020-11-18 08:47:43.127632+08
test01	100013v	<message msec_times='1605660471427' xml:lang='en' from='test01@startalk.tech' to='100013v@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='66cddd61-6bd0-4262-806a-89064b3d6052' msgType='2'>{&quot;FileName&quot;:&quot;e4edfb90-26cc-4b81-8755-0f4a6626c1f4.aar&quot;,&quot;FilePath&quot;:&quot;/data/user/0/sdk.im.qunar.com.qtalksdkdemo/files/qvoice/qvoice.tmp&quot;,&quot;HttpUrl&quot;:&quot;file/v2/download/5b334cb0252825eae03d548ea32d6dce?name\\u003dqvoice.tmp&quot;,&quot;Seconds&quot;:3,&quot;s&quot;:0}</body></message>	2020-11-18 08:47:51.427+08	309	3	66cddd61-6bd0-4262-806a-89064b3d6052	startalk.tech	startalk.tech			chat	2020-11-18 08:47:51.429004+08
test01	100013v	<message msec_times='1605661251405' xml:lang='en' from='test01@startalk.tech' to='100013v@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body extendInfo='{&quot;auth&quot;:true,&quot;desc&quot;:&quot;点击查看全部&quot;,&quot;linkurl&quot;:&quot;https://im.startalk.tech:8443/py/sharemsg?jdata\\u003daHR0cHM6Ly9pbS5zdGFydGFsay50ZWNoOjg0NDMvZmlsZS92Mi9kb3dubG9hZC8xMGZmZTFmZDhiYTVjZDYxMWI0OThhMDNlNDc5M2Q3Mj9uYW1lPWN1cnJfc2hhcmVfbXNnLmpzb24mdT10ZXN0MDEmaz0yOTA3MTE2MDU2NjExMzc3MjI2NjY%3D&quot;,&quot;showas667&quot;:false,&quot;showbar&quot;:true,&quot;title&quot;:&quot;test01,test02的聊天记录&quot;}' id='d14f3dcb-a70d-44d2-84a4-277494e992e8' msgType='666'>https://im.startalk.tech:8443/py/sharemsg?jdata=aHR0cHM6Ly9pbS5zdGFydGFsay50ZWNoOjg0NDMvZmlsZS92Mi9kb3dubG9hZC8xMGZmZTFmZDhiYTVjZDYxMWI0OThhMDNlNDc5M2Q3Mj9uYW1lPWN1cnJfc2hhcmVfbXNnLmpzb24mdT10ZXN0MDEmaz0yOTA3MTE2MDU2NjExMzc3MjI2NjY%3D</body></message>	2020-11-18 09:00:51.405+08	328	3	d14f3dcb-a70d-44d2-84a4-277494e992e8	startalk.tech	startalk.tech			chat	2020-11-18 09:00:51.406445+08
test01	100013v	<message msec_times='1605660479734' xml:lang='en' from='test01@startalk.tech' to='100013v@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='ed5c4f7c-e865-4f98-a0fc-ed701e1c0c54' msgType='2'>{&quot;FileName&quot;:&quot;f80baf19-59d8-4a05-bda2-056c0988bc27.aar&quot;,&quot;FilePath&quot;:&quot;/data/user/0/sdk.im.qunar.com.qtalksdkdemo/files/qvoice/qvoice.tmp&quot;,&quot;HttpUrl&quot;:&quot;file/v2/download/5802f56ad5e8c21c6e51ecb3d9e2aa8c?name\\u003dqvoice.tmp&quot;,&quot;Seconds&quot;:2,&quot;s&quot;:0}</body></message>	2020-11-18 08:47:59.734+08	310	3	ed5c4f7c-e865-4f98-a0fc-ed701e1c0c54	startalk.tech	startalk.tech			chat	2020-11-18 08:47:59.736061+08
test01	100013v	<message msec_times='1605660642926' xml:lang='en' from='test01@startalk.tech' to='100013v@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='b3d25726-5f18-4cd9-8375-f0e2db3bd99e' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/hhx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/hhx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/hhx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/hhx]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-18 08:50:42.926+08	311	3	b3d25726-5f18-4cd9-8375-f0e2db3bd99e	startalk.tech	startalk.tech			chat	2020-11-18 08:50:42.927548+08
100013v	test01	<message msec_times='1605661653730' xml:lang='en' from='100013v@startalk.tech' to='test01@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='511c3390-24df-42e3-800a-577049393f53' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-18 09:07:33.73+08	329	3	511c3390-24df-42e3-800a-577049393f53	startalk.tech	startalk.tech			chat	2020-11-18 09:07:33.732097+08
test01	100013v	<message msec_times='1605660644584' xml:lang='en' from='test01@startalk.tech' to='100013v@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='058cf24f-2572-47bc-8757-fd4a840f49f6' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-18 08:50:44.584+08	312	3	058cf24f-2572-47bc-8757-fd4a840f49f6	startalk.tech	startalk.tech			chat	2020-11-18 08:50:44.586251+08
test01	100013v	<message msec_times='1605660646194' xml:lang='en' from='test01@startalk.tech' to='100013v@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='9c8228ab-2591-46b9-88cf-5550fbbeba45' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-18 08:50:46.194+08	313	3	9c8228ab-2591-46b9-88cf-5550fbbeba45	startalk.tech	startalk.tech			chat	2020-11-18 08:50:46.195321+08
test01	100013v	<message msec_times='1605660651871' xml:lang='en' from='test01@startalk.tech' to='100013v@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='fa5e9455-8232-44db-a6ff-eeb463646760' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/lzx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/lzx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/lzx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/lzx]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-18 08:50:51.871+08	314	3	fa5e9455-8232-44db-a6ff-eeb463646760	startalk.tech	startalk.tech			chat	2020-11-18 08:50:51.872562+08
test01	100013v	<message msec_times='1605660653053' xml:lang='en' from='test01@startalk.tech' to='100013v@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='b6092bd3-c333-4b9e-ae06-1ed08a04525b' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-18 08:50:53.053+08	315	3	b6092bd3-c333-4b9e-ae06-1ed08a04525b	startalk.tech	startalk.tech			chat	2020-11-18 08:50:53.054669+08
test01	100013v	<message msec_times='1605660656466' xml:lang='en' from='test01@startalk.tech' to='100013v@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='70fac183-1e41-4434-a2be-22f524592763' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-18 08:50:56.466+08	316	3	70fac183-1e41-4434-a2be-22f524592763	startalk.tech	startalk.tech			chat	2020-11-18 08:50:56.467334+08
test01	100013v	<message msec_times='1605660657921' xml:lang='en' from='test01@startalk.tech' to='100013v@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='5494e683-7764-4732-8874-5a2007bf0257' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/sa]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/sa]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-18 08:50:57.921+08	317	3	5494e683-7764-4732-8874-5a2007bf0257	startalk.tech	startalk.tech			chat	2020-11-18 08:50:57.922704+08
test01	100013v	<message msec_times='1605660660644' xml:lang='en' from='test01@startalk.tech' to='100013v@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='44cbb77d-a769-4ea2-98d4-869cf29b674b' msgType='2'>{&quot;FileName&quot;:&quot;85e5885a-8a20-4310-8bea-eb3e4f1e7490.aar&quot;,&quot;FilePath&quot;:&quot;/data/user/0/sdk.im.qunar.com.qtalksdkdemo/files/qvoice/qvoice.tmp&quot;,&quot;HttpUrl&quot;:&quot;file/v2/download/4ba09bc8bb409e2f2e3415cb27fc9b29?name\\u003dqvoice.tmp&quot;,&quot;Seconds&quot;:1,&quot;s&quot;:0}</body></message>	2020-11-18 08:51:00.644+08	318	3	44cbb77d-a769-4ea2-98d4-869cf29b674b	startalk.tech	startalk.tech			chat	2020-11-18 08:51:00.645677+08
test01	100013v	<message msec_times='1605660662561' xml:lang='en' from='test01@startalk.tech' to='100013v@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='d086fe0f-3d5f-4936-926e-efc653ae790d' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/zk]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/zk]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-18 08:51:02.561+08	319	3	d086fe0f-3d5f-4936-926e-efc653ae790d	startalk.tech	startalk.tech			chat	2020-11-18 08:51:02.562837+08
100013v	test01	<message msec_times='1605661654745' xml:lang='en' from='100013v@startalk.tech' to='test01@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='0a742133-64ac-4a13-9755-de7792f195cd' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-18 09:07:34.745+08	330	3	0a742133-64ac-4a13-9755-de7792f195cd	startalk.tech	startalk.tech			chat	2020-11-18 09:07:34.746899+08
100013v	test01	<message msec_times='1605661656094' xml:lang='en' from='100013v@startalk.tech' to='test01@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='51ecab45-1f80-4d11-99b4-619c8cf54d21' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ]</body></message>	2020-11-18 09:07:36.094+08	331	3	51ecab45-1f80-4d11-99b4-619c8cf54d21	startalk.tech	startalk.tech			chat	2020-11-18 09:07:36.09602+08
test01	100013v	<message msec_times='1605660797011' xml:lang='en' from='test01@startalk.tech' to='100013v@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='24b785eb-8a30-418b-8323-fbd334d6650b' msgType='3'>[obj type=&quot;image&quot; value=&quot;file/v2/download/aa0d8dffaebfd44c6cb668cec0ab490f.jpg?name=aa0d8dffaebfd44c6cb668cec0ab490f.jpg&quot; width=1080 height=2340]</body></message>	2020-11-18 08:53:17.011+08	320	3	24b785eb-8a30-418b-8323-fbd334d6650b	startalk.tech	startalk.tech			chat	2020-11-18 08:53:17.012951+08
test01	file-transfer	<message msec_times='1605662080823' xml:lang='en' from='test01@startalk.tech' to='file-transfer@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='ebef2d46-67ac-45af-8106-b3d1a0e05f91' msgType='1'>几</body></message>	2020-11-18 09:14:40.823+08	332	0	ebef2d46-67ac-45af-8106-b3d1a0e05f91	startalk.tech	startalk.tech			chat	2020-11-18 09:14:40.825364+08
test01	file-transfer	<message msec_times='1605662085287' xml:lang='en' from='test01@startalk.tech' to='file-transfer@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='19b6a7a0-ac61-4c79-bb54-71c346fd0334' msgType='1'>官方</body></message>	2020-11-18 09:14:45.287+08	333	0	19b6a7a0-ac61-4c79-bb54-71c346fd0334	startalk.tech	startalk.tech			chat	2020-11-18 09:14:45.289026+08
test01	100013v	<message msec_times='1605660806746' xml:lang='en' from='test01@startalk.tech' to='100013v@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='f08dc845-b6c4-4480-81a9-6e5492a06cbc' msgType='3'>[obj type=&quot;image&quot; value=&quot;file/v2/download/8ba97ee14ea82f78a2e2e19a2d10f6cd.jpg?name=8ba97ee14ea82f78a2e2e19a2d10f6cd.jpg&quot; width=1080 height=2340]</body></message>	2020-11-18 08:53:26.746+08	321	3	f08dc845-b6c4-4480-81a9-6e5492a06cbc	startalk.tech	startalk.tech			chat	2020-11-18 08:53:26.747225+08
test01	100013v	<message msec_times='1605660811008' xml:lang='en' from='test01@startalk.tech' to='100013v@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='295c8553-546a-482c-ba31-4d8a99f67620' msgType='3'>[obj type=&quot;image&quot; value=&quot;file/v2/download/30e04f7134cd25e14e4766f866b0eed0.jpg?name=30e04f7134cd25e14e4766f866b0eed0.jpg&quot; width=1080 height=2340]</body></message>	2020-11-18 08:53:31.008+08	322	3	295c8553-546a-482c-ba31-4d8a99f67620	startalk.tech	startalk.tech			chat	2020-11-18 08:53:31.009538+08
\.


--
-- Data for Name: msg_history_backup; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.msg_history_backup (m_from, m_to, m_body, create_time, id, read_flag, msg_id, from_host, to_host, realfrom, realto, msg_type, update_time) FROM stdin;
\.


--
-- Data for Name: muc_last; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.muc_last (muc_name, create_time, last_msg_time) FROM stdin;
\.


--
-- Data for Name: muc_registered; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.muc_registered (jid, host, nick, created_at) FROM stdin;
\.


--
-- Data for Name: muc_room; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.muc_room (name, host, opts, created_at) FROM stdin;
eacfa594c3374240a8370990febb980a	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"admin">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-10-15 15:33:25.676748
46823ed77669448eaea51c1f9f130d70	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100094z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-10-26 00:23:45.826503
13a476002524475898657c196fe66197	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100096z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-10-26 00:28:56.237785
e6f21f761ddd4a7f8eb6570adc7cbf9e	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100094z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-10-29 16:28:18.619377
b235887358a34bba8f81c269d5d5658e	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100094z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-10-29 16:32:09.499314
e68a47f141ad43df8d72bd00ae78b133	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100094z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-10-29 17:34:03.802664
838c7c32d28e4747be9a61043ead3e08	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100096z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-10-29 20:01:49.12031
9022c32aa1cd439fb9cbda23c45da981	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100094z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-10-30 00:30:33.209783
7a720787654245529bccba67426a0366	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100095z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-10-30 00:33:03.85513
42b028bd797443fb8230a73b1caf0931	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100004q">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-10-30 00:57:07.201611
3389f6c1bb4042a2ab0c339dec3c16a9	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100094z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-10-30 20:53:24.421589
b0b5ebc6f7f240a1a92b26a1f313d03a	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100094z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-10-30 20:59:51.462325
95047e5e04014cd2b2ec4b16c85f744c	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100094z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-10-30 21:00:59.224914
b10f8a925460494a96ffb7ef58002ffa	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100096z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-11-02 15:02:47.984776
677930584d7145b6bd20b79f4bae7352	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100096z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-11-02 15:04:00.096134
56be69ae06e5475b9e85295de0ae4dd7	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100096z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-11-02 15:05:29.543142
d62701c245234248aaa069f2e63e2474	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100096z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-11-02 16:06:22.433706
64598a656b384af4b458473b72dceb26	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100096z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-11-02 16:07:17.970439
eb32de0dc28c40b0824b72af7873dfa5	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100094z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-10-31 14:57:34.830678
3c1b6a39035c442a8f59e5704bba096a	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100094z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-10-31 15:01:31.954348
18dd0d10d591479c858a92be057c694e	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100095z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-10-31 22:58:03.803247
e299435983c34c3885d329e59a7561ca	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100095z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-10-31 23:00:53.981675
55a59d75b08a4f77b76f75eb68cd3e15	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100095z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-10-31 23:17:25.192565
575b0da2c0e44f5aade67f4bcd161e8f	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100096z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-11-02 17:51:44.11957
08385b97f4954b4ba55fab2277f26436	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100094z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-11-02 17:52:40.039507
b58cb19af6c04a71af24417aef49cf0b	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100094z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-11-02 17:55:07.463771
03bf3595212f4c098fc3b4967af8467d	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100096z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-11-02 17:55:30.937155
0229eb47b1154771866863ddab7c96b6	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100096z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-11-02 17:16:02.009359
abd227dec13a48bbbf4de1b44605bbcb	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100094z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-11-02 17:21:13.632609
ead71a2044ea4007b275e4c1dd6326ae	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100094z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-11-02 17:34:45.491597
b53827521885446b9b53cd68c885f878	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100094z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-11-02 17:39:24.875409
da499de5f90e42a789b91e75a75d075c	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100095z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-11-03 11:00:03.407906
a6c0d98b4c9045e88a88098b5424c812	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100095z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-11-03 11:21:16.787676
b2c2ec63c86e469e9d9199b8f224dde6	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100094z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-11-02 17:55:58.368155
408fcdfe35454d37ab20f02606ef0695	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"mumu">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-11-02 17:57:42.675057
ba2a497adbbe44c7b67f2dd81e53e8f9	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100004q">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-11-02 18:01:36.225473
b9f791d73c5045b7bad8f0c1235d22f4	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100004q">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-11-02 18:02:53.565956
99f601bbbefd40de92e681fbe8d02048	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100095z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-11-03 11:23:31.957766
53e4ccf7cd6049788f427737d03f2534	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100095z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-11-03 11:23:57.905034
2ce913d30df441cf8fb82d3d42bf105b	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100095z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-11-03 11:25:01.932769
221d33e20e17449db36173cdd39e76ff	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100095z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-11-06 19:30:32.344624
5cde4d34a44544b9a58c7a592a851756	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100095z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-11-06 19:32:03.935204
ba9fa0065e1c49e38415ac184ba3a3a8	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100095z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-11-06 19:32:27.298587
17a73d186c034b1ea71bfc3dd3108ee0	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100095z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-11-10 08:04:52.029202
6737bb1bb2af443086d57e81d71eeb94	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100094z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-11-10 08:58:54.063614
83d2403acedf4b39877f592244043dee	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100095z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-11-10 09:24:19.146385
9afcd37223a842d6b39f29ec13e2d678	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100095z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-11-10 09:24:33.916066
3b9ff47191c143e9991452fa02affa23	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]},{max_users,600},{affiliations,[{{<<"100004q">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]}]	2020-11-08 17:56:58.079993
7f8cf571ceb74bd2a27a33f985386362	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100094z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-11-14 23:39:49.876583
5e0faeaa8741489ab5b9f6131667fe80	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100094z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-11-14 23:40:40.482875
38cfb6912f814b77bb7bb2d6bbfd3245	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"mumu">>,<<"startalk.tech">>,<<>>},{admin,<<>>}},{{<<"100094z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-11-14 23:41:17.167855
3c23e31805af4ba0bc6a7fc71639cf21	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"mumu">>,<<"startalk.tech">>,<<>>},{owner,<<>>}},{{<<"100094z">>,<<"startalk.tech">>,<<>>},{member,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-11-14 23:45:25.912108
c395017fb9434bafbeb86a69b8b3a46d	conference.startalk.tech	[{title,<<>>},{description,<<>>},{allow_change_subj,true},{allow_query_users,true},{allow_private_messages,false},{allow_private_messages_from_visitors,anyone},{allow_visitor_status,true},{allow_visitor_nickchange,true},{public,false},{public_list,false},{persistent,true},{moderated,true},{members_by_default,true},{members_only,false},{allow_user_invites,true},{password_protected,false},{captcha_protected,false},{password,<<>>},{anonymous,true},{logging,true},{max_users,600},{allow_voice_requests,true},{mam,false},{voice_request_min_interval,1800},{vcard,<<>>},{captcha_whitelist,[]},{affiliations,[{{<<"100094z">>,<<"startalk.tech">>,<<>>},{owner,<<>>}}]},{subject,<<>>},{subject_author,<<>>},{subscribers,[]}]	2020-11-15 19:17:38.579036
\.


--
-- Data for Name: muc_room_backup; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.muc_room_backup (name, host, opts, created_at) FROM stdin;
\.


--
-- Data for Name: muc_room_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.muc_room_history (muc_room_name, nick, packet, have_subject, size, create_time, id, host, msg_id) FROM stdin;
eacfa594c3374240a8370990febb980a	eacfa594c3374240a8370990febb980a_conference.startalk.tech	<message from='eacfa594c3374240a8370990febb980a@conference.startalk.tech/eacfa594c3374240a8370990febb980a_conference.startalk.tech' to='eacfa594c3374240a8370990febb980a@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1602747205697'><body msgType='15' id='http_290711602747205697'>管理员 创建聊天室.</body></message>	t	0	2020-10-15 15:33:25.697+08	1	conference.startalk.tech	http_290711602747205697
46823ed77669448eaea51c1f9f130d70	46823ed77669448eaea51c1f9f130d70_conference.startalk.tech	<message from='46823ed77669448eaea51c1f9f130d70@conference.startalk.tech/46823ed77669448eaea51c1f9f130d70_conference.startalk.tech' to='46823ed77669448eaea51c1f9f130d70@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1603643025833'><body msgType='15' id='http_290711603643025833'>珊珊JH 创建聊天室.</body></message>	t	0	2020-10-26 00:23:45.833+08	2	conference.startalk.tech	http_290711603643025833
13a476002524475898657c196fe66197	13a476002524475898657c196fe66197_conference.startalk.tech	<message from='13a476002524475898657c196fe66197@conference.startalk.tech/13a476002524475898657c196fe66197_conference.startalk.tech' to='13a476002524475898657c196fe66197@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1603643336244'><body msgType='15' id='http_290711603643336244'>勇敢 创建聊天室.</body></message>	t	0	2020-10-26 00:28:56.244+08	3	conference.startalk.tech	http_290711603643336244
13a476002524475898657c196fe66197	100096z_startalk.tech	<message from='13a476002524475898657c196fe66197@conference.startalk.tech/100096z_startalk.tech' to='13a476002524475898657c196fe66197@conference.startalk.tech' sendjid='100096z@startalk.tech' realfrom='100096z@startalk.tech' msec_times='1603643860769' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='dde80df5-fa94-4bb2-8790-383c95dcf4ce' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-10-26 00:37:40.769+08	4	startalk.tech	dde80df5-fa94-4bb2-8790-383c95dcf4ce
13a476002524475898657c196fe66197	100096z_startalk.tech	<message from='13a476002524475898657c196fe66197@conference.startalk.tech/100096z_startalk.tech' to='13a476002524475898657c196fe66197@conference.startalk.tech' sendjid='100096z@startalk.tech' realfrom='100096z@startalk.tech' msec_times='1603643881580' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='8d0e970e-9f90-4faf-a4b9-894192b98dd7' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/dzwx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/dzwx]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-10-26 00:38:01.58+08	5	startalk.tech	8d0e970e-9f90-4faf-a4b9-894192b98dd7
13a476002524475898657c196fe66197	100096z_startalk.tech	<message from='13a476002524475898657c196fe66197@conference.startalk.tech/100096z_startalk.tech' to='13a476002524475898657c196fe66197@conference.startalk.tech' sendjid='100096z@startalk.tech' realfrom='100096z@startalk.tech' msec_times='1603643906064' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='8ffb1641-72a9-4125-88d9-8be81d29ae84' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/dzwx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/dzwx]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-10-26 00:38:26.064+08	6	startalk.tech	8ffb1641-72a9-4125-88d9-8be81d29ae84
46823ed77669448eaea51c1f9f130d70	100094z_startalk.tech	<message from='46823ed77669448eaea51c1f9f130d70@conference.startalk.tech/100094z_startalk.tech' to='46823ed77669448eaea51c1f9f130d70@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1603711812594' isHiddenMsg='0' type='groupchat'><body id='14006C959BC44F36CA3D44A6E60EBA50' maType='6' msgType='1'>11</body><active xmlns='http://jabber.org/protocol/chatstates'/></message>	t	0	2020-10-26 19:30:12.594+08	7	startalk.tech	14006C959BC44F36CA3D44A6E60EBA50
46823ed77669448eaea51c1f9f130d70	100094z_startalk.tech	<message from='46823ed77669448eaea51c1f9f130d70@conference.startalk.tech/100094z_startalk.tech' to='46823ed77669448eaea51c1f9f130d70@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1603711819956' isHiddenMsg='0' type='groupchat'><body id='DB30EE90F32547B3E63FFC6A3230148B' maType='6' msgType='1'>12</body><active xmlns='http://jabber.org/protocol/chatstates'/></message>	t	0	2020-10-26 19:30:19.956+08	8	startalk.tech	DB30EE90F32547B3E63FFC6A3230148B
6087afffae43438a88f6a7a46e969404	6087afffae43438a88f6a7a46e969404_conference.startalk.tech	<message from='6087afffae43438a88f6a7a46e969404@conference.startalk.tech/6087afffae43438a88f6a7a46e969404_conference.startalk.tech' to='6087afffae43438a88f6a7a46e969404@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1603885787641'><body msgType='15' id='http_290711603885787641'>珊珊JH 创建聊天室.</body></message>	t	0	2020-10-28 19:49:47.641+08	9	conference.startalk.tech	http_290711603885787641
e6f21f761ddd4a7f8eb6570adc7cbf9e	e6f21f761ddd4a7f8eb6570adc7cbf9e_conference.startalk.tech	<message from='e6f21f761ddd4a7f8eb6570adc7cbf9e@conference.startalk.tech/e6f21f761ddd4a7f8eb6570adc7cbf9e_conference.startalk.tech' to='e6f21f761ddd4a7f8eb6570adc7cbf9e@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1603960098626'><body msgType='15' id='http_290711603960098626'>珊珊JH 创建聊天室.</body></message>	t	0	2020-10-29 16:28:18.626+08	10	conference.startalk.tech	http_290711603960098626
e6f21f761ddd4a7f8eb6570adc7cbf9e	e6f21f761ddd4a7f8eb6570adc7cbf9e_conference.startalk.tech	<message from='e6f21f761ddd4a7f8eb6570adc7cbf9e@conference.startalk.tech/e6f21f761ddd4a7f8eb6570adc7cbf9e_conference.startalk.tech' to='e6f21f761ddd4a7f8eb6570adc7cbf9e@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1603960098829'><body msgType='15' id='http_619861603960098829'>珊珊JH 邀请 zhangchao5, 杉杉 进入聊天室.</body></message>	t	0	2020-10-29 16:28:18.829+08	11	conference.startalk.tech	http_619861603960098829
e6f21f761ddd4a7f8eb6570adc7cbf9e	100094z_startalk.tech	<message from='e6f21f761ddd4a7f8eb6570adc7cbf9e@conference.startalk.tech/100094z_startalk.tech' to='e6f21f761ddd4a7f8eb6570adc7cbf9e@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1603960110483' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='0c829008-a7c4-4a5a-8239-2d6235f0edc0' msgType='1'>1</body></message>	t	0	2020-10-29 16:28:30.483+08	12	startalk.tech	0c829008-a7c4-4a5a-8239-2d6235f0edc0
e6f21f761ddd4a7f8eb6570adc7cbf9e	100094z_startalk.tech	<message from='e6f21f761ddd4a7f8eb6570adc7cbf9e@conference.startalk.tech/100094z_startalk.tech' to='e6f21f761ddd4a7f8eb6570adc7cbf9e@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1603960125997' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='aab82466-3f5c-421a-8a3e-c9a95b541063' msgType='1'>2</body></message>	t	0	2020-10-29 16:28:45.997+08	13	startalk.tech	aab82466-3f5c-421a-8a3e-c9a95b541063
b235887358a34bba8f81c269d5d5658e	b235887358a34bba8f81c269d5d5658e_conference.startalk.tech	<message from='b235887358a34bba8f81c269d5d5658e@conference.startalk.tech/b235887358a34bba8f81c269d5d5658e_conference.startalk.tech' to='b235887358a34bba8f81c269d5d5658e@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1603960329507'><body msgType='15' id='http_290711603960329507'>珊珊JH 创建聊天室.</body></message>	t	0	2020-10-29 16:32:09.507+08	14	conference.startalk.tech	http_290711603960329507
b235887358a34bba8f81c269d5d5658e	b235887358a34bba8f81c269d5d5658e_conference.startalk.tech	<message from='b235887358a34bba8f81c269d5d5658e@conference.startalk.tech/b235887358a34bba8f81c269d5d5658e_conference.startalk.tech' to='b235887358a34bba8f81c269d5d5658e@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1603960329798'><body msgType='15' id='http_619861603960329798'>珊珊JH 邀请 zhangchao5, 勇敢 进入聊天室.</body></message>	t	0	2020-10-29 16:32:09.798+08	15	conference.startalk.tech	http_619861603960329798
b235887358a34bba8f81c269d5d5658e	100094z_startalk.tech	<message from='b235887358a34bba8f81c269d5d5658e@conference.startalk.tech/100094z_startalk.tech' to='b235887358a34bba8f81c269d5d5658e@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1603960450444' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='4891a6b7-5cef-44b2-89a1-edaee1814627' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/dyx]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-10-29 16:34:10.444+08	16	startalk.tech	4891a6b7-5cef-44b2-89a1-edaee1814627
e68a47f141ad43df8d72bd00ae78b133	e68a47f141ad43df8d72bd00ae78b133_conference.startalk.tech	<message from='e68a47f141ad43df8d72bd00ae78b133@conference.startalk.tech/e68a47f141ad43df8d72bd00ae78b133_conference.startalk.tech' to='e68a47f141ad43df8d72bd00ae78b133@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1603964043810'><body msgType='15' id='http_290711603964043810'>珊珊JH 创建聊天室.</body></message>	t	0	2020-10-29 17:34:03.81+08	17	conference.startalk.tech	http_290711603964043810
e68a47f141ad43df8d72bd00ae78b133	e68a47f141ad43df8d72bd00ae78b133_conference.startalk.tech	<message from='e68a47f141ad43df8d72bd00ae78b133@conference.startalk.tech/e68a47f141ad43df8d72bd00ae78b133_conference.startalk.tech' to='e68a47f141ad43df8d72bd00ae78b133@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1603964043961'><body msgType='15' id='http_619861603964043961'>珊珊JH 邀请 zhangchao5 进入聊天室.</body></message>	t	0	2020-10-29 17:34:03.961+08	18	conference.startalk.tech	http_619861603964043961
e68a47f141ad43df8d72bd00ae78b133	100094z_startalk.tech	<message from='e68a47f141ad43df8d72bd00ae78b133@conference.startalk.tech/100094z_startalk.tech' to='e68a47f141ad43df8d72bd00ae78b133@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1603964186193' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='7a196d19-6aa1-4100-bbe4-2e71574b2635' msgType='1'>1\n</body></message>	t	0	2020-10-29 17:36:26.193+08	19	startalk.tech	7a196d19-6aa1-4100-bbe4-2e71574b2635
838c7c32d28e4747be9a61043ead3e08	838c7c32d28e4747be9a61043ead3e08_conference.startalk.tech	<message from='838c7c32d28e4747be9a61043ead3e08@conference.startalk.tech/838c7c32d28e4747be9a61043ead3e08_conference.startalk.tech' to='838c7c32d28e4747be9a61043ead3e08@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1603972909131'><body msgType='15' id='http_290711603972909131'>勇敢 创建聊天室.</body></message>	t	0	2020-10-29 20:01:49.131+08	20	conference.startalk.tech	http_290711603972909131
9022c32aa1cd439fb9cbda23c45da981	9022c32aa1cd439fb9cbda23c45da981_conference.startalk.tech	<message from='9022c32aa1cd439fb9cbda23c45da981@conference.startalk.tech/9022c32aa1cd439fb9cbda23c45da981_conference.startalk.tech' to='9022c32aa1cd439fb9cbda23c45da981@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1603989033217'><body msgType='15' id='http_290711603989033217'>珊珊JH 创建聊天室.</body></message>	t	0	2020-10-30 00:30:33.217+08	21	conference.startalk.tech	http_290711603989033217
9022c32aa1cd439fb9cbda23c45da981	100094z_startalk.tech	<message from='9022c32aa1cd439fb9cbda23c45da981@conference.startalk.tech/100094z_startalk.tech' to='9022c32aa1cd439fb9cbda23c45da981@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1603989042832' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='482ee7b1-f5f5-45fc-9b1a-09f0687a262c' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/lzx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/lzx]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-10-30 00:30:42.832+08	22	startalk.tech	482ee7b1-f5f5-45fc-9b1a-09f0687a262c
9022c32aa1cd439fb9cbda23c45da981	100094z_startalk.tech	<message from='9022c32aa1cd439fb9cbda23c45da981@conference.startalk.tech/100094z_startalk.tech' to='9022c32aa1cd439fb9cbda23c45da981@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1603989058387' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='090db320-1042-4a1a-9df6-febda8d427b9' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/lzx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/lzx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/lzx]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-10-30 00:30:58.387+08	23	startalk.tech	090db320-1042-4a1a-9df6-febda8d427b9
7a720787654245529bccba67426a0366	7a720787654245529bccba67426a0366_conference.startalk.tech	<message from='7a720787654245529bccba67426a0366@conference.startalk.tech/7a720787654245529bccba67426a0366_conference.startalk.tech' to='7a720787654245529bccba67426a0366@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1603989183862'><body msgType='15' id='http_290711603989183862'>杉杉 创建聊天室.</body></message>	t	0	2020-10-30 00:33:03.862+08	24	conference.startalk.tech	http_290711603989183862
b0b5ebc6f7f240a1a92b26a1f313d03a	b0b5ebc6f7f240a1a92b26a1f313d03a_conference.startalk.tech	<message from='b0b5ebc6f7f240a1a92b26a1f313d03a@conference.startalk.tech/b0b5ebc6f7f240a1a92b26a1f313d03a_conference.startalk.tech' to='b0b5ebc6f7f240a1a92b26a1f313d03a@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604118999725'><body msgType='15' id='http_473861604118999725'>珊珊JH 邀请 勇敢 进入聊天室.</body></message>	t	0	2020-10-31 12:36:39.725+08	36	conference.startalk.tech	http_473861604118999725
eb32de0dc28c40b0824b72af7873dfa5	eb32de0dc28c40b0824b72af7873dfa5_conference.startalk.tech	<message from='eb32de0dc28c40b0824b72af7873dfa5@conference.startalk.tech/eb32de0dc28c40b0824b72af7873dfa5_conference.startalk.tech' to='eb32de0dc28c40b0824b72af7873dfa5@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604127454838'><body msgType='15' id='http_290711604127454838'>珊珊JH 创建聊天室.</body></message>	t	0	2020-10-31 14:57:34.838+08	37	conference.startalk.tech	http_290711604127454838
42b028bd797443fb8230a73b1caf0931	42b028bd797443fb8230a73b1caf0931_conference.startalk.tech	<message from='42b028bd797443fb8230a73b1caf0931@conference.startalk.tech/42b028bd797443fb8230a73b1caf0931_conference.startalk.tech' to='42b028bd797443fb8230a73b1caf0931@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1603990627209'><body msgType='15' id='http_290711603990627209'>JH伽勒 创建聊天室.</body></message>	t	0	2020-10-30 00:57:07.209+08	25	conference.startalk.tech	http_290711603990627209
3389f6c1bb4042a2ab0c339dec3c16a9	3389f6c1bb4042a2ab0c339dec3c16a9_conference.startalk.tech	<message from='3389f6c1bb4042a2ab0c339dec3c16a9@conference.startalk.tech/3389f6c1bb4042a2ab0c339dec3c16a9_conference.startalk.tech' to='3389f6c1bb4042a2ab0c339dec3c16a9@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604062404428'><body msgType='15' id='http_290711604062404428'>珊珊JH 创建聊天室.</body></message>	t	0	2020-10-30 20:53:24.428+08	26	conference.startalk.tech	http_290711604062404428
3389f6c1bb4042a2ab0c339dec3c16a9	3389f6c1bb4042a2ab0c339dec3c16a9_conference.startalk.tech	<message from='3389f6c1bb4042a2ab0c339dec3c16a9@conference.startalk.tech/3389f6c1bb4042a2ab0c339dec3c16a9_conference.startalk.tech' to='3389f6c1bb4042a2ab0c339dec3c16a9@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604062404603'><body msgType='15' id='http_619861604062404603'>珊珊JH 邀请 zhangchao5 进入聊天室.</body></message>	t	0	2020-10-30 20:53:24.603+08	27	conference.startalk.tech	http_619861604062404603
3389f6c1bb4042a2ab0c339dec3c16a9	100094z_startalk.tech	<message from='3389f6c1bb4042a2ab0c339dec3c16a9@conference.startalk.tech/100094z_startalk.tech' to='3389f6c1bb4042a2ab0c339dec3c16a9@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1604062549910' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='d8f8cf45-78c2-4d31-b380-4cd6a69a1f47' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/dyx]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-10-30 20:55:49.91+08	28	startalk.tech	d8f8cf45-78c2-4d31-b380-4cd6a69a1f47
3389f6c1bb4042a2ab0c339dec3c16a9	100094z_startalk.tech	<message from='3389f6c1bb4042a2ab0c339dec3c16a9@conference.startalk.tech/100094z_startalk.tech' to='3389f6c1bb4042a2ab0c339dec3c16a9@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1604062552428' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='995b24b5-a77d-4711-8daf-10c135e80df2' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/cy]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-10-30 20:55:52.428+08	29	startalk.tech	995b24b5-a77d-4711-8daf-10c135e80df2
b0b5ebc6f7f240a1a92b26a1f313d03a	b0b5ebc6f7f240a1a92b26a1f313d03a_conference.startalk.tech	<message from='b0b5ebc6f7f240a1a92b26a1f313d03a@conference.startalk.tech/b0b5ebc6f7f240a1a92b26a1f313d03a_conference.startalk.tech' to='b0b5ebc6f7f240a1a92b26a1f313d03a@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604062791470'><body msgType='15' id='http_290711604062791470'>珊珊JH 创建聊天室.</body></message>	t	0	2020-10-30 20:59:51.47+08	30	conference.startalk.tech	http_290711604062791470
b0b5ebc6f7f240a1a92b26a1f313d03a	b0b5ebc6f7f240a1a92b26a1f313d03a_conference.startalk.tech	<message from='b0b5ebc6f7f240a1a92b26a1f313d03a@conference.startalk.tech/b0b5ebc6f7f240a1a92b26a1f313d03a_conference.startalk.tech' to='b0b5ebc6f7f240a1a92b26a1f313d03a@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604062791617'><body msgType='15' id='http_619861604062791617'>珊珊JH 邀请 zhangchao5 进入聊天室.</body></message>	t	0	2020-10-30 20:59:51.617+08	31	conference.startalk.tech	http_619861604062791617
b0b5ebc6f7f240a1a92b26a1f313d03a	b0b5ebc6f7f240a1a92b26a1f313d03a_conference.startalk.tech	<message from='b0b5ebc6f7f240a1a92b26a1f313d03a@conference.startalk.tech/b0b5ebc6f7f240a1a92b26a1f313d03a_conference.startalk.tech' to='b0b5ebc6f7f240a1a92b26a1f313d03a@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604062800458'><body msgType='15' id='http_204041604062800458'>珊珊JH 邀请 杉杉 进入聊天室.</body></message>	t	0	2020-10-30 21:00:00.458+08	32	conference.startalk.tech	http_204041604062800458
95047e5e04014cd2b2ec4b16c85f744c	95047e5e04014cd2b2ec4b16c85f744c_conference.startalk.tech	<message from='95047e5e04014cd2b2ec4b16c85f744c@conference.startalk.tech/95047e5e04014cd2b2ec4b16c85f744c_conference.startalk.tech' to='95047e5e04014cd2b2ec4b16c85f744c@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604062859233'><body msgType='15' id='http_290711604062859233'>珊珊JH 创建聊天室.</body></message>	t	0	2020-10-30 21:00:59.233+08	33	conference.startalk.tech	http_290711604062859233
95047e5e04014cd2b2ec4b16c85f744c	95047e5e04014cd2b2ec4b16c85f744c_conference.startalk.tech	<message from='95047e5e04014cd2b2ec4b16c85f744c@conference.startalk.tech/95047e5e04014cd2b2ec4b16c85f744c_conference.startalk.tech' to='95047e5e04014cd2b2ec4b16c85f744c@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604062859382'><body msgType='15' id='http_619861604062859382'>珊珊JH 邀请 zhangchao5 进入聊天室.</body></message>	t	0	2020-10-30 21:00:59.382+08	34	conference.startalk.tech	http_619861604062859382
95047e5e04014cd2b2ec4b16c85f744c	95047e5e04014cd2b2ec4b16c85f744c_conference.startalk.tech	<message from='95047e5e04014cd2b2ec4b16c85f744c@conference.startalk.tech/95047e5e04014cd2b2ec4b16c85f744c_conference.startalk.tech' to='95047e5e04014cd2b2ec4b16c85f744c@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604062867972'><body msgType='15' id='http_204041604062867972'>珊珊JH 邀请 杉杉 进入聊天室.</body></message>	t	0	2020-10-30 21:01:07.972+08	35	conference.startalk.tech	http_204041604062867972
b10f8a925460494a96ffb7ef58002ffa	b10f8a925460494a96ffb7ef58002ffa_conference.startalk.tech	<message from='b10f8a925460494a96ffb7ef58002ffa@conference.startalk.tech/b10f8a925460494a96ffb7ef58002ffa_conference.startalk.tech' to='b10f8a925460494a96ffb7ef58002ffa@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604300567992'><body msgType='15' id='http_290711604300567992'>勇敢 创建聊天室.</body></message>	t	0	2020-11-02 15:02:47.992+08	44	conference.startalk.tech	http_290711604300567992
b10f8a925460494a96ffb7ef58002ffa	b10f8a925460494a96ffb7ef58002ffa_conference.startalk.tech	<message from='b10f8a925460494a96ffb7ef58002ffa@conference.startalk.tech/b10f8a925460494a96ffb7ef58002ffa_conference.startalk.tech' to='b10f8a925460494a96ffb7ef58002ffa@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604300568576'><body msgType='15' id='http_619861604300568576'>勇敢 邀请 珊珊JH 进入聊天室.</body></message>	t	0	2020-11-02 15:02:48.576+08	45	conference.startalk.tech	http_619861604300568576
3c1b6a39035c442a8f59e5704bba096a	3c1b6a39035c442a8f59e5704bba096a_conference.startalk.tech	<message from='3c1b6a39035c442a8f59e5704bba096a@conference.startalk.tech/3c1b6a39035c442a8f59e5704bba096a_conference.startalk.tech' to='3c1b6a39035c442a8f59e5704bba096a@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604127691961'><body msgType='15' id='http_290711604127691961'>珊珊JH 创建聊天室.</body></message>	t	0	2020-10-31 15:01:31.961+08	38	conference.startalk.tech	http_290711604127691961
95047e5e04014cd2b2ec4b16c85f744c	95047e5e04014cd2b2ec4b16c85f744c_conference.startalk.tech	<message from='95047e5e04014cd2b2ec4b16c85f744c@conference.startalk.tech/95047e5e04014cd2b2ec4b16c85f744c_conference.startalk.tech' to='95047e5e04014cd2b2ec4b16c85f744c@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604129645149'><body msgType='15' id='http_473861604129645149'>杉杉 邀请 勇敢 进入聊天室.</body></message>	t	0	2020-10-31 15:34:05.149+08	39	conference.startalk.tech	http_473861604129645149
18dd0d10d591479c858a92be057c694e	18dd0d10d591479c858a92be057c694e_conference.startalk.tech	<message from='18dd0d10d591479c858a92be057c694e@conference.startalk.tech/18dd0d10d591479c858a92be057c694e_conference.startalk.tech' to='18dd0d10d591479c858a92be057c694e@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604156283811'><body msgType='15' id='http_290711604156283811'>杉杉 创建聊天室.</body></message>	t	0	2020-10-31 22:58:03.811+08	40	conference.startalk.tech	http_290711604156283811
e299435983c34c3885d329e59a7561ca	e299435983c34c3885d329e59a7561ca_conference.startalk.tech	<message from='e299435983c34c3885d329e59a7561ca@conference.startalk.tech/e299435983c34c3885d329e59a7561ca_conference.startalk.tech' to='e299435983c34c3885d329e59a7561ca@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604156453990'><body msgType='15' id='http_290711604156453990'>杉杉 创建聊天室.</body></message>	t	0	2020-10-31 23:00:53.99+08	41	conference.startalk.tech	http_290711604156453990
55a59d75b08a4f77b76f75eb68cd3e15	55a59d75b08a4f77b76f75eb68cd3e15_conference.startalk.tech	<message from='55a59d75b08a4f77b76f75eb68cd3e15@conference.startalk.tech/55a59d75b08a4f77b76f75eb68cd3e15_conference.startalk.tech' to='55a59d75b08a4f77b76f75eb68cd3e15@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604157445200'><body msgType='15' id='http_290711604157445200'>杉杉 创建聊天室.</body></message>	t	0	2020-10-31 23:17:25.2+08	42	conference.startalk.tech	http_290711604157445200
55a59d75b08a4f77b76f75eb68cd3e15	55a59d75b08a4f77b76f75eb68cd3e15_conference.startalk.tech	<message from='55a59d75b08a4f77b76f75eb68cd3e15@conference.startalk.tech/55a59d75b08a4f77b76f75eb68cd3e15_conference.startalk.tech' to='55a59d75b08a4f77b76f75eb68cd3e15@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604157446387'><body msgType='15' id='http_619861604157446387'>杉杉 邀请 珊珊JH 进入聊天室.</body></message>	t	0	2020-10-31 23:17:26.387+08	43	conference.startalk.tech	http_619861604157446387
677930584d7145b6bd20b79f4bae7352	677930584d7145b6bd20b79f4bae7352_conference.startalk.tech	<message from='677930584d7145b6bd20b79f4bae7352@conference.startalk.tech/677930584d7145b6bd20b79f4bae7352_conference.startalk.tech' to='677930584d7145b6bd20b79f4bae7352@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604300640104'><body msgType='15' id='http_290711604300640104'>勇敢 创建聊天室.</body></message>	t	0	2020-11-02 15:04:00.104+08	46	conference.startalk.tech	http_290711604300640104
677930584d7145b6bd20b79f4bae7352	677930584d7145b6bd20b79f4bae7352_conference.startalk.tech	<message from='677930584d7145b6bd20b79f4bae7352@conference.startalk.tech/677930584d7145b6bd20b79f4bae7352_conference.startalk.tech' to='677930584d7145b6bd20b79f4bae7352@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604300640707'><body msgType='15' id='http_619861604300640707'>勇敢 邀请 杉杉 进入聊天室.</body></message>	t	0	2020-11-02 15:04:00.707+08	47	conference.startalk.tech	http_619861604300640707
56be69ae06e5475b9e85295de0ae4dd7	56be69ae06e5475b9e85295de0ae4dd7_conference.startalk.tech	<message from='56be69ae06e5475b9e85295de0ae4dd7@conference.startalk.tech/56be69ae06e5475b9e85295de0ae4dd7_conference.startalk.tech' to='56be69ae06e5475b9e85295de0ae4dd7@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604300729550'><body msgType='15' id='http_290711604300729550'>勇敢 创建聊天室.</body></message>	t	0	2020-11-02 15:05:29.55+08	48	conference.startalk.tech	http_290711604300729550
d62701c245234248aaa069f2e63e2474	d62701c245234248aaa069f2e63e2474_conference.startalk.tech	<message from='d62701c245234248aaa069f2e63e2474@conference.startalk.tech/d62701c245234248aaa069f2e63e2474_conference.startalk.tech' to='d62701c245234248aaa069f2e63e2474@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604304382441'><body msgType='15' id='http_290711604304382441'>勇敢 创建聊天室.</body></message>	t	0	2020-11-02 16:06:22.441+08	49	conference.startalk.tech	http_290711604304382441
d62701c245234248aaa069f2e63e2474	d62701c245234248aaa069f2e63e2474_conference.startalk.tech	<message from='d62701c245234248aaa069f2e63e2474@conference.startalk.tech/d62701c245234248aaa069f2e63e2474_conference.startalk.tech' to='d62701c245234248aaa069f2e63e2474@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604304383052'><body msgType='15' id='http_619861604304383052'>勇敢 邀请 珊珊JH 进入聊天室.</body></message>	t	0	2020-11-02 16:06:23.052+08	50	conference.startalk.tech	http_619861604304383052
d62701c245234248aaa069f2e63e2474	d62701c245234248aaa069f2e63e2474_conference.startalk.tech	<message from='d62701c245234248aaa069f2e63e2474@conference.startalk.tech/d62701c245234248aaa069f2e63e2474_conference.startalk.tech' to='d62701c245234248aaa069f2e63e2474@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604304397320'><body msgType='15' id='http_204041604304397320'>勇敢 邀请 杉杉 进入聊天室.</body></message>	t	0	2020-11-02 16:06:37.32+08	51	conference.startalk.tech	http_204041604304397320
64598a656b384af4b458473b72dceb26	64598a656b384af4b458473b72dceb26_conference.startalk.tech	<message from='64598a656b384af4b458473b72dceb26@conference.startalk.tech/64598a656b384af4b458473b72dceb26_conference.startalk.tech' to='64598a656b384af4b458473b72dceb26@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604304437977'><body msgType='15' id='http_290711604304437977'>勇敢 创建聊天室.</body></message>	t	0	2020-11-02 16:07:17.977+08	52	conference.startalk.tech	http_290711604304437977
64598a656b384af4b458473b72dceb26	64598a656b384af4b458473b72dceb26_conference.startalk.tech	<message from='64598a656b384af4b458473b72dceb26@conference.startalk.tech/64598a656b384af4b458473b72dceb26_conference.startalk.tech' to='64598a656b384af4b458473b72dceb26@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604304438618'><body msgType='15' id='http_619861604304438618'>勇敢 邀请 杉杉 进入聊天室.</body></message>	t	0	2020-11-02 16:07:18.618+08	53	conference.startalk.tech	http_619861604304438618
0229eb47b1154771866863ddab7c96b6	0229eb47b1154771866863ddab7c96b6_conference.startalk.tech	<message from='0229eb47b1154771866863ddab7c96b6@conference.startalk.tech/0229eb47b1154771866863ddab7c96b6_conference.startalk.tech' to='0229eb47b1154771866863ddab7c96b6@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604308562017'><body msgType='15' id='http_290711604308562017'>勇敢 创建聊天室.</body></message>	t	0	2020-11-02 17:16:02.017+08	54	conference.startalk.tech	http_290711604308562017
0229eb47b1154771866863ddab7c96b6	0229eb47b1154771866863ddab7c96b6_conference.startalk.tech	<message from='0229eb47b1154771866863ddab7c96b6@conference.startalk.tech/0229eb47b1154771866863ddab7c96b6_conference.startalk.tech' to='0229eb47b1154771866863ddab7c96b6@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604308563234'><body msgType='15' id='http_619861604308563234'>勇敢 邀请 珊珊JH, 杉杉 进入聊天室.</body></message>	t	0	2020-11-02 17:16:03.234+08	55	conference.startalk.tech	http_619861604308563234
0229eb47b1154771866863ddab7c96b6	100095z_startalk.tech	<message from='0229eb47b1154771866863ddab7c96b6@conference.startalk.tech/100095z_startalk.tech' to='0229eb47b1154771866863ddab7c96b6@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1604308569704' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='5e010134ae4c45579e914f5b60ac7aeb' msgType='1'>123</body></message>	t	0	2020-11-02 17:16:09.704+08	56	startalk.tech	5e010134ae4c45579e914f5b60ac7aeb
0229eb47b1154771866863ddab7c96b6	100095z_startalk.tech	<message from='0229eb47b1154771866863ddab7c96b6@conference.startalk.tech/100095z_startalk.tech' to='0229eb47b1154771866863ddab7c96b6@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1604308583706' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='0d00c782af5b49ad8b97b3db8b9ece91' msgType='1'>12344</body></message>	t	0	2020-11-02 17:16:23.706+08	57	startalk.tech	0d00c782af5b49ad8b97b3db8b9ece91
abd227dec13a48bbbf4de1b44605bbcb	abd227dec13a48bbbf4de1b44605bbcb_conference.startalk.tech	<message from='abd227dec13a48bbbf4de1b44605bbcb@conference.startalk.tech/abd227dec13a48bbbf4de1b44605bbcb_conference.startalk.tech' to='abd227dec13a48bbbf4de1b44605bbcb@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604308873639'><body msgType='15' id='http_290711604308873639'>珊珊JH 创建聊天室.</body></message>	t	0	2020-11-02 17:21:13.639+08	58	conference.startalk.tech	http_290711604308873639
abd227dec13a48bbbf4de1b44605bbcb	abd227dec13a48bbbf4de1b44605bbcb_conference.startalk.tech	<message from='abd227dec13a48bbbf4de1b44605bbcb@conference.startalk.tech/abd227dec13a48bbbf4de1b44605bbcb_conference.startalk.tech' to='abd227dec13a48bbbf4de1b44605bbcb@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604308873849'><body msgType='15' id='http_619861604308873849'>珊珊JH 邀请 zhangchao5 进入聊天室.</body></message>	t	0	2020-11-02 17:21:13.849+08	59	conference.startalk.tech	http_619861604308873849
abd227dec13a48bbbf4de1b44605bbcb	100094z_startalk.tech	<message from='abd227dec13a48bbbf4de1b44605bbcb@conference.startalk.tech/100094z_startalk.tech' to='abd227dec13a48bbbf4de1b44605bbcb@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1604308879095' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='55917edf-90c2-4212-8633-1c3b6c00f0d4' msgType='1'>1111\n</body></message>	t	0	2020-11-02 17:21:19.095+08	60	startalk.tech	55917edf-90c2-4212-8633-1c3b6c00f0d4
ead71a2044ea4007b275e4c1dd6326ae	ead71a2044ea4007b275e4c1dd6326ae_conference.startalk.tech	<message from='ead71a2044ea4007b275e4c1dd6326ae@conference.startalk.tech/ead71a2044ea4007b275e4c1dd6326ae_conference.startalk.tech' to='ead71a2044ea4007b275e4c1dd6326ae@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604309685499'><body msgType='15' id='http_290711604309685499'>珊珊JH 创建聊天室.</body></message>	t	0	2020-11-02 17:34:45.499+08	61	conference.startalk.tech	http_290711604309685499
b53827521885446b9b53cd68c885f878	b53827521885446b9b53cd68c885f878_conference.startalk.tech	<message from='b53827521885446b9b53cd68c885f878@conference.startalk.tech/b53827521885446b9b53cd68c885f878_conference.startalk.tech' to='b53827521885446b9b53cd68c885f878@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604309964882'><body msgType='15' id='http_290711604309964882'>珊珊JH 创建聊天室.</body></message>	t	0	2020-11-02 17:39:24.882+08	62	conference.startalk.tech	http_290711604309964882
b53827521885446b9b53cd68c885f878	100094z_startalk.tech	<message from='b53827521885446b9b53cd68c885f878@conference.startalk.tech/100094z_startalk.tech' to='b53827521885446b9b53cd68c885f878@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1604309968647' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='95c64920-bcd9-400d-b5ee-a0c5e8a90ba6' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/dzwx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/dzwx]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-02 17:39:28.647+08	63	startalk.tech	95c64920-bcd9-400d-b5ee-a0c5e8a90ba6
42b028bd797443fb8230a73b1caf0931	42b028bd797443fb8230a73b1caf0931_conference.startalk.tech	<message from='42b028bd797443fb8230a73b1caf0931@conference.startalk.tech/42b028bd797443fb8230a73b1caf0931_conference.startalk.tech' to='42b028bd797443fb8230a73b1caf0931@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604310233440'><body msgType='15' id='http_473861604310233440'>JH伽勒 邀请 杉杉 进入聊天室.</body></message>	t	0	2020-11-02 17:43:53.44+08	64	conference.startalk.tech	http_473861604310233440
42b028bd797443fb8230a73b1caf0931	100095z_startalk.tech	<message from='42b028bd797443fb8230a73b1caf0931@conference.startalk.tech/100095z_startalk.tech' to='42b028bd797443fb8230a73b1caf0931@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1604310246817' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='1094081aba24460cae08620d1a1540b0' msgType='1'>可以吗</body></message>	t	0	2020-11-02 17:44:06.817+08	65	startalk.tech	1094081aba24460cae08620d1a1540b0
42b028bd797443fb8230a73b1caf0931	100004q_startalk.tech	<message from='42b028bd797443fb8230a73b1caf0931@conference.startalk.tech/100004q_startalk.tech' to='42b028bd797443fb8230a73b1caf0931@conference.startalk.tech' sendjid='100004q@startalk.tech' realfrom='100004q@startalk.tech' msec_times='1604310275016' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='f1d76535-d588-4381-8ed5-06a360a58442' msgType='1'>可以</body></message>	t	0	2020-11-02 17:44:35.016+08	66	startalk.tech	f1d76535-d588-4381-8ed5-06a360a58442
42b028bd797443fb8230a73b1caf0931	100095z_startalk.tech	<message from='42b028bd797443fb8230a73b1caf0931@conference.startalk.tech/100095z_startalk.tech' to='42b028bd797443fb8230a73b1caf0931@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1604310283982' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='9119720e67e3463fb279ba460b39eea9' msgType='1'>那是什么问题？</body></message>	t	0	2020-11-02 17:44:43.982+08	67	startalk.tech	9119720e67e3463fb279ba460b39eea9
42b028bd797443fb8230a73b1caf0931	100004q_startalk.tech	<message from='42b028bd797443fb8230a73b1caf0931@conference.startalk.tech/100004q_startalk.tech' to='42b028bd797443fb8230a73b1caf0931@conference.startalk.tech' sendjid='100004q@startalk.tech' realfrom='100004q@startalk.tech' msec_times='1604310295448' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='0a8b989d-7f38-4615-bfa2-6e7671a7f24b' msgType='1'>你搜的是自己</body></message>	t	0	2020-11-02 17:44:55.448+08	68	startalk.tech	0a8b989d-7f38-4615-bfa2-6e7671a7f24b
42b028bd797443fb8230a73b1caf0931	100095z_startalk.tech	<message from='42b028bd797443fb8230a73b1caf0931@conference.startalk.tech/100095z_startalk.tech' to='42b028bd797443fb8230a73b1caf0931@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1604310381866' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='b30db9947b904d1a9d35ed056289b88a' msgType='1'>不是的，我珊珊去搜杉杉，没找到；或者通过ID都说也没有</body></message>	t	0	2020-11-02 17:46:21.866+08	69	startalk.tech	b30db9947b904d1a9d35ed056289b88a
42b028bd797443fb8230a73b1caf0931	100004q_startalk.tech	<message from='42b028bd797443fb8230a73b1caf0931@conference.startalk.tech/100004q_startalk.tech' to='42b028bd797443fb8230a73b1caf0931@conference.startalk.tech' sendjid='100004q@startalk.tech' realfrom='100004q@startalk.tech' msec_times='1604310397508' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='ed2394ee-c66c-427f-85bf-2fc22757b6ae' msgType='1'>重启一下</body></message>	t	0	2020-11-02 17:46:37.508+08	70	startalk.tech	ed2394ee-c66c-427f-85bf-2fc22757b6ae
42b028bd797443fb8230a73b1caf0931	100095z_startalk.tech	<message from='42b028bd797443fb8230a73b1caf0931@conference.startalk.tech/100095z_startalk.tech' to='42b028bd797443fb8230a73b1caf0931@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1604310402271' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='a01f80b1c33e4099940568ebe1effba9' msgType='1'>好的</body></message>	t	0	2020-11-02 17:46:42.271+08	71	startalk.tech	a01f80b1c33e4099940568ebe1effba9
575b0da2c0e44f5aade67f4bcd161e8f	575b0da2c0e44f5aade67f4bcd161e8f_conference.startalk.tech	<message from='575b0da2c0e44f5aade67f4bcd161e8f@conference.startalk.tech/575b0da2c0e44f5aade67f4bcd161e8f_conference.startalk.tech' to='575b0da2c0e44f5aade67f4bcd161e8f@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604310704127'><body msgType='15' id='http_290711604310704127'>勇敢 创建聊天室.</body></message>	t	0	2020-11-02 17:51:44.127+08	72	conference.startalk.tech	http_290711604310704127
08385b97f4954b4ba55fab2277f26436	08385b97f4954b4ba55fab2277f26436_conference.startalk.tech	<message from='08385b97f4954b4ba55fab2277f26436@conference.startalk.tech/08385b97f4954b4ba55fab2277f26436_conference.startalk.tech' to='08385b97f4954b4ba55fab2277f26436@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604310760047'><body msgType='15' id='http_290711604310760047'>珊珊JH 创建聊天室.</body></message>	t	0	2020-11-02 17:52:40.047+08	73	conference.startalk.tech	http_290711604310760047
b58cb19af6c04a71af24417aef49cf0b	b58cb19af6c04a71af24417aef49cf0b_conference.startalk.tech	<message from='b58cb19af6c04a71af24417aef49cf0b@conference.startalk.tech/b58cb19af6c04a71af24417aef49cf0b_conference.startalk.tech' to='b58cb19af6c04a71af24417aef49cf0b@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604310907472'><body msgType='15' id='http_290711604310907472'>珊珊JH 创建聊天室.</body></message>	t	0	2020-11-02 17:55:07.472+08	74	conference.startalk.tech	http_290711604310907472
b58cb19af6c04a71af24417aef49cf0b	b58cb19af6c04a71af24417aef49cf0b_conference.startalk.tech	<message from='b58cb19af6c04a71af24417aef49cf0b@conference.startalk.tech/b58cb19af6c04a71af24417aef49cf0b_conference.startalk.tech' to='b58cb19af6c04a71af24417aef49cf0b@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604310908100'><body msgType='15' id='http_619861604310908100'>珊珊JH 邀请 zhangchao5 进入聊天室.</body></message>	t	0	2020-11-02 17:55:08.1+08	75	conference.startalk.tech	http_619861604310908100
03bf3595212f4c098fc3b4967af8467d	03bf3595212f4c098fc3b4967af8467d_conference.startalk.tech	<message from='03bf3595212f4c098fc3b4967af8467d@conference.startalk.tech/03bf3595212f4c098fc3b4967af8467d_conference.startalk.tech' to='03bf3595212f4c098fc3b4967af8467d@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604310930944'><body msgType='15' id='http_290711604310930944'>勇敢 创建聊天室.</body></message>	t	0	2020-11-02 17:55:30.944+08	76	conference.startalk.tech	http_290711604310930944
b2c2ec63c86e469e9d9199b8f224dde6	b2c2ec63c86e469e9d9199b8f224dde6_conference.startalk.tech	<message from='b2c2ec63c86e469e9d9199b8f224dde6@conference.startalk.tech/b2c2ec63c86e469e9d9199b8f224dde6_conference.startalk.tech' to='b2c2ec63c86e469e9d9199b8f224dde6@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604310958375'><body msgType='15' id='http_290711604310958375'>珊珊JH 创建聊天室.</body></message>	t	0	2020-11-02 17:55:58.375+08	77	conference.startalk.tech	http_290711604310958375
b2c2ec63c86e469e9d9199b8f224dde6	b2c2ec63c86e469e9d9199b8f224dde6_conference.startalk.tech	<message from='b2c2ec63c86e469e9d9199b8f224dde6@conference.startalk.tech/b2c2ec63c86e469e9d9199b8f224dde6_conference.startalk.tech' to='b2c2ec63c86e469e9d9199b8f224dde6@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604310959022'><body msgType='15' id='http_619861604310959022'>珊珊JH 邀请 勇敢, zhangchao5 进入聊天室.</body></message>	t	0	2020-11-02 17:55:59.022+08	78	conference.startalk.tech	http_619861604310959022
b2c2ec63c86e469e9d9199b8f224dde6	b2c2ec63c86e469e9d9199b8f224dde6_conference.startalk.tech	<message from='b2c2ec63c86e469e9d9199b8f224dde6@conference.startalk.tech/b2c2ec63c86e469e9d9199b8f224dde6_conference.startalk.tech' to='b2c2ec63c86e469e9d9199b8f224dde6@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604310965405'><body msgType='15' id='http_204041604310965405'>珊珊JH 邀请 JH伽勒 进入聊天室.</body></message>	t	0	2020-11-02 17:56:05.405+08	79	conference.startalk.tech	http_204041604310965405
408fcdfe35454d37ab20f02606ef0695	408fcdfe35454d37ab20f02606ef0695_conference.startalk.tech	<message from='408fcdfe35454d37ab20f02606ef0695@conference.startalk.tech/408fcdfe35454d37ab20f02606ef0695_conference.startalk.tech' to='408fcdfe35454d37ab20f02606ef0695@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604311062682'><body msgType='15' id='http_290711604311062682'>沐沐 创建聊天室.</body></message>	t	0	2020-11-02 17:57:42.682+08	80	conference.startalk.tech	http_290711604311062682
ba2a497adbbe44c7b67f2dd81e53e8f9	ba2a497adbbe44c7b67f2dd81e53e8f9_conference.startalk.tech	<message from='ba2a497adbbe44c7b67f2dd81e53e8f9@conference.startalk.tech/ba2a497adbbe44c7b67f2dd81e53e8f9_conference.startalk.tech' to='ba2a497adbbe44c7b67f2dd81e53e8f9@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604311296232'><body msgType='15' id='http_290711604311296232'>JH伽勒 创建聊天室.</body></message>	t	0	2020-11-02 18:01:36.232+08	81	conference.startalk.tech	http_290711604311296232
ba2a497adbbe44c7b67f2dd81e53e8f9	ba2a497adbbe44c7b67f2dd81e53e8f9_conference.startalk.tech	<message from='ba2a497adbbe44c7b67f2dd81e53e8f9@conference.startalk.tech/ba2a497adbbe44c7b67f2dd81e53e8f9_conference.startalk.tech' to='ba2a497adbbe44c7b67f2dd81e53e8f9@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604311296643'><body msgType='15' id='http_619861604311296643'>JH伽勒 邀请 杉杉, 沐沐 进入聊天室.</body></message>	t	0	2020-11-02 18:01:36.643+08	82	conference.startalk.tech	http_619861604311296643
ba2a497adbbe44c7b67f2dd81e53e8f9	100004q_startalk.tech	<message from='ba2a497adbbe44c7b67f2dd81e53e8f9@conference.startalk.tech/100004q_startalk.tech' to='ba2a497adbbe44c7b67f2dd81e53e8f9@conference.startalk.tech' sendjid='100004q@startalk.tech' realfrom='100004q@startalk.tech' msec_times='1604311302889' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='7ca549d5-683e-4ea9-aa6c-4e686ffcd098' msgType='1'>hi</body></message>	t	0	2020-11-02 18:01:42.889+08	83	startalk.tech	7ca549d5-683e-4ea9-aa6c-4e686ffcd098
b2c2ec63c86e469e9d9199b8f224dde6	100004q_startalk.tech	<message from='b2c2ec63c86e469e9d9199b8f224dde6@conference.startalk.tech/100004q_startalk.tech' to='b2c2ec63c86e469e9d9199b8f224dde6@conference.startalk.tech' sendjid='100004q@startalk.tech' realfrom='100004q@startalk.tech' msec_times='1604311306925' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='69e56fca-620f-40b8-9846-54d4ecf94caf' msgType='1'>hi</body></message>	t	0	2020-11-02 18:01:46.925+08	84	startalk.tech	69e56fca-620f-40b8-9846-54d4ecf94caf
ba2a497adbbe44c7b67f2dd81e53e8f9	mumu_startalk.tech	<message from='ba2a497adbbe44c7b67f2dd81e53e8f9@conference.startalk.tech/mumu_startalk.tech' to='ba2a497adbbe44c7b67f2dd81e53e8f9@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1604311311762' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='5960fef7-b3dc-43e3-aec7-846d0cdd1299' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/ak]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-02 18:01:51.762+08	85	startalk.tech	5960fef7-b3dc-43e3-aec7-846d0cdd1299
ba2a497adbbe44c7b67f2dd81e53e8f9	mumu_startalk.tech	<message from='ba2a497adbbe44c7b67f2dd81e53e8f9@conference.startalk.tech/mumu_startalk.tech' to='ba2a497adbbe44c7b67f2dd81e53e8f9@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1604311315145' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='039f9b62-1e74-4969-ab4f-52d949292068' msgType='1'>可以收到</body></message>	t	0	2020-11-02 18:01:55.145+08	86	startalk.tech	039f9b62-1e74-4969-ab4f-52d949292068
ba2a497adbbe44c7b67f2dd81e53e8f9	100095z_startalk.tech	<message from='ba2a497adbbe44c7b67f2dd81e53e8f9@conference.startalk.tech/100095z_startalk.tech' to='ba2a497adbbe44c7b67f2dd81e53e8f9@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1604311326674' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='a53db1d01b2948258423c2318f8bc9da' msgType='1'>可以收到</body></message>	t	0	2020-11-02 18:02:06.674+08	87	startalk.tech	a53db1d01b2948258423c2318f8bc9da
ba2a497adbbe44c7b67f2dd81e53e8f9	100004q_startalk.tech	<message from='ba2a497adbbe44c7b67f2dd81e53e8f9@conference.startalk.tech/100004q_startalk.tech' to='ba2a497adbbe44c7b67f2dd81e53e8f9@conference.startalk.tech' sendjid='100004q@startalk.tech' realfrom='100004q@startalk.tech' msec_times='1604311334060' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='adafa94b-552c-458d-be7e-e520aa3bdd01' msgType='1'>加下别人试试</body></message>	t	0	2020-11-02 18:02:14.06+08	88	startalk.tech	adafa94b-552c-458d-be7e-e520aa3bdd01
ba2a497adbbe44c7b67f2dd81e53e8f9	ba2a497adbbe44c7b67f2dd81e53e8f9_conference.startalk.tech	<message from='ba2a497adbbe44c7b67f2dd81e53e8f9@conference.startalk.tech/ba2a497adbbe44c7b67f2dd81e53e8f9_conference.startalk.tech' to='ba2a497adbbe44c7b67f2dd81e53e8f9@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604311369478'><body msgType='15' id='http_204041604311369478'>杉杉 邀请 珊珊JH 进入聊天室.</body></message>	t	0	2020-11-02 18:02:49.478+08	89	conference.startalk.tech	http_204041604311369478
b9f791d73c5045b7bad8f0c1235d22f4	b9f791d73c5045b7bad8f0c1235d22f4_conference.startalk.tech	<message from='b9f791d73c5045b7bad8f0c1235d22f4@conference.startalk.tech/b9f791d73c5045b7bad8f0c1235d22f4_conference.startalk.tech' to='b9f791d73c5045b7bad8f0c1235d22f4@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604311373573'><body msgType='15' id='http_290711604311373573'>JH伽勒 创建聊天室.</body></message>	t	0	2020-11-02 18:02:53.573+08	90	conference.startalk.tech	http_290711604311373573
ba2a497adbbe44c7b67f2dd81e53e8f9	100095z_startalk.tech	<message from='ba2a497adbbe44c7b67f2dd81e53e8f9@conference.startalk.tech/100095z_startalk.tech' to='ba2a497adbbe44c7b67f2dd81e53e8f9@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1604311381924' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='cfc5cdcf5c004cecb3804b7a4da459d5' msgType='1'>桌面版可以在群内加其他人进来</body></message>	t	0	2020-11-02 18:03:01.924+08	91	startalk.tech	cfc5cdcf5c004cecb3804b7a4da459d5
ba2a497adbbe44c7b67f2dd81e53e8f9	100095z_startalk.tech	<message from='ba2a497adbbe44c7b67f2dd81e53e8f9@conference.startalk.tech/100095z_startalk.tech' to='ba2a497adbbe44c7b67f2dd81e53e8f9@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1604311385514' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='c0b4a7d0abe345b1a5a3278cddc4d66f' msgType='1'>但是安卓不行</body></message>	t	0	2020-11-02 18:03:05.514+08	92	startalk.tech	c0b4a7d0abe345b1a5a3278cddc4d66f
ba2a497adbbe44c7b67f2dd81e53e8f9	100095z_startalk.tech	<message from='ba2a497adbbe44c7b67f2dd81e53e8f9@conference.startalk.tech/100095z_startalk.tech' to='ba2a497adbbe44c7b67f2dd81e53e8f9@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1604311395546' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='3a44801862c3414faf5228853bc7e712' msgType='1'>安卓搜索不出</body></message>	t	0	2020-11-02 18:03:15.546+08	93	startalk.tech	3a44801862c3414faf5228853bc7e712
ba2a497adbbe44c7b67f2dd81e53e8f9	100094z_startalk.tech	<message from='ba2a497adbbe44c7b67f2dd81e53e8f9@conference.startalk.tech/100094z_startalk.tech' to='ba2a497adbbe44c7b67f2dd81e53e8f9@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1604315203641' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;FILEID&quot;:&quot;9bf9bb8c69ac4f6bb8c75e96d6f68ad9&quot;,&quot;FileName&quot;:&quot;test.txt&quot;,&quot;FileSize&quot;:&quot;0.00KB&quot;,&quot;FILEMD5&quot;:&quot;004881ebe3826cf16cfd124968f2a5bb&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/004881ebe3826cf16cfd124968f2a5bb?name=004881ebe3826cf16cfd124968f2a5bb.txt&quot;}' id='9bf9bb8c69ac4f6bb8c75e96d6f68ad9' msgType='5'>{&quot;FILEID&quot;:&quot;9bf9bb8c69ac4f6bb8c75e96d6f68ad9&quot;,&quot;FileName&quot;:&quot;test.txt&quot;,&quot;FileSize&quot;:&quot;0.00KB&quot;,&quot;FILEMD5&quot;:&quot;004881ebe3826cf16cfd124968f2a5bb&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/004881ebe3826cf16cfd124968f2a5bb?name=004881ebe3826cf16cfd124968f2a5bb.txt&quot;}</body></message>	t	0	2020-11-02 19:06:43.641+08	94	startalk.tech	9bf9bb8c69ac4f6bb8c75e96d6f68ad9
ba2a497adbbe44c7b67f2dd81e53e8f9	100004q_startalk.tech	<message from='ba2a497adbbe44c7b67f2dd81e53e8f9@conference.startalk.tech/100004q_startalk.tech' to='ba2a497adbbe44c7b67f2dd81e53e8f9@conference.startalk.tech' sendjid='100004q@startalk.tech' realfrom='100004q@startalk.tech' msec_times='1604315443220' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='11db9422-0f71-40f6-aa31-a725c8fa7750' msgType='1'>模拟器和手机都不行，是吗？</body></message>	t	0	2020-11-02 19:10:43.22+08	95	startalk.tech	11db9422-0f71-40f6-aa31-a725c8fa7750
42b028bd797443fb8230a73b1caf0931	42b028bd797443fb8230a73b1caf0931_conference.startalk.tech	<message from='42b028bd797443fb8230a73b1caf0931@conference.startalk.tech/42b028bd797443fb8230a73b1caf0931_conference.startalk.tech' to='42b028bd797443fb8230a73b1caf0931@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604368151551'><body msgType='15' id='http_473861604368151551'>杉杉 邀请 珊珊JH, 勇敢 进入聊天室.</body></message>	t	0	2020-11-03 09:49:11.551+08	97	conference.startalk.tech	http_473861604368151551
ba2a497adbbe44c7b67f2dd81e53e8f9	100094z_startalk.tech	<message from='ba2a497adbbe44c7b67f2dd81e53e8f9@conference.startalk.tech/100094z_startalk.tech' to='ba2a497adbbe44c7b67f2dd81e53e8f9@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1604315903925' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;FILEID&quot;:&quot;8775082f16ef4c07bf9500616dde38b0&quot;,&quot;FileName&quot;:&quot;test.txt&quot;,&quot;FileSize&quot;:&quot;0.00KB&quot;,&quot;FILEMD5&quot;:&quot;004881ebe3826cf16cfd124968f2a5bb&quot;,&quot;HttpUrl&quot;:&quot;http://47.52.208.181:8080/im_http_service/file/v2/download/004881EBE3826CF16CFD124968F2A5BB.txt&quot;}' id='8775082f16ef4c07bf9500616dde38b0' msgType='5'>{&quot;FILEID&quot;:&quot;8775082f16ef4c07bf9500616dde38b0&quot;,&quot;FileName&quot;:&quot;test.txt&quot;,&quot;FileSize&quot;:&quot;0.00KB&quot;,&quot;FILEMD5&quot;:&quot;004881ebe3826cf16cfd124968f2a5bb&quot;,&quot;HttpUrl&quot;:&quot;http://47.52.208.181:8080/im_http_service/file/v2/download/004881EBE3826CF16CFD124968F2A5BB.txt&quot;}</body></message>	t	0	2020-11-02 19:18:23.925+08	96	startalk.tech	8775082f16ef4c07bf9500616dde38b0
da499de5f90e42a789b91e75a75d075c	da499de5f90e42a789b91e75a75d075c_conference.startalk.tech	<message from='da499de5f90e42a789b91e75a75d075c@conference.startalk.tech/da499de5f90e42a789b91e75a75d075c_conference.startalk.tech' to='da499de5f90e42a789b91e75a75d075c@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604372403416'><body msgType='15' id='http_290711604372403416'>杉杉 创建聊天室.</body></message>	t	0	2020-11-03 11:00:03.416+08	98	conference.startalk.tech	http_290711604372403416
a6c0d98b4c9045e88a88098b5424c812	a6c0d98b4c9045e88a88098b5424c812_conference.startalk.tech	<message from='a6c0d98b4c9045e88a88098b5424c812@conference.startalk.tech/a6c0d98b4c9045e88a88098b5424c812_conference.startalk.tech' to='a6c0d98b4c9045e88a88098b5424c812@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604373676798'><body msgType='15' id='http_290711604373676798'>杉杉 创建聊天室.</body></message>	t	0	2020-11-03 11:21:16.798+08	99	conference.startalk.tech	http_290711604373676798
a6c0d98b4c9045e88a88098b5424c812	a6c0d98b4c9045e88a88098b5424c812_conference.startalk.tech	<message from='a6c0d98b4c9045e88a88098b5424c812@conference.startalk.tech/a6c0d98b4c9045e88a88098b5424c812_conference.startalk.tech' to='a6c0d98b4c9045e88a88098b5424c812@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604373677164'><body msgType='15' id='http_619861604373677164'>杉杉 邀请 珊珊JH, 勇敢 进入聊天室.</body></message>	t	0	2020-11-03 11:21:17.164+08	100	conference.startalk.tech	http_619861604373677164
99f601bbbefd40de92e681fbe8d02048	99f601bbbefd40de92e681fbe8d02048_conference.startalk.tech	<message from='99f601bbbefd40de92e681fbe8d02048@conference.startalk.tech/99f601bbbefd40de92e681fbe8d02048_conference.startalk.tech' to='99f601bbbefd40de92e681fbe8d02048@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604373811967'><body msgType='15' id='http_290711604373811967'>杉杉 创建聊天室.</body></message>	t	0	2020-11-03 11:23:31.967+08	101	conference.startalk.tech	http_290711604373811967
99f601bbbefd40de92e681fbe8d02048	99f601bbbefd40de92e681fbe8d02048_conference.startalk.tech	<message from='99f601bbbefd40de92e681fbe8d02048@conference.startalk.tech/99f601bbbefd40de92e681fbe8d02048_conference.startalk.tech' to='99f601bbbefd40de92e681fbe8d02048@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604373812423'><body msgType='15' id='http_619861604373812423'>杉杉 邀请 勇敢 进入聊天室.</body></message>	t	0	2020-11-03 11:23:32.423+08	102	conference.startalk.tech	http_619861604373812423
53e4ccf7cd6049788f427737d03f2534	53e4ccf7cd6049788f427737d03f2534_conference.startalk.tech	<message from='53e4ccf7cd6049788f427737d03f2534@conference.startalk.tech/53e4ccf7cd6049788f427737d03f2534_conference.startalk.tech' to='53e4ccf7cd6049788f427737d03f2534@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604373837912'><body msgType='15' id='http_290711604373837912'>杉杉 创建聊天室.</body></message>	t	0	2020-11-03 11:23:57.912+08	103	conference.startalk.tech	http_290711604373837912
53e4ccf7cd6049788f427737d03f2534	53e4ccf7cd6049788f427737d03f2534_conference.startalk.tech	<message from='53e4ccf7cd6049788f427737d03f2534@conference.startalk.tech/53e4ccf7cd6049788f427737d03f2534_conference.startalk.tech' to='53e4ccf7cd6049788f427737d03f2534@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604373838414'><body msgType='15' id='http_619861604373838414'>杉杉 邀请 勇敢 进入聊天室.</body></message>	t	0	2020-11-03 11:23:58.414+08	104	conference.startalk.tech	http_619861604373838414
53e4ccf7cd6049788f427737d03f2534	53e4ccf7cd6049788f427737d03f2534_conference.startalk.tech	<message from='53e4ccf7cd6049788f427737d03f2534@conference.startalk.tech/53e4ccf7cd6049788f427737d03f2534_conference.startalk.tech' to='53e4ccf7cd6049788f427737d03f2534@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604373859405'><body msgType='15' id='http_473861604373859405'>杉杉 邀请 zhangchao5 进入聊天室.</body></message>	t	0	2020-11-03 11:24:19.405+08	105	conference.startalk.tech	http_473861604373859405
2ce913d30df441cf8fb82d3d42bf105b	2ce913d30df441cf8fb82d3d42bf105b_conference.startalk.tech	<message from='2ce913d30df441cf8fb82d3d42bf105b@conference.startalk.tech/2ce913d30df441cf8fb82d3d42bf105b_conference.startalk.tech' to='2ce913d30df441cf8fb82d3d42bf105b@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604373901940'><body msgType='15' id='http_290711604373901940'>杉杉 创建聊天室.</body></message>	t	0	2020-11-03 11:25:01.94+08	106	conference.startalk.tech	http_290711604373901940
221d33e20e17449db36173cdd39e76ff	221d33e20e17449db36173cdd39e76ff_conference.startalk.tech	<message from='221d33e20e17449db36173cdd39e76ff@conference.startalk.tech/221d33e20e17449db36173cdd39e76ff_conference.startalk.tech' to='221d33e20e17449db36173cdd39e76ff@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604662232353'><body msgType='15' id='http_290711604662232353'>杉杉 创建聊天室.</body></message>	t	0	2020-11-06 19:30:32.353+08	107	conference.startalk.tech	http_290711604662232353
221d33e20e17449db36173cdd39e76ff	221d33e20e17449db36173cdd39e76ff_conference.startalk.tech	<message from='221d33e20e17449db36173cdd39e76ff@conference.startalk.tech/221d33e20e17449db36173cdd39e76ff_conference.startalk.tech' to='221d33e20e17449db36173cdd39e76ff@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604662232745'><body msgType='15' id='http_619861604662232745'>杉杉 邀请 珊珊JH 进入聊天室.</body></message>	t	0	2020-11-06 19:30:32.745+08	108	conference.startalk.tech	http_619861604662232745
221d33e20e17449db36173cdd39e76ff	221d33e20e17449db36173cdd39e76ff_conference.startalk.tech	<message from='221d33e20e17449db36173cdd39e76ff@conference.startalk.tech/221d33e20e17449db36173cdd39e76ff_conference.startalk.tech' to='221d33e20e17449db36173cdd39e76ff@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604662239808'><body msgType='15' id='http_204041604662239808'>杉杉 邀请 勇敢 进入聊天室.</body></message>	t	0	2020-11-06 19:30:39.808+08	109	conference.startalk.tech	http_204041604662239808
5cde4d34a44544b9a58c7a592a851756	5cde4d34a44544b9a58c7a592a851756_conference.startalk.tech	<message from='5cde4d34a44544b9a58c7a592a851756@conference.startalk.tech/5cde4d34a44544b9a58c7a592a851756_conference.startalk.tech' to='5cde4d34a44544b9a58c7a592a851756@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604662323943'><body msgType='15' id='http_290711604662323943'>杉杉 创建聊天室.</body></message>	t	0	2020-11-06 19:32:03.943+08	110	conference.startalk.tech	http_290711604662323943
5cde4d34a44544b9a58c7a592a851756	5cde4d34a44544b9a58c7a592a851756_conference.startalk.tech	<message from='5cde4d34a44544b9a58c7a592a851756@conference.startalk.tech/5cde4d34a44544b9a58c7a592a851756_conference.startalk.tech' to='5cde4d34a44544b9a58c7a592a851756@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604662324322'><body msgType='15' id='http_619861604662324322'>杉杉 邀请 勇敢, 潮涨_startalk.tech 进入聊天室.</body></message>	t	0	2020-11-06 19:32:04.322+08	111	conference.startalk.tech	http_619861604662324322
5cde4d34a44544b9a58c7a592a851756	100095z_startalk.tech	<message from='5cde4d34a44544b9a58c7a592a851756@conference.startalk.tech/100095z_startalk.tech' to='5cde4d34a44544b9a58c7a592a851756@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1604662334452' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='43a1a9d2b8e547558fe0967b85c6d28b' msgType='1'>122333</body></message>	t	0	2020-11-06 19:32:14.452+08	112	startalk.tech	43a1a9d2b8e547558fe0967b85c6d28b
5cde4d34a44544b9a58c7a592a851756	100095z_startalk.tech	<message from='5cde4d34a44544b9a58c7a592a851756@conference.startalk.tech/100095z_startalk.tech' to='5cde4d34a44544b9a58c7a592a851756@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1604662337197' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='eb9764dade734a24ab4a81abfb174e24' msgType='1'>1222</body></message>	t	0	2020-11-06 19:32:17.197+08	113	startalk.tech	eb9764dade734a24ab4a81abfb174e24
ba9fa0065e1c49e38415ac184ba3a3a8	ba9fa0065e1c49e38415ac184ba3a3a8_conference.startalk.tech	<message from='ba9fa0065e1c49e38415ac184ba3a3a8@conference.startalk.tech/ba9fa0065e1c49e38415ac184ba3a3a8_conference.startalk.tech' to='ba9fa0065e1c49e38415ac184ba3a3a8@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604662347305'><body msgType='15' id='http_290711604662347305'>杉杉 创建聊天室.</body></message>	t	0	2020-11-06 19:32:27.305+08	114	conference.startalk.tech	http_290711604662347305
ba9fa0065e1c49e38415ac184ba3a3a8	ba9fa0065e1c49e38415ac184ba3a3a8_conference.startalk.tech	<message from='ba9fa0065e1c49e38415ac184ba3a3a8@conference.startalk.tech/ba9fa0065e1c49e38415ac184ba3a3a8_conference.startalk.tech' to='ba9fa0065e1c49e38415ac184ba3a3a8@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604662347768'><body msgType='15' id='http_619861604662347768'>杉杉 邀请 珊珊JH, 勇敢, 潮涨_startalk.tech 进入聊天室.</body></message>	t	0	2020-11-06 19:32:27.768+08	115	conference.startalk.tech	http_619861604662347768
ba9fa0065e1c49e38415ac184ba3a3a8	100095z_startalk.tech	<message from='ba9fa0065e1c49e38415ac184ba3a3a8@conference.startalk.tech/100095z_startalk.tech' to='ba9fa0065e1c49e38415ac184ba3a3a8@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1604662352803' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='8c50187fe61f4583ab857145ea4034fd' msgType='1'>ddddd</body></message>	t	0	2020-11-06 19:32:32.803+08	116	startalk.tech	8c50187fe61f4583ab857145ea4034fd
221d33e20e17449db36173cdd39e76ff	100095z_startalk.tech	<message from='221d33e20e17449db36173cdd39e76ff@conference.startalk.tech/100095z_startalk.tech' to='221d33e20e17449db36173cdd39e76ff@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1604662365813' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='5360d2094af44d0ca9d207b28fd90829' msgType='1'>dfdfdf</body></message>	t	0	2020-11-06 19:32:45.813+08	117	startalk.tech	5360d2094af44d0ca9d207b28fd90829
221d33e20e17449db36173cdd39e76ff	100095z_startalk.tech	<message from='221d33e20e17449db36173cdd39e76ff@conference.startalk.tech/100095z_startalk.tech' to='221d33e20e17449db36173cdd39e76ff@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1604662381365' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='743ae9ed1b3f43e88176ddfb5b860009' msgType='1'>fdfdsfd</body></message>	t	0	2020-11-06 19:33:01.365+08	118	startalk.tech	743ae9ed1b3f43e88176ddfb5b860009
3b9ff47191c143e9991452fa02affa23	3b9ff47191c143e9991452fa02affa23_conference.startalk.tech	<message from='3b9ff47191c143e9991452fa02affa23@conference.startalk.tech/3b9ff47191c143e9991452fa02affa23_conference.startalk.tech' to='3b9ff47191c143e9991452fa02affa23@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604829418088'><body msgType='15' id='http_290711604829418088'>JH伽勒 创建聊天室.</body></message>	t	0	2020-11-08 17:56:58.088+08	119	conference.startalk.tech	http_290711604829418088
17a73d186c034b1ea71bfc3dd3108ee0	17a73d186c034b1ea71bfc3dd3108ee0_conference.startalk.tech	<message from='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech/17a73d186c034b1ea71bfc3dd3108ee0_conference.startalk.tech' to='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604966692037'><body msgType='15' id='http_290711604966692037'>杉杉 创建聊天室.</body></message>	t	0	2020-11-10 08:04:52.037+08	120	conference.startalk.tech	http_290711604966692037
17a73d186c034b1ea71bfc3dd3108ee0	17a73d186c034b1ea71bfc3dd3108ee0_conference.startalk.tech	<message from='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech/17a73d186c034b1ea71bfc3dd3108ee0_conference.startalk.tech' to='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604966692411'><body msgType='15' id='http_619861604966692411'>杉杉 邀请 珊珊JH 进入聊天室.</body></message>	t	0	2020-11-10 08:04:52.411+08	121	conference.startalk.tech	http_619861604966692411
6737bb1bb2af443086d57e81d71eeb94	6737bb1bb2af443086d57e81d71eeb94_conference.startalk.tech	<message from='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech/6737bb1bb2af443086d57e81d71eeb94_conference.startalk.tech' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604969934071'><body msgType='15' id='http_290711604969934071'>珊珊JH 创建聊天室.</body></message>	t	0	2020-11-10 08:58:54.071+08	122	conference.startalk.tech	http_290711604969934071
6737bb1bb2af443086d57e81d71eeb94	6737bb1bb2af443086d57e81d71eeb94_conference.startalk.tech	<message from='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech/6737bb1bb2af443086d57e81d71eeb94_conference.startalk.tech' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604969934263'><body msgType='15' id='http_619861604969934263'>珊珊JH 邀请 沐沐, 杉杉 进入聊天室.</body></message>	t	0	2020-11-10 08:58:54.263+08	123	conference.startalk.tech	http_619861604969934263
17a73d186c034b1ea71bfc3dd3108ee0	17a73d186c034b1ea71bfc3dd3108ee0_conference.startalk.tech	<message from='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech/17a73d186c034b1ea71bfc3dd3108ee0_conference.startalk.tech' to='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604971447957'><body msgType='15' id='http_473861604971447957'>杉杉 邀请 沐沐 进入聊天室.</body></message>	t	0	2020-11-10 09:24:07.957+08	124	conference.startalk.tech	http_473861604971447957
83d2403acedf4b39877f592244043dee	83d2403acedf4b39877f592244043dee_conference.startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/83d2403acedf4b39877f592244043dee_conference.startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604971459153'><body msgType='15' id='http_290711604971459153'>杉杉 创建聊天室.</body></message>	t	0	2020-11-10 09:24:19.153+08	125	conference.startalk.tech	http_290711604971459153
83d2403acedf4b39877f592244043dee	83d2403acedf4b39877f592244043dee_conference.startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/83d2403acedf4b39877f592244043dee_conference.startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604971459831'><body msgType='15' id='http_619861604971459831'>杉杉 邀请 珊珊JH, 勇敢 进入聊天室.</body></message>	t	0	2020-11-10 09:24:19.831+08	126	conference.startalk.tech	http_619861604971459831
9afcd37223a842d6b39f29ec13e2d678	9afcd37223a842d6b39f29ec13e2d678_conference.startalk.tech	<message from='9afcd37223a842d6b39f29ec13e2d678@conference.startalk.tech/9afcd37223a842d6b39f29ec13e2d678_conference.startalk.tech' to='9afcd37223a842d6b39f29ec13e2d678@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604971473922'><body msgType='15' id='http_290711604971473922'>杉杉 创建聊天室.</body></message>	t	0	2020-11-10 09:24:33.922+08	127	conference.startalk.tech	http_290711604971473922
9afcd37223a842d6b39f29ec13e2d678	9afcd37223a842d6b39f29ec13e2d678_conference.startalk.tech	<message from='9afcd37223a842d6b39f29ec13e2d678@conference.startalk.tech/9afcd37223a842d6b39f29ec13e2d678_conference.startalk.tech' to='9afcd37223a842d6b39f29ec13e2d678@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604971474958'><body msgType='15' id='http_619861604971474958'>杉杉 邀请 珊珊JH 进入聊天室.</body></message>	t	0	2020-11-10 09:24:34.958+08	128	conference.startalk.tech	http_619861604971474958
83d2403acedf4b39877f592244043dee	83d2403acedf4b39877f592244043dee_conference.startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/83d2403acedf4b39877f592244043dee_conference.startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604971760377'><body msgType='15' id='http_204041604971760377'>勇敢 邀请 沐沐 进入聊天室.</body></message>	t	0	2020-11-10 09:29:20.377+08	129	conference.startalk.tech	http_204041604971760377
83d2403acedf4b39877f592244043dee	100096z_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100096z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100096z@startalk.tech' realfrom='100096z@startalk.tech' msec_times='1604971766406' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='884f1ed4-9d47-4c0f-8713-ec739e5f44e9' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/ak]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-10 09:29:26.406+08	130	startalk.tech	884f1ed4-9d47-4c0f-8713-ec739e5f44e9
83d2403acedf4b39877f592244043dee	100096z_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100096z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100096z@startalk.tech' realfrom='100096z@startalk.tech' msec_times='1604971769056' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='c501af63-1119-4f59-978d-2e69121bcc2e' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/cy]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-10 09:29:29.056+08	131	startalk.tech	c501af63-1119-4f59-978d-2e69121bcc2e
83d2403acedf4b39877f592244043dee	100094z_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100094z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1604971777021' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='ffa371a4-5048-41af-8b70-3a0d035d6e9c' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-10 09:29:37.021+08	132	startalk.tech	ffa371a4-5048-41af-8b70-3a0d035d6e9c
83d2403acedf4b39877f592244043dee	100094z_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100094z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1604971779834' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='82dd7365-0ac3-4692-849d-d78a5a9ef0a6' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/dyx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/dyx]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-10 09:29:39.834+08	133	startalk.tech	82dd7365-0ac3-4692-849d-d78a5a9ef0a6
83d2403acedf4b39877f592244043dee	100095z_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100095z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1604971786712' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='a0ad4dbd510443db88c0927fc3946a3f' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xy]&quot; width=EmojiOne height=EmojiOne ]</body></message>	t	0	2020-11-10 09:29:46.712+08	134	startalk.tech	a0ad4dbd510443db88c0927fc3946a3f
83d2403acedf4b39877f592244043dee	100095z_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100095z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1604971796374' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='a532bc78c55d45c4b9ca6102a91f7fb7' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/ak]&quot; width=EmojiOne height=EmojiOne ]</body></message>	t	0	2020-11-10 09:29:56.374+08	135	startalk.tech	a532bc78c55d45c4b9ca6102a91f7fb7
83d2403acedf4b39877f592244043dee	100095z_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100095z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1604971823014' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='e8f8321d60c940a3ad78157f24154123' msgType='1'>你好</body></message>	t	0	2020-11-10 09:30:23.014+08	136	startalk.tech	e8f8321d60c940a3ad78157f24154123
83d2403acedf4b39877f592244043dee	100096z_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100096z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100096z@startalk.tech' realfrom='100096z@startalk.tech' msec_times='1604971830272' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='e9b6d267-15c3-477e-b35c-03cfd1b7ba8a' msgType='1'>大家好\n</body></message>	t	0	2020-11-10 09:30:30.272+08	137	startalk.tech	e9b6d267-15c3-477e-b35c-03cfd1b7ba8a
83d2403acedf4b39877f592244043dee	100096z_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100096z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100096z@startalk.tech' realfrom='100096z@startalk.tech' msec_times='1604971834025' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='1ba569d8-b319-4801-9243-16502f8f9229' msgType='1'>哈哈哈</body></message>	t	0	2020-11-10 09:30:34.025+08	138	startalk.tech	1ba569d8-b319-4801-9243-16502f8f9229
83d2403acedf4b39877f592244043dee	100096z_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100096z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100096z@startalk.tech' realfrom='100096z@startalk.tech' msec_times='1604972045726' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='091cb7fb-c95c-43c3-88d2-3f86b127d1cb' msgType='3'>[obj type=&quot;image&quot; value=&quot;file/v2/download/82e0e9495f288cbb247d2327f78f32c8.png?name=星语国内二维码.png&quot; width=398 height=388]</body></message>	t	0	2020-11-10 09:34:05.726+08	139	startalk.tech	091cb7fb-c95c-43c3-88d2-3f86b127d1cb
83d2403acedf4b39877f592244043dee	100094z_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100094z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1604972060658' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='d567e520-c023-4ce7-a0dd-cf6d3ff9c370' msgType='3'>[obj type=&quot;image&quot; value=&quot;file/v2/download/a4793e5160872a1d19704fc4f1c9dbae.jpg?name=a4793e5160872a1d19704fc4f1c9dbae.jpg&quot; width=1080 height=5159]</body></message>	t	0	2020-11-10 09:34:20.658+08	140	startalk.tech	d567e520-c023-4ce7-a0dd-cf6d3ff9c370
83d2403acedf4b39877f592244043dee	100095z_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100095z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1604972087193' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;FILEID&quot;:&quot;3431936f547e4a52b5222e6d9d9c310f&quot;,&quot;FileName&quot;:&quot;头像.jpg&quot;,&quot;FileSize&quot;:&quot;27.18KB&quot;,&quot;FILEMD5&quot;:&quot;98c31df0915b1357efb2c167a178e728&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/98c31df0915b1357efb2c167a178e728?name=98c31df0915b1357efb2c167a178e728.jpg&quot;}' id='3431936f547e4a52b5222e6d9d9c310f' msgType='5'>{&quot;FILEID&quot;:&quot;3431936f547e4a52b5222e6d9d9c310f&quot;,&quot;FileName&quot;:&quot;头像.jpg&quot;,&quot;FileSize&quot;:&quot;27.18KB&quot;,&quot;FILEMD5&quot;:&quot;98c31df0915b1357efb2c167a178e728&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/98c31df0915b1357efb2c167a178e728?name=98c31df0915b1357efb2c167a178e728.jpg&quot;}</body></message>	t	0	2020-11-10 09:34:47.193+08	141	startalk.tech	3431936f547e4a52b5222e6d9d9c310f
83d2403acedf4b39877f592244043dee	100094z_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100094z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1604972255184' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='bff1a812-d9dc-4614-9f70-f1c7d7dd0790' msgType='3'>[obj type=&quot;image&quot; value=&quot;file/v2/download/e1c7963e7a98029427499df4583b75e5.jpg?name=e1c7963e7a98029427499df4583b75e5.jpg&quot; width=1920 height=880]</body></message>	t	0	2020-11-10 09:37:35.184+08	142	startalk.tech	bff1a812-d9dc-4614-9f70-f1c7d7dd0790
83d2403acedf4b39877f592244043dee	100094z_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100094z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1604972392623' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body extendInfo='{&quot;FILEID&quot;:&quot;d2f4f9eb-3032-4719-a7fb-6d4f343dad9a&quot;,&quot;FILEMD5&quot;:&quot;4712edca8ea1b68cf0082cdfe1b1afc5&quot;,&quot;FileName&quot;:&quot;Dream_It_Possible.mp3&quot;,&quot;FileSize&quot;:&quot;8.09M&quot;,&quot;HttpUrl&quot;:&quot;file/v2/download/4712edca8ea1b68cf0082cdfe1b1afc5?name\\u003dDream_It_Possible.mp3&quot;,&quot;LocalFile&quot;:&quot;/product/media/Pre-loaded/Music/Dream_It_Possible.mp3&quot;,&quot;noMD5&quot;:false}' id='d2f4f9eb-3032-4719-a7fb-6d4f343dad9a' msgType='5'>{&quot;FILEID&quot;:&quot;d2f4f9eb-3032-4719-a7fb-6d4f343dad9a&quot;,&quot;FILEMD5&quot;:&quot;4712edca8ea1b68cf0082cdfe1b1afc5&quot;,&quot;FileName&quot;:&quot;Dream_It_Possible.mp3&quot;,&quot;FileSize&quot;:&quot;8.09M&quot;,&quot;HttpUrl&quot;:&quot;file/v2/download/4712edca8ea1b68cf0082cdfe1b1afc5?name\\u003dDream_It_Possible.mp3&quot;,&quot;LocalFile&quot;:&quot;/product/media/Pre-loaded/Music/Dream_It_Possible.mp3&quot;,&quot;noMD5&quot;:false}</body></message>	t	0	2020-11-10 09:39:52.623+08	143	startalk.tech	d2f4f9eb-3032-4719-a7fb-6d4f343dad9a
83d2403acedf4b39877f592244043dee	100095z_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100095z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1604972607805' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='059eb02a39814f7f9c551470b0655e6a' msgType='1'>[obj type=&quot;image&quot; value=&quot;https://im.startalk.tech:8443/file/v2/download/d01621b20c411b1b747ba8a78952e5b5.png?name=d01621b20c411b1b747ba8a78952e5b5.png&quot; width=238 height=172]</body></message>	t	0	2020-11-10 09:43:27.805+08	144	startalk.tech	059eb02a39814f7f9c551470b0655e6a
83d2403acedf4b39877f592244043dee	100095z_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100095z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1604972652190' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='80c004af744e4edcb1c953b458693e6a' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/byqq]&quot; width=EmojiOne height=EmojiOne ]</body></message>	t	0	2020-11-10 09:44:12.19+08	145	startalk.tech	80c004af744e4edcb1c953b458693e6a
83d2403acedf4b39877f592244043dee	100095z_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100095z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1604972657021' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='0c06f535a54d4cfca2b81c890f4e38dc' msgType='1'>「 杉杉: [obj type=&quot;emoticon&quot; value=&quot;[/byqq]&quot; width=EmojiOne height=EmojiOne ] 」\n -------------------------  \n你好</body></message>	t	0	2020-11-10 09:44:17.021+08	146	startalk.tech	0c06f535a54d4cfca2b81c890f4e38dc
83d2403acedf4b39877f592244043dee	100095z_startalk.tech	<message type='revoke' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' msec_times='1604972682931'><body id='6b5e0f435a664278b1eb0627653bea17' msgType='-1' extendInfo='{&quot;messageId&quot;:&quot;6b5e0f435a664278b1eb0627653bea17&quot;,&quot;fromId&quot;:&quot;100095z@startalk.tech/V[200010]_P[PC64]_ID[59b90b02440d4481beea15641315692f]_C[1]_PB&quot;}'>[撤销一条消息]</body><stime xmlns='jabber:stime:delay' stamp='20201110T01:44:42'/></message>	t	0	2020-11-10 09:44:42.931+08	148	startalk.tech	6b5e0f435a664278b1eb0627653bea17
83d2403acedf4b39877f592244043dee	100095z_startalk.tech	<message type='revoke' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' msec_times='1604972685158'><body id='7cf3fcb19df249aaa8ad5d5d46613bb9' msgType='-1' extendInfo='{&quot;messageId&quot;:&quot;7cf3fcb19df249aaa8ad5d5d46613bb9&quot;,&quot;fromId&quot;:&quot;100095z@startalk.tech/V[200010]_P[PC64]_ID[59b90b02440d4481beea15641315692f]_C[1]_PB&quot;}'>[撤销一条消息]</body><stime xmlns='jabber:stime:delay' stamp='20201110T01:44:45'/></message>	t	0	2020-11-10 09:44:45.158+08	147	startalk.tech	7cf3fcb19df249aaa8ad5d5d46613bb9
83d2403acedf4b39877f592244043dee	100095z_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100095z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1604972753595' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='936b3fc23bcc4f828c446afe35a2e256' msgType='1'>你好你好</body></message>	t	0	2020-11-10 09:45:53.595+08	149	startalk.tech	936b3fc23bcc4f828c446afe35a2e256
83d2403acedf4b39877f592244043dee	100095z_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100095z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1604972755558' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='eaf8726d15984c6995da48defb1f7ba4' msgType='1'>嗯嗯</body></message>	t	0	2020-11-10 09:45:55.558+08	150	startalk.tech	eaf8726d15984c6995da48defb1f7ba4
83d2403acedf4b39877f592244043dee	100095z_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100095z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1604972763631' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;title&quot;:&quot;杉杉,珊珊JH,勇敢的聊天记录&quot;,&quot;desc&quot;:&quot;&quot;,&quot;linkurl&quot;:&quot;https://im.startalk.tech:8443/py/sharemsg?jdata=&quot;}' id='87561e12e1ef4589a7bb2c44de0948dd' msgType='666'>收到了一个消息记录文件文件，请升级客户端查看。</body></message>	t	0	2020-11-10 09:46:03.631+08	151	startalk.tech	87561e12e1ef4589a7bb2c44de0948dd
83d2403acedf4b39877f592244043dee	100095z_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100095z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1604973038030' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='1b49798daa8a4a57ad34c8d72200c691' msgType='1'>[obj type=&quot;url&quot; value=&quot;www.baidu.com&quot;]</body></message>	t	0	2020-11-10 09:50:38.03+08	152	startalk.tech	1b49798daa8a4a57ad34c8d72200c691
83d2403acedf4b39877f592244043dee	100094z_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100094z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1604973169953' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='861c33bf-d000-489a-92af-6bb63aa6c638' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/dyx]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-10 09:52:49.953+08	153	startalk.tech	861c33bf-d000-489a-92af-6bb63aa6c638
83d2403acedf4b39877f592244043dee	100094z_startalk.tech	<message type='revoke' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' msec_times='1604973195346'><body id='836c4e04-673b-49a4-ad6f-7dcbc26970b0' msgType='-1' extendInfo='{&quot;messageId&quot;:&quot;836c4e04-673b-49a4-ad6f-7dcbc26970b0&quot;,&quot;fromId&quot;:&quot;100094z@startalk.tech/V[240]_P[Android]_D[ART-AL00x]_ID[7836f83e-0566-4979-9e6d-64c43691c5d0]_PB&quot;}'>[撤销一条消息]</body><stime xmlns='jabber:stime:delay' stamp='20201110T01:53:15'/></message>	t	0	2020-11-10 09:53:15.346+08	154	startalk.tech	836c4e04-673b-49a4-ad6f-7dcbc26970b0
83d2403acedf4b39877f592244043dee	100094z_startalk.tech	<message type='revoke' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' msec_times='1604973205394'><body id='ffc2f57c-476a-4fbe-8fba-c06b48242f52' msgType='-1' extendInfo='{&quot;messageId&quot;:&quot;ffc2f57c-476a-4fbe-8fba-c06b48242f52&quot;,&quot;fromId&quot;:&quot;100094z@startalk.tech/V[240]_P[Android]_D[ART-AL00x]_ID[7836f83e-0566-4979-9e6d-64c43691c5d0]_PB&quot;}'>[撤销一条消息]</body><stime xmlns='jabber:stime:delay' stamp='20201110T01:53:25'/></message>	t	0	2020-11-10 09:53:25.394+08	155	startalk.tech	ffc2f57c-476a-4fbe-8fba-c06b48242f52
83d2403acedf4b39877f592244043dee	100094z_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100094z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1604973220672' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='4d1723a0-e0d0-45cf-85ec-58124d741300' msgType='1'>[瞪眼笑]</body></message>	t	0	2020-11-10 09:53:40.672+08	156	startalk.tech	4d1723a0-e0d0-45cf-85ec-58124d741300
83d2403acedf4b39877f592244043dee	100094z_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100094z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1604973233415' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='58d2b927-386d-421d-a573-9fe4a39239bd' msgType='1'>[obj type=&quot;url&quot; value=&quot;www.baidu.com&quot;]</body></message>	t	0	2020-11-10 09:53:53.415+08	157	startalk.tech	58d2b927-386d-421d-a573-9fe4a39239bd
83d2403acedf4b39877f592244043dee	100094z_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100094z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1604973244541' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='86416b0f-484f-4e13-8e61-94d1152e60ef' msgType='1'>[瞪眼笑]</body></message>	t	0	2020-11-10 09:54:04.541+08	158	startalk.tech	86416b0f-484f-4e13-8e61-94d1152e60ef
83d2403acedf4b39877f592244043dee	100094z_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100094z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1604973255973' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='0b7d5551-d57a-4992-a56d-7b3161f237bb' msgType='1'>[obj type=&quot;url&quot; value=&quot;www.baidu.com&quot;]</body></message>	t	0	2020-11-10 09:54:15.973+08	159	startalk.tech	0b7d5551-d57a-4992-a56d-7b3161f237bb
83d2403acedf4b39877f592244043dee	100094z_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100094z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1604973275562' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='a6f94972-9ee7-4a8d-8295-da473af5083f' msgType='1'>今天  上午9:54\n「珊珊JH：[obj type=&quot;url&quot; value=&quot;www.baidu.com&quot;]」\n- - - - - - - - - - - - - - -\n刚刚</body></message>	t	0	2020-11-10 09:54:35.562+08	160	startalk.tech	a6f94972-9ee7-4a8d-8295-da473af5083f
83d2403acedf4b39877f592244043dee	100095z_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100095z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1604973499117' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='65cc5e4fbc0c472a88820802c6943dd3' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/byx]&quot; width=EmojiOne height=EmojiOne ]</body></message>	t	0	2020-11-10 09:58:19.117+08	161	startalk.tech	65cc5e4fbc0c472a88820802c6943dd3
83d2403acedf4b39877f592244043dee	100094z_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100094z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1604973513433' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='8a8dc0da-d666-4d56-8899-acb0e73e1b18' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/ak]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/ak]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-10 09:58:33.433+08	162	startalk.tech	8a8dc0da-d666-4d56-8899-acb0e73e1b18
83d2403acedf4b39877f592244043dee	100095z_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100095z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1604973543785' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='369053a988724bd2b12ac2813108af3e' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/byqq]&quot; width=EmojiOne height=EmojiOne ]</body></message>	t	0	2020-11-10 09:59:03.785+08	163	startalk.tech	369053a988724bd2b12ac2813108af3e
83d2403acedf4b39877f592244043dee	100094z_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100094z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1604973565202' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='9e019e89-f48b-4295-8148-878b518589ce' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/cy]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/cy]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/cy]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-10 09:59:25.202+08	164	startalk.tech	9e019e89-f48b-4295-8148-878b518589ce
83d2403acedf4b39877f592244043dee	100094z_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100094z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1604973575690' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='5eaae652-5de8-4907-bca1-5b79719c6035' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/byx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/byx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/byx]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-10 09:59:35.69+08	165	startalk.tech	5eaae652-5de8-4907-bca1-5b79719c6035
6dec5e56b25741a9ba0ad2e04766d8d4	6dec5e56b25741a9ba0ad2e04766d8d4_conference.startalk.tech	<message from='6dec5e56b25741a9ba0ad2e04766d8d4@conference.startalk.tech/6dec5e56b25741a9ba0ad2e04766d8d4_conference.startalk.tech' to='6dec5e56b25741a9ba0ad2e04766d8d4@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604973720480'><body msgType='15' id='http_290711604973720480'>珊珊JH 创建聊天室.</body></message>	t	0	2020-11-10 10:02:00.48+08	166	conference.startalk.tech	http_290711604973720480
6dec5e56b25741a9ba0ad2e04766d8d4	6dec5e56b25741a9ba0ad2e04766d8d4_conference.startalk.tech	<message from='6dec5e56b25741a9ba0ad2e04766d8d4@conference.startalk.tech/6dec5e56b25741a9ba0ad2e04766d8d4_conference.startalk.tech' to='6dec5e56b25741a9ba0ad2e04766d8d4@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604973720636'><body msgType='15' id='http_619861604973720636'>珊珊JH 邀请 杉杉 进入聊天室.</body></message>	t	0	2020-11-10 10:02:00.636+08	167	conference.startalk.tech	http_619861604973720636
6dec5e56b25741a9ba0ad2e04766d8d4	6dec5e56b25741a9ba0ad2e04766d8d4_conference.startalk.tech	<message from='6dec5e56b25741a9ba0ad2e04766d8d4@conference.startalk.tech/6dec5e56b25741a9ba0ad2e04766d8d4_conference.startalk.tech' to='6dec5e56b25741a9ba0ad2e04766d8d4@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604973729271'><body msgType='15' id='http_204041604973729271'>珊珊JH 邀请 勇敢 进入聊天室.</body></message>	t	0	2020-11-10 10:02:09.271+08	168	conference.startalk.tech	http_204041604973729271
3b9ff47191c143e9991452fa02affa23	3b9ff47191c143e9991452fa02affa23_conference.startalk.tech	<message from='3b9ff47191c143e9991452fa02affa23@conference.startalk.tech/3b9ff47191c143e9991452fa02affa23_conference.startalk.tech' to='3b9ff47191c143e9991452fa02affa23@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604980291695'><body msgType='15' id='http_473861604980291695'>JH伽勒 邀请 杉杉 进入聊天室.</body></message>	t	0	2020-11-10 11:51:31.695+08	169	conference.startalk.tech	http_473861604980291695
3b9ff47191c143e9991452fa02affa23	3b9ff47191c143e9991452fa02affa23_conference.startalk.tech	<message from='3b9ff47191c143e9991452fa02affa23@conference.startalk.tech/3b9ff47191c143e9991452fa02affa23_conference.startalk.tech' to='3b9ff47191c143e9991452fa02affa23@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1604980697393'><body msgType='15' id='http_328661604980697393'>JH伽勒 邀请 zhangchao5 进入聊天室.</body></message>	t	0	2020-11-10 11:58:17.393+08	170	conference.startalk.tech	http_328661604980697393
6737bb1bb2af443086d57e81d71eeb94	100094z_startalk.tech	<message from='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech/100094z_startalk.tech' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605060376195' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='d275353636524d36a3333d7b54507637' msgType='1'>11</body></message>	t	0	2020-11-11 10:06:16.195+08	171	startalk.tech	d275353636524d36a3333d7b54507637
6737bb1bb2af443086d57e81d71eeb94	100094z_startalk.tech	<message from='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech/100094z_startalk.tech' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605060377960' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='0daaabce8f424ca19ca23614ff9995aa' msgType='1'>12</body></message>	t	0	2020-11-11 10:06:17.96+08	172	startalk.tech	0daaabce8f424ca19ca23614ff9995aa
6737bb1bb2af443086d57e81d71eeb94	100094z_startalk.tech	<message from='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech/100094z_startalk.tech' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605060379855' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='af82ba7924dd4792ae11c0439d658ea7' msgType='1'>123</body></message>	t	0	2020-11-11 10:06:19.855+08	173	startalk.tech	af82ba7924dd4792ae11c0439d658ea7
6737bb1bb2af443086d57e81d71eeb94	100094z_startalk.tech	<message from='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech/100094z_startalk.tech' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605060381234' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='c8d22b831b20405f849e1dec388bd189' msgType='1'>332</body></message>	t	0	2020-11-11 10:06:21.234+08	174	startalk.tech	c8d22b831b20405f849e1dec388bd189
6737bb1bb2af443086d57e81d71eeb94	mumu_startalk.tech	<message from='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech/mumu_startalk.tech' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605063564696' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;FILEID&quot;:&quot;0f187f0e2078409a941b70e31d70141d&quot;,&quot;FileName&quot;:&quot;nodejs版本星语测试（2020.11.10）.xlsx&quot;,&quot;FileSize&quot;:&quot;15.29KB&quot;,&quot;FILEMD5&quot;:&quot;41310521928eb23a6da71debfac74cdf&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/41310521928eb23a6da71debfac74cdf?name=41310521928eb23a6da71debfac74cdf.xlsx&quot;}' id='0f187f0e2078409a941b70e31d70141d' msgType='5'>{&quot;FILEID&quot;:&quot;0f187f0e2078409a941b70e31d70141d&quot;,&quot;FileName&quot;:&quot;nodejs版本星语测试（2020.11.10）.xlsx&quot;,&quot;FileSize&quot;:&quot;15.29KB&quot;,&quot;FILEMD5&quot;:&quot;41310521928eb23a6da71debfac74cdf&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/41310521928eb23a6da71debfac74cdf?name=41310521928eb23a6da71debfac74cdf.xlsx&quot;}</body></message>	t	0	2020-11-11 10:59:24.696+08	175	startalk.tech	0f187f0e2078409a941b70e31d70141d
6737bb1bb2af443086d57e81d71eeb94	100094z_startalk.tech	<message from='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech/100094z_startalk.tech' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605063570699' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='07c94baa2380488ebddaef4d3db47e8d' msgType='1'>收到了</body></message>	t	0	2020-11-11 10:59:30.699+08	176	startalk.tech	07c94baa2380488ebddaef4d3db47e8d
6737bb1bb2af443086d57e81d71eeb94	mumu_startalk.tech	<message from='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech/mumu_startalk.tech' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605063967366' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;FILEID&quot;:&quot;18dbfc30bae44806a12ef9c1297c0f05&quot;,&quot;FileName&quot;:&quot;Track157.mp3&quot;,&quot;FileSize&quot;:&quot;135.85KB&quot;,&quot;FILEMD5&quot;:&quot;dfbc3931c0e175abd3954f87252ff9df&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/dfbc3931c0e175abd3954f87252ff9df?name=dfbc3931c0e175abd3954f87252ff9df.mp3&quot;}' id='18dbfc30bae44806a12ef9c1297c0f05' msgType='5'>{&quot;FILEID&quot;:&quot;18dbfc30bae44806a12ef9c1297c0f05&quot;,&quot;FileName&quot;:&quot;Track157.mp3&quot;,&quot;FileSize&quot;:&quot;135.85KB&quot;,&quot;FILEMD5&quot;:&quot;dfbc3931c0e175abd3954f87252ff9df&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/dfbc3931c0e175abd3954f87252ff9df?name=dfbc3931c0e175abd3954f87252ff9df.mp3&quot;}</body></message>	t	0	2020-11-11 11:06:07.366+08	177	startalk.tech	18dbfc30bae44806a12ef9c1297c0f05
6737bb1bb2af443086d57e81d71eeb94	100094z_startalk.tech	<message from='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech/100094z_startalk.tech' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605064290103' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;FILEID&quot;:&quot;404450df3bd04a2ca26733cd737711d8&quot;,&quot;FileName&quot;:&quot;API.md&quot;,&quot;FileSize&quot;:&quot;8.86KB&quot;,&quot;FILEMD5&quot;:&quot;129cfe7f7429e438109fb635b0a0a30a&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/129cfe7f7429e438109fb635b0a0a30a?name=129cfe7f7429e438109fb635b0a0a30a.md&quot;}' id='404450df3bd04a2ca26733cd737711d8' msgType='5'>{&quot;FILEID&quot;:&quot;404450df3bd04a2ca26733cd737711d8&quot;,&quot;FileName&quot;:&quot;API.md&quot;,&quot;FileSize&quot;:&quot;8.86KB&quot;,&quot;FILEMD5&quot;:&quot;129cfe7f7429e438109fb635b0a0a30a&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/129cfe7f7429e438109fb635b0a0a30a?name=129cfe7f7429e438109fb635b0a0a30a.md&quot;}</body></message>	t	0	2020-11-11 11:11:30.103+08	178	startalk.tech	404450df3bd04a2ca26733cd737711d8
6737bb1bb2af443086d57e81d71eeb94	mumu_startalk.tech	<message from='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech/mumu_startalk.tech' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605064322059' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='e4d2a95650b44d13b71bba20ac19f972' msgType='1'>ok</body></message>	t	0	2020-11-11 11:12:02.059+08	179	startalk.tech	e4d2a95650b44d13b71bba20ac19f972
6737bb1bb2af443086d57e81d71eeb94	100094z_startalk.tech	<message from='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech/100094z_startalk.tech' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605064327984' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;FILEID&quot;:&quot;cbbd6695318a41c5b1c6c9ed061ad2bb&quot;,&quot;FileName&quot;:&quot;base.md&quot;,&quot;FileSize&quot;:&quot;1.37KB&quot;,&quot;FILEMD5&quot;:&quot;36aeb6afaaf7ac22574a8b64e560059c&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/36aeb6afaaf7ac22574a8b64e560059c?name=36aeb6afaaf7ac22574a8b64e560059c.md&quot;}' id='cbbd6695318a41c5b1c6c9ed061ad2bb' msgType='5'>{&quot;FILEID&quot;:&quot;cbbd6695318a41c5b1c6c9ed061ad2bb&quot;,&quot;FileName&quot;:&quot;base.md&quot;,&quot;FileSize&quot;:&quot;1.37KB&quot;,&quot;FILEMD5&quot;:&quot;36aeb6afaaf7ac22574a8b64e560059c&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/36aeb6afaaf7ac22574a8b64e560059c?name=36aeb6afaaf7ac22574a8b64e560059c.md&quot;}</body></message>	t	0	2020-11-11 11:12:07.984+08	180	startalk.tech	cbbd6695318a41c5b1c6c9ed061ad2bb
6737bb1bb2af443086d57e81d71eeb94	mumu_startalk.tech	<message from='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech/mumu_startalk.tech' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605064333162' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;FILEID&quot;:&quot;75d5044545e34ad9b1d3d06be2b914d1&quot;,&quot;FileName&quot;:&quot;未命名.md&quot;,&quot;FileSize&quot;:&quot;1.05KB&quot;,&quot;FILEMD5&quot;:&quot;79dd11e6a8195f5695805ccfbbd26d98&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/79dd11e6a8195f5695805ccfbbd26d98?name=79dd11e6a8195f5695805ccfbbd26d98.md&quot;}' id='75d5044545e34ad9b1d3d06be2b914d1' msgType='5'>{&quot;FILEID&quot;:&quot;75d5044545e34ad9b1d3d06be2b914d1&quot;,&quot;FileName&quot;:&quot;未命名.md&quot;,&quot;FileSize&quot;:&quot;1.05KB&quot;,&quot;FILEMD5&quot;:&quot;79dd11e6a8195f5695805ccfbbd26d98&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/79dd11e6a8195f5695805ccfbbd26d98?name=79dd11e6a8195f5695805ccfbbd26d98.md&quot;}</body></message>	t	0	2020-11-11 11:12:13.162+08	181	startalk.tech	75d5044545e34ad9b1d3d06be2b914d1
6737bb1bb2af443086d57e81d71eeb94	100094z_startalk.tech	<message from='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech/100094z_startalk.tech' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605064336263' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='a4c15adc5e9c4ea7906322b94f56da6a' msgType='1'>md的可以了</body></message>	t	0	2020-11-11 11:12:16.263+08	182	startalk.tech	a4c15adc5e9c4ea7906322b94f56da6a
6737bb1bb2af443086d57e81d71eeb94	mumu_startalk.tech	<message from='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech/mumu_startalk.tech' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605064338884' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='d11dbe0ab319412cb57489fdf4d33fdd' msgType='1'>好</body></message>	t	0	2020-11-11 11:12:18.884+08	183	startalk.tech	d11dbe0ab319412cb57489fdf4d33fdd
6737bb1bb2af443086d57e81d71eeb94	100094z_startalk.tech	<message from='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech/100094z_startalk.tech' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605064370209' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='60c404d9b9b04adcb3417107f1c0d878' msgType='1'>你发一下，其他的几种</body></message>	t	0	2020-11-11 11:12:50.209+08	184	startalk.tech	60c404d9b9b04adcb3417107f1c0d878
6737bb1bb2af443086d57e81d71eeb94	100094z_startalk.tech	<message from='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech/100094z_startalk.tech' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605064371605' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='3e810db1aa8340dba348f02b0efb349b' msgType='1'>pdf</body></message>	t	0	2020-11-11 11:12:51.605+08	185	startalk.tech	3e810db1aa8340dba348f02b0efb349b
6737bb1bb2af443086d57e81d71eeb94	mumu_startalk.tech	<message from='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech/mumu_startalk.tech' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605064376618' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;FILEID&quot;:&quot;bb38934ebdf34bd4b461a688db6b568c&quot;,&quot;FileName&quot;:&quot;df.pdf&quot;,&quot;FileSize&quot;:&quot;69.16KB&quot;,&quot;FILEMD5&quot;:&quot;dae0024186f2196c41c85e372ce27168&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/dae0024186f2196c41c85e372ce27168?name=dae0024186f2196c41c85e372ce27168.pdf&quot;}' id='bb38934ebdf34bd4b461a688db6b568c' msgType='5'>{&quot;FILEID&quot;:&quot;bb38934ebdf34bd4b461a688db6b568c&quot;,&quot;FileName&quot;:&quot;df.pdf&quot;,&quot;FileSize&quot;:&quot;69.16KB&quot;,&quot;FILEMD5&quot;:&quot;dae0024186f2196c41c85e372ce27168&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/dae0024186f2196c41c85e372ce27168?name=dae0024186f2196c41c85e372ce27168.pdf&quot;}</body></message>	t	0	2020-11-11 11:12:56.618+08	186	startalk.tech	bb38934ebdf34bd4b461a688db6b568c
6737bb1bb2af443086d57e81d71eeb94	100094z_startalk.tech	<message from='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech/100094z_startalk.tech' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605064376799' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='8bb97bec4a374770b3f5cc81571ba509' msgType='1'>docx</body></message>	t	0	2020-11-11 11:12:56.799+08	187	startalk.tech	8bb97bec4a374770b3f5cc81571ba509
6737bb1bb2af443086d57e81d71eeb94	100094z_startalk.tech	<message from='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech/100094z_startalk.tech' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605064503070' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='a7726995d09c45e0913e7e1b9fddc25e' msgType='1'>好的</body></message>	t	0	2020-11-11 11:15:03.07+08	198	startalk.tech	a7726995d09c45e0913e7e1b9fddc25e
6737bb1bb2af443086d57e81d71eeb94	mumu_startalk.tech	<message from='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech/mumu_startalk.tech' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605064383156' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;FILEID&quot;:&quot;3abf4892ba9e4ed08a3b13b02d98ae29&quot;,&quot;FileName&quot;:&quot;你好啊 啊啊啊 啊.docx&quot;,&quot;FileSize&quot;:&quot;12.42KB&quot;,&quot;FILEMD5&quot;:&quot;c600eac5dc458933853be0dab28594f2&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/c600eac5dc458933853be0dab28594f2?name=c600eac5dc458933853be0dab28594f2.docx&quot;}' id='3abf4892ba9e4ed08a3b13b02d98ae29' msgType='5'>{&quot;FILEID&quot;:&quot;3abf4892ba9e4ed08a3b13b02d98ae29&quot;,&quot;FileName&quot;:&quot;你好啊 啊啊啊 啊.docx&quot;,&quot;FileSize&quot;:&quot;12.42KB&quot;,&quot;FILEMD5&quot;:&quot;c600eac5dc458933853be0dab28594f2&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/c600eac5dc458933853be0dab28594f2?name=c600eac5dc458933853be0dab28594f2.docx&quot;}</body></message>	t	0	2020-11-11 11:13:03.156+08	188	startalk.tech	3abf4892ba9e4ed08a3b13b02d98ae29
6737bb1bb2af443086d57e81d71eeb94	mumu_startalk.tech	<message from='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech/mumu_startalk.tech' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605064385926' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='28da10a119db4fe682de8933e14b5d84' msgType='1'>可以了</body></message>	t	0	2020-11-11 11:13:05.926+08	189	startalk.tech	28da10a119db4fe682de8933e14b5d84
6737bb1bb2af443086d57e81d71eeb94	100094z_startalk.tech	<message from='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech/100094z_startalk.tech' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605064387252' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='1017979ffe474efda563e22230ca4e60' msgType='1'>doc的我记得也是有两种吧</body></message>	t	0	2020-11-11 11:13:07.252+08	190	startalk.tech	1017979ffe474efda563e22230ca4e60
6737bb1bb2af443086d57e81d71eeb94	mumu_startalk.tech	<message from='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech/mumu_startalk.tech' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605064399496' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='d6efc1b272c2485694c9c74ec94fc5d0' msgType='1'>好像是</body></message>	t	0	2020-11-11 11:13:19.496+08	192	startalk.tech	d6efc1b272c2485694c9c74ec94fc5d0
6737bb1bb2af443086d57e81d71eeb94	mumu_startalk.tech	<message type='revoke' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' msec_times='1605064401730'><body id='6b8a88578aab4b1d895c8eebd6bd0bfd' msgType='-1' extendInfo='{&quot;messageId&quot;:&quot;6b8a88578aab4b1d895c8eebd6bd0bfd&quot;,&quot;fromId&quot;:&quot;mumu@startalk.tech/V[200010]_P[PC64]_ID[a64cdf51e5cf459e89f1cd5cb5f1f649]_C[1]_PB&quot;}'>[撤销一条消息]</body><stime xmlns='jabber:stime:delay' stamp='20201111T03:13:21'/></message>	t	0	2020-11-11 11:13:21.73+08	191	startalk.tech	6b8a88578aab4b1d895c8eebd6bd0bfd
6737bb1bb2af443086d57e81d71eeb94	100094z_startalk.tech	<message from='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech/100094z_startalk.tech' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605064415976' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='3e4c8e26ba0742678143bacb57a74bdc' msgType='1'>后面遇到了，可以再添加</body></message>	t	0	2020-11-11 11:13:35.976+08	193	startalk.tech	3e4c8e26ba0742678143bacb57a74bdc
6737bb1bb2af443086d57e81d71eeb94	mumu_startalk.tech	<message from='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech/mumu_startalk.tech' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605064421294' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='be38c2ba577e45278ebad908cb3ae043' msgType='1'>好</body></message>	t	0	2020-11-11 11:13:41.294+08	194	startalk.tech	be38c2ba577e45278ebad908cb3ae043
6737bb1bb2af443086d57e81d71eeb94	100094z_startalk.tech	<message from='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech/100094z_startalk.tech' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605064441470' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='46c741b81dd44f25b4a07a6b6f0b680b' msgType='1'>你再验证一下 m4a的</body></message>	t	0	2020-11-11 11:14:01.47+08	195	startalk.tech	46c741b81dd44f25b4a07a6b6f0b680b
6737bb1bb2af443086d57e81d71eeb94	mumu_startalk.tech	<message from='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech/mumu_startalk.tech' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605064491874' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;FILEID&quot;:&quot;ea6fbc1645b2449e99f8be5a87c59c1b&quot;,&quot;FileName&quot;:&quot;20201111_110634.m4a&quot;,&quot;FileSize&quot;:&quot;72.29KB&quot;,&quot;FILEMD5&quot;:&quot;c65ef5efdc86873d337c3610e382295f&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/c65ef5efdc86873d337c3610e382295f?name=c65ef5efdc86873d337c3610e382295f.m4a&quot;}' id='ea6fbc1645b2449e99f8be5a87c59c1b' msgType='5'>{&quot;FILEID&quot;:&quot;ea6fbc1645b2449e99f8be5a87c59c1b&quot;,&quot;FileName&quot;:&quot;20201111_110634.m4a&quot;,&quot;FileSize&quot;:&quot;72.29KB&quot;,&quot;FILEMD5&quot;:&quot;c65ef5efdc86873d337c3610e382295f&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/c65ef5efdc86873d337c3610e382295f?name=c65ef5efdc86873d337c3610e382295f.m4a&quot;}</body></message>	t	0	2020-11-11 11:14:51.874+08	196	startalk.tech	ea6fbc1645b2449e99f8be5a87c59c1b
6737bb1bb2af443086d57e81d71eeb94	mumu_startalk.tech	<message from='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech/mumu_startalk.tech' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605064497290' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='411736febfce40f7917b93f4910e96a1' msgType='1'>可以</body></message>	t	0	2020-11-11 11:14:57.29+08	197	startalk.tech	411736febfce40f7917b93f4910e96a1
6737bb1bb2af443086d57e81d71eeb94	100094z_startalk.tech	<message from='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech/100094z_startalk.tech' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605064533910' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='c52ebb5995b641d28eac89144964951b' msgType='1'>那这个问题，就先这样，我看看下一个分享的问题，那个好像有bug</body></message>	t	0	2020-11-11 11:15:33.91+08	199	startalk.tech	c52ebb5995b641d28eac89144964951b
6737bb1bb2af443086d57e81d71eeb94	mumu_startalk.tech	<message from='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech/mumu_startalk.tech' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605064540201' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='4bfacdd621f4436b92badcdb2349d661' msgType='1'>好</body></message>	t	0	2020-11-11 11:15:40.201+08	200	startalk.tech	4bfacdd621f4436b92badcdb2349d661
17a73d186c034b1ea71bfc3dd3108ee0	100094z_startalk.tech	<message from='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech/100094z_startalk.tech' to='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605065731269' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='8204a11fbed2422b83d8fc3ca8fe8be6' msgType='1'>11</body></message>	t	0	2020-11-11 11:35:31.269+08	201	startalk.tech	8204a11fbed2422b83d8fc3ca8fe8be6
17a73d186c034b1ea71bfc3dd3108ee0	100094z_startalk.tech	<message from='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech/100094z_startalk.tech' to='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605065731606' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='441d5673c35a4714af1d568343d0d5e1' msgType='1'>2</body></message>	t	0	2020-11-11 11:35:31.606+08	202	startalk.tech	441d5673c35a4714af1d568343d0d5e1
17a73d186c034b1ea71bfc3dd3108ee0	100094z_startalk.tech	<message from='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech/100094z_startalk.tech' to='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605065732091' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='d3245607cb8648f4bae233e49c9b4d20' msgType='1'>3</body></message>	t	0	2020-11-11 11:35:32.091+08	203	startalk.tech	d3245607cb8648f4bae233e49c9b4d20
6737bb1bb2af443086d57e81d71eeb94	mumu_startalk.tech	<message from='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech/mumu_startalk.tech' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605190498828' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;title&quot;:&quot;test22的聊天记录&quot;,&quot;desc&quot;:&quot;&quot;,&quot;linkurl&quot;:&quot;https://im.startalk.tech:8443/py/sharemsg?jdata=aHR0cHM6Ly9pbS5zdGFydGFsay50ZWNoOjg0NDMvZmlsZS92Mi9kb3dubG9hZC85OGUzODljMGQxZmNiOTQyOGEyMDBhYTIzOWU0MzE2ZT9uYW1lPTk4ZTM4OWMwZDFmY2I5NDI4YTIwMGFhMjM5ZTQzMTZlLg==&quot;}' id='15b4f1bdc26f4c3ebe924a1cf5fc43e6' msgType='666'>收到了一个消息记录文件文件，请升级客户端查看。</body></message>	t	0	2020-11-12 22:14:58.828+08	204	startalk.tech	15b4f1bdc26f4c3ebe924a1cf5fc43e6
17a73d186c034b1ea71bfc3dd3108ee0	mumu_startalk.tech	<message from='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech/mumu_startalk.tech' to='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605190662974' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;FILEID&quot;:&quot;714495435c884cde861bbe722cf94f3b&quot;,&quot;FileName&quot;:&quot;sunny1.jpeg&quot;,&quot;FileSize&quot;:&quot;208.22KB&quot;,&quot;FILEMD5&quot;:&quot;80d91db7cf0cf2104d9bff62903db0e5&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/80d91db7cf0cf2104d9bff62903db0e5?name=80d91db7cf0cf2104d9bff62903db0e5.jpeg&quot;}' id='714495435c884cde861bbe722cf94f3b' msgType='5'>{&quot;FILEID&quot;:&quot;714495435c884cde861bbe722cf94f3b&quot;,&quot;FileName&quot;:&quot;sunny1.jpeg&quot;,&quot;FileSize&quot;:&quot;208.22KB&quot;,&quot;FILEMD5&quot;:&quot;80d91db7cf0cf2104d9bff62903db0e5&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/80d91db7cf0cf2104d9bff62903db0e5?name=80d91db7cf0cf2104d9bff62903db0e5.jpeg&quot;}</body></message>	t	0	2020-11-12 22:17:42.974+08	205	startalk.tech	714495435c884cde861bbe722cf94f3b
3b9ff47191c143e9991452fa02affa23	100004q_startalk.tech	<message from='3b9ff47191c143e9991452fa02affa23@conference.startalk.tech/100004q_startalk.tech' to='3b9ff47191c143e9991452fa02affa23@conference.startalk.tech' sendjid='100004q@startalk.tech' realfrom='100004q@startalk.tech' msec_times='1605205398347' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='7bb69c5e-ea10-457b-8940-4a05e8423875' msgType='1'>哈哈哈\n</body></message>	t	0	2020-11-13 02:23:18.347+08	206	startalk.tech	7bb69c5e-ea10-457b-8940-4a05e8423875
3b9ff47191c143e9991452fa02affa23	100004q_startalk.tech	<message from='3b9ff47191c143e9991452fa02affa23@conference.startalk.tech/100004q_startalk.tech' to='3b9ff47191c143e9991452fa02affa23@conference.startalk.tech' sendjid='100004q@startalk.tech' realfrom='100004q@startalk.tech' msec_times='1605205460214' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='0a3d243b-b88a-4289-b8ce-d61c9ee1ef1c' msgType='1'>哈哈哈</body></message>	t	0	2020-11-13 02:24:20.214+08	207	startalk.tech	0a3d243b-b88a-4289-b8ce-d61c9ee1ef1c
83d2403acedf4b39877f592244043dee	mumu_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/mumu_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605366435267' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='bc47f737ca59412caaeaefb1eb368ca0' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/lzx]&quot; width=EmojiOne height=EmojiOne ]</body></message>	t	0	2020-11-14 23:07:15.267+08	208	startalk.tech	bc47f737ca59412caaeaefb1eb368ca0
17a73d186c034b1ea71bfc3dd3108ee0	mumu_startalk.tech	<message from='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech/mumu_startalk.tech' to='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605366442556' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='94a9733808ad493abba66d46b455bdaf' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/byx]&quot; width=EmojiOne height=EmojiOne ]</body></message>	t	0	2020-11-14 23:07:22.556+08	209	startalk.tech	94a9733808ad493abba66d46b455bdaf
17a73d186c034b1ea71bfc3dd3108ee0	mumu_startalk.tech	<message from='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech/mumu_startalk.tech' to='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605366446678' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='8e17179f284645a7a037f4b83c737c89' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/zy]&quot; width=EmojiOne height=EmojiOne ]</body></message>	t	0	2020-11-14 23:07:26.678+08	210	startalk.tech	8e17179f284645a7a037f4b83c737c89
17a73d186c034b1ea71bfc3dd3108ee0	mumu_startalk.tech	<message from='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech/mumu_startalk.tech' to='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605366469095' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='654043a582f44cfebbe6a10ae8a3a88b' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/tp]&quot; width=EmojiOne height=EmojiOne ]</body></message>	t	0	2020-11-14 23:07:49.095+08	211	startalk.tech	654043a582f44cfebbe6a10ae8a3a88b
17a73d186c034b1ea71bfc3dd3108ee0	mumu_startalk.tech	<message from='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech/mumu_startalk.tech' to='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605366480422' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='8bd6f1505a554d6890f3aeb6ba08c045' msgType='1'>123</body></message>	t	0	2020-11-14 23:08:00.422+08	212	startalk.tech	8bd6f1505a554d6890f3aeb6ba08c045
17a73d186c034b1ea71bfc3dd3108ee0	mumu_startalk.tech	<message from='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech/mumu_startalk.tech' to='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605366498114' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;FILEID&quot;:&quot;66a2a4de9f824509a5a266cb8604daed&quot;,&quot;FileName&quot;:&quot;头像.jpg&quot;,&quot;FileSize&quot;:&quot;27.18KB&quot;,&quot;FILEMD5&quot;:&quot;98c31df0915b1357efb2c167a178e728&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/98c31df0915b1357efb2c167a178e728?name=98c31df0915b1357efb2c167a178e728.jpg&quot;}' id='66a2a4de9f824509a5a266cb8604daed' msgType='5'>{&quot;FILEID&quot;:&quot;66a2a4de9f824509a5a266cb8604daed&quot;,&quot;FileName&quot;:&quot;头像.jpg&quot;,&quot;FileSize&quot;:&quot;27.18KB&quot;,&quot;FILEMD5&quot;:&quot;98c31df0915b1357efb2c167a178e728&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/98c31df0915b1357efb2c167a178e728?name=98c31df0915b1357efb2c167a178e728.jpg&quot;}</body></message>	t	0	2020-11-14 23:08:18.114+08	213	startalk.tech	66a2a4de9f824509a5a266cb8604daed
17a73d186c034b1ea71bfc3dd3108ee0	mumu_startalk.tech	<message from='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech/mumu_startalk.tech' to='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605366511256' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;FILEID&quot;:&quot;12d089818c2c4046a456dcea4f877aa6&quot;,&quot;FileName&quot;:&quot;未命名.md&quot;,&quot;FileSize&quot;:&quot;1.05KB&quot;,&quot;FILEMD5&quot;:&quot;79dd11e6a8195f5695805ccfbbd26d98&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/79dd11e6a8195f5695805ccfbbd26d98?name=79dd11e6a8195f5695805ccfbbd26d98.md&quot;}' id='12d089818c2c4046a456dcea4f877aa6' msgType='5'>{&quot;FILEID&quot;:&quot;12d089818c2c4046a456dcea4f877aa6&quot;,&quot;FileName&quot;:&quot;未命名.md&quot;,&quot;FileSize&quot;:&quot;1.05KB&quot;,&quot;FILEMD5&quot;:&quot;79dd11e6a8195f5695805ccfbbd26d98&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/79dd11e6a8195f5695805ccfbbd26d98?name=79dd11e6a8195f5695805ccfbbd26d98.md&quot;}</body></message>	t	0	2020-11-14 23:08:31.256+08	214	startalk.tech	12d089818c2c4046a456dcea4f877aa6
17a73d186c034b1ea71bfc3dd3108ee0	mumu_startalk.tech	<message from='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech/mumu_startalk.tech' to='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605366516235' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;FILEID&quot;:&quot;7d553a769f1643a499515bea4518ae3e&quot;,&quot;FileName&quot;:&quot;你好啊 啊啊啊 啊.docx&quot;,&quot;FileSize&quot;:&quot;12.42KB&quot;,&quot;FILEMD5&quot;:&quot;c600eac5dc458933853be0dab28594f2&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/c600eac5dc458933853be0dab28594f2?name=c600eac5dc458933853be0dab28594f2.docx&quot;}' id='7d553a769f1643a499515bea4518ae3e' msgType='5'>{&quot;FILEID&quot;:&quot;7d553a769f1643a499515bea4518ae3e&quot;,&quot;FileName&quot;:&quot;你好啊 啊啊啊 啊.docx&quot;,&quot;FileSize&quot;:&quot;12.42KB&quot;,&quot;FILEMD5&quot;:&quot;c600eac5dc458933853be0dab28594f2&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/c600eac5dc458933853be0dab28594f2?name=c600eac5dc458933853be0dab28594f2.docx&quot;}</body></message>	t	0	2020-11-14 23:08:36.235+08	215	startalk.tech	7d553a769f1643a499515bea4518ae3e
17a73d186c034b1ea71bfc3dd3108ee0	mumu_startalk.tech	<message from='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech/mumu_startalk.tech' to='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605366521009' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;FILEID&quot;:&quot;cd2dc161cd8b4b138dc4ef4cfb1d26fc&quot;,&quot;FileName&quot;:&quot;20201111_110634.m4a&quot;,&quot;FileSize&quot;:&quot;72.29KB&quot;,&quot;FILEMD5&quot;:&quot;c65ef5efdc86873d337c3610e382295f&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/c65ef5efdc86873d337c3610e382295f?name=c65ef5efdc86873d337c3610e382295f.m4a&quot;}' id='cd2dc161cd8b4b138dc4ef4cfb1d26fc' msgType='5'>{&quot;FILEID&quot;:&quot;cd2dc161cd8b4b138dc4ef4cfb1d26fc&quot;,&quot;FileName&quot;:&quot;20201111_110634.m4a&quot;,&quot;FileSize&quot;:&quot;72.29KB&quot;,&quot;FILEMD5&quot;:&quot;c65ef5efdc86873d337c3610e382295f&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/c65ef5efdc86873d337c3610e382295f?name=c65ef5efdc86873d337c3610e382295f.m4a&quot;}</body></message>	t	0	2020-11-14 23:08:41.009+08	216	startalk.tech	cd2dc161cd8b4b138dc4ef4cfb1d26fc
b0fd2895a3a447b2ba9aa3768c4b52ec	mumu_startalk.tech	<message from='b0fd2895a3a447b2ba9aa3768c4b52ec@conference.startalk.tech/mumu_startalk.tech' to='b0fd2895a3a447b2ba9aa3768c4b52ec@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605366627857' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='37c4590f0a0549198c8b9b2d05bc6a83' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/byx]&quot; width=EmojiOne height=EmojiOne ]</body></message>	t	0	2020-11-14 23:10:27.857+08	225	startalk.tech	37c4590f0a0549198c8b9b2d05bc6a83
83d2403acedf4b39877f592244043dee	mumu_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/mumu_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605366529589' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;FILEID&quot;:&quot;cd2dc161cd8b4b138dc4ef4cfb1d26fc&quot;,&quot;FileName&quot;:&quot;20201111_110634.m4a&quot;,&quot;FileSize&quot;:&quot;72.29KB&quot;,&quot;FILEMD5&quot;:&quot;c65ef5efdc86873d337c3610e382295f&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/c65ef5efdc86873d337c3610e382295f?name=c65ef5efdc86873d337c3610e382295f.m4a&quot;}' id='8edd744e95e44bf7a0d3abe36a51cdb4' msgType='5'>{&quot;FILEID&quot;:&quot;cd2dc161cd8b4b138dc4ef4cfb1d26fc&quot;,&quot;FileName&quot;:&quot;20201111_110634.m4a&quot;,&quot;FileSize&quot;:&quot;72.29KB&quot;,&quot;FILEMD5&quot;:&quot;c65ef5efdc86873d337c3610e382295f&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/c65ef5efdc86873d337c3610e382295f?name=c65ef5efdc86873d337c3610e382295f.m4a&quot;}</body></message>	t	0	2020-11-14 23:08:49.589+08	217	startalk.tech	8edd744e95e44bf7a0d3abe36a51cdb4
17a73d186c034b1ea71bfc3dd3108ee0	mumu_startalk.tech	<message type='revoke' to='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech' msec_times='1605366541916'><body id='2407148586e34f2d9ba2915b920a0f30' msgType='-1' extendInfo='{&quot;messageId&quot;:&quot;2407148586e34f2d9ba2915b920a0f30&quot;,&quot;fromId&quot;:&quot;mumu@startalk.tech/V[200010]_P[PC64]_ID[fb72733cc0cd4469ac40a2abc838c75f]_C[1]_PB&quot;}'>[撤销一条消息]</body><stime xmlns='jabber:stime:delay' stamp='20201114T15:09:01'/></message>	t	0	2020-11-14 23:09:01.916+08	218	startalk.tech	2407148586e34f2d9ba2915b920a0f30
17a73d186c034b1ea71bfc3dd3108ee0	mumu_startalk.tech	<message from='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech/mumu_startalk.tech' to='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605366548207' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;title&quot;:&quot;test22的聊天记录&quot;,&quot;desc&quot;:&quot;&quot;,&quot;linkurl&quot;:&quot;https://im.startalk.tech:8443/py/sharemsg?jdata=aHR0cHM6Ly9pbS5zdGFydGFsay50ZWNoOjg0NDMvZmlsZS92Mi9kb3dubG9hZC84OGYyZTg0N2Y0ODQwNTY3ZmFhMWIxNjYxOGQzY2I4YT9uYW1lPTg4ZjJlODQ3ZjQ4NDA1NjdmYWExYjE2NjE4ZDNjYjhhLg==&quot;}' id='00b1dcbc627948a683ac575c3b41834d' msgType='666'>收到了一个消息记录文件文件，请升级客户端查看。</body></message>	t	0	2020-11-14 23:09:08.207+08	219	startalk.tech	00b1dcbc627948a683ac575c3b41834d
17a73d186c034b1ea71bfc3dd3108ee0	mumu_startalk.tech	<message from='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech/mumu_startalk.tech' to='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605366571926' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='33141bf58c52492da4eb032f278fdf04' msgType='1'>[obj type=&quot;image&quot; value=&quot;https://im.startalk.tech:8443/file/v2/download/74050014fb6ad965ec55e8567dffb6e7.png?name=74050014fb6ad965ec55e8567dffb6e7.png&quot; width=244 height=70]</body></message>	t	0	2020-11-14 23:09:31.926+08	220	startalk.tech	33141bf58c52492da4eb032f278fdf04
17a73d186c034b1ea71bfc3dd3108ee0	mumu_startalk.tech	<message from='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech/mumu_startalk.tech' to='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605366580395' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='5e1cf9e8be6e49bba40f6ea7b3480aaf' msgType='1'>[obj type=&quot;image&quot; value=&quot;https://im.startalk.tech:8443/file/v2/download/39c45bc83d483502db98899ebcc1edb0.png?name=39c45bc83d483502db98899ebcc1edb0.png&quot; width=239 height=145]</body></message>	t	0	2020-11-14 23:09:40.395+08	221	startalk.tech	5e1cf9e8be6e49bba40f6ea7b3480aaf
17a73d186c034b1ea71bfc3dd3108ee0	mumu_startalk.tech	<message from='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech/mumu_startalk.tech' to='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605366589684' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='4345077084e1429cac6882a0facf017a' msgType='1'>[obj type=&quot;image&quot; value=&quot;https://im.startalk.tech:8443/file/v2/download/39c45bc83d483502db98899ebcc1edb0.png?name=39c45bc83d483502db98899ebcc1edb0.png&quot; width=239 height=145]</body></message>	t	0	2020-11-14 23:09:49.684+08	222	startalk.tech	4345077084e1429cac6882a0facf017a
b0fd2895a3a447b2ba9aa3768c4b52ec	b0fd2895a3a447b2ba9aa3768c4b52ec_conference.startalk.tech	<message from='b0fd2895a3a447b2ba9aa3768c4b52ec@conference.startalk.tech/b0fd2895a3a447b2ba9aa3768c4b52ec_conference.startalk.tech' to='b0fd2895a3a447b2ba9aa3768c4b52ec@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1605366611046'><body msgType='15' id='http_290711605366611046'>沐沐 创建聊天室.</body></message>	t	0	2020-11-14 23:10:11.046+08	223	conference.startalk.tech	http_290711605366611046
b0fd2895a3a447b2ba9aa3768c4b52ec	b0fd2895a3a447b2ba9aa3768c4b52ec_conference.startalk.tech	<message from='b0fd2895a3a447b2ba9aa3768c4b52ec@conference.startalk.tech/b0fd2895a3a447b2ba9aa3768c4b52ec_conference.startalk.tech' to='b0fd2895a3a447b2ba9aa3768c4b52ec@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1605366611736'><body msgType='15' id='http_619861605366611736'>沐沐 邀请 杉杉, 勇敢 进入聊天室.</body></message>	t	0	2020-11-14 23:10:11.736+08	224	conference.startalk.tech	http_619861605366611736
b0fd2895a3a447b2ba9aa3768c4b52ec	b0fd2895a3a447b2ba9aa3768c4b52ec_conference.startalk.tech	<message from='b0fd2895a3a447b2ba9aa3768c4b52ec@conference.startalk.tech/b0fd2895a3a447b2ba9aa3768c4b52ec_conference.startalk.tech' to='b0fd2895a3a447b2ba9aa3768c4b52ec@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1605366635681'><body msgType='15' id='http_204041605366635681'>沐沐 邀请 珊珊JH 进入聊天室.</body></message>	t	0	2020-11-14 23:10:35.681+08	226	conference.startalk.tech	http_204041605366635681
b0fd2895a3a447b2ba9aa3768c4b52ec	mumu_startalk.tech	<message from='b0fd2895a3a447b2ba9aa3768c4b52ec@conference.startalk.tech/mumu_startalk.tech' to='b0fd2895a3a447b2ba9aa3768c4b52ec@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605366639289' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='f3b06407b2bb4fb6ad3680b0bc3cfa48' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/byqq]&quot; width=EmojiOne height=EmojiOne ]</body></message>	t	0	2020-11-14 23:10:39.289+08	227	startalk.tech	f3b06407b2bb4fb6ad3680b0bc3cfa48
b0fd2895a3a447b2ba9aa3768c4b52ec	mumu_startalk.tech	<message from='b0fd2895a3a447b2ba9aa3768c4b52ec@conference.startalk.tech/mumu_startalk.tech' to='b0fd2895a3a447b2ba9aa3768c4b52ec@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605366642802' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='210fcfb89f1147b9b9586ba462dfa8a3' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/hxqq]&quot; width=EmojiOne height=EmojiOne ]kl</body></message>	t	0	2020-11-14 23:10:42.802+08	228	startalk.tech	210fcfb89f1147b9b9586ba462dfa8a3
b0fd2895a3a447b2ba9aa3768c4b52ec	mumu_startalk.tech	<message from='b0fd2895a3a447b2ba9aa3768c4b52ec@conference.startalk.tech/mumu_startalk.tech' to='b0fd2895a3a447b2ba9aa3768c4b52ec@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605366653907' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='6e01046db4cb456cbe0237722e4031d0' msgType='1'>jj</body></message>	t	0	2020-11-14 23:10:53.907+08	229	startalk.tech	6e01046db4cb456cbe0237722e4031d0
6737bb1bb2af443086d57e81d71eeb94	mumu_startalk.tech	<message from='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech/mumu_startalk.tech' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605366839279' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='693ba3208b124ab098c3bf3aadfd56c4' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/byqq]&quot; width=EmojiOne height=EmojiOne ]</body></message>	t	0	2020-11-14 23:13:59.279+08	230	startalk.tech	693ba3208b124ab098c3bf3aadfd56c4
6737bb1bb2af443086d57e81d71eeb94	mumu_startalk.tech	<message from='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech/mumu_startalk.tech' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605366849082' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='7ebe635faa15402596831ddd24ebc550' msgType='1'>dd</body></message>	t	0	2020-11-14 23:14:09.082+08	231	startalk.tech	7ebe635faa15402596831ddd24ebc550
83d2403acedf4b39877f592244043dee	mumu_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/mumu_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605367135876' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='bf8c1d67bc9c44299d4ec7ce52a3cf92' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/tp]&quot; width=EmojiOne height=EmojiOne ]</body></message>	t	0	2020-11-14 23:18:55.876+08	232	startalk.tech	bf8c1d67bc9c44299d4ec7ce52a3cf92
83d2403acedf4b39877f592244043dee	83d2403acedf4b39877f592244043dee_conference.startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/83d2403acedf4b39877f592244043dee_conference.startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1605367140592'><body msgType='15' id='http_473861605367140592'>沐沐 邀请 珊珊JH, 杉杉 进入聊天室.</body></message>	t	0	2020-11-14 23:19:00.592+08	233	conference.startalk.tech	http_473861605367140592
83d2403acedf4b39877f592244043dee	mumu_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/mumu_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605367199052' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='efc77907e7d04c0cb89713394c73aee7' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/bm]&quot; width=EmojiOne height=EmojiOne ]</body></message>	t	0	2020-11-14 23:19:59.052+08	234	startalk.tech	efc77907e7d04c0cb89713394c73aee7
cb8c771fd29a4f4f96a2de73a012c4a5	cb8c771fd29a4f4f96a2de73a012c4a5_conference.startalk.tech	<message from='cb8c771fd29a4f4f96a2de73a012c4a5@conference.startalk.tech/cb8c771fd29a4f4f96a2de73a012c4a5_conference.startalk.tech' to='cb8c771fd29a4f4f96a2de73a012c4a5@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1605368333550'><body msgType='15' id='http_290711605368333550'>珊珊JH 创建聊天室.</body></message>	t	0	2020-11-14 23:38:53.55+08	235	conference.startalk.tech	http_290711605368333550
cb8c771fd29a4f4f96a2de73a012c4a5	cb8c771fd29a4f4f96a2de73a012c4a5_conference.startalk.tech	<message from='cb8c771fd29a4f4f96a2de73a012c4a5@conference.startalk.tech/cb8c771fd29a4f4f96a2de73a012c4a5_conference.startalk.tech' to='cb8c771fd29a4f4f96a2de73a012c4a5@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1605368333784'><body msgType='15' id='http_619861605368333784'>珊珊JH 邀请 杉杉, 沐沐 进入聊天室.</body></message>	t	0	2020-11-14 23:38:53.784+08	236	conference.startalk.tech	http_619861605368333784
cb8c771fd29a4f4f96a2de73a012c4a5	mumu_startalk.tech	<message from='cb8c771fd29a4f4f96a2de73a012c4a5@conference.startalk.tech/mumu_startalk.tech' to='cb8c771fd29a4f4f96a2de73a012c4a5@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605368345215' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='2a194a2fc4214d4783a994d319a7c7d1' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/tp]&quot; width=EmojiOne height=EmojiOne ]</body></message>	t	0	2020-11-14 23:39:05.215+08	237	startalk.tech	2a194a2fc4214d4783a994d319a7c7d1
cb8c771fd29a4f4f96a2de73a012c4a5	100094z_startalk.tech	<message from='cb8c771fd29a4f4f96a2de73a012c4a5@conference.startalk.tech/100094z_startalk.tech' to='cb8c771fd29a4f4f96a2de73a012c4a5@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605368347520' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='6e29a804-c2e5-455f-a6ad-82e83a0f37b5' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/fn]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-14 23:39:07.52+08	238	startalk.tech	6e29a804-c2e5-455f-a6ad-82e83a0f37b5
7f8cf571ceb74bd2a27a33f985386362	7f8cf571ceb74bd2a27a33f985386362_conference.startalk.tech	<message from='7f8cf571ceb74bd2a27a33f985386362@conference.startalk.tech/7f8cf571ceb74bd2a27a33f985386362_conference.startalk.tech' to='7f8cf571ceb74bd2a27a33f985386362@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1605368389884'><body msgType='15' id='http_290711605368389884'>珊珊JH 创建聊天室.</body></message>	t	0	2020-11-14 23:39:49.884+08	239	conference.startalk.tech	http_290711605368389884
7f8cf571ceb74bd2a27a33f985386362	7f8cf571ceb74bd2a27a33f985386362_conference.startalk.tech	<message from='7f8cf571ceb74bd2a27a33f985386362@conference.startalk.tech/7f8cf571ceb74bd2a27a33f985386362_conference.startalk.tech' to='7f8cf571ceb74bd2a27a33f985386362@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1605368390089'><body msgType='15' id='http_619861605368390089'>珊珊JH 邀请 杉杉 进入聊天室.</body></message>	t	0	2020-11-14 23:39:50.089+08	240	conference.startalk.tech	http_619861605368390089
b9a915b72ff94cf8a71823c05cd12528	b9a915b72ff94cf8a71823c05cd12528_conference.startalk.tech	<message from='b9a915b72ff94cf8a71823c05cd12528@conference.startalk.tech/b9a915b72ff94cf8a71823c05cd12528_conference.startalk.tech' to='b9a915b72ff94cf8a71823c05cd12528@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1605368402574'><body msgType='15' id='http_290711605368402574'>珊珊JH 创建聊天室.</body></message>	t	0	2020-11-14 23:40:02.574+08	241	conference.startalk.tech	http_290711605368402574
5e0faeaa8741489ab5b9f6131667fe80	5e0faeaa8741489ab5b9f6131667fe80_conference.startalk.tech	<message from='5e0faeaa8741489ab5b9f6131667fe80@conference.startalk.tech/5e0faeaa8741489ab5b9f6131667fe80_conference.startalk.tech' to='5e0faeaa8741489ab5b9f6131667fe80@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1605368440489'><body msgType='15' id='http_290711605368440489'>珊珊JH 创建聊天室.</body></message>	t	0	2020-11-14 23:40:40.489+08	242	conference.startalk.tech	http_290711605368440489
5e0faeaa8741489ab5b9f6131667fe80	5e0faeaa8741489ab5b9f6131667fe80_conference.startalk.tech	<message from='5e0faeaa8741489ab5b9f6131667fe80@conference.startalk.tech/5e0faeaa8741489ab5b9f6131667fe80_conference.startalk.tech' to='5e0faeaa8741489ab5b9f6131667fe80@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1605368440663'><body msgType='15' id='http_619861605368440663'>珊珊JH 邀请 杉杉 进入聊天室.</body></message>	t	0	2020-11-14 23:40:40.663+08	243	conference.startalk.tech	http_619861605368440663
83d2403acedf4b39877f592244043dee	100094z_startalk.tech	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100094z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605368462031' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='7a97ea69-b09a-464c-ad94-0e72fcf4f0e3' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/hhx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/hhx]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-14 23:41:02.031+08	244	startalk.tech	7a97ea69-b09a-464c-ad94-0e72fcf4f0e3
38cfb6912f814b77bb7bb2d6bbfd3245	38cfb6912f814b77bb7bb2d6bbfd3245_conference.startalk.tech	<message from='38cfb6912f814b77bb7bb2d6bbfd3245@conference.startalk.tech/38cfb6912f814b77bb7bb2d6bbfd3245_conference.startalk.tech' to='38cfb6912f814b77bb7bb2d6bbfd3245@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1605368477175'><body msgType='15' id='http_290711605368477175'>珊珊JH 创建聊天室.</body></message>	t	0	2020-11-14 23:41:17.175+08	245	conference.startalk.tech	http_290711605368477175
38cfb6912f814b77bb7bb2d6bbfd3245	38cfb6912f814b77bb7bb2d6bbfd3245_conference.startalk.tech	<message from='38cfb6912f814b77bb7bb2d6bbfd3245@conference.startalk.tech/38cfb6912f814b77bb7bb2d6bbfd3245_conference.startalk.tech' to='38cfb6912f814b77bb7bb2d6bbfd3245@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1605368477450'><body msgType='15' id='http_619861605368477449'>珊珊JH 邀请 杉杉 进入聊天室.</body></message>	t	0	2020-11-14 23:41:17.45+08	246	conference.startalk.tech	http_619861605368477449
38cfb6912f814b77bb7bb2d6bbfd3245	100094z_startalk.tech	<message from='38cfb6912f814b77bb7bb2d6bbfd3245@conference.startalk.tech/100094z_startalk.tech' to='38cfb6912f814b77bb7bb2d6bbfd3245@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605368480139' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='37f09d2c-fc91-44b4-b684-9244de1a901a' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/hhx]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-14 23:41:20.139+08	247	startalk.tech	37f09d2c-fc91-44b4-b684-9244de1a901a
38cfb6912f814b77bb7bb2d6bbfd3245	38cfb6912f814b77bb7bb2d6bbfd3245_conference.startalk.tech	<message from='38cfb6912f814b77bb7bb2d6bbfd3245@conference.startalk.tech/38cfb6912f814b77bb7bb2d6bbfd3245_conference.startalk.tech' to='38cfb6912f814b77bb7bb2d6bbfd3245@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1605368495882'><body msgType='15' id='http_204041605368495882'>珊珊JH 邀请 沐沐 进入聊天室.</body></message>	t	0	2020-11-14 23:41:35.882+08	248	conference.startalk.tech	http_204041605368495882
38cfb6912f814b77bb7bb2d6bbfd3245	38cfb6912f814b77bb7bb2d6bbfd3245_conference.startalk.tech	<message from='38cfb6912f814b77bb7bb2d6bbfd3245@conference.startalk.tech/38cfb6912f814b77bb7bb2d6bbfd3245_conference.startalk.tech' to='38cfb6912f814b77bb7bb2d6bbfd3245@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1605368572866'><body msgType='15' id='http_600091605368572866'>珊珊JH 邀请 杉杉 进入聊天室.</body></message>	t	0	2020-11-14 23:42:52.866+08	249	conference.startalk.tech	http_600091605368572866
38cfb6912f814b77bb7bb2d6bbfd3245	38cfb6912f814b77bb7bb2d6bbfd3245_conference.startalk.tech	<message from='38cfb6912f814b77bb7bb2d6bbfd3245@conference.startalk.tech/38cfb6912f814b77bb7bb2d6bbfd3245_conference.startalk.tech' to='38cfb6912f814b77bb7bb2d6bbfd3245@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1605368705651'><body msgType='15' id='http_312691605368705651'>沐沐 邀请 杉杉 进入聊天室.</body></message>	t	0	2020-11-14 23:45:05.651+08	250	conference.startalk.tech	http_312691605368705651
3c23e31805af4ba0bc6a7fc71639cf21	3c23e31805af4ba0bc6a7fc71639cf21_conference.startalk.tech	<message from='3c23e31805af4ba0bc6a7fc71639cf21@conference.startalk.tech/3c23e31805af4ba0bc6a7fc71639cf21_conference.startalk.tech' to='3c23e31805af4ba0bc6a7fc71639cf21@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1605368725921'><body msgType='15' id='http_290711605368725921'>沐沐 创建聊天室.</body></message>	t	0	2020-11-14 23:45:25.921+08	251	conference.startalk.tech	http_290711605368725921
3c23e31805af4ba0bc6a7fc71639cf21	3c23e31805af4ba0bc6a7fc71639cf21_conference.startalk.tech	<message from='3c23e31805af4ba0bc6a7fc71639cf21@conference.startalk.tech/3c23e31805af4ba0bc6a7fc71639cf21_conference.startalk.tech' to='3c23e31805af4ba0bc6a7fc71639cf21@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1605368726646'><body msgType='15' id='http_619861605368726646'>沐沐 邀请 珊珊JH, 杉杉 进入聊天室.</body></message>	t	0	2020-11-14 23:45:26.646+08	252	conference.startalk.tech	http_619861605368726646
38cfb6912f814b77bb7bb2d6bbfd3245	100094z_startalk.tech	<message from='38cfb6912f814b77bb7bb2d6bbfd3245@conference.startalk.tech/100094z_startalk.tech' to='38cfb6912f814b77bb7bb2d6bbfd3245@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605368745470' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='c9bae2fb-049d-4642-894a-632a15bf87f8' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-14 23:45:45.47+08	253	startalk.tech	c9bae2fb-049d-4642-894a-632a15bf87f8
38cfb6912f814b77bb7bb2d6bbfd3245	100095z_startalk.tech	<message from='38cfb6912f814b77bb7bb2d6bbfd3245@conference.startalk.tech/100095z_startalk.tech' to='38cfb6912f814b77bb7bb2d6bbfd3245@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1605435434751' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='721d538a-880f-488b-acfe-f0e25cfcb4ec' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xy]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/ka]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/ka]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-15 18:17:14.751+08	254	startalk.tech	721d538a-880f-488b-acfe-f0e25cfcb4ec
96a85e39bcc647c4b60831060dc0f94c	96a85e39bcc647c4b60831060dc0f94c_conference.startalk.tech	<message from='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech/96a85e39bcc647c4b60831060dc0f94c_conference.startalk.tech' to='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1605436823932'><body msgType='15' id='http_290711605436823932'>珊珊JH 创建聊天室.</body></message>	t	0	2020-11-15 18:40:23.932+08	255	conference.startalk.tech	http_290711605436823932
96a85e39bcc647c4b60831060dc0f94c	96a85e39bcc647c4b60831060dc0f94c_conference.startalk.tech	<message from='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech/96a85e39bcc647c4b60831060dc0f94c_conference.startalk.tech' to='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1605436824039'><body msgType='15' id='http_619861605436824039'>珊珊JH 邀请 杉杉 进入聊天室.</body></message>	t	0	2020-11-15 18:40:24.039+08	256	conference.startalk.tech	http_619861605436824039
96a85e39bcc647c4b60831060dc0f94c	100094z_startalk.tech	<message from='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech/100094z_startalk.tech' to='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605436829849' xml:lang='en' type='groupchat' client_type='ClientTypeiOS' client_ver='0'><body extendInfo='{&quot;width&quot;:0,&quot;shortcut&quot;:&quot;bf63c198ffdee0619dbfb5b761e91681&quot;,&quot;height&quot;:0,&quot;pkgid&quot;:&quot;qunar_camel&quot;,&quot;url&quot;:&quot;&quot;}' id='A56E0846695944A5B21259E47A8F63DB' msgType='30'>[obj type=&quot;emoticon&quot; value=&quot;[bf63c198ffdee0619dbfb5b761e91681]&quot; width=qunar_camel height=0 ]</body></message>	t	0	2020-11-15 18:40:29.849+08	257	startalk.tech	A56E0846695944A5B21259E47A8F63DB
96a85e39bcc647c4b60831060dc0f94c	100094z_startalk.tech	<message from='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech/100094z_startalk.tech' to='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605436849034' xml:lang='en' type='groupchat' client_type='ClientTypeiOS' client_ver='0'><body id='5554737C32EF4497817ED6E697360950' msgType='1'>哈哈哈</body></message>	t	0	2020-11-15 18:40:49.034+08	258	startalk.tech	5554737C32EF4497817ED6E697360950
96a85e39bcc647c4b60831060dc0f94c	100094z_startalk.tech	<message from='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech/100094z_startalk.tech' to='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605436851232' xml:lang='en' type='groupchat' client_type='ClientTypeiOS' client_ver='0'><body id='3C09CD5AFA1C4E65800F796ED9F38083' msgType='1'>ooo</body></message>	t	0	2020-11-15 18:40:51.232+08	259	startalk.tech	3C09CD5AFA1C4E65800F796ED9F38083
96a85e39bcc647c4b60831060dc0f94c	100094z_startalk.tech	<message from='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech/100094z_startalk.tech' to='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605436853224' xml:lang='en' type='groupchat' client_type='ClientTypeiOS' client_ver='0'><body id='BA567D311B5843AA977C2EF3E11225FE' msgType='1'>ooo</body></message>	t	0	2020-11-15 18:40:53.224+08	260	startalk.tech	BA567D311B5843AA977C2EF3E11225FE
96a85e39bcc647c4b60831060dc0f94c	100094z_startalk.tech	<message from='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech/100094z_startalk.tech' to='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605436871801' xml:lang='en' type='groupchat' client_type='ClientTypeiOS' client_ver='0'><body extendInfo='{&quot;width&quot;:0,&quot;shortcut&quot;:&quot;eda23d07c90645fe339935d393fdef5c&quot;,&quot;height&quot;:0,&quot;pkgid&quot;:&quot;qunar_camel&quot;,&quot;url&quot;:&quot;&quot;}' id='C1FE26811F6042F2A4692601353EFE9B' msgType='30'>[obj type=&quot;emoticon&quot; value=&quot;[eda23d07c90645fe339935d393fdef5c]&quot; width=qunar_camel height=0 ]</body></message>	t	0	2020-11-15 18:41:11.801+08	261	startalk.tech	C1FE26811F6042F2A4692601353EFE9B
96a85e39bcc647c4b60831060dc0f94c	100094z_startalk.tech	<message from='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech/100094z_startalk.tech' to='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605436880107' xml:lang='en' type='groupchat' client_type='ClientTypeiOS' client_ver='0'><body id='0A98B030DCE64362B6C8792EBC60045F' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/cy]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-15 18:41:20.107+08	262	startalk.tech	0A98B030DCE64362B6C8792EBC60045F
d1aa13f85c4b41768b25027ff007c81a	test01_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/test01_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='test01@startalk.tech' realfrom='test01@startalk.tech' msec_times='1605660902772' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='d3784bcf-c6b2-46de-8e58-7a1ce18f46c3' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-18 08:55:02.772+08	292	startalk.tech	d3784bcf-c6b2-46de-8e58-7a1ce18f46c3
96a85e39bcc647c4b60831060dc0f94c	100094z_startalk.tech	<message from='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech/100094z_startalk.tech' to='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605437080872' xml:lang='en' type='groupchat' client_type='ClientTypeiOS' client_ver='0'><body extendInfo='{&quot;FILEID&quot;:&quot;7d553a769f1643a499515bea4518ae3e&quot;,&quot;FileName&quot;:&quot;你好啊 啊啊啊 啊.docx&quot;,&quot;FileSize&quot;:&quot;12.42KB&quot;,&quot;FILEMD5&quot;:&quot;c600eac5dc458933853be0dab28594f2&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/c600eac5dc458933853be0dab28594f2?name=c600eac5dc458933853be0dab28594f2.docx&quot;}' id='4CD7338FFB364D6FA671B349B5234B19' msgType='5'>{&quot;FILEID&quot;:&quot;7d553a769f1643a499515bea4518ae3e&quot;,&quot;FileName&quot;:&quot;你好啊 啊啊啊 啊.docx&quot;,&quot;FileSize&quot;:&quot;12.42KB&quot;,&quot;FILEMD5&quot;:&quot;c600eac5dc458933853be0dab28594f2&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/c600eac5dc458933853be0dab28594f2?name=c600eac5dc458933853be0dab28594f2.docx&quot;}</body></message>	t	0	2020-11-15 18:44:40.872+08	263	startalk.tech	4CD7338FFB364D6FA671B349B5234B19
96a85e39bcc647c4b60831060dc0f94c	100094z_startalk.tech	<message from='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech/100094z_startalk.tech' to='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605437097506' xml:lang='en' type='groupchat' client_type='ClientTypeiOS' client_ver='0'><body extendInfo='{&quot;FILEID&quot;:&quot;cd2dc161cd8b4b138dc4ef4cfb1d26fc&quot;,&quot;FileName&quot;:&quot;20201111_110634.m4a&quot;,&quot;FileSize&quot;:&quot;72.29KB&quot;,&quot;FILEMD5&quot;:&quot;c65ef5efdc86873d337c3610e382295f&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/c65ef5efdc86873d337c3610e382295f?name=c65ef5efdc86873d337c3610e382295f.m4a&quot;}' id='88F752ED3D3043A5AF846E48BA0DCD55' msgType='5'>{&quot;FILEID&quot;:&quot;cd2dc161cd8b4b138dc4ef4cfb1d26fc&quot;,&quot;FileName&quot;:&quot;20201111_110634.m4a&quot;,&quot;FileSize&quot;:&quot;72.29KB&quot;,&quot;FILEMD5&quot;:&quot;c65ef5efdc86873d337c3610e382295f&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/c65ef5efdc86873d337c3610e382295f?name=c65ef5efdc86873d337c3610e382295f.m4a&quot;}</body></message>	t	0	2020-11-15 18:44:57.506+08	264	startalk.tech	88F752ED3D3043A5AF846E48BA0DCD55
96a85e39bcc647c4b60831060dc0f94c	96a85e39bcc647c4b60831060dc0f94c_conference.startalk.tech	<message from='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech/96a85e39bcc647c4b60831060dc0f94c_conference.startalk.tech' to='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1605437400379'><body msgType='15' id='http_204041605437400379'>珊珊JH 邀请 沐沐 进入聊天室.</body></message>	t	0	2020-11-15 18:50:00.379+08	265	conference.startalk.tech	http_204041605437400379
96a85e39bcc647c4b60831060dc0f94c	100095z_startalk.tech	<message from='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech/100095z_startalk.tech' to='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1605437474690' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='cc5514db-e119-4851-8eb1-313c1bd15a54' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/zy]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/zy]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-15 18:51:14.69+08	266	startalk.tech	cc5514db-e119-4851-8eb1-313c1bd15a54
96a85e39bcc647c4b60831060dc0f94c	100095z_startalk.tech	<message from='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech/100095z_startalk.tech' to='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1605437477388' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='eeef3e4e-118a-4606-a010-369a516984d8' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/ka]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/ka]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/ka]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/ka]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-15 18:51:17.388+08	267	startalk.tech	eeef3e4e-118a-4606-a010-369a516984d8
96a85e39bcc647c4b60831060dc0f94c	100095z_startalk.tech	<message from='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech/100095z_startalk.tech' to='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1605437494353' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='d4b0d931-3003-414f-8823-27e991aa8904' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-15 18:51:34.353+08	268	startalk.tech	d4b0d931-3003-414f-8823-27e991aa8904
96a85e39bcc647c4b60831060dc0f94c	100095z_startalk.tech	<message from='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech/100095z_startalk.tech' to='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1605437498487' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='0594c973-d82a-41cb-a618-e94d7d88d32a' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/ak]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-15 18:51:38.487+08	269	startalk.tech	0594c973-d82a-41cb-a618-e94d7d88d32a
96a85e39bcc647c4b60831060dc0f94c	100095z_startalk.tech	<message from='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech/100095z_startalk.tech' to='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1605437500565' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='1c6ac59c-b432-475d-8e0a-7b56e0656639' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-15 18:51:40.565+08	270	startalk.tech	1c6ac59c-b432-475d-8e0a-7b56e0656639
96a85e39bcc647c4b60831060dc0f94c	100095z_startalk.tech	<message from='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech/100095z_startalk.tech' to='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1605437501994' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='4e67a25e-f8fd-4a02-9098-0b5a2c91949e' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/zy]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-15 18:51:41.994+08	271	startalk.tech	4e67a25e-f8fd-4a02-9098-0b5a2c91949e
96a85e39bcc647c4b60831060dc0f94c	100094z_startalk.tech	<message from='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech/100094z_startalk.tech' to='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605437562881' xml:lang='en' type='groupchat' client_type='ClientTypeiOS' client_ver='0'><body extendInfo='{&quot;FileLength&quot;:&quot;12.42KB&quot;,&quot;FileMd5&quot;:&quot;你好啊 啊啊啊 啊.docx&quot;,&quot;HttpUrl&quot;:&quot;https:\\/\\/im.startalk.tech:8443\\/file\\/v2\\/download\\/c600eac5dc458933853be0dab28594f2?name=c600eac5dc458933853be0dab28594f2.docx&quot;,&quot;FileName&quot;:&quot;你好啊 啊啊啊 啊.docx&quot;}' id='9A15657E523041BD894F856339B544E3' msgType='5'>{&quot;FileLength&quot;:&quot;12.42KB&quot;,&quot;FileMd5&quot;:&quot;你好啊 啊啊啊 啊.docx&quot;,&quot;HttpUrl&quot;:&quot;https:\\/\\/im.startalk.tech:8443\\/file\\/v2\\/download\\/c600eac5dc458933853be0dab28594f2?name=c600eac5dc458933853be0dab28594f2.docx&quot;,&quot;FileName&quot;:&quot;你好啊 啊啊啊 啊.docx&quot;}</body></message>	t	0	2020-11-15 18:52:42.881+08	272	startalk.tech	9A15657E523041BD894F856339B544E3
96a85e39bcc647c4b60831060dc0f94c	100094z_startalk.tech	<message from='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech/100094z_startalk.tech' to='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605437571940' xml:lang='en' type='groupchat' client_type='ClientTypeiOS' client_ver='0'><body id='237BE18E45E44F62BDEA6967B937C2F2' msgType='1'>你好</body></message>	t	0	2020-11-15 18:52:51.94+08	273	startalk.tech	237BE18E45E44F62BDEA6967B937C2F2
96a85e39bcc647c4b60831060dc0f94c	96a85e39bcc647c4b60831060dc0f94c_conference.startalk.tech	<message from='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech/96a85e39bcc647c4b60831060dc0f94c_conference.startalk.tech' to='96a85e39bcc647c4b60831060dc0f94c@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1605437619717'><body msgType='15' id='http_600091605437619717'>杉杉 邀请 珊珊JH 进入聊天室.</body></message>	t	0	2020-11-15 18:53:39.717+08	274	conference.startalk.tech	http_600091605437619717
c395017fb9434bafbeb86a69b8b3a46d	c395017fb9434bafbeb86a69b8b3a46d_conference.startalk.tech	<message from='c395017fb9434bafbeb86a69b8b3a46d@conference.startalk.tech/c395017fb9434bafbeb86a69b8b3a46d_conference.startalk.tech' to='c395017fb9434bafbeb86a69b8b3a46d@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1605439058587'><body msgType='15' id='http_290711605439058587'>珊珊JH 创建聊天室.</body></message>	t	0	2020-11-15 19:17:38.587+08	275	conference.startalk.tech	http_290711605439058587
c395017fb9434bafbeb86a69b8b3a46d	c395017fb9434bafbeb86a69b8b3a46d_conference.startalk.tech	<message from='c395017fb9434bafbeb86a69b8b3a46d@conference.startalk.tech/c395017fb9434bafbeb86a69b8b3a46d_conference.startalk.tech' to='c395017fb9434bafbeb86a69b8b3a46d@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1605439058738'><body msgType='15' id='http_619861605439058738'>珊珊JH 邀请 杉杉, 沐沐 进入聊天室.</body></message>	t	0	2020-11-15 19:17:38.738+08	276	conference.startalk.tech	http_619861605439058738
c395017fb9434bafbeb86a69b8b3a46d	100094z_startalk.tech	<message from='c395017fb9434bafbeb86a69b8b3a46d@conference.startalk.tech/100094z_startalk.tech' to='c395017fb9434bafbeb86a69b8b3a46d@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605439061313' xml:lang='en' type='groupchat' client_type='ClientTypeiOS' client_ver='0'><body extendInfo='{&quot;width&quot;:0,&quot;shortcut&quot;:&quot;bf63c198ffdee0619dbfb5b761e91681&quot;,&quot;height&quot;:0,&quot;pkgid&quot;:&quot;qunar_camel&quot;,&quot;url&quot;:&quot;&quot;}' id='FD9582B218D54CCF9023F3C0DF56EDF9' msgType='30'>[obj type=&quot;emoticon&quot; value=&quot;[bf63c198ffdee0619dbfb5b761e91681]&quot; width=qunar_camel height=0 ]</body></message>	t	0	2020-11-15 19:17:41.313+08	277	startalk.tech	FD9582B218D54CCF9023F3C0DF56EDF9
c395017fb9434bafbeb86a69b8b3a46d	100094z_startalk.tech	<message from='c395017fb9434bafbeb86a69b8b3a46d@conference.startalk.tech/100094z_startalk.tech' to='c395017fb9434bafbeb86a69b8b3a46d@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605439366129' xml:lang='en' type='groupchat' client_type='ClientTypeiOS' client_ver='0'><body extendInfo='{&quot;width&quot;:0,&quot;shortcut&quot;:&quot;ca04c6890cd7b54472afa6014649b095&quot;,&quot;height&quot;:0,&quot;pkgid&quot;:&quot;qunar_camel&quot;,&quot;url&quot;:&quot;&quot;}' id='EC56E9400D3C449DA8C8FA0A8C182DE0' msgType='30'>[obj type=&quot;emoticon&quot; value=&quot;[ca04c6890cd7b54472afa6014649b095]&quot; width=qunar_camel height=0 ]</body></message>	t	0	2020-11-15 19:22:46.129+08	278	startalk.tech	EC56E9400D3C449DA8C8FA0A8C182DE0
c395017fb9434bafbeb86a69b8b3a46d	mumu_startalk.tech	<message from='c395017fb9434bafbeb86a69b8b3a46d@conference.startalk.tech/mumu_startalk.tech' to='c395017fb9434bafbeb86a69b8b3a46d@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605498897058' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;FILEID&quot;:&quot;0c34b8928abf4fc596e5985f966420ae&quot;,&quot;FileName&quot;:&quot;Track1.amr&quot;,&quot;FileSize&quot;:&quot;5.13KB&quot;,&quot;FILEMD5&quot;:&quot;b3df88399069e7146280203690e28221&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/b3df88399069e7146280203690e28221?name=b3df88399069e7146280203690e28221.amr&quot;}' id='0c34b8928abf4fc596e5985f966420ae' msgType='5'>{&quot;FILEID&quot;:&quot;0c34b8928abf4fc596e5985f966420ae&quot;,&quot;FileName&quot;:&quot;Track1.amr&quot;,&quot;FileSize&quot;:&quot;5.13KB&quot;,&quot;FILEMD5&quot;:&quot;b3df88399069e7146280203690e28221&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/b3df88399069e7146280203690e28221?name=b3df88399069e7146280203690e28221.amr&quot;}</body></message>	t	0	2020-11-16 11:54:57.058+08	279	startalk.tech	0c34b8928abf4fc596e5985f966420ae
c395017fb9434bafbeb86a69b8b3a46d	100094z_startalk.tech	<message from='c395017fb9434bafbeb86a69b8b3a46d@conference.startalk.tech/100094z_startalk.tech' to='c395017fb9434bafbeb86a69b8b3a46d@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605499510009' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='167d24da-eb9c-40d7-9222-b7ed5e377ca0' msgType='2'>{&quot;FileName&quot;:&quot;a4348cb2-79d3-42a5-9abc-c1b313439d81.aar&quot;,&quot;FilePath&quot;:&quot;/data/user/0/com.qunar.im.startalk/files/qvoice/qvoice.tmp&quot;,&quot;HttpUrl&quot;:&quot;file/v2/download/64a4bee0089a0bf77ea0ec3ab90d7ad6?name\\u003dqvoice.tmp&quot;,&quot;Seconds&quot;:3,&quot;s&quot;:0}</body></message>	t	0	2020-11-16 12:05:10.009+08	280	startalk.tech	167d24da-eb9c-40d7-9222-b7ed5e377ca0
d1aa13f85c4b41768b25027ff007c81a	test01_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/test01_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='test01@startalk.tech' realfrom='test01@startalk.tech' msec_times='1605660904897' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='7c50a723-2fe8-412d-9155-850d009ba9a8' msgType='1'>哈哈哈哈哈哈</body></message>	t	0	2020-11-18 08:55:04.897+08	293	startalk.tech	7c50a723-2fe8-412d-9155-850d009ba9a8
c395017fb9434bafbeb86a69b8b3a46d	100094z_startalk.tech	<message from='c395017fb9434bafbeb86a69b8b3a46d@conference.startalk.tech/100094z_startalk.tech' to='c395017fb9434bafbeb86a69b8b3a46d@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605499523068' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='66a0a8d1-ea64-466a-9a7f-b0748c854671' msgType='2'>{&quot;FileName&quot;:&quot;71f98202-b384-4f5a-838d-b502bc91f013.aar&quot;,&quot;FilePath&quot;:&quot;/data/user/0/com.qunar.im.startalk/files/qvoice/qvoice.tmp&quot;,&quot;HttpUrl&quot;:&quot;file/v2/download/2fad2964a25bf795d8512c52d5730b90?name\\u003dqvoice.tmp&quot;,&quot;Seconds&quot;:4,&quot;s&quot;:0}</body></message>	t	0	2020-11-16 12:05:23.068+08	281	startalk.tech	66a0a8d1-ea64-466a-9a7f-b0748c854671
c395017fb9434bafbeb86a69b8b3a46d	100094z_startalk.tech	<message from='c395017fb9434bafbeb86a69b8b3a46d@conference.startalk.tech/100094z_startalk.tech' to='c395017fb9434bafbeb86a69b8b3a46d@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605499543641' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='96172fbe-6943-4805-a084-58fe000ffe4a' msgType='2'>{&quot;FileName&quot;:&quot;b164e5a6-7a45-49fd-8f3d-8106ca44206b.aar&quot;,&quot;FilePath&quot;:&quot;/data/user/0/com.qunar.im.startalk/files/qvoice/qvoice.tmp&quot;,&quot;HttpUrl&quot;:&quot;file/v2/download/666ce4f520f62c869c556a085cd81d20?name\\u003dqvoice.tmp&quot;,&quot;Seconds&quot;:2,&quot;s&quot;:0}</body></message>	t	0	2020-11-16 12:05:43.641+08	282	startalk.tech	96172fbe-6943-4805-a084-58fe000ffe4a
c395017fb9434bafbeb86a69b8b3a46d	100094z_startalk.tech	<message from='c395017fb9434bafbeb86a69b8b3a46d@conference.startalk.tech/100094z_startalk.tech' to='c395017fb9434bafbeb86a69b8b3a46d@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1605499575823' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='1249c3dd-0403-4eed-808c-090d0d60527a' msgType='2'>{&quot;FileName&quot;:&quot;889e6f6c-6639-45ae-be02-ba703bf42303.aar&quot;,&quot;FilePath&quot;:&quot;/data/user/0/com.qunar.im.startalk/files/qvoice/qvoice.tmp&quot;,&quot;HttpUrl&quot;:&quot;file/v2/download/16a30ef7c2abef24bab93a5fbc6f6d46?name\\u003dqvoice.tmp&quot;,&quot;Seconds&quot;:4,&quot;s&quot;:0}</body></message>	t	0	2020-11-16 12:06:15.823+08	283	startalk.tech	1249c3dd-0403-4eed-808c-090d0d60527a
d1aa13f85c4b41768b25027ff007c81a	d1aa13f85c4b41768b25027ff007c81a_conference.startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/d1aa13f85c4b41768b25027ff007c81a_conference.startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1605660827072'><body msgType='15' id='http_290711605660827072'>test01 创建聊天室.</body></message>	t	0	2020-11-18 08:53:47.072+08	284	conference.startalk.tech	http_290711605660827072
d1aa13f85c4b41768b25027ff007c81a	d1aa13f85c4b41768b25027ff007c81a_conference.startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/d1aa13f85c4b41768b25027ff007c81a_conference.startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1605660827273'><body msgType='15' id='http_619861605660827273'>test01 邀请 test02 进入聊天室.</body></message>	t	0	2020-11-18 08:53:47.273+08	285	conference.startalk.tech	http_619861605660827273
d1aa13f85c4b41768b25027ff007c81a	d1aa13f85c4b41768b25027ff007c81a_conference.startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/d1aa13f85c4b41768b25027ff007c81a_conference.startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1605660877642'><body msgType='15' id='http_204041605660877642'>test01 邀请 SuniJH 进入聊天室.</body></message>	t	0	2020-11-18 08:54:37.642+08	286	conference.startalk.tech	http_204041605660877642
d1aa13f85c4b41768b25027ff007c81a	test01_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/test01_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='test01@startalk.tech' realfrom='test01@startalk.tech' msec_times='1605660886371' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='83e8dcaf-571a-44d4-b5be-58e2575684e4' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/byqq]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/byqq]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/byqq]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-18 08:54:46.371+08	287	startalk.tech	83e8dcaf-571a-44d4-b5be-58e2575684e4
d1aa13f85c4b41768b25027ff007c81a	test01_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/test01_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='test01@startalk.tech' realfrom='test01@startalk.tech' msec_times='1605660890197' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='7fd56d76-f2e2-400b-9e90-dd30bab420b1' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-18 08:54:50.197+08	288	startalk.tech	7fd56d76-f2e2-400b-9e90-dd30bab420b1
d1aa13f85c4b41768b25027ff007c81a	test01_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/test01_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='test01@startalk.tech' realfrom='test01@startalk.tech' msec_times='1605660891717' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='a9680bfe-0d38-40aa-a458-36e3903d2ab6' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-18 08:54:51.717+08	289	startalk.tech	a9680bfe-0d38-40aa-a458-36e3903d2ab6
d1aa13f85c4b41768b25027ff007c81a	test01_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/test01_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='test01@startalk.tech' realfrom='test01@startalk.tech' msec_times='1605660895249' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='625b31d0-a2f1-4ca1-8562-eda688475310' msgType='1'>哈哈哈</body></message>	t	0	2020-11-18 08:54:55.249+08	290	startalk.tech	625b31d0-a2f1-4ca1-8562-eda688475310
d1aa13f85c4b41768b25027ff007c81a	test01_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/test01_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='test01@startalk.tech' realfrom='test01@startalk.tech' msec_times='1605660897791' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='b3c66001-d837-4d59-aa5b-837162b68e32' msgType='1'>噼噼</body></message>	t	0	2020-11-18 08:54:57.791+08	291	startalk.tech	b3c66001-d837-4d59-aa5b-837162b68e32
d1aa13f85c4b41768b25027ff007c81a	test01_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/test01_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='test01@startalk.tech' realfrom='test01@startalk.tech' msec_times='1605660915216' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='694cb388-382f-4f7c-8387-7aedfdfeaded' msgType='2'>{&quot;FileName&quot;:&quot;a85e69ce-0bf8-4452-859d-5b10dc88370a.aar&quot;,&quot;FilePath&quot;:&quot;/data/user/0/sdk.im.qunar.com.qtalksdkdemo/files/qvoice/qvoice.tmp&quot;,&quot;HttpUrl&quot;:&quot;file/v2/download/6c047b53b73cd255c6e2b03e407632be?name\\u003dqvoice.tmp&quot;,&quot;Seconds&quot;:2,&quot;s&quot;:0}</body></message>	t	0	2020-11-18 08:55:15.216+08	294	startalk.tech	694cb388-382f-4f7c-8387-7aedfdfeaded
d1aa13f85c4b41768b25027ff007c81a	test01_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/test01_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='test01@startalk.tech' realfrom='test01@startalk.tech' msec_times='1605660935495' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='ee8573d2-4811-4dd2-af30-07e3e0c77f08' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-18 08:55:35.495+08	295	startalk.tech	ee8573d2-4811-4dd2-af30-07e3e0c77f08
d1aa13f85c4b41768b25027ff007c81a	test01_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/test01_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='test01@startalk.tech' realfrom='test01@startalk.tech' msec_times='1605660936875' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='85c468ce-ab2a-44be-9742-a2b148fbf330' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-18 08:55:36.875+08	296	startalk.tech	85c468ce-ab2a-44be-9742-a2b148fbf330
d1aa13f85c4b41768b25027ff007c81a	test01_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/test01_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='test01@startalk.tech' realfrom='test01@startalk.tech' msec_times='1605660937898' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='d381a068-3b52-43b6-b6aa-618e0c2ae696' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-18 08:55:37.898+08	297	startalk.tech	d381a068-3b52-43b6-b6aa-618e0c2ae696
d1aa13f85c4b41768b25027ff007c81a	test01_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/test01_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='test01@startalk.tech' realfrom='test01@startalk.tech' msec_times='1605660939420' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='75e79a8d-f639-4cbb-a6a5-aba74aac1a30' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/dzwx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-18 08:55:39.42+08	298	startalk.tech	75e79a8d-f639-4cbb-a6a5-aba74aac1a30
d1aa13f85c4b41768b25027ff007c81a	test01_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/test01_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='test01@startalk.tech' realfrom='test01@startalk.tech' msec_times='1605660943144' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='cd5220c5-0714-4ad6-af6b-b128f70fcb8c' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/lzx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/lzx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/lzx]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-18 08:55:43.144+08	299	startalk.tech	cd5220c5-0714-4ad6-af6b-b128f70fcb8c
d1aa13f85c4b41768b25027ff007c81a	test01_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/test01_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='test01@startalk.tech' realfrom='test01@startalk.tech' msec_times='1605660959711' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='76fd3534-2113-44af-9085-d1e4d49449f5' msgType='3'>[obj type=&quot;image&quot; value=&quot;file/v2/download/dd9fd3b12ae3bd4fc948a034d28e4e31.jpg?name=dd9fd3b12ae3bd4fc948a034d28e4e31.jpg&quot; width=1080 height=2340]</body></message>	t	0	2020-11-18 08:55:59.711+08	300	startalk.tech	76fd3534-2113-44af-9085-d1e4d49449f5
d1aa13f85c4b41768b25027ff007c81a	test01_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/test01_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='test01@startalk.tech' realfrom='test01@startalk.tech' msec_times='1605660967329' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='a275a51a-b026-4bad-b71d-a40bd48bf7ad' msgType='3'>[obj type=&quot;image&quot; value=&quot;file/v2/download/8ba97ee14ea82f78a2e2e19a2d10f6cd.jpg?name=Screenshot_20201117_202715_com.tencent.mm.jpg&quot; width=1080 height=2340]</body></message>	t	0	2020-11-18 08:56:07.329+08	301	startalk.tech	a275a51a-b026-4bad-b71d-a40bd48bf7ad
d1aa13f85c4b41768b25027ff007c81a	test01_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/test01_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='test01@startalk.tech' realfrom='test01@startalk.tech' msec_times='1605660967370' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='ee59ed91-f039-4897-86ec-1b417dc027f3' msgType='3'>[obj type=&quot;image&quot; value=&quot;file/v2/download/dd9fd3b12ae3bd4fc948a034d28e4e31.jpg?name=Screenshot_20201117_202924_com.tencent.mm.jpg&quot; width=1080 height=2340]</body></message>	t	0	2020-11-18 08:56:07.37+08	302	startalk.tech	ee59ed91-f039-4897-86ec-1b417dc027f3
d1aa13f85c4b41768b25027ff007c81a	test01_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/test01_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='test01@startalk.tech' realfrom='test01@startalk.tech' msec_times='1605660967653' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='a621bec2-7b38-44a2-9a5e-8239959bca47' msgType='3'>[obj type=&quot;image&quot; value=&quot;file/v2/download/a9bade2d08f8f55ff4d1a41224ec90c4.jpg?name=a9bade2d08f8f55ff4d1a41224ec90c4.jpg&quot; width=1080 height=2340]</body></message>	t	0	2020-11-18 08:56:07.653+08	303	startalk.tech	a621bec2-7b38-44a2-9a5e-8239959bca47
d1aa13f85c4b41768b25027ff007c81a	d1aa13f85c4b41768b25027ff007c81a_conference.startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/d1aa13f85c4b41768b25027ff007c81a_conference.startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1605661476427'><body msgType='15' id='http_312691605661476427'>test01 邀请 SuniJH 进入聊天室.</body></message>	t	0	2020-11-18 09:04:36.427+08	327	conference.startalk.tech	http_312691605661476427
d1aa13f85c4b41768b25027ff007c81a	test01_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/test01_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='test01@startalk.tech' realfrom='test01@startalk.tech' msec_times='1605660967694' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='c0943f77-eb32-4030-a757-b5bec397c6aa' msgType='3'>[obj type=&quot;image&quot; value=&quot;file/v2/download/ff45e1cdb8ff484712ef3afc63889e27.jpg?name=ff45e1cdb8ff484712ef3afc63889e27.jpg&quot; width=1080 height=2340]</body></message>	t	0	2020-11-18 08:56:07.694+08	304	startalk.tech	c0943f77-eb32-4030-a757-b5bec397c6aa
d1aa13f85c4b41768b25027ff007c81a	test01_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/test01_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='test01@startalk.tech' realfrom='test01@startalk.tech' msec_times='1605660967700' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='4ac1dbe5-2e81-47db-a98d-a58cd9cf3d0b' msgType='3'>[obj type=&quot;image&quot; value=&quot;file/v2/download/dec5e86a66ed1fd3fc0e3b1a68284cfa.jpg?name=dec5e86a66ed1fd3fc0e3b1a68284cfa.jpg&quot; width=1080 height=2340]</body></message>	t	0	2020-11-18 08:56:07.7+08	305	startalk.tech	4ac1dbe5-2e81-47db-a98d-a58cd9cf3d0b
d1aa13f85c4b41768b25027ff007c81a	test01_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/test01_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='test01@startalk.tech' realfrom='test01@startalk.tech' msec_times='1605660986024' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='5d29fd46-5ad0-4f20-843f-0bb800e85861' msgType='3'>[obj type=&quot;image&quot; value=&quot;file/v2/download/8e59c88017907185a8d38696eb59a342.jpg?name=8e59c88017907185a8d38696eb59a342.jpg&quot; width=1080 height=2336]</body></message>	t	0	2020-11-18 08:56:26.024+08	306	startalk.tech	5d29fd46-5ad0-4f20-843f-0bb800e85861
d1aa13f85c4b41768b25027ff007c81a	test01_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/test01_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='test01@startalk.tech' realfrom='test01@startalk.tech' msec_times='1605660998172' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='853b43b6-7db9-46e7-9670-a94230af7193' msgType='3'>[obj type=&quot;image&quot; value=&quot;file/v2/download/ab947f1d0cadb0d48a79ec7ef2f98f6f.jpg?name=ab947f1d0cadb0d48a79ec7ef2f98f6f.jpg&quot; width=1080 height=2336]</body></message>	t	0	2020-11-18 08:56:38.172+08	307	startalk.tech	853b43b6-7db9-46e7-9670-a94230af7193
d1aa13f85c4b41768b25027ff007c81a	test01_startalk.tech	<message type='revoke' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' msec_times='1605661060269'><body id='e6f228eb-2ae1-4baf-b15c-e4856a4fe572' msgType='-1' extendInfo='{&quot;messageId&quot;:&quot;e6f228eb-2ae1-4baf-b15c-e4856a4fe572&quot;,&quot;fromId&quot;:&quot;test01@startalk.tech/V[206]_P[Android]_D[YAL-AL10]_ID[5c7ebbcb-703c-40d9-a3c4-031ac2fc5d08]_PB&quot;}'>[撤销一条消息]</body><stime xmlns='jabber:stime:delay' stamp='20201118T00:57:40'/></message>	t	0	2020-11-18 08:57:40.269+08	309	startalk.tech	e6f228eb-2ae1-4baf-b15c-e4856a4fe572
d1aa13f85c4b41768b25027ff007c81a	test01_startalk.tech	<message type='revoke' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' msec_times='1605661132639'><body id='f87dc85d-930b-4609-92b2-0d43a1f4c8b5' msgType='-1' extendInfo='{&quot;messageId&quot;:&quot;f87dc85d-930b-4609-92b2-0d43a1f4c8b5&quot;,&quot;fromId&quot;:&quot;test01@startalk.tech/V[206]_P[Android]_D[YAL-AL10]_ID[451dcf69-0cb9-4d0d-9fd4-0c877769b2df]_PB&quot;}'>[撤销一条消息]</body><stime xmlns='jabber:stime:delay' stamp='20201118T00:58:52'/></message>	t	0	2020-11-18 08:58:52.639+08	308	startalk.tech	f87dc85d-930b-4609-92b2-0d43a1f4c8b5
d1aa13f85c4b41768b25027ff007c81a	test01_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/test01_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='test01@startalk.tech' realfrom='test01@startalk.tech' msec_times='1605661150053' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='6f4a62e7-7105-46c1-b50d-aefd2d192d9b' msgType='1'>哦哦哦</body></message>	t	0	2020-11-18 08:59:10.053+08	310	startalk.tech	6f4a62e7-7105-46c1-b50d-aefd2d192d9b
d1aa13f85c4b41768b25027ff007c81a	test01_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/test01_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='test01@startalk.tech' realfrom='test01@startalk.tech' msec_times='1605661153946' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='8eb9f0b9-05dd-4cd8-a3a3-782f064237f7' msgType='1'>哦哦哦</body></message>	t	0	2020-11-18 08:59:13.946+08	311	startalk.tech	8eb9f0b9-05dd-4cd8-a3a3-782f064237f7
d1aa13f85c4b41768b25027ff007c81a	test01_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/test01_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='test01@startalk.tech' realfrom='test01@startalk.tech' msec_times='1605661155787' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='56aff0dc-1da3-496e-912d-2051e95e6d68' msgType='1'>哦哦哦</body></message>	t	0	2020-11-18 08:59:15.787+08	312	startalk.tech	56aff0dc-1da3-496e-912d-2051e95e6d68
d1aa13f85c4b41768b25027ff007c81a	test01_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/test01_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='test01@startalk.tech' realfrom='test01@startalk.tech' msec_times='1605661187895' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='169f03a7-8a1e-4227-a79e-006440dc6d3c' msgType='1'>今天  上午8:59\n「test01：哦哦哦」\n- - - - - - - - - - - - - - -\n雨</body></message>	t	0	2020-11-18 08:59:47.895+08	313	startalk.tech	169f03a7-8a1e-4227-a79e-006440dc6d3c
d1aa13f85c4b41768b25027ff007c81a	100013v_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/100013v_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='100013v@startalk.tech' realfrom='100013v@startalk.tech' msec_times='1605661207623' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='964eaf98-98b3-445f-b7b5-69346f607a4b' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/dzwx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/dzwx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/dzwx]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-18 09:00:07.623+08	314	startalk.tech	964eaf98-98b3-445f-b7b5-69346f607a4b
d1aa13f85c4b41768b25027ff007c81a	100013v_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/100013v_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='100013v@startalk.tech' realfrom='100013v@startalk.tech' msec_times='1605661209805' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='ebe7ab31-ddf5-4561-baf3-e3be382e9a24' msgType='1'>好吧</body></message>	t	0	2020-11-18 09:00:09.805+08	315	startalk.tech	ebe7ab31-ddf5-4561-baf3-e3be382e9a24
d1aa13f85c4b41768b25027ff007c81a	test01_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/test01_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='test01@startalk.tech' realfrom='test01@startalk.tech' msec_times='1605661217803' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='98ad8fd8-a3d0-45ad-a5a5-177f1280f2ff' msgType='1'>今天  上午9:00\n「SuniJH：好吧」\n- - - - - - - - - - - - - - -\n[obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-18 09:00:17.803+08	316	startalk.tech	98ad8fd8-a3d0-45ad-a5a5-177f1280f2ff
d1aa13f85c4b41768b25027ff007c81a	d1aa13f85c4b41768b25027ff007c81a_conference.startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/d1aa13f85c4b41768b25027ff007c81a_conference.startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='admin@startalk.tech' realfrom='admin@startalk.tech' type='groupchat' msec_times='1605661350254'><body msgType='15' id='http_600091605661350254'>test01 邀请 SuniJH 进入聊天室.</body></message>	t	0	2020-11-18 09:02:30.254+08	317	conference.startalk.tech	http_600091605661350254
d1aa13f85c4b41768b25027ff007c81a	100013v_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/100013v_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='100013v@startalk.tech' realfrom='100013v@startalk.tech' msec_times='1605661388692' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='ef8e23d8-dc92-43fa-9740-7c93f180a507' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-18 09:03:08.692+08	318	startalk.tech	ef8e23d8-dc92-43fa-9740-7c93f180a507
d1aa13f85c4b41768b25027ff007c81a	100013v_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/100013v_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='100013v@startalk.tech' realfrom='100013v@startalk.tech' msec_times='1605661390052' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='392de9c0-2fae-40cc-9afb-e26358e68f94' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-18 09:03:10.052+08	319	startalk.tech	392de9c0-2fae-40cc-9afb-e26358e68f94
d1aa13f85c4b41768b25027ff007c81a	100013v_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/100013v_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='100013v@startalk.tech' realfrom='100013v@startalk.tech' msec_times='1605661393097' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='2f3764b1-b6b7-4e5e-9e40-a85c4fc9c67b' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-18 09:03:13.097+08	320	startalk.tech	2f3764b1-b6b7-4e5e-9e40-a85c4fc9c67b
d1aa13f85c4b41768b25027ff007c81a	100013v_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/100013v_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='100013v@startalk.tech' realfrom='100013v@startalk.tech' msec_times='1605661394712' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='a51b9354-3c24-4bc3-92ce-5c2ebecb5160' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xmy]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-18 09:03:14.712+08	321	startalk.tech	a51b9354-3c24-4bc3-92ce-5c2ebecb5160
d1aa13f85c4b41768b25027ff007c81a	100013v_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/100013v_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='100013v@startalk.tech' realfrom='100013v@startalk.tech' msec_times='1605661395566' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='fc34cb58-f4aa-48dc-88f4-2d65f75f6193' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-18 09:03:15.566+08	322	startalk.tech	fc34cb58-f4aa-48dc-88f4-2d65f75f6193
d1aa13f85c4b41768b25027ff007c81a	test01_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/test01_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='test01@startalk.tech' realfrom='test01@startalk.tech' msec_times='1605661401726' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='0b959803-24d5-49ad-bc4a-bddd4ccdf693' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/dzwx]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/dzwx]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-18 09:03:21.726+08	323	startalk.tech	0b959803-24d5-49ad-bc4a-bddd4ccdf693
d1aa13f85c4b41768b25027ff007c81a	test01_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/test01_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='test01@startalk.tech' realfrom='test01@startalk.tech' msec_times='1605661405260' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='93c9cdb9-a322-4528-b86b-eacc4ff4ea50' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xlh]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-18 09:03:25.26+08	324	startalk.tech	93c9cdb9-a322-4528-b86b-eacc4ff4ea50
d1aa13f85c4b41768b25027ff007c81a	test01_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/test01_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='test01@startalk.tech' realfrom='test01@startalk.tech' msec_times='1605661407817' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='cb9f420f-0b93-483b-b842-f2862d4aefdc' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/wx]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-18 09:03:27.817+08	325	startalk.tech	cb9f420f-0b93-483b-b842-f2862d4aefdc
d1aa13f85c4b41768b25027ff007c81a	test01_startalk.tech	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/test01_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='test01@startalk.tech' realfrom='test01@startalk.tech' msec_times='1605661429963' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='f24fcf3b-29f3-4bae-a2a3-8b1b1cc003e0' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/dzwx]&quot; width=EmojiOne height=0 ]</body></message>	t	0	2020-11-18 09:03:49.963+08	326	startalk.tech	f24fcf3b-29f3-4bae-a2a3-8b1b1cc003e0
\.


--
-- Data for Name: muc_room_history_backup; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.muc_room_history_backup (muc_room_name, nick, packet, have_subject, size, create_time, id, host, msg_id) FROM stdin;
\.


--
-- Data for Name: muc_room_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.muc_room_users (muc_name, username, host, subscribe_flag, id, date, login_date, domain, update_time) FROM stdin;
eacfa594c3374240a8370990febb980a	admin	startalk.tech	1	1542632	0	1602747205	conference.startalk.tech	2020-10-15 15:33:25.687803+08
95047e5e04014cd2b2ec4b16c85f744c	100095z	startalk.tech	1	1542655	1604129645149	1604062867	conference.startalk.tech	2020-10-30 21:01:07.966147+08
38cfb6912f814b77bb7bb2d6bbfd3245	100095z	startalk.tech	1	1542774	1605435441316	1605368705	conference.startalk.tech	2020-11-14 23:45:05.640915+08
7a720787654245529bccba67426a0366	100095z	startalk.tech	1	1542646	1603989196115	1603989183	conference.startalk.tech	2020-10-30 00:33:03.861338+08
18dd0d10d591479c858a92be057c694e	100095z	startalk.tech	1	1542663	1604156283811	1604156283	conference.startalk.tech	2020-10-31 22:58:03.810142+08
3389f6c1bb4042a2ab0c339dec3c16a9	chao.zhang5	startalk.tech	1	1542649	0	1604062404	conference.startalk.tech	2020-10-30 20:53:24.59658+08
b10f8a925460494a96ffb7ef58002ffa	100096z	startalk.tech	1	1542668	1604300568576	1604300567	conference.startalk.tech	2020-11-02 15:02:47.990996+08
95047e5e04014cd2b2ec4b16c85f744c	100096z	startalk.tech	1	1542660	1604129645149	1604129645	conference.startalk.tech	2020-10-31 15:34:05.141649+08
677930584d7145b6bd20b79f4bae7352	100095z	startalk.tech	1	1542672	0	1604300640	conference.startalk.tech	2020-11-02 15:04:00.7006+08
42b028bd797443fb8230a73b1caf0931	100004q	startalk.tech	1	1542647	1604829164886	1603990627	conference.startalk.tech	2020-10-30 00:57:07.208074+08
55a59d75b08a4f77b76f75eb68cd3e15	100095z	startalk.tech	1	1542665	1604157446387	1604157445	conference.startalk.tech	2020-10-31 23:17:25.199464+08
e299435983c34c3885d329e59a7561ca	100095z	startalk.tech	1	1542664	1604156453990	1604156453	conference.startalk.tech	2020-10-31 23:00:53.988859+08
e6f21f761ddd4a7f8eb6570adc7cbf9e	chao.zhang5	startalk.tech	1	1542637	0	1603960098	conference.startalk.tech	2020-10-29 16:28:18.81896+08
e6f21f761ddd4a7f8eb6570adc7cbf9e	100095z	startalk.tech	1	1542638	0	1603960098	conference.startalk.tech	2020-10-29 16:28:18.823445+08
c395017fb9434bafbeb86a69b8b3a46d	100094z	startalk.tech	1	1542785	1605499575823	1605439058	conference.startalk.tech	2020-11-15 19:17:38.586077+08
d62701c245234248aaa069f2e63e2474	100095z	startalk.tech	1	1542678	0	1604304397	conference.startalk.tech	2020-11-02 16:06:37.314693+08
c395017fb9434bafbeb86a69b8b3a46d	mumu	startalk.tech	1	1542788	1605499575823	1605439058	conference.startalk.tech	2020-11-15 19:17:38.732894+08
d62701c245234248aaa069f2e63e2474	100096z	startalk.tech	1	1542675	1604304397320	1604304382	conference.startalk.tech	2020-11-02 16:06:22.439938+08
56be69ae06e5475b9e85295de0ae4dd7	100096z	startalk.tech	1	1542674	1604300729550	1604300729	conference.startalk.tech	2020-11-02 15:05:29.548998+08
b0b5ebc6f7f240a1a92b26a1f313d03a	chao.zhang5	startalk.tech	1	1542651	0	1604062791	conference.startalk.tech	2020-10-30 20:59:51.611449+08
b235887358a34bba8f81c269d5d5658e	chao.zhang5	startalk.tech	1	1542640	0	1603960329	conference.startalk.tech	2020-10-29 16:32:09.787865+08
b235887358a34bba8f81c269d5d5658e	100096z	startalk.tech	1	1542641	0	1603960329	conference.startalk.tech	2020-10-29 16:32:09.79198+08
677930584d7145b6bd20b79f4bae7352	100096z	startalk.tech	1	1542671	1604300640707	1604300640	conference.startalk.tech	2020-11-02 15:04:00.102594+08
64598a656b384af4b458473b72dceb26	100095z	startalk.tech	1	1542680	0	1604304438	conference.startalk.tech	2020-11-02 16:07:18.61244+08
64598a656b384af4b458473b72dceb26	100096z	startalk.tech	1	1542679	1604304438618	1604304437	conference.startalk.tech	2020-11-02 16:07:17.975836+08
c395017fb9434bafbeb86a69b8b3a46d	100095z	startalk.tech	1	1542787	1605504634960	1605439058	conference.startalk.tech	2020-11-15 19:17:38.729006+08
95047e5e04014cd2b2ec4b16c85f744c	chao.zhang5	startalk.tech	1	1542654	0	1604062859	conference.startalk.tech	2020-10-30 21:00:59.375403+08
e68a47f141ad43df8d72bd00ae78b133	chao.zhang5	startalk.tech	1	1542643	0	1603964043	conference.startalk.tech	2020-10-29 17:34:03.954564+08
0229eb47b1154771866863ddab7c96b6	100095z	startalk.tech	1	1542683	1604308563234	1604308563	conference.startalk.tech	2020-11-02 17:16:03.225738+08
0229eb47b1154771866863ddab7c96b6	100096z	startalk.tech	1	1542681	1604308583706	1604308562	conference.startalk.tech	2020-11-02 17:16:02.015559+08
abd227dec13a48bbbf4de1b44605bbcb	chao.zhang5	startalk.tech	1	1542686	0	1604308873	conference.startalk.tech	2020-11-02 17:21:13.843876+08
838c7c32d28e4747be9a61043ead3e08	100096z	startalk.tech	1	1542644	1603972972860	1603972909	conference.startalk.tech	2020-10-29 20:01:49.129621+08
13a476002524475898657c196fe66197	100096z	startalk.tech	1	1542634	1603972974744	1603643336	conference.startalk.tech	2020-10-26 00:28:56.24321+08
b0b5ebc6f7f240a1a92b26a1f313d03a	100096z	startalk.tech	1	1542656	0	1604118999	conference.startalk.tech	2020-10-31 12:36:39.718523+08
b0b5ebc6f7f240a1a92b26a1f313d03a	100095z	startalk.tech	1	1542652	1604118999725	1604062800	conference.startalk.tech	2020-10-30 21:00:00.44837+08
575b0da2c0e44f5aade67f4bcd161e8f	100096z	startalk.tech	1	1542690	1604310703901	1604310704	conference.startalk.tech	2020-11-02 17:51:44.125516+08
b58cb19af6c04a71af24417aef49cf0b	chao.zhang5	startalk.tech	1	1542693	0	1604310908	conference.startalk.tech	2020-11-02 17:55:08.094563+08
9afcd37223a842d6b39f29ec13e2d678	100094z	startalk.tech	1	1542745	1605439271000	1604971474	conference.startalk.tech	2020-11-10 09:24:34.951419+08
ba2a497adbbe44c7b67f2dd81e53e8f9	mumu	startalk.tech	1	1542703	1604317174397	1604311296	conference.startalk.tech	2020-11-02 18:01:36.637417+08
a6c0d98b4c9045e88a88098b5424c812	100094z	startalk.tech	1	1542710	1605439271000	1604373677	conference.startalk.tech	2020-11-03 11:21:17.149442+08
b2c2ec63c86e469e9d9199b8f224dde6	100094z	startalk.tech	1	1542695	1605439271000	1604310958	conference.startalk.tech	2020-11-02 17:55:58.374337+08
38cfb6912f814b77bb7bb2d6bbfd3245	mumu	startalk.tech	1	1542772	1605435434751	1605368495	conference.startalk.tech	2020-11-14 23:41:35.873555+08
b2c2ec63c86e469e9d9199b8f224dde6	100096z	startalk.tech	1	1542697	0	1604310959	conference.startalk.tech	2020-11-02 17:55:59.011674+08
b2c2ec63c86e469e9d9199b8f224dde6	chao.zhang5	startalk.tech	1	1542698	0	1604310959	conference.startalk.tech	2020-11-02 17:55:59.016765+08
408fcdfe35454d37ab20f02606ef0695	mumu	startalk.tech	1	1542700	1604311274904	1604311062	conference.startalk.tech	2020-11-02 17:57:42.681226+08
83d2403acedf4b39877f592244043dee	mumu	startalk.tech	1	1542747	1605368462031	1604971760	conference.startalk.tech	2020-11-10 09:29:20.369732+08
42b028bd797443fb8230a73b1caf0931	100095z	startalk.tech	1	1542689	1604368151551	1604310233	conference.startalk.tech	2020-11-02 17:43:53.433563+08
83d2403acedf4b39877f592244043dee	100095z	startalk.tech	1	1542759	1605516338665	1605367140	conference.startalk.tech	2020-11-14 23:19:00.584303+08
3c23e31805af4ba0bc6a7fc71639cf21	100095z	startalk.tech	1	1542777	1605368726646	1605368726	conference.startalk.tech	2020-11-14 23:45:26.63733+08
da499de5f90e42a789b91e75a75d075c	100095z	startalk.tech	1	1542708	1604372419557	1604372403	conference.startalk.tech	2020-11-03 11:00:03.414973+08
6737bb1bb2af443086d57e81d71eeb94	mumu	startalk.tech	1	1542737	1605064533910	1604969934	conference.startalk.tech	2020-11-10 08:58:54.2534+08
a6c0d98b4c9045e88a88098b5424c812	100096z	startalk.tech	1	1542711	0	1604373677	conference.startalk.tech	2020-11-03 11:21:17.156208+08
a6c0d98b4c9045e88a88098b5424c812	100095z	startalk.tech	1	1542709	1604373677164	1604373676	conference.startalk.tech	2020-11-03 11:21:16.796277+08
99f601bbbefd40de92e681fbe8d02048	100096z	startalk.tech	1	1542713	0	1604373812	conference.startalk.tech	2020-11-03 11:23:32.417343+08
99f601bbbefd40de92e681fbe8d02048	100095z	startalk.tech	1	1542712	1604373812423	1604373811	conference.startalk.tech	2020-11-03 11:23:31.965514+08
53e4ccf7cd6049788f427737d03f2534	100096z	startalk.tech	1	1542716	0	1604373838	conference.startalk.tech	2020-11-03 11:23:58.407084+08
53e4ccf7cd6049788f427737d03f2534	chao.zhang5	startalk.tech	1	1542718	0	1604373859	conference.startalk.tech	2020-11-03 11:24:19.398724+08
53e4ccf7cd6049788f427737d03f2534	100095z	startalk.tech	1	1542714	1604373859405	1604373837	conference.startalk.tech	2020-11-03 11:23:57.911164+08
2ce913d30df441cf8fb82d3d42bf105b	100095z	startalk.tech	1	1542719	1604375986583	1604373901	conference.startalk.tech	2020-11-03 11:25:01.939516+08
ba2a497adbbe44c7b67f2dd81e53e8f9	100095z	startalk.tech	1	1542702	1604311369478	1604311296	conference.startalk.tech	2020-11-02 18:01:36.633323+08
221d33e20e17449db36173cdd39e76ff	100096z	startalk.tech	1	1542722	0	1604662239	conference.startalk.tech	2020-11-06 19:30:39.799432+08
221d33e20e17449db36173cdd39e76ff	100095z	startalk.tech	1	1542720	1604662239808	1604662232	conference.startalk.tech	2020-11-06 19:30:32.351628+08
5cde4d34a44544b9a58c7a592a851756	100096z	startalk.tech	1	1542725	0	1604662324	conference.startalk.tech	2020-11-06 19:32:04.311461+08
5cde4d34a44544b9a58c7a592a851756	潮涨	startalk.tech	1	1542726	0	1604662324	conference.startalk.tech	2020-11-06 19:32:04.316202+08
5cde4d34a44544b9a58c7a592a851756	100095z	startalk.tech	1	1542723	1604662324322	1604662323	conference.startalk.tech	2020-11-06 19:32:03.941962+08
ba9fa0065e1c49e38415ac184ba3a3a8	潮涨	startalk.tech	1	1542731	0	1604662347	conference.startalk.tech	2020-11-06 19:32:27.76245+08
ba9fa0065e1c49e38415ac184ba3a3a8	100095z	startalk.tech	1	1542727	1604662347768	1604662347	conference.startalk.tech	2020-11-06 19:32:27.304519+08
b2c2ec63c86e469e9d9199b8f224dde6	100004q	startalk.tech	1	1542699	1604828932396	1604310965	conference.startalk.tech	2020-11-02 17:56:05.397879+08
3b9ff47191c143e9991452fa02affa23	100004q	startalk.tech	1	1542732	1605337721737	1604829418	conference.startalk.tech	2020-11-08 17:56:58.086846+08
b9f791d73c5045b7bad8f0c1235d22f4	100004q	startalk.tech	1	1542705	1604313187457	1604311373	conference.startalk.tech	2020-11-02 18:02:53.571725+08
ba2a497adbbe44c7b67f2dd81e53e8f9	100004q	startalk.tech	1	1542701	1604829017476	1604311296	conference.startalk.tech	2020-11-02 18:01:36.231468+08
6737bb1bb2af443086d57e81d71eeb94	100095z	startalk.tech	1	1542738	1604969934263	1604969934	conference.startalk.tech	2020-11-10 08:58:54.257518+08
42b028bd797443fb8230a73b1caf0931	100096z	startalk.tech	1	1542707	1605366842714	1604368151	conference.startalk.tech	2020-11-03 09:49:11.544151+08
17a73d186c034b1ea71bfc3dd3108ee0	100095z	startalk.tech	1	1542733	1604971447957	1604966692	conference.startalk.tech	2020-11-10 08:04:52.035373+08
03bf3595212f4c098fc3b4967af8467d	100096z	startalk.tech	1	1542694	1605366843019	1604310930	conference.startalk.tech	2020-11-02 17:55:30.943359+08
17a73d186c034b1ea71bfc3dd3108ee0	mumu	startalk.tech	1	1542740	1605366589684	1604971447	conference.startalk.tech	2020-11-10 09:24:07.950782+08
9afcd37223a842d6b39f29ec13e2d678	100095z	startalk.tech	1	1542744	1604971474958	1604971473	conference.startalk.tech	2020-11-10 09:24:33.921672+08
ba9fa0065e1c49e38415ac184ba3a3a8	100096z	startalk.tech	1	1542730	1604971722026	1604662347	conference.startalk.tech	2020-11-06 19:32:27.758263+08
7f8cf571ceb74bd2a27a33f985386362	100095z	startalk.tech	1	1542764	0	1605368390	conference.startalk.tech	2020-11-14 23:39:50.083657+08
5e0faeaa8741489ab5b9f6131667fe80	100095z	startalk.tech	1	1542768	0	1605368440	conference.startalk.tech	2020-11-14 23:40:40.657092+08
42b028bd797443fb8230a73b1caf0931	100094z	startalk.tech	1	1542706	1605439271000	1604368151	conference.startalk.tech	2020-11-03 09:49:11.539115+08
3c23e31805af4ba0bc6a7fc71639cf21	mumu	startalk.tech	1	1542775	1605368726646	1605368725	conference.startalk.tech	2020-11-14 23:45:25.920479+08
55a59d75b08a4f77b76f75eb68cd3e15	100094z	startalk.tech	1	1542666	1605439271000	1604157446	conference.startalk.tech	2020-10-31 23:17:26.378324+08
b235887358a34bba8f81c269d5d5658e	100094z	startalk.tech	1	1542639	1605439271000	1603960329	conference.startalk.tech	2020-10-29 16:32:09.506279+08
e68a47f141ad43df8d72bd00ae78b133	100094z	startalk.tech	1	1542642	1605439271000	1603964043	conference.startalk.tech	2020-10-29 17:34:03.80886+08
9022c32aa1cd439fb9cbda23c45da981	100094z	startalk.tech	1	1542645	1605439271000	1603989033	conference.startalk.tech	2020-10-30 00:30:33.216189+08
e6f21f761ddd4a7f8eb6570adc7cbf9e	100094z	startalk.tech	1	1542636	1605439271000	1603960098	conference.startalk.tech	2020-10-29 16:28:18.624982+08
b10f8a925460494a96ffb7ef58002ffa	100094z	startalk.tech	1	1542669	1605439271000	1604300568	conference.startalk.tech	2020-11-02 15:02:48.569754+08
46823ed77669448eaea51c1f9f130d70	100094z	startalk.tech	1	1542633	1605439271000	1603643025	conference.startalk.tech	2020-10-26 00:23:45.832179+08
d62701c245234248aaa069f2e63e2474	100094z	startalk.tech	1	1542676	1605439271000	1604304383	conference.startalk.tech	2020-11-02 16:06:23.045698+08
08385b97f4954b4ba55fab2277f26436	100094z	startalk.tech	1	1542691	1605439271000	1604310760	conference.startalk.tech	2020-11-02 17:52:40.045784+08
3389f6c1bb4042a2ab0c339dec3c16a9	100094z	startalk.tech	1	1542648	1605439271000	1604062404	conference.startalk.tech	2020-10-30 20:53:24.427369+08
0229eb47b1154771866863ddab7c96b6	100094z	startalk.tech	1	1542682	1605439271000	1604308563	conference.startalk.tech	2020-11-02 17:16:03.221613+08
abd227dec13a48bbbf4de1b44605bbcb	100094z	startalk.tech	1	1542685	1605439271000	1604308873	conference.startalk.tech	2020-11-02 17:21:13.638406+08
ead71a2044ea4007b275e4c1dd6326ae	100094z	startalk.tech	1	1542687	1605439271000	1604309685	conference.startalk.tech	2020-11-02 17:34:45.497732+08
95047e5e04014cd2b2ec4b16c85f744c	100094z	startalk.tech	1	1542653	1605439271000	1604062859	conference.startalk.tech	2020-10-30 21:00:59.232794+08
b0b5ebc6f7f240a1a92b26a1f313d03a	100094z	startalk.tech	1	1542650	1605439271000	1604062791	conference.startalk.tech	2020-10-30 20:59:51.468685+08
eb32de0dc28c40b0824b72af7873dfa5	100094z	startalk.tech	1	1542658	1605439271000	1604127454	conference.startalk.tech	2020-10-31 14:57:34.836639+08
b53827521885446b9b53cd68c885f878	100094z	startalk.tech	1	1542688	1605439271000	1604309964	conference.startalk.tech	2020-11-02 17:39:24.881455+08
3c1b6a39035c442a8f59e5704bba096a	100094z	startalk.tech	1	1542659	1605439271000	1604127691	conference.startalk.tech	2020-10-31 15:01:31.96053+08
83d2403acedf4b39877f592244043dee	100094z	startalk.tech	1	1542758	1605439271000	1605367140	conference.startalk.tech	2020-11-14 23:19:00.577317+08
6737bb1bb2af443086d57e81d71eeb94	100094z	startalk.tech	1	1542736	1605439271000	1604969934	conference.startalk.tech	2020-11-10 08:58:54.069969+08
221d33e20e17449db36173cdd39e76ff	100094z	startalk.tech	1	1542721	1605439271000	1604662232	conference.startalk.tech	2020-11-06 19:30:32.739691+08
b58cb19af6c04a71af24417aef49cf0b	100094z	startalk.tech	1	1542692	1605439271000	1604310907	conference.startalk.tech	2020-11-02 17:55:07.470611+08
17a73d186c034b1ea71bfc3dd3108ee0	100094z	startalk.tech	1	1542734	1605439271000	1604966692	conference.startalk.tech	2020-11-10 08:04:52.404996+08
ba2a497adbbe44c7b67f2dd81e53e8f9	100094z	startalk.tech	1	1542704	1605439271000	1604311369	conference.startalk.tech	2020-11-02 18:02:49.468946+08
38cfb6912f814b77bb7bb2d6bbfd3245	100094z	startalk.tech	1	1542769	1605499987650	1605368477	conference.startalk.tech	2020-11-14 23:41:17.174171+08
\.


--
-- Data for Name: muc_user_mark; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.muc_user_mark (muc_name, user_name, login_date, logout_date, id) FROM stdin;
6087afffae43438a88f6a7a46e969404	100094z	1603885787	1603960309	1
6dec5e56b25741a9ba0ad2e04766d8d4	100095z	1604973720	1604973738	2
6dec5e56b25741a9ba0ad2e04766d8d4	100096z	1604973729	1604973738	3
6dec5e56b25741a9ba0ad2e04766d8d4	100094z	1604973720	1604973738	4
b0fd2895a3a447b2ba9aa3768c4b52ec	100095z	1605366611	1605366831	5
b0fd2895a3a447b2ba9aa3768c4b52ec	100096z	1605366611	1605366831	6
b0fd2895a3a447b2ba9aa3768c4b52ec	mumu	1605366611	1605366831	7
b0fd2895a3a447b2ba9aa3768c4b52ec	100094z	1605366635	1605366831	8
cb8c771fd29a4f4f96a2de73a012c4a5	100095z	1605368333	1605368352	9
cb8c771fd29a4f4f96a2de73a012c4a5	100094z	1605368333	1605368352	10
cb8c771fd29a4f4f96a2de73a012c4a5	mumu	1605368333	1605368352	11
b9a915b72ff94cf8a71823c05cd12528	100094z	1605368402	1605368448	12
96a85e39bcc647c4b60831060dc0f94c	mumu	1605437400	1605437631	13
96a85e39bcc647c4b60831060dc0f94c	100095z	1605436824	1605437631	14
96a85e39bcc647c4b60831060dc0f94c	100094z	1605437619	1605437631	15
d1aa13f85c4b41768b25027ff007c81a	test02	1605660827	1605661485	16
d1aa13f85c4b41768b25027ff007c81a	100013v	1605661476	1605661485	17
d1aa13f85c4b41768b25027ff007c81a	test01	1605660827	1605661485	18
\.


--
-- Data for Name: muc_vcard_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.muc_vcard_info (muc_name, show_name, muc_desc, muc_title, muc_pic, show_name_pinyin, update_time, version) FROM stdin;
eacfa594c3374240a8370990febb980a@conference.startalk.tech	测试群组			/file/v2/download/5645fc02eac20176c8a3569d83f3ff7a.png	测试群组	2020-10-15 15:33:25.678+08	2
46823ed77669448eaea51c1f9f130d70@conference.startalk.tech		没有公告	欢迎加入	/file/v2/download/5645fc02eac20176c8a3569d83f3ff7a.png		2020-10-26 00:23:45.828+08	2
13a476002524475898657c196fe66197@conference.startalk.tech		没有公告	欢迎加入	/file/v2/download/5645fc02eac20176c8a3569d83f3ff7a.png		2020-10-26 00:28:56.239+08	2
55a59d75b08a4f77b76f75eb68cd3e15@conference.startalk.tech	test22			/file/v2/download/d63e7f0da0d89a38e0fec160ade307f3.png	test22|test22	2020-10-31 23:17:26.078418+08	3
3389f6c1bb4042a2ab0c339dec3c16a9@conference.startalk.tech	,chao.zhang5@startalk.tech	没有公告	欢迎加入	/file/v2/download/d63e7f0da0d89a38e0fec160ade307f3.png	chaozhang5startalktech|chaozhang5startalktech	2020-10-30 20:53:24.542636+08	3
b10f8a925460494a96ffb7ef58002ffa@conference.startalk.tech	test11			/file/v2/download/d63e7f0da0d89a38e0fec160ade307f3.png	test11|test11	2020-11-02 15:02:48.177631+08	3
abd227dec13a48bbbf4de1b44605bbcb@conference.startalk.tech	珊珊JH,zhangchao5	没有公告	欢迎加入	/file/v2/download/d63e7f0da0d89a38e0fec160ade307f3.png	珊珊JH,zhangchao5	2020-11-02 17:21:13.634+08	3
677930584d7145b6bd20b79f4bae7352@conference.startalk.tech	12			/file/v2/download/d63e7f0da0d89a38e0fec160ade307f3.png	12|12	2020-11-02 15:04:00.292313+08	3
b235887358a34bba8f81c269d5d5658e@conference.startalk.tech	zhangchao测试7	没有公告	欢迎加入	/file/v2/download/d63e7f0da0d89a38e0fec160ade307f3.png	zhangchaoceshi7|zhangchaocs7	2020-10-29 17:23:26.139378+08	11
e6f21f761ddd4a7f8eb6570adc7cbf9e@conference.startalk.tech	test22	没有公告	欢迎加入	/file/v2/download/d63e7f0da0d89a38e0fec160ade307f3.png	test22|test22	2020-10-29 17:24:02.301052+08	4
b0b5ebc6f7f240a1a92b26a1f313d03a@conference.startalk.tech	珊珊JH,zhangchao5	没有公告	欢迎加入	/file/v2/download/6f3f04cfa23acb9e7050bb5b3fc208b4.png	shanshanjhzhangchao5|ssjhzhangchao5	2020-10-30 20:59:51.55695+08	5
e68a47f141ad43df8d72bd00ae78b133@conference.startalk.tech	珊珊JH,zhangchao6	没有公告	欢迎加入	/file/v2/download/d63e7f0da0d89a38e0fec160ade307f3.png	珊珊JH,zhangchao6	2020-10-29 17:34:03.804+08	4
838c7c32d28e4747be9a61043ead3e08@conference.startalk.tech		没有公告	欢迎加入	/file/v2/download/5645fc02eac20176c8a3569d83f3ff7a.png		2020-10-29 20:01:49.124+08	2
9022c32aa1cd439fb9cbda23c45da981@conference.startalk.tech		没有公告	欢迎加入	/file/v2/download/5645fc02eac20176c8a3569d83f3ff7a.png		2020-10-30 00:30:33.211+08	2
7a720787654245529bccba67426a0366@conference.startalk.tech		没有公告	欢迎加入	/file/v2/download/5645fc02eac20176c8a3569d83f3ff7a.png		2020-10-30 00:33:03.857+08	2
56be69ae06e5475b9e85295de0ae4dd7@conference.startalk.tech	13			/file/v2/download/5645fc02eac20176c8a3569d83f3ff7a.png	13	2020-11-02 15:05:29.545+08	2
eb32de0dc28c40b0824b72af7873dfa5@conference.startalk.tech		没有公告	欢迎加入	/file/v2/download/5645fc02eac20176c8a3569d83f3ff7a.png		2020-10-31 14:57:34.832+08	2
3c1b6a39035c442a8f59e5704bba096a@conference.startalk.tech		没有公告	欢迎加入	/file/v2/download/5645fc02eac20176c8a3569d83f3ff7a.png		2020-10-31 15:01:31.956+08	2
95047e5e04014cd2b2ec4b16c85f744c@conference.startalk.tech	test11	没有公告	欢迎加入	/file/v2/download/6f3f04cfa23acb9e7050bb5b3fc208b4.png	test11	2020-10-30 21:00:59.228+08	6
18dd0d10d591479c858a92be057c694e@conference.startalk.tech	珊珊JH,杉杉			/file/v2/download/5645fc02eac20176c8a3569d83f3ff7a.png	珊珊JH,杉杉	2020-10-31 22:58:03.805+08	2
e299435983c34c3885d329e59a7561ca@conference.startalk.tech	test21			/file/v2/download/5645fc02eac20176c8a3569d83f3ff7a.png	test21	2020-10-31 23:00:53.983+08	2
ead71a2044ea4007b275e4c1dd6326ae@conference.startalk.tech		没有公告	欢迎加入	/file/v2/download/5645fc02eac20176c8a3569d83f3ff7a.png		2020-11-02 17:34:45.493+08	2
d62701c245234248aaa069f2e63e2474@conference.startalk.tech	14			/file/v2/download/c48d543591c3ba25767a680d927e47a3.png	14	2020-11-02 16:06:22.435+08	4
b53827521885446b9b53cd68c885f878@conference.startalk.tech		没有公告	欢迎加入	/file/v2/download/5645fc02eac20176c8a3569d83f3ff7a.png		2020-11-02 17:39:24.877+08	2
64598a656b384af4b458473b72dceb26@conference.startalk.tech	15			/file/v2/download/d63e7f0da0d89a38e0fec160ade307f3.png	15	2020-11-02 16:07:17.972+08	3
b58cb19af6c04a71af24417aef49cf0b@conference.startalk.tech	chaozhangtest1			/file/v2/download/d63e7f0da0d89a38e0fec160ade307f3.png	chaozhangtest1	2020-11-02 17:55:07.465+08	3
0229eb47b1154771866863ddab7c96b6@conference.startalk.tech	15			/file/v2/download/d63e7f0da0d89a38e0fec160ade307f3.png	15	2020-11-02 17:16:02.011+08	3
575b0da2c0e44f5aade67f4bcd161e8f@conference.startalk.tech		没有公告	欢迎加入	/file/v2/download/5645fc02eac20176c8a3569d83f3ff7a.png		2020-11-02 17:51:44.121+08	2
08385b97f4954b4ba55fab2277f26436@conference.startalk.tech		没有公告	欢迎加入	/file/v2/download/5645fc02eac20176c8a3569d83f3ff7a.png		2020-11-02 17:52:40.041+08	2
03bf3595212f4c098fc3b4967af8467d@conference.startalk.tech		没有公告	欢迎加入	/file/v2/download/5645fc02eac20176c8a3569d83f3ff7a.png		2020-11-02 17:55:30.939+08	2
408fcdfe35454d37ab20f02606ef0695@conference.startalk.tech		没有公告	欢迎加入	/file/v2/download/5645fc02eac20176c8a3569d83f3ff7a.png		2020-11-02 17:57:42.677+08	2
b2c2ec63c86e469e9d9199b8f224dde6@conference.startalk.tech	test2333			/file/v2/download/c48d543591c3ba25767a680d927e47a3.png	test2333	2020-11-02 17:55:58.37+08	4
da499de5f90e42a789b91e75a75d075c@conference.startalk.tech		没有公告	欢迎加入	/file/v2/download/5645fc02eac20176c8a3569d83f3ff7a.png		2020-11-03 11:00:03.41+08	2
ba2a497adbbe44c7b67f2dd81e53e8f9@conference.startalk.tech	测试	没有公告	欢迎加入	/file/v2/download/c48d543591c3ba25767a680d927e47a3.png	测试	2020-11-02 18:01:36.227+08	5
b9f791d73c5045b7bad8f0c1235d22f4@conference.startalk.tech	JH伽勒	没有公告	欢迎加入	/file/v2/download/5645fc02eac20176c8a3569d83f3ff7a.png	JH伽勒	2020-11-02 18:02:53.567+08	2
a6c0d98b4c9045e88a88098b5424c812@conference.startalk.tech	test22			/file/v2/download/d63e7f0da0d89a38e0fec160ade307f3.png	test22	2020-11-03 11:21:16.789+08	3
99f601bbbefd40de92e681fbe8d02048@conference.startalk.tech	test33			/file/v2/download/d63e7f0da0d89a38e0fec160ade307f3.png	test33	2020-11-03 11:23:31.959+08	3
53e4ccf7cd6049788f427737d03f2534@conference.startalk.tech	test44			/file/v2/download/6f3f04cfa23acb9e7050bb5b3fc208b4.png	test44	2020-11-03 11:23:57.907+08	4
2ce913d30df441cf8fb82d3d42bf105b@conference.startalk.tech		没有公告	欢迎加入	/file/v2/download/5645fc02eac20176c8a3569d83f3ff7a.png		2020-11-03 11:25:01.934+08	2
42b028bd797443fb8230a73b1caf0931@conference.startalk.tech	哈哈	没有公告	欢迎加入	/file/v2/download/6f3f04cfa23acb9e7050bb5b3fc208b4.png	哈哈	2020-11-02 17:43:43.330325+08	7
221d33e20e17449db36173cdd39e76ff@conference.startalk.tech	test234			/file/v2/download/c48d543591c3ba25767a680d927e47a3.png	test234	2020-11-06 19:30:32.347+08	4
5cde4d34a44544b9a58c7a592a851756@conference.startalk.tech	dddd			/file/v2/download/d63e7f0da0d89a38e0fec160ade307f3.png	dddd	2020-11-06 19:32:03.937+08	3
ba9fa0065e1c49e38415ac184ba3a3a8@conference.startalk.tech	33333			/file/v2/download/d63e7f0da0d89a38e0fec160ade307f3.png	33333	2020-11-06 19:32:27.3+08	3
6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech	测试一家	没有公告	欢迎加入	/file/v2/download/d63e7f0da0d89a38e0fec160ade307f3.png	ceshiyijia|csyj	2020-11-10 08:59:14.574309+08	4
17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech	test22			/file/v2/download/6f3f04cfa23acb9e7050bb5b3fc208b4.png	test22	2020-11-10 08:04:52.031+08	4
83d2403acedf4b39877f592244043dee@conference.startalk.tech	hhh		大家好	/file/v2/download/6f3f04cfa23acb9e7050bb5b3fc208b4.png	hhh|hhh	2020-11-10 09:57:01.75407+08	7
9afcd37223a842d6b39f29ec13e2d678@conference.startalk.tech	珊珊JH,杉杉			/file/v2/download/d63e7f0da0d89a38e0fec160ade307f3.png	shanshanjhshanshan|ssjhss	2020-11-10 09:24:34.48355+08	3
7f8cf571ceb74bd2a27a33f985386362@conference.startalk.tech	珊珊JH,杉杉	没有公告	欢迎加入	/file/v2/download/d63e7f0da0d89a38e0fec160ade307f3.png	shanshanjhshanshan|ssjhss	2020-11-14 23:39:50.024324+08	3
c395017fb9434bafbeb86a69b8b3a46d@conference.startalk.tech	杉杉,沐沐		\N	/file/v2/download/d63e7f0da0d89a38e0fec160ade307f3.png	shanshanmumu|ssmm	2020-11-15 19:17:38.851136+08	3
3b9ff47191c143e9991452fa02affa23@conference.startalk.tech	测试3	哈哈哈	测试	/file/v2/download/d74779b795e16dde2c7fe761a11cb5d0.png	ceshi3|cs3	2020-11-13 02:31:32.248975+08	6
5e0faeaa8741489ab5b9f6131667fe80@conference.startalk.tech	珊珊JH,杉杉	没有公告	欢迎加入	/file/v2/download/d63e7f0da0d89a38e0fec160ade307f3.png	shanshanjhshanshan|ssjhss	2020-11-14 23:40:40.592742+08	3
38cfb6912f814b77bb7bb2d6bbfd3245@conference.startalk.tech	珊珊JH,杉杉	没有公告	欢迎加入进来了	/file/v2/download/d63e7f0da0d89a38e0fec160ade307f3.png	shanshanjhshanshan|ssjhss	2020-11-14 23:41:26.682917+08	7
3c23e31805af4ba0bc6a7fc71639cf21@conference.startalk.tech	珊珊JH,杉杉,沐沐			/file/v2/download/d63e7f0da0d89a38e0fec160ade307f3.png	shanshanjhshanshanmumu|ssjhssmm	2020-11-14 23:45:26.193698+08	3
\.


--
-- Data for Name: notice_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notice_history (id, msg_id, m_from, m_body, create_time, host) FROM stdin;
\.


--
-- Data for Name: persistent_logins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.persistent_logins (username, series, token, last_used) FROM stdin;
\.


--
-- Data for Name: privacy_default_list; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.privacy_default_list (username, name) FROM stdin;
\.


--
-- Data for Name: privacy_list; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.privacy_list (username, name, id, created_at) FROM stdin;
\.


--
-- Data for Name: privacy_list_data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.privacy_list_data (id, t, value, action, ord, match_all, match_iq, match_message, match_presence_in, match_presence_out) FROM stdin;
\.


--
-- Data for Name: private_storage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.private_storage (username, namespace, data, created_at) FROM stdin;
\.


--
-- Data for Name: pubsub_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pubsub_item (nodeid, itemid, publisher, creation, modification, payload) FROM stdin;
\.


--
-- Data for Name: pubsub_node; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pubsub_node (host, node, parent, type, nodeid) FROM stdin;
\.


--
-- Data for Name: pubsub_node_option; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pubsub_node_option (nodeid, name, val) FROM stdin;
\.


--
-- Data for Name: pubsub_node_owner; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pubsub_node_owner (nodeid, owner) FROM stdin;
\.


--
-- Data for Name: pubsub_state; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pubsub_state (nodeid, jid, affiliation, subscriptions, stateid) FROM stdin;
\.


--
-- Data for Name: pubsub_subscription_opt; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pubsub_subscription_opt (subid, opt_name, opt_value) FROM stdin;
\.


--
-- Data for Name: push_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.push_info (id, user_name, host, mac_key, platname, pkgname, os, version, create_time, update_at, show_content, push_flag) FROM stdin;
1	admin	startalk.tech	372257F8352EE9F94364FFA7265AAF89	mipush	com.qunar.im.startalk	android	240	2020-10-25 16:40:04.407534+08	2020-10-25 16:40:04.407534+08	1	29
4	100095z	startalk.tech	8a1538a60f4ce1f5776bdf85fcb64afb6a7eb7c0aeaf518dbb0fab9b8104d925	iPhone12,8_zh_CN	com.qunar.qunartalk	ios	3140670	2020-10-26 00:13:21.211728+08	2020-11-17 17:15:30.62739+08	1	29
2	100004q	startalk.tech	dAq7udf8f60:APA91bFto4TtXkzgubH3mHMKxy3osK0lDvSHwGCVIxK0hTQo5WAmAr-Z4Scqxe4SJYHruR1gqlTi3jOG69RLMI-L4oeuwCywRayv-WzIx00yWOOd-hUPo9VtwNuH1lJ4jKS_mYb5qK6P	fcmpush_zh	com.qunar.im.startalk	android	254	2020-10-25 16:46:14.398097+08	2020-11-17 21:05:46.651799+08	1	29
7	100013v	startalk.tech				android	206	2020-11-03 11:24:45.324687+08	2020-11-18 08:34:16.984383+08	1	29
6	mumu	startalk.tech				android	240	2020-11-02 17:57:29.457142+08	2020-11-03 07:19:17.397313+08	1	29
3	100094z	startalk.tech				ios	3140670	2020-10-25 23:59:06.971284+08	2020-11-16 12:06:41.422062+08	1	31
5	100096z	startalk.tech	342d2960b06599c21db840630b07d9203d4b2fc82fca385571a2f4ab421c482a	iPhone6sPlus_zh_CN	com.qunar.qunartalk	ios	3140670	2020-10-26 00:28:44.282271+08	2020-11-16 12:24:52.377015+08	1	29
\.


--
-- Data for Name: qcloud_main; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.qcloud_main (id, q_user, q_type, q_title, q_introduce, q_content, q_time, q_state) FROM stdin;
\.


--
-- Data for Name: qcloud_main_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.qcloud_main_history (id, q_id, qh_content, qh_time, qh_state) FROM stdin;
\.


--
-- Data for Name: qcloud_sub; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.qcloud_sub (id, q_id, qs_user, qs_type, qs_title, qs_introduce, qs_content, qs_time, qs_state) FROM stdin;
\.


--
-- Data for Name: qcloud_sub_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.qcloud_sub_history (id, qs_id, qh_content, qh_time, qh_state) FROM stdin;
\.


--
-- Data for Name: qtalk_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.qtalk_config (id, config_key, config_value, create_time) FROM stdin;
\.


--
-- Data for Name: qtalk_user_comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.qtalk_user_comment (id, from_user, to_user, create_time, comment, grade) FROM stdin;
\.


--
-- Data for Name: recv_msg_option; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recv_msg_option (username, rec_msg_opt, version) FROM stdin;
\.


--
-- Data for Name: revoke_msg_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.revoke_msg_history (m_from, m_to, m_body, id, m_timestamp, msg_id, create_time) FROM stdin;
100094z	100096z	<message msec_times='1603953261528' xml:lang='en' from='100094z@startalk.tech' to='100096z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;FILEID&quot;:&quot;a71ed9262c5b48b8a77174fde5a7900b&quot;,&quot;FileName&quot;:&quot;分析Protoo代码的施工方案.md&quot;,&quot;FileSize&quot;:&quot;0.61KB&quot;,&quot;FILEMD5&quot;:&quot;c7e743cc7b9b25394bea0442f7990213&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/c7e743cc7b9b25394bea0442f7990213?name=c7e743cc7b9b25394bea0442f7990213.md&quot;}' id='a71ed9262c5b48b8a77174fde5a7900b' msgType='5'>{&quot;FILEID&quot;:&quot;a71ed9262c5b48b8a77174fde5a7900b&quot;,&quot;FileName&quot;:&quot;分析Protoo代码的施工方案.md&quot;,&quot;FileSize&quot;:&quot;0.61KB&quot;,&quot;FILEMD5&quot;:&quot;c7e743cc7b9b25394bea0442f7990213&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/c7e743cc7b9b25394bea0442f7990213?name=c7e743cc7b9b25394bea0442f7990213.md&quot;}</body></message>	1	1603953264	a71ed9262c5b48b8a77174fde5a7900b	2020-10-29 14:34:24.061578+08
100094z	100095z	<message msec_times='1603970250524' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='d1bc3427af7540eebbd913cf42bfc797' msgType='1'>订单</body></message>	2	1603970261	d1bc3427af7540eebbd913cf42bfc797	2020-10-29 19:17:40.784339+08
100094z	100095z	<message msec_times='1603970263056' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='ccf7a3cfa73d477e9a60a82c0cf0508d' msgType='1'>订单</body></message>	3	1603970292	ccf7a3cfa73d477e9a60a82c0cf0508d	2020-10-29 19:18:11.666033+08
100094z	100095z	<message msec_times='1603970337395' xml:lang='en' from='100094z@startalk.tech' to='100095z@startalk.tech' type='chat' client_type='ClientTypePC' client_ver='200010'><body id='ab54293c584845c99acaa066adca778b' msgType='1'>的 </body></message>	4	1603970421	ab54293c584845c99acaa066adca778b	2020-10-29 19:20:21.291006+08
100095z_startalk.tech	83d2403acedf4b39877f592244043dee	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100095z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1604972680740' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='6b5e0f435a664278b1eb0627653bea17' msgType='1'>「 杉杉: 「 杉杉: [obj type=&quot;image&quot; value=&quot;https://im.startalk.tech:8443/file/v2/download/d13996df6e0d4ec19ff9231cde75896d.png?name=d13996df6e0d4ec19ff9231cde75896d.png&quot; width=48 height=48] 」\n -------------------------  \n你好 」\n -------------------------  \n的</body></message>	5	1604972683	6b5e0f435a664278b1eb0627653bea17	2020-11-10 09:44:42.934934+08
100095z_startalk.tech	83d2403acedf4b39877f592244043dee	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100095z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100095z@startalk.tech' realfrom='100095z@startalk.tech' msec_times='1604972674790' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='7cf3fcb19df249aaa8ad5d5d46613bb9' msgType='1'>「 杉杉: 「 杉杉: [obj type=&quot;emoticon&quot; value=&quot;[/byqq]&quot; width=EmojiOne height=EmojiOne ] 」\n -------------------------  \n你好 」\n -------------------------  \n的</body></message>	6	1604972685	7cf3fcb19df249aaa8ad5d5d46613bb9	2020-11-10 09:44:45.16191+08
100094z_startalk.tech	83d2403acedf4b39877f592244043dee	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100094z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1604973189921' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body extendInfo='{&quot;adress&quot;:&quot;荆长大道168号&quot;,&quot;fileUrl&quot;:&quot;file/v2/download/55b28f8c9f9546439135eb693d45ac54.jpg?name\\u003d55b28f8c9f9546439135eb693d45ac54.jpg&quot;,&quot;latitude&quot;:&quot;30.297425694685018&quot;,&quot;longitude&quot;:&quot;120.04859612979332&quot;,&quot;name&quot;:&quot;重庆鸡公煲(同顺街店)&quot;}' id='836c4e04-673b-49a4-ad6f-7dcbc26970b0' msgType='16'>我在这里，点击查看：[obj type=&quot;url&quot; value=&quot;http://api.map.baidu.com/marker?location=30.297425694685018,120.04859612979332&amp;title=我的位置&amp;content=荆长大道168号&amp;output=html&quot;]荆长大道168号</body></message>	7	1604973195	836c4e04-673b-49a4-ad6f-7dcbc26970b0	2020-11-10 09:53:15.349559+08
100094z_startalk.tech	83d2403acedf4b39877f592244043dee	<message from='83d2403acedf4b39877f592244043dee@conference.startalk.tech/100094z_startalk.tech' to='83d2403acedf4b39877f592244043dee@conference.startalk.tech' sendjid='100094z@startalk.tech' realfrom='100094z@startalk.tech' msec_times='1604973201760' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body id='ffc2f57c-476a-4fbe-8fba-c06b48242f52' msgType='1'>[obj type=&quot;emoticon&quot; value=&quot;[/zy]&quot; width=EmojiOne height=0 ][obj type=&quot;emoticon&quot; value=&quot;[/xy]&quot; width=EmojiOne height=0 ]</body></message>	8	1604973205	ffc2f57c-476a-4fbe-8fba-c06b48242f52	2020-11-10 09:53:25.39725+08
mumu_startalk.tech	6737bb1bb2af443086d57e81d71eeb94	<message from='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech/mumu_startalk.tech' to='6737bb1bb2af443086d57e81d71eeb94@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605064397625' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body id='6b8a88578aab4b1d895c8eebd6bd0bfd' msgType='1'>好像时候</body></message>	9	1605064402	6b8a88578aab4b1d895c8eebd6bd0bfd	2020-11-11 11:13:21.733682+08
mumu_startalk.tech	17a73d186c034b1ea71bfc3dd3108ee0	<message from='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech/mumu_startalk.tech' to='17a73d186c034b1ea71bfc3dd3108ee0@conference.startalk.tech' sendjid='mumu@startalk.tech' realfrom='mumu@startalk.tech' msec_times='1605366536859' xml:lang='en' type='groupchat' client_type='ClientTypePC' client_ver='200010'><body extendInfo='{&quot;FILEID&quot;:&quot;cd2dc161cd8b4b138dc4ef4cfb1d26fc&quot;,&quot;FileName&quot;:&quot;20201111_110634.m4a&quot;,&quot;FileSize&quot;:&quot;72.29KB&quot;,&quot;FILEMD5&quot;:&quot;c65ef5efdc86873d337c3610e382295f&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/c65ef5efdc86873d337c3610e382295f?name=c65ef5efdc86873d337c3610e382295f.m4a&quot;}' id='2407148586e34f2d9ba2915b920a0f30' msgType='5'>{&quot;FILEID&quot;:&quot;cd2dc161cd8b4b138dc4ef4cfb1d26fc&quot;,&quot;FileName&quot;:&quot;20201111_110634.m4a&quot;,&quot;FileSize&quot;:&quot;72.29KB&quot;,&quot;FILEMD5&quot;:&quot;c65ef5efdc86873d337c3610e382295f&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/c65ef5efdc86873d337c3610e382295f?name=c65ef5efdc86873d337c3610e382295f.m4a&quot;}</body></message>	10	1605366542	2407148586e34f2d9ba2915b920a0f30	2020-11-14 23:09:01.919769+08
100094z	100095z	<message msec_times='1605437112590' xml:lang='en' from='100094z@startalk.tech/V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[D3AC1B7D4415412B8400318872B88EFD]_PB' to='100095z@startalk.tech' type='chat' client_type='ClientTypeiOS' client_ver='0'><body extendInfo='{&quot;FILEID&quot;:&quot;7d553a769f1643a499515bea4518ae3e&quot;,&quot;FileName&quot;:&quot;你好啊 啊啊啊 啊.docx&quot;,&quot;FileSize&quot;:&quot;12.42KB&quot;,&quot;FILEMD5&quot;:&quot;c600eac5dc458933853be0dab28594f2&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/c600eac5dc458933853be0dab28594f2?name=c600eac5dc458933853be0dab28594f2.docx&quot;}' id='E93220B8D9DD462BAB7A902AB529EBEF' msgType='5'>{&quot;FILEID&quot;:&quot;7d553a769f1643a499515bea4518ae3e&quot;,&quot;FileName&quot;:&quot;你好啊 啊啊啊 啊.docx&quot;,&quot;FileSize&quot;:&quot;12.42KB&quot;,&quot;FILEMD5&quot;:&quot;c600eac5dc458933853be0dab28594f2&quot;,&quot;HttpUrl&quot;:&quot;https://im.startalk.tech:8443/file/v2/download/c600eac5dc458933853be0dab28594f2?name=c600eac5dc458933853be0dab28594f2.docx&quot;}</body></message>	11	1605437127	E93220B8D9DD462BAB7A902AB529EBEF	2020-11-15 18:45:26.599154+08
100094z	100095z	<message msec_times='1605442901944' xml:lang='en' from='100094z@startalk.tech/V[3140670]_P[iOS]_D[iPhone 6s Plus]_S[13.6]_ID[65EC5D9601E34A089862F3D5F5E06285]_PB' to='100095z@startalk.tech' type='chat' client_type='ClientTypeiOS' client_ver='0'><body id='E0B0754888AE422C8041CA0792B7DB71' msgType='1'>你好</body></message>	12	1605442912	E0B0754888AE422C8041CA0792B7DB71	2020-11-15 20:21:52.384358+08
test01	100013v	<message msec_times='1605660442388' xml:lang='en' from='test01@startalk.tech' to='100013v@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='5ef090a5-0975-443a-94bb-9ecde6044191' msgType='2'>{&quot;FileName&quot;:&quot;c8bcb0e1-fcae-48d2-a419-83bede7ac39a.aar&quot;,&quot;FilePath&quot;:&quot;/data/user/0/sdk.im.qunar.com.qtalksdkdemo/files/qvoice/qvoice.tmp&quot;,&quot;HttpUrl&quot;:&quot;file/v2/download/4b3a4548b47b83cca302b959cc0a5882?name\\u003dqvoice.tmp&quot;,&quot;Seconds&quot;:3,&quot;s&quot;:0}</body></message>	13	1605660450	5ef090a5-0975-443a-94bb-9ecde6044191	2020-11-18 08:47:29.742966+08
test01	100013v	<message msec_times='1605660432198' xml:lang='en' from='test01@startalk.tech' to='100013v@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='3a35d54c-b4dd-4c82-a61b-2241aeb94751' msgType='2'>{&quot;FileName&quot;:&quot;39510d3f-2727-4f49-a741-397fdc8e39eb.aar&quot;,&quot;FilePath&quot;:&quot;/data/user/0/sdk.im.qunar.com.qtalksdkdemo/files/qvoice/qvoice.tmp&quot;,&quot;HttpUrl&quot;:&quot;file/v2/download/615442d83562ec68217eebfd15efc252?name\\u003dqvoice.tmp&quot;,&quot;Seconds&quot;:1,&quot;s&quot;:0}</body></message>	14	1605660452	3a35d54c-b4dd-4c82-a61b-2241aeb94751	2020-11-18 08:47:31.549929+08
test01	100013v	<message msec_times='1605660417719' xml:lang='en' from='test01@startalk.tech' to='100013v@startalk.tech' type='chat' client_type='ClientTypeAndroid' client_ver='0'><body id='bd9a79c0-fa56-4bb7-96c5-eedebebf14d8' msgType='2'>{&quot;FileName&quot;:&quot;bb738f31-6dce-4418-8f8b-ac6fcef644b5.aar&quot;,&quot;FilePath&quot;:&quot;/data/user/0/sdk.im.qunar.com.qtalksdkdemo/files/qvoice/qvoice.tmp&quot;,&quot;HttpUrl&quot;:&quot;file/v2/download/bdb5391300bc84dadd595ec648522743?name\\u003dqvoice.tmp&quot;,&quot;Seconds&quot;:1,&quot;s&quot;:0}</body></message>	15	1605660453	bd9a79c0-fa56-4bb7-96c5-eedebebf14d8	2020-11-18 08:47:33.129179+08
test01_startalk.tech	d1aa13f85c4b41768b25027ff007c81a	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/test01_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='test01@startalk.tech' realfrom='test01@startalk.tech' msec_times='1605661054964' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body extendInfo='{&quot;FILEID&quot;:&quot;e6f228eb-2ae1-4baf-b15c-e4856a4fe572&quot;,&quot;FILEMD5&quot;:&quot;73e9b9eb112eeabc6b2370c9f91bbf8e&quot;,&quot;FileName&quot;:&quot;mmexport1605617009550.png&quot;,&quot;FileSize&quot;:&quot;97.61K&quot;,&quot;HttpUrl&quot;:&quot;file/v2/download/73e9b9eb112eeabc6b2370c9f91bbf8e?name\\u003dmmexport1605617009550.png&quot;,&quot;LocalFile&quot;:&quot;/storage/emulated/0/Pictures/WeiXin/mmexport1605617009550.png&quot;,&quot;noMD5&quot;:false}' id='e6f228eb-2ae1-4baf-b15c-e4856a4fe572' msgType='5'>{&quot;FILEID&quot;:&quot;e6f228eb-2ae1-4baf-b15c-e4856a4fe572&quot;,&quot;FILEMD5&quot;:&quot;73e9b9eb112eeabc6b2370c9f91bbf8e&quot;,&quot;FileName&quot;:&quot;mmexport1605617009550.png&quot;,&quot;FileSize&quot;:&quot;97.61K&quot;,&quot;HttpUrl&quot;:&quot;file/v2/download/73e9b9eb112eeabc6b2370c9f91bbf8e?name\\u003dmmexport1605617009550.png&quot;,&quot;LocalFile&quot;:&quot;/storage/emulated/0/Pictures/WeiXin/mmexport1605617009550.png&quot;,&quot;noMD5&quot;:false}</body></message>	16	1605661060	e6f228eb-2ae1-4baf-b15c-e4856a4fe572	2020-11-18 08:57:40.272959+08
test01_startalk.tech	d1aa13f85c4b41768b25027ff007c81a	<message from='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech/test01_startalk.tech' to='d1aa13f85c4b41768b25027ff007c81a@conference.startalk.tech' sendjid='test01@startalk.tech' realfrom='test01@startalk.tech' msec_times='1605661052386' xml:lang='en' type='groupchat' client_type='ClientTypeAndroid' client_ver='0'><body extendInfo='{&quot;FILEID&quot;:&quot;f87dc85d-930b-4609-92b2-0d43a1f4c8b5&quot;,&quot;FILEMD5&quot;:&quot;aa0d8dffaebfd44c6cb668cec0ab490f&quot;,&quot;FileName&quot;:&quot;Screenshot_20201118_085103_sdk.im.qunar.com.qtalksdkdemo.jpg&quot;,&quot;FileSize&quot;:&quot;299.20K&quot;,&quot;HttpUrl&quot;:&quot;file/v2/download/aa0d8dffaebfd44c6cb668cec0ab490f?name\\u003dScreenshot_20201118_085103_sdk.im.qunar.com.qtalksdkdemo.jpg&quot;,&quot;LocalFile&quot;:&quot;/storage/emulated/0/Pictures/Screenshots/Screenshot_20201118_085103_sdk.im.qunar.com.qtalksdkdemo.jpg&quot;,&quot;noMD5&quot;:false}' id='f87dc85d-930b-4609-92b2-0d43a1f4c8b5' msgType='5'>{&quot;FILEID&quot;:&quot;f87dc85d-930b-4609-92b2-0d43a1f4c8b5&quot;,&quot;FILEMD5&quot;:&quot;aa0d8dffaebfd44c6cb668cec0ab490f&quot;,&quot;FileName&quot;:&quot;Screenshot_20201118_085103_sdk.im.qunar.com.qtalksdkdemo.jpg&quot;,&quot;FileSize&quot;:&quot;299.20K&quot;,&quot;HttpUrl&quot;:&quot;file/v2/download/aa0d8dffaebfd44c6cb668cec0ab490f?name\\u003dScreenshot_20201118_085103_sdk.im.qunar.com.qtalksdkdemo.jpg&quot;,&quot;LocalFile&quot;:&quot;/storage/emulated/0/Pictures/Screenshots/Screenshot_20201118_085103_sdk.im.qunar.com.qtalksdkdemo.jpg&quot;,&quot;noMD5&quot;:false}</body></message>	17	1605661133	f87dc85d-930b-4609-92b2-0d43a1f4c8b5	2020-11-18 08:58:52.642399+08
\.


--
-- Data for Name: revoke_msg_history_backup; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.revoke_msg_history_backup (m_from, m_to, m_body, id, m_timestamp, msg_id, create_time) FROM stdin;
\.


--
-- Data for Name: s2s_mapped_host; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.s2s_mapped_host (domain, host, port, priority, weight) FROM stdin;
\.


--
-- Data for Name: scheduling_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scheduling_info (id, scheduling_id, scheduling_name, scheduling_type, scheduling_remarks, scheduling_intr, scheduling_appointment, scheduling_locale, scheduling_locale_id, scheduling_room, scheduling_room_id, schedule_time, scheduling_date, begin_time, end_time, inviter, member, mem_action, remind_flag, action_remark, canceled, update_time) FROM stdin;
1	f81e2a3f62754433bb42238a5a96e203	旅游	2		你好	北京		0		0	2020-11-14 23:49:47+08	2020-11-15	2020-11-15 00:00:00+08	2020-11-15 01:00:00+08	100094z@startalk.tech	100095z@startalk.tech	0	0		f	2020-11-14 23:49:37.957+08
2	f81e2a3f62754433bb42238a5a96e203	旅游	2		你好	北京		0		0	2020-11-14 23:49:47+08	2020-11-15	2020-11-15 00:00:00+08	2020-11-15 01:00:00+08	100094z@startalk.tech	100094z@startalk.tech	0	0		f	2020-11-14 23:49:37.957+08
3	54a3e9c223864d1cb2ba05cc00a01dff	解决	2		解决了	背景		0		0	2020-11-15 18:59:20+08	2020-11-16	2020-11-16 08:00:00+08	2020-11-16 09:00:00+08	100094z@startalk.tech	100095z@startalk.tech	0	2		f	2020-11-15 18:59:20.739+08
4	54a3e9c223864d1cb2ba05cc00a01dff	解决	2		解决了	背景		0		0	2020-11-15 18:59:20+08	2020-11-16	2020-11-16 08:00:00+08	2020-11-16 09:00:00+08	100094z@startalk.tech	100094z@startalk.tech	0	2		f	2020-11-15 18:59:20.739+08
9	30026f0115f2406695d01a156572f9e3	个	2		雨	服服服		0		0	2020-11-18 09:11:54+08	2020-11-20	2020-11-20 08:00:00+08	2020-11-20 09:00:00+08	test01@startalk.tech	100013v@startalk.tech	0	0		f	2020-11-18 09:11:55.766+08
10	30026f0115f2406695d01a156572f9e3	个	2		雨	服服服		0		0	2020-11-18 09:11:54+08	2020-11-20	2020-11-20 08:00:00+08	2020-11-20 09:00:00+08	test01@startalk.tech	test01@startalk.tech	0	0		f	2020-11-18 09:11:55.766+08
11	54ed920c2acf4ec4990842755686061d	个	2		雨	服服服		0		0	2020-11-18 09:11:55+08	2020-11-20	2020-11-20 08:00:00+08	2020-11-20 09:00:00+08	test01@startalk.tech	100013v@startalk.tech	0	0		f	2020-11-18 09:11:56.883+08
12	54ed920c2acf4ec4990842755686061d	个	2		雨	服服服		0		0	2020-11-18 09:11:55+08	2020-11-20	2020-11-20 08:00:00+08	2020-11-20 09:00:00+08	test01@startalk.tech	test01@startalk.tech	0	0		f	2020-11-18 09:11:56.883+08
13	882bd5f8d4ef472886e8b9045bcf90d4	个	2		雨	服服服		0		0	2020-11-18 09:11:56+08	2020-11-20	2020-11-20 08:00:00+08	2020-11-20 09:00:00+08	test01@startalk.tech	100013v@startalk.tech	0	0		f	2020-11-18 09:11:58.124+08
14	882bd5f8d4ef472886e8b9045bcf90d4	个	2		雨	服服服		0		0	2020-11-18 09:11:56+08	2020-11-20	2020-11-20 08:00:00+08	2020-11-20 09:00:00+08	test01@startalk.tech	test01@startalk.tech	0	0		f	2020-11-18 09:11:58.124+08
15	1f133f9d250e446ab8808820c13aabba	个	2		雨	服服服		0		0	2020-11-18 09:11:56+08	2020-11-20	2020-11-20 08:00:00+08	2020-11-20 09:00:00+08	test01@startalk.tech	100013v@startalk.tech	0	0		f	2020-11-18 09:11:58.394+08
16	1f133f9d250e446ab8808820c13aabba	个	2		雨	服服服		0		0	2020-11-18 09:11:56+08	2020-11-20	2020-11-20 08:00:00+08	2020-11-20 09:00:00+08	test01@startalk.tech	test01@startalk.tech	0	0		f	2020-11-18 09:11:58.394+08
17	13b40dd745d0481799fdac2da770f9f7	个	2		雨	服服服		0		0	2020-11-18 09:11:57+08	2020-11-20	2020-11-20 08:00:00+08	2020-11-20 09:00:00+08	test01@startalk.tech	100013v@startalk.tech	0	0		f	2020-11-18 09:11:59.188+08
18	13b40dd745d0481799fdac2da770f9f7	个	2		雨	服服服		0		0	2020-11-18 09:11:57+08	2020-11-20	2020-11-20 08:00:00+08	2020-11-20 09:00:00+08	test01@startalk.tech	test01@startalk.tech	0	0		f	2020-11-18 09:11:59.188+08
19	ecaf82247aec40daa823db186a9700ab	个	2		雨	服服服		0		0	2020-11-18 09:11:57+08	2020-11-20	2020-11-20 08:00:00+08	2020-11-20 09:00:00+08	test01@startalk.tech	100013v@startalk.tech	0	0		f	2020-11-18 09:11:59.351+08
20	ecaf82247aec40daa823db186a9700ab	个	2		雨	服服服		0		0	2020-11-18 09:11:57+08	2020-11-20	2020-11-20 08:00:00+08	2020-11-20 09:00:00+08	test01@startalk.tech	test01@startalk.tech	0	0		f	2020-11-18 09:11:59.351+08
21	fbc273d5a8ef478ab4153f8f60f2541e	个	2		雨	服服服		0		0	2020-11-18 09:11:58+08	2020-11-20	2020-11-20 08:00:00+08	2020-11-20 09:00:00+08	test01@startalk.tech	100013v@startalk.tech	0	0		f	2020-11-18 09:11:59.91+08
22	fbc273d5a8ef478ab4153f8f60f2541e	个	2		雨	服服服		0		0	2020-11-18 09:11:58+08	2020-11-20	2020-11-20 08:00:00+08	2020-11-20 09:00:00+08	test01@startalk.tech	test01@startalk.tech	0	0		f	2020-11-18 09:11:59.91+08
23	692e8957136a4c7085bfa490d7d11548	个	2		雨	服服服		0		0	2020-11-18 09:11:58+08	2020-11-20	2020-11-20 08:00:00+08	2020-11-20 09:00:00+08	test01@startalk.tech	100013v@startalk.tech	0	0		f	2020-11-18 09:12:00.086+08
24	692e8957136a4c7085bfa490d7d11548	个	2		雨	服服服		0		0	2020-11-18 09:11:58+08	2020-11-20	2020-11-20 08:00:00+08	2020-11-20 09:00:00+08	test01@startalk.tech	test01@startalk.tech	0	0		f	2020-11-18 09:12:00.086+08
25	afa7e30b07bb40a8a8754f286e4caed8	个	2		雨	服服服		0		0	2020-11-18 09:11:58+08	2020-11-20	2020-11-20 08:00:00+08	2020-11-20 09:00:00+08	test01@startalk.tech	100013v@startalk.tech	0	0		f	2020-11-18 09:12:00.3+08
26	afa7e30b07bb40a8a8754f286e4caed8	个	2		雨	服服服		0		0	2020-11-18 09:11:58+08	2020-11-20	2020-11-20 08:00:00+08	2020-11-20 09:00:00+08	test01@startalk.tech	test01@startalk.tech	0	0		f	2020-11-18 09:12:00.3+08
27	b83e34deb9b44e6588b06b82cb4039d1	个	2		雨	服服服		0		0	2020-11-18 09:12:04+08	2020-11-20	2020-11-20 08:00:00+08	2020-11-20 09:00:00+08	test01@startalk.tech	100013v@startalk.tech	0	0		f	2020-11-18 09:12:05.773+08
28	b83e34deb9b44e6588b06b82cb4039d1	个	2		雨	服服服		0		0	2020-11-18 09:12:04+08	2020-11-20	2020-11-20 08:00:00+08	2020-11-20 09:00:00+08	test01@startalk.tech	test01@startalk.tech	0	0		f	2020-11-18 09:12:05.773+08
29	f07c1a07dd2044b49dd40cec824fd2e6	个	2		雨	服服服		0		0	2020-11-18 09:12:04+08	2020-11-20	2020-11-20 08:00:00+08	2020-11-20 09:00:00+08	test01@startalk.tech	100013v@startalk.tech	0	0		f	2020-11-18 09:12:05.952+08
30	f07c1a07dd2044b49dd40cec824fd2e6	个	2		雨	服服服		0		0	2020-11-18 09:12:04+08	2020-11-20	2020-11-20 08:00:00+08	2020-11-20 09:00:00+08	test01@startalk.tech	test01@startalk.tech	0	0		f	2020-11-18 09:12:05.952+08
31	05ffe77dbdf944e68e9caeb916ba5b12	个	2		雨	服服服		0		0	2020-11-18 09:12:04+08	2020-11-20	2020-11-20 08:00:00+08	2020-11-20 09:00:00+08	test01@startalk.tech	100013v@startalk.tech	0	0		f	2020-11-18 09:12:06.135+08
32	05ffe77dbdf944e68e9caeb916ba5b12	个	2		雨	服服服		0		0	2020-11-18 09:12:04+08	2020-11-20	2020-11-20 08:00:00+08	2020-11-20 09:00:00+08	test01@startalk.tech	test01@startalk.tech	0	0		f	2020-11-18 09:12:06.135+08
33	08b75ce0abd541cb8e13de77e75899c8	个	2		雨	服服服		0		0	2020-11-18 09:12:04+08	2020-11-20	2020-11-20 08:00:00+08	2020-11-20 09:00:00+08	test01@startalk.tech	100013v@startalk.tech	0	0		f	2020-11-18 09:12:06.452+08
34	08b75ce0abd541cb8e13de77e75899c8	个	2		雨	服服服		0		0	2020-11-18 09:12:04+08	2020-11-20	2020-11-20 08:00:00+08	2020-11-20 09:00:00+08	test01@startalk.tech	test01@startalk.tech	0	0		f	2020-11-18 09:12:06.452+08
35	8a53321e5cb840adb58e463e83ec8eeb	个	2		雨	服服服		0		0	2020-11-18 09:12:06+08	2020-11-20	2020-11-20 08:00:00+08	2020-11-20 09:00:00+08	test01@startalk.tech	100013v@startalk.tech	0	0		f	2020-11-18 09:12:07.994+08
36	8a53321e5cb840adb58e463e83ec8eeb	个	2		雨	服服服		0		0	2020-11-18 09:12:06+08	2020-11-20	2020-11-20 08:00:00+08	2020-11-20 09:00:00+08	test01@startalk.tech	test01@startalk.tech	0	0		f	2020-11-18 09:12:07.994+08
7	0665df6fb50b422c9febfbf16ba58d01	个	2		雨	服服服		0		0	2020-11-18 09:11:52+08	2020-11-20	2020-11-20 08:00:00+08	2020-11-20 09:00:00+08	test01@startalk.tech	100013v@startalk.tech	0	0		t	2020-11-18 09:13:30.533+08
8	0665df6fb50b422c9febfbf16ba58d01	个	2		雨	服服服		0		0	2020-11-18 09:11:52+08	2020-11-20	2020-11-20 08:00:00+08	2020-11-20 09:00:00+08	test01@startalk.tech	test01@startalk.tech	0	0		t	2020-11-18 09:13:30.533+08
5	813a6a07ebe643059fac4c8f1f40aa44	个	2			服服服		0		0	2020-11-18 09:11:49+08	2020-11-20	2020-11-20 08:00:00+08	2020-11-20 09:00:00+08	test01@startalk.tech	100013v@startalk.tech	0	0		t	2020-11-18 09:13:55+08
6	813a6a07ebe643059fac4c8f1f40aa44	个	2			服服服		0		0	2020-11-18 09:11:49+08	2020-11-20	2020-11-20 08:00:00+08	2020-11-20 09:00:00+08	test01@startalk.tech	test01@startalk.tech	0	0		t	2020-11-18 09:13:55+08
\.


--
-- Data for Name: startalk_dep_setting; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.startalk_dep_setting (id, setting_name, settings) FROM stdin;
1	DEFAULT	1
\.


--
-- Data for Name: startalk_dep_table; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.startalk_dep_table (id, dep_name, dep_level, dep_vp, dep_hr, dep_visible, dep_leader, parent_id, delete_flag, dep_desc, create_time, update_time) FROM stdin;
1	/管理员	1	\N	\N	\N	\N	\N	0	\N	2019-10-28 22:18:14.382936	2019-10-28 22:18:14.382936
2	/智能服务助手	1	\N	\N	\N	\N	\N	0	\N	2019-10-28 22:18:14.394035	2019-10-28 22:18:14.394035
34	/zhangchao	1		admin	\N	admin	0	0	\N	2020-10-15 08:28:55.714292	2020-10-15 08:28:55.714292
\.


--
-- Data for Name: startalk_role_class; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.startalk_role_class (id, role_class, available_flag) FROM stdin;
\.


--
-- Data for Name: startalk_user_role_table; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.startalk_user_role_table (id, role_name, available_flag, class_id) FROM stdin;
\.


--
-- Data for Name: statistic_qtalk_click_event; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.statistic_qtalk_click_event (id, client_platform, client_version, client_brand, client_model, click_event, click_day, click_cnt, del_flag, create_time) FROM stdin;
\.


--
-- Data for Name: sys_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_permission (id, url, describe, create_time, update_time, status, sub_permission_ids, navigation_flag) FROM stdin;
1	/qtalk_background_management/startalk/management/addUser/user		2019-05-15 09:56:18.263012+08	2019-05-15 09:56:18.263012+08	1	\N	0
2	/qtalk_background_management/startalk/management/download/template		2019-05-15 09:56:18.308918+08	2019-05-15 09:56:18.308918+08	1	\N	0
3	/qtalk_background_management/startalk/management/update/user		2019-05-15 09:57:07.807083+08	2019-05-15 09:57:07.807083+08	1	\N	0
4	/qtalk_background_management/startalk/management/delete/user		2019-05-15 09:57:07.835557+08	2019-05-15 09:57:07.835557+08	1	\N	0
5	/qtalk_background_management/startalk/management/getuserDetail		2019-05-15 09:57:08.712239+08	2019-05-15 09:57:08.712239+08	1	\N	0
6	/qtalk_background_management/startalk/management/organ/addDep		2019-05-15 09:57:08.140355+08	2019-05-15 09:57:08.140355+08	1	\N	0
7	/qtalk_background_management/startalk/management/organ/deleteDep		2019-05-15 09:57:08.169407+08	2019-05-15 09:57:08.169407+08	1	\N	0
8	/qtalk_background_management/startalk/management/organ/addRoleClass		2019-05-15 09:57:08.226841+08	2019-05-15 09:57:08.226841+08	1	\N	0
9	/qtalk_background_management/startalk/management/organ/addRole		2019-05-15 09:57:08.25226+08	2019-05-15 09:57:08.25226+08	1	\N	0
10	/qtalk_background_management/startalk/management/organ/updateRole		2019-05-15 09:57:08.28482+08	2019-05-15 09:57:08.28482+08	1	\N	0
11	/qtalk_background_management/startalk/management/organ/deleteRole		2019-05-15 09:57:08.316238+08	2019-05-15 09:57:08.316238+08	1	\N	0
12	/qtalk_background_management/startalk/management/organ/getRoleClass		2019-05-15 09:57:08.359823+08	2019-05-15 09:57:08.359823+08	1	\N	0
13	/qtalk_background_management/startalk/management/searchUser	用户搜索	2019-05-17 07:11:11.408295+08	2019-05-17 07:11:11.408295+08	1	\N	0
14	/qtalk_background_management/startalk/management/unbindRole	解绑用户	2019-05-17 07:11:11.408295+08	2019-05-17 07:11:11.408295+08	1	\N	0
15	/qtalk_background_management/startalk/management/bindRole	绑定用户	2019-05-17 07:11:11.408295+08	2019-05-17 07:11:11.408295+08	1	\N	0
16	/qtalk_background_management/startalk/management/findAllRoles	所有角色	2019-05-17 07:11:11.408295+08	2019-05-17 07:11:11.408295+08	1	{18,19,20,21,22}	1
17	/qtalk_background_management/startalk/management/queryUserList	用户列表	2019-05-17 07:11:11.408295+08	2019-05-17 07:11:11.408295+08	1	{13,14,15,16}	1
18	/qtalk_background_management/startalk/management/findAllPermissions	所有权限	2019-05-17 07:11:11.408295+08	2019-05-17 07:11:11.408295+08	1	\N	0
19	/qtalk_background_management/startalk/management/findPermissionByRoleId	角色查找权限	2019-05-17 07:11:11.408295+08	2019-05-17 07:11:11.408295+08	1	\N	0
20	/qtalk_background_management/startalk/management/updateRolePermissions	更新权限	2019-05-17 07:11:11.408295+08	2019-05-17 07:11:11.408295+08	1	\N	0
21	/qtalk_background_management/startalk/management/deleteRole	删除角色	2019-05-17 07:11:11.408295+08	2019-05-17 07:11:11.408295+08	1	\N	0
22	/qtalk_background_management/startalk/management/addNewRole	添加角色	2019-05-17 07:11:11.408295+08	2019-05-17 07:11:11.408295+08	1	\N	0
23	/qtalk_background_management/startalk/management/organ/getStructure		2019-05-15 09:57:08.078643+08	2019-05-15 09:57:08.078643+08	1	{6,7}	1
24	/qtalk_background_management/startalk/management/organ/getAllRole		2019-05-15 09:57:08.50187+08	2019-05-15 09:57:08.50187+08	1	{8,9,10,11,12}	1
25	/qtalk_background_management/startalk/management/search		2019-05-15 09:57:08.662159+08	2019-05-15 09:57:08.662159+08	1	{1,2,3,4,5}	1
26	/qtalk_background_management/startalk/management/find/add/application		2019-05-15 09:56:18.263012+08	2019-05-15 09:56:18.263012+08	1	\N	0
27	/qtalk_background_management/startalk/management/find/get/group		2019-05-15 09:56:18.263012+08	2019-05-15 09:56:18.263012+08	1	\N	0
28	/qtalk_background_management/startalk/management/find/update/app		2019-05-15 09:56:18.263012+08	2019-05-15 09:56:18.263012+08	1	\N	0
29	/qtalk_background_management/startalk/management/find/action/app		2019-05-15 09:56:18.263012+08	2019-05-15 09:56:18.263012+08	1	\N	0
30	/qtalk_background_management/startalk/management/find/add/group		2019-05-15 09:56:18.263012+08	2019-05-15 09:56:18.263012+08	1	\N	0
31	/qtalk_background_management/startalk/management/file/upload		2019-05-15 09:56:18.263012+08	2019-05-15 09:56:18.263012+08	1	\N	0
32	/qtalk_background_management/startalk/management/find/management		2019-05-15 09:57:08.662159+08	2019-05-15 09:57:08.662159+08	1	{26,27,28,29,30,31}	1
33	/qtalk_background_management/startalk/management/baseData	test	2019-10-28 22:18:14.523409+08	2019-10-28 22:18:14.523409+08	1	{35}	1
34	/qtalk_background_management/startalk/management/depList	test	2019-10-28 22:18:14.526599+08	2019-10-28 22:18:14.526599+08	1	{}	0
35	/qtalk_background_management/startalk/management/dayDataSearch	test	2019-10-28 22:18:14.529868+08	2019-10-28 22:18:14.529868+08	1	{}	0
36	/qtalk_background_management/startalk/management/dayMsgDataSearch	test	2019-10-28 22:18:14.533204+08	2019-10-28 22:18:14.533204+08	1	{34,37}	1
37	/qtalk_background_management/startalk/management/userMsgCount	test	2019-10-28 22:18:14.53687+08	2019-10-28 22:18:14.53687+08	1	{}	0
38	/qtalk_background_management/startalk/management/clientVersion	test	2019-10-28 22:18:14.540715+08	2019-10-28 22:18:14.540715+08	1	{}	1
39	/qtalk_background_management/startalk/management/getVersionList	test	2019-10-28 22:18:14.544291+08	2019-10-28 22:18:14.544291+08	1	{}	0
40	/qtalk_background_management/startalk/management/clickCount	test	2019-10-28 22:18:14.547908+08	2019-10-28 22:18:14.547908+08	1	{41,42}	1
41	/qtalk_background_management/startalk/management/selectList	test	2019-10-28 22:18:14.551825+08	2019-10-28 22:18:14.551825+08	1	{}	0
42	/qtalk_background_management/startalk/management/selectModel	test	2019-10-28 22:18:14.555514+08	2019-10-28 22:18:14.555514+08	1	{}	0
43	/qtalk_background_management/startalk/management/activity	test	2019-10-28 22:18:14.559427+08	2019-10-28 22:18:14.559427+08	1	{}	1
44	/qtalk_background_management/startalk/management/userOnline	test	2019-10-28 22:18:14.5631+08	2019-10-28 22:18:14.5631+08	1	{45}	1
45	/qtalk_background_management/startalk/management/searchUserOnline	test	2019-10-28 22:18:14.566742+08	2019-10-28 22:18:14.566742+08	1	{}	0
47	/qtalk_background_management/startalk/management/organ/getVisibleDeps		2019-05-15 09:57:08.662159+08	2019-05-15 09:57:08.662159+08	1	{}	1
48	/qtalk_background_management/startalk/management/find/check_update		2019-05-15 09:57:08.662159+08	2019-05-15 09:57:08.662159+08	1	{}	1
\.


--
-- Data for Name: sys_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_role (id, describe, create_time, update_time, role_name) FROM stdin;
1	所有权限	2019-05-15 03:25:07.078138+08	2019-05-15 03:25:07.078138+08	超级管理员
\.


--
-- Data for Name: sys_role_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_role_permission (id, role_id, permission_id) FROM stdin;
1	1	1
2	1	2
3	1	3
4	1	4
5	1	5
6	1	6
7	1	7
8	1	8
9	1	9
10	1	10
11	1	11
12	1	12
13	1	13
14	1	14
15	1	15
16	1	16
17	1	17
18	1	18
19	1	19
20	1	20
21	1	21
22	1	22
23	1	23
24	1	24
25	1	25
26	1	26
27	1	27
28	1	28
29	1	29
30	1	30
31	1	31
32	1	32
33	1	33
34	1	34
35	1	35
36	1	36
37	1	37
38	1	38
39	1	39
40	1	40
41	1	41
42	1	42
43	1	43
44	1	44
45	1	45
46	1	33
47	1	34
48	1	35
49	1	36
50	1	37
51	1	38
52	1	39
53	1	40
54	1	41
55	1	42
56	1	43
57	1	44
58	1	45
59	1	47
60	1	48
\.


--
-- Data for Name: sys_user_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_user_role (id, role_id, user_id) FROM stdin;
1	1	admin
\.


--
-- Data for Name: t_client_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_client_log (id, u_id, u_domain, d_os, d_brand, d_model, d_plat, d_ip, d_lat, d_lgt, l_type, l_sub_type, l_report_time, l_data, l_device_data, l_user_data, l_version_code, l_version_name, create_time, l_client_event, d_platform, l_event_id, l_current_page) FROM stdin;
\.


--
-- Data for Name: t_dict_client_brand; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_dict_client_brand (id, brand, platform, del_flag, create_time) FROM stdin;
\.


--
-- Data for Name: t_dict_client_event; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_dict_client_event (id, event, del_flag, create_time, platform) FROM stdin;
\.


--
-- Data for Name: t_dict_client_model; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_dict_client_model (id, client_model, client_brand, platform, del_flag, create_time) FROM stdin;
\.


--
-- Data for Name: t_dict_client_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_dict_client_version (id, client_version, platform, del_flag, create_time) FROM stdin;
\.


--
-- Data for Name: user_friends; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_friends (username, friend, relationship, version, host, userhost) FROM stdin;
100094z	100095z	1	1	startalk.tech	startalk.tech
100095z	100094z	1	1	startalk.tech	startalk.tech
100094z	100004q	1	1	startalk.tech	startalk.tech
100004q	100094z	1	1	startalk.tech	startalk.tech
admin	100004q	1	1	startalk.tech	startalk.tech
100004q	admin	1	1	startalk.tech	startalk.tech
\.


--
-- Data for Name: user_register_mucs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_register_mucs (username, muc_name, domain, created_at, registed_flag, host) FROM stdin;
admin	eacfa594c3374240a8370990febb980a	conference.startalk.tech	2020-10-15 15:33:25.686+08	1	startalk.tech
100094z	46823ed77669448eaea51c1f9f130d70	conference.startalk.tech	2020-10-26 00:23:45.831+08	1	startalk.tech
100096z	13a476002524475898657c196fe66197	conference.startalk.tech	2020-10-26 00:28:56.242+08	1	startalk.tech
100094z	e6f21f761ddd4a7f8eb6570adc7cbf9e	conference.startalk.tech	2020-10-29 16:28:18.624+08	1	startalk.tech
chao.zhang5	e6f21f761ddd4a7f8eb6570adc7cbf9e	conference.startalk.tech	2020-10-29 16:28:18.82+08	1	startalk.tech
100095z	e6f21f761ddd4a7f8eb6570adc7cbf9e	conference.startalk.tech	2020-10-29 16:28:18.824+08	1	startalk.tech
100094z	6087afffae43438a88f6a7a46e969404	conference.startalk.tech	2020-10-29 16:31:49.148+08	0	startalk.tech
100094z	b235887358a34bba8f81c269d5d5658e	conference.startalk.tech	2020-10-29 16:32:09.505+08	1	startalk.tech
chao.zhang5	b235887358a34bba8f81c269d5d5658e	conference.startalk.tech	2020-10-29 16:32:09.789+08	1	startalk.tech
100096z	b235887358a34bba8f81c269d5d5658e	conference.startalk.tech	2020-10-29 16:32:09.793+08	1	startalk.tech
100094z	e68a47f141ad43df8d72bd00ae78b133	conference.startalk.tech	2020-10-29 17:34:03.808+08	1	startalk.tech
chao.zhang5	e68a47f141ad43df8d72bd00ae78b133	conference.startalk.tech	2020-10-29 17:34:03.956+08	1	startalk.tech
100096z	838c7c32d28e4747be9a61043ead3e08	conference.startalk.tech	2020-10-29 20:01:49.128+08	1	startalk.tech
100094z	9022c32aa1cd439fb9cbda23c45da981	conference.startalk.tech	2020-10-30 00:30:33.215+08	1	startalk.tech
100095z	7a720787654245529bccba67426a0366	conference.startalk.tech	2020-10-30 00:33:03.86+08	1	startalk.tech
100004q	42b028bd797443fb8230a73b1caf0931	conference.startalk.tech	2020-10-30 00:57:07.207+08	1	startalk.tech
100094z	3389f6c1bb4042a2ab0c339dec3c16a9	conference.startalk.tech	2020-10-30 20:53:24.426+08	1	startalk.tech
chao.zhang5	3389f6c1bb4042a2ab0c339dec3c16a9	conference.startalk.tech	2020-10-30 20:53:24.598+08	1	startalk.tech
100094z	b0b5ebc6f7f240a1a92b26a1f313d03a	conference.startalk.tech	2020-10-30 20:59:51.468+08	1	startalk.tech
chao.zhang5	b0b5ebc6f7f240a1a92b26a1f313d03a	conference.startalk.tech	2020-10-30 20:59:51.613+08	1	startalk.tech
100095z	b0b5ebc6f7f240a1a92b26a1f313d03a	conference.startalk.tech	2020-10-30 21:00:00.452+08	1	startalk.tech
100094z	95047e5e04014cd2b2ec4b16c85f744c	conference.startalk.tech	2020-10-30 21:00:59.232+08	1	startalk.tech
chao.zhang5	95047e5e04014cd2b2ec4b16c85f744c	conference.startalk.tech	2020-10-30 21:00:59.377+08	1	startalk.tech
100095z	95047e5e04014cd2b2ec4b16c85f744c	conference.startalk.tech	2020-10-30 21:01:07.968+08	1	startalk.tech
100096z	b0b5ebc6f7f240a1a92b26a1f313d03a	conference.startalk.tech	2020-10-31 12:36:39.72+08	1	startalk.tech
100094z	eb32de0dc28c40b0824b72af7873dfa5	conference.startalk.tech	2020-10-31 14:57:34.836+08	1	startalk.tech
100094z	3c1b6a39035c442a8f59e5704bba096a	conference.startalk.tech	2020-10-31 15:01:31.959+08	1	startalk.tech
100096z	95047e5e04014cd2b2ec4b16c85f744c	conference.startalk.tech	2020-10-31 15:34:05.143+08	1	startalk.tech
100095z	18dd0d10d591479c858a92be057c694e	conference.startalk.tech	2020-10-31 22:58:03.809+08	1	startalk.tech
100095z	e299435983c34c3885d329e59a7561ca	conference.startalk.tech	2020-10-31 23:00:53.988+08	1	startalk.tech
100095z	55a59d75b08a4f77b76f75eb68cd3e15	conference.startalk.tech	2020-10-31 23:17:25.198+08	1	startalk.tech
100094z	55a59d75b08a4f77b76f75eb68cd3e15	conference.startalk.tech	2020-10-31 23:17:26.38+08	1	startalk.tech
100096z	b10f8a925460494a96ffb7ef58002ffa	conference.startalk.tech	2020-11-02 15:02:47.99+08	1	startalk.tech
100094z	b10f8a925460494a96ffb7ef58002ffa	conference.startalk.tech	2020-11-02 15:02:48.571+08	1	startalk.tech
100096z	677930584d7145b6bd20b79f4bae7352	conference.startalk.tech	2020-11-02 15:04:00.101+08	1	startalk.tech
100095z	677930584d7145b6bd20b79f4bae7352	conference.startalk.tech	2020-11-02 15:04:00.702+08	1	startalk.tech
100096z	56be69ae06e5475b9e85295de0ae4dd7	conference.startalk.tech	2020-11-02 15:05:29.548+08	1	startalk.tech
100096z	d62701c245234248aaa069f2e63e2474	conference.startalk.tech	2020-11-02 16:06:22.439+08	1	startalk.tech
100094z	d62701c245234248aaa069f2e63e2474	conference.startalk.tech	2020-11-02 16:06:23.047+08	1	startalk.tech
100095z	d62701c245234248aaa069f2e63e2474	conference.startalk.tech	2020-11-02 16:06:37.316+08	1	startalk.tech
100096z	64598a656b384af4b458473b72dceb26	conference.startalk.tech	2020-11-02 16:07:17.975+08	1	startalk.tech
100095z	64598a656b384af4b458473b72dceb26	conference.startalk.tech	2020-11-02 16:07:18.614+08	1	startalk.tech
100096z	0229eb47b1154771866863ddab7c96b6	conference.startalk.tech	2020-11-02 17:16:02.014+08	1	startalk.tech
100094z	0229eb47b1154771866863ddab7c96b6	conference.startalk.tech	2020-11-02 17:16:03.223+08	1	startalk.tech
100095z	0229eb47b1154771866863ddab7c96b6	conference.startalk.tech	2020-11-02 17:16:03.227+08	1	startalk.tech
100094z	abd227dec13a48bbbf4de1b44605bbcb	conference.startalk.tech	2020-11-02 17:21:13.637+08	1	startalk.tech
chao.zhang5	abd227dec13a48bbbf4de1b44605bbcb	conference.startalk.tech	2020-11-02 17:21:13.845+08	1	startalk.tech
100094z	ead71a2044ea4007b275e4c1dd6326ae	conference.startalk.tech	2020-11-02 17:34:45.497+08	1	startalk.tech
100094z	b53827521885446b9b53cd68c885f878	conference.startalk.tech	2020-11-02 17:39:24.88+08	1	startalk.tech
100095z	42b028bd797443fb8230a73b1caf0931	conference.startalk.tech	2020-11-02 17:43:53.435+08	1	startalk.tech
100096z	575b0da2c0e44f5aade67f4bcd161e8f	conference.startalk.tech	2020-11-02 17:51:44.124+08	1	startalk.tech
100094z	08385b97f4954b4ba55fab2277f26436	conference.startalk.tech	2020-11-02 17:52:40.045+08	1	startalk.tech
100094z	b58cb19af6c04a71af24417aef49cf0b	conference.startalk.tech	2020-11-02 17:55:07.469+08	1	startalk.tech
chao.zhang5	b58cb19af6c04a71af24417aef49cf0b	conference.startalk.tech	2020-11-02 17:55:08.096+08	1	startalk.tech
100096z	03bf3595212f4c098fc3b4967af8467d	conference.startalk.tech	2020-11-02 17:55:30.942+08	1	startalk.tech
100094z	b2c2ec63c86e469e9d9199b8f224dde6	conference.startalk.tech	2020-11-02 17:55:58.373+08	1	startalk.tech
100096z	b2c2ec63c86e469e9d9199b8f224dde6	conference.startalk.tech	2020-11-02 17:55:59.013+08	1	startalk.tech
chao.zhang5	b2c2ec63c86e469e9d9199b8f224dde6	conference.startalk.tech	2020-11-02 17:55:59.018+08	1	startalk.tech
100004q	b2c2ec63c86e469e9d9199b8f224dde6	conference.startalk.tech	2020-11-02 17:56:05.399+08	1	startalk.tech
mumu	408fcdfe35454d37ab20f02606ef0695	conference.startalk.tech	2020-11-02 17:57:42.68+08	1	startalk.tech
100004q	ba2a497adbbe44c7b67f2dd81e53e8f9	conference.startalk.tech	2020-11-02 18:01:36.23+08	1	startalk.tech
100095z	ba2a497adbbe44c7b67f2dd81e53e8f9	conference.startalk.tech	2020-11-02 18:01:36.635+08	1	startalk.tech
mumu	ba2a497adbbe44c7b67f2dd81e53e8f9	conference.startalk.tech	2020-11-02 18:01:36.638+08	1	startalk.tech
100094z	ba2a497adbbe44c7b67f2dd81e53e8f9	conference.startalk.tech	2020-11-02 18:02:49.471+08	1	startalk.tech
100004q	b9f791d73c5045b7bad8f0c1235d22f4	conference.startalk.tech	2020-11-02 18:02:53.571+08	1	startalk.tech
100094z	42b028bd797443fb8230a73b1caf0931	conference.startalk.tech	2020-11-03 09:49:11.541+08	1	startalk.tech
100096z	42b028bd797443fb8230a73b1caf0931	conference.startalk.tech	2020-11-03 09:49:11.545+08	1	startalk.tech
100095z	da499de5f90e42a789b91e75a75d075c	conference.startalk.tech	2020-11-03 11:00:03.414+08	1	startalk.tech
100095z	a6c0d98b4c9045e88a88098b5424c812	conference.startalk.tech	2020-11-03 11:21:16.795+08	1	startalk.tech
100094z	a6c0d98b4c9045e88a88098b5424c812	conference.startalk.tech	2020-11-03 11:21:17.151+08	1	startalk.tech
100096z	a6c0d98b4c9045e88a88098b5424c812	conference.startalk.tech	2020-11-03 11:21:17.157+08	1	startalk.tech
100095z	99f601bbbefd40de92e681fbe8d02048	conference.startalk.tech	2020-11-03 11:23:31.964+08	1	startalk.tech
100096z	99f601bbbefd40de92e681fbe8d02048	conference.startalk.tech	2020-11-03 11:23:32.419+08	1	startalk.tech
100095z	53e4ccf7cd6049788f427737d03f2534	conference.startalk.tech	2020-11-03 11:23:57.91+08	1	startalk.tech
100096z	53e4ccf7cd6049788f427737d03f2534	conference.startalk.tech	2020-11-03 11:23:58.409+08	1	startalk.tech
chao.zhang5	53e4ccf7cd6049788f427737d03f2534	conference.startalk.tech	2020-11-03 11:24:19.4+08	1	startalk.tech
100095z	2ce913d30df441cf8fb82d3d42bf105b	conference.startalk.tech	2020-11-03 11:25:01.938+08	1	startalk.tech
100095z	221d33e20e17449db36173cdd39e76ff	conference.startalk.tech	2020-11-06 19:30:32.35+08	1	startalk.tech
100094z	221d33e20e17449db36173cdd39e76ff	conference.startalk.tech	2020-11-06 19:30:32.741+08	1	startalk.tech
100096z	221d33e20e17449db36173cdd39e76ff	conference.startalk.tech	2020-11-06 19:30:39.803+08	1	startalk.tech
100095z	5cde4d34a44544b9a58c7a592a851756	conference.startalk.tech	2020-11-06 19:32:03.94+08	1	startalk.tech
100096z	5cde4d34a44544b9a58c7a592a851756	conference.startalk.tech	2020-11-06 19:32:04.313+08	1	startalk.tech
潮涨	5cde4d34a44544b9a58c7a592a851756	conference.startalk.tech	2020-11-06 19:32:04.317+08	1	startalk.tech
100095z	ba9fa0065e1c49e38415ac184ba3a3a8	conference.startalk.tech	2020-11-06 19:32:27.303+08	1	startalk.tech
100096z	ba9fa0065e1c49e38415ac184ba3a3a8	conference.startalk.tech	2020-11-06 19:32:27.759+08	1	startalk.tech
潮涨	ba9fa0065e1c49e38415ac184ba3a3a8	conference.startalk.tech	2020-11-06 19:32:27.763+08	1	startalk.tech
100004q	3b9ff47191c143e9991452fa02affa23	conference.startalk.tech	2020-11-08 17:56:58.085+08	1	startalk.tech
100095z	17a73d186c034b1ea71bfc3dd3108ee0	conference.startalk.tech	2020-11-10 08:04:52.034+08	1	startalk.tech
100094z	17a73d186c034b1ea71bfc3dd3108ee0	conference.startalk.tech	2020-11-10 08:04:52.407+08	1	startalk.tech
100094z	6737bb1bb2af443086d57e81d71eeb94	conference.startalk.tech	2020-11-10 08:58:54.069+08	1	startalk.tech
mumu	6737bb1bb2af443086d57e81d71eeb94	conference.startalk.tech	2020-11-10 08:58:54.255+08	1	startalk.tech
100095z	6737bb1bb2af443086d57e81d71eeb94	conference.startalk.tech	2020-11-10 08:58:54.259+08	1	startalk.tech
mumu	17a73d186c034b1ea71bfc3dd3108ee0	conference.startalk.tech	2020-11-10 09:24:07.952+08	1	startalk.tech
100095z	9afcd37223a842d6b39f29ec13e2d678	conference.startalk.tech	2020-11-10 09:24:33.921+08	1	startalk.tech
100094z	9afcd37223a842d6b39f29ec13e2d678	conference.startalk.tech	2020-11-10 09:24:34.953+08	1	startalk.tech
mumu	83d2403acedf4b39877f592244043dee	conference.startalk.tech	2020-11-10 09:29:20.371+08	1	startalk.tech
100096z	83d2403acedf4b39877f592244043dee	conference.startalk.tech	2020-11-10 10:01:30.636+08	0	startalk.tech
100094z	6dec5e56b25741a9ba0ad2e04766d8d4	conference.startalk.tech	2020-11-10 10:02:18.308+08	0	startalk.tech
100095z	6dec5e56b25741a9ba0ad2e04766d8d4	conference.startalk.tech	2020-11-10 10:02:18.308+08	0	startalk.tech
100096z	6dec5e56b25741a9ba0ad2e04766d8d4	conference.startalk.tech	2020-11-10 10:02:18.308+08	0	startalk.tech
chao.zhang5	3b9ff47191c143e9991452fa02affa23	conference.startalk.tech	2020-11-13 02:25:11.706+08	0	startalk.tech
100095z	3b9ff47191c143e9991452fa02affa23	conference.startalk.tech	2020-11-13 02:25:15.392+08	0	startalk.tech
mumu	b0fd2895a3a447b2ba9aa3768c4b52ec	conference.startalk.tech	2020-11-14 23:13:51.3+08	0	startalk.tech
100095z	b0fd2895a3a447b2ba9aa3768c4b52ec	conference.startalk.tech	2020-11-14 23:13:51.3+08	0	startalk.tech
100096z	b0fd2895a3a447b2ba9aa3768c4b52ec	conference.startalk.tech	2020-11-14 23:13:51.3+08	0	startalk.tech
100094z	b0fd2895a3a447b2ba9aa3768c4b52ec	conference.startalk.tech	2020-11-14 23:13:51.3+08	0	startalk.tech
100094z	83d2403acedf4b39877f592244043dee	conference.startalk.tech	2020-11-14 23:19:00.58+08	1	startalk.tech
100095z	83d2403acedf4b39877f592244043dee	conference.startalk.tech	2020-11-14 23:19:00.586+08	1	startalk.tech
100094z	cb8c771fd29a4f4f96a2de73a012c4a5	conference.startalk.tech	2020-11-14 23:39:12.41+08	0	startalk.tech
100095z	cb8c771fd29a4f4f96a2de73a012c4a5	conference.startalk.tech	2020-11-14 23:39:12.41+08	0	startalk.tech
mumu	cb8c771fd29a4f4f96a2de73a012c4a5	conference.startalk.tech	2020-11-14 23:39:12.41+08	0	startalk.tech
100095z	7f8cf571ceb74bd2a27a33f985386362	conference.startalk.tech	2020-11-14 23:39:50.085+08	1	startalk.tech
100095z	5e0faeaa8741489ab5b9f6131667fe80	conference.startalk.tech	2020-11-14 23:40:40.658+08	1	startalk.tech
100094z	b9a915b72ff94cf8a71823c05cd12528	conference.startalk.tech	2020-11-14 23:40:48.025+08	0	startalk.tech
100094z	7f8cf571ceb74bd2a27a33f985386362	conference.startalk.tech	2020-11-14 23:40:53.879+08	0	startalk.tech
100094z	5e0faeaa8741489ab5b9f6131667fe80	conference.startalk.tech	2020-11-14 23:40:58.32+08	0	startalk.tech
100094z	38cfb6912f814b77bb7bb2d6bbfd3245	conference.startalk.tech	2020-11-14 23:41:17.173+08	1	startalk.tech
mumu	38cfb6912f814b77bb7bb2d6bbfd3245	conference.startalk.tech	2020-11-14 23:41:35.875+08	1	startalk.tech
100095z	38cfb6912f814b77bb7bb2d6bbfd3245	conference.startalk.tech	2020-11-14 23:45:05.644+08	1	startalk.tech
mumu	3c23e31805af4ba0bc6a7fc71639cf21	conference.startalk.tech	2020-11-14 23:45:25.919+08	1	startalk.tech
100094z	ba9fa0065e1c49e38415ac184ba3a3a8	conference.startalk.tech	2020-11-14 23:47:08.345+08	0	startalk.tech
100095z	3c23e31805af4ba0bc6a7fc71639cf21	conference.startalk.tech	2020-11-14 23:45:26.638+08	1	startalk.tech
100094z	3c23e31805af4ba0bc6a7fc71639cf21	conference.startalk.tech	2020-11-14 23:45:33.187+08	0	startalk.tech
100095z	96a85e39bcc647c4b60831060dc0f94c	conference.startalk.tech	2020-11-15 18:53:51.14+08	0	startalk.tech
mumu	96a85e39bcc647c4b60831060dc0f94c	conference.startalk.tech	2020-11-15 18:53:51.14+08	0	startalk.tech
100094z	96a85e39bcc647c4b60831060dc0f94c	conference.startalk.tech	2020-11-15 18:53:51.14+08	0	startalk.tech
100094z	c395017fb9434bafbeb86a69b8b3a46d	conference.startalk.tech	2020-11-15 19:17:38.679+08	1	startalk.tech
100095z	c395017fb9434bafbeb86a69b8b3a46d	conference.startalk.tech	2020-11-15 19:17:38.73+08	1	startalk.tech
mumu	c395017fb9434bafbeb86a69b8b3a46d	conference.startalk.tech	2020-11-15 19:17:38.734+08	1	startalk.tech
test01	d1aa13f85c4b41768b25027ff007c81a	conference.startalk.tech	2020-11-18 09:04:45.616+08	0	startalk.tech
test02	d1aa13f85c4b41768b25027ff007c81a	conference.startalk.tech	2020-11-18 09:04:45.616+08	0	startalk.tech
100013v	d1aa13f85c4b41768b25027ff007c81a	conference.startalk.tech	2020-11-18 09:04:45.616+08	0	startalk.tech
\.


--
-- Data for Name: user_register_mucs_backup; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_register_mucs_backup (username, muc_name, domain, created_at, registed_flag) FROM stdin;
\.


--
-- Data for Name: user_relation_opts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_relation_opts (username, rec_msg_opt, vld_friend_opt, validate_quetion, validate_answer, vesion, userhost) FROM stdin;
\.


--
-- Data for Name: vcard_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vcard_version (username, version, url, uin, id, profile_version, mood, gender, host) FROM stdin;
admin	1	/file/v2/download/214b6c4f070cf08a1ed27dbd73fdee5d.png	\N	1	1	\N	1	startalk.tech
file-transfer	1	/file/v2/download/214b6c4f070cf08a1ed27dbd73fdee5d.png	\N	2	1	\N	1	startalk.tech
chao.zhang5	1	/file/v2/download/214b6c4f070cf08a1ed27dbd73fdee5d.png	\N	34	1	\N	1	1
100004q	1	/file/v2/download/214b6c4f070cf08a1ed27dbd73fdee5d.png	\N	35	1	\N	1	1
100094z	1	/file/v2/download/214b6c4f070cf08a1ed27dbd73fdee5d.png	\N	36	1	\N	2	1
100095z	1	/file/v2/download/214b6c4f070cf08a1ed27dbd73fdee5d.png	\N	37	1	\N	1	1
100096z	1	/file/v2/download/214b6c4f070cf08a1ed27dbd73fdee5d.png	\N	38	1	\N	1	1
mumu	1	/file/v2/download/214b6c4f070cf08a1ed27dbd73fdee5d.png	\N	39	1	\N	1	1
100013v	1	/file/v2/download/214b6c4f070cf08a1ed27dbd73fdee5d.png	\N	40	1	\N	2	1
mumu	4	https://im.startalk.tech:8443/file/v2/download/8321e70ecb0c29607da6a7e2d75b5004.jpg?name=8321e70ecb0c29607da6a7e2d75b5004.jpg	\N	43	4	 很好	0	startalk.tech
100095z	2	https://im.startalk.tech:8443/file/v2/download/98c31df0915b1357efb2c167a178e728.jpg?name=98c31df0915b1357efb2c167a178e728.jpg	\N	42	2	哦哦哦	0	startalk.tech
100094z	3	file/v2/download/f31906533d12335c362442d117b4ffd0.jpg?name=f31906533d12335c362442d117b4ffd0.jpg	\N	41	3	信心啦啦积极	0	startalk.tech
test01	1	/file/v2/download/214b6c4f070cf08a1ed27dbd73fdee5d.png	\N	44	1	\N	1	1
test02	1	/file/v2/download/214b6c4f070cf08a1ed27dbd73fdee5d.png	\N	45	1	\N	1	1
test03	1	/file/v2/download/214b6c4f070cf08a1ed27dbd73fdee5d.png	\N	46	1	\N	1	1
test04	1	/file/v2/download/214b6c4f070cf08a1ed27dbd73fdee5d.png	\N	47	1	\N	1	1
test05	1	/file/v2/download/214b6c4f070cf08a1ed27dbd73fdee5d.png	\N	48	1	\N	1	1
test06	1	/file/v2/download/214b6c4f070cf08a1ed27dbd73fdee5d.png	\N	49	1	\N	1	1
test07	1	/file/v2/download/214b6c4f070cf08a1ed27dbd73fdee5d.png	\N	50	1	\N	1	1
test01	2	file/v2/download/7a3905b4779510a946723a3195bf1972.jpg?name=7a3905b4779510a946723a3195bf1972.jpg	\N	51	2	测试	0	startalk.tech
\.


--
-- Data for Name: vpn_account_list; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vpn_account_list (id, username, pin_code, password, is_enabled, create_timestamp, expire_timestamp) FROM stdin;
\.


--
-- Data for Name: warn_msg_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.warn_msg_history (id, m_from, m_to, read_flag, msg_id, from_host, to_host, m_body, create_time) FROM stdin;
\.


--
-- Data for Name: warn_msg_history_backup; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.warn_msg_history_backup (id, m_from, m_to, read_flag, msg_id, from_host, to_host, m_body, create_time) FROM stdin;
\.


--
-- Data for Name: white_list; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.white_list (username, created_at, single_flag) FROM stdin;
\.


--
-- Name: client_config_sync_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.client_config_sync_id_seq', 64, true);


--
-- Name: client_upgrade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.client_upgrade_id_seq', 1, false);


--
-- Name: data_board_day_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.data_board_day_id_seq', 1, false);


--
-- Name: destroy_muc_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.destroy_muc_info_id_seq', 7, true);


--
-- Name: find_application_table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.find_application_table_id_seq', 1, false);


--
-- Name: find_class_table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.find_class_table_id_seq', 1, false);


--
-- Name: flogin_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.flogin_user_id_seq', 1, false);


--
-- Name: fresh_empl_entering_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fresh_empl_entering_id_seq', 1, false);


--
-- Name: host_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.host_info_id_seq', 33, true);


--
-- Name: host_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.host_users_id_seq', 47, true);


--
-- Name: login_data_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.login_data_id_seq', 330, true);


--
-- Name: meeting_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.meeting_info_id_seq', 1, false);


--
-- Name: msg_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.msg_history_id_seq', 334, true);


--
-- Name: muc_room_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.muc_room_history_id_seq', 327, true);


--
-- Name: muc_room_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.muc_room_users_id_seq', 1542794, true);


--
-- Name: muc_user_mark_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.muc_user_mark_id_seq', 18, true);


--
-- Name: notice_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notice_history_id_seq', 1, false);


--
-- Name: privacy_list_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.privacy_list_id_seq', 1, false);


--
-- Name: pubsub_node_nodeid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pubsub_node_nodeid_seq', 1, false);


--
-- Name: pubsub_state_stateid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pubsub_state_stateid_seq', 1, false);


--
-- Name: push_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.push_info_id_seq', 7, true);


--
-- Name: qcloud_main_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.qcloud_main_history_id_seq', 1, false);


--
-- Name: qcloud_main_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.qcloud_main_id_seq', 1, false);


--
-- Name: qcloud_sub_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.qcloud_sub_history_id_seq', 1, false);


--
-- Name: qcloud_sub_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.qcloud_sub_id_seq', 1, false);


--
-- Name: qtalk_config_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.qtalk_config_id_seq', 1, false);


--
-- Name: qtalk_user_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.qtalk_user_comment_id_seq', 1, false);


--
-- Name: revoke_msg_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.revoke_msg_history_id_seq', 17, true);


--
-- Name: scheduling_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.scheduling_info_id_seq', 36, true);


--
-- Name: startalk_dep_setting_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.startalk_dep_setting_id_seq', 2, true);


--
-- Name: startalk_dep_table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.startalk_dep_table_id_seq', 34, true);


--
-- Name: startalk_role_class_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.startalk_role_class_id_seq', 1, false);


--
-- Name: startalk_user_role_table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.startalk_user_role_table_id_seq', 1, false);


--
-- Name: statistic_qtalk_click_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.statistic_qtalk_click_event_id_seq', 1, false);


--
-- Name: sys_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_permission_id_seq', 46, false);


--
-- Name: sys_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_role_id_seq', 33, true);


--
-- Name: sys_role_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_role_permission_id_seq', 66, true);


--
-- Name: sys_user_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_user_role_id_seq', 33, true);


--
-- Name: t_client_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.t_client_log_id_seq', 1, false);


--
-- Name: t_dict_client_brand_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.t_dict_client_brand_id_seq', 1, false);


--
-- Name: t_dict_client_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.t_dict_client_event_id_seq', 1, false);


--
-- Name: t_dict_client_model_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.t_dict_client_model_id_seq', 1, false);


--
-- Name: t_dict_client_version_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.t_dict_client_version_id_seq', 1, false);


--
-- Name: vcard_version_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vcard_version_id_seq', 51, true);


--
-- Name: vpn_account_list_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vpn_account_list_id_seq', 1, false);


--
-- Name: warn_msg_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.warn_msg_history_id_seq', 1, false);


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

CREATE UNIQUE INDEX msg_history_backup_msg_id_idx ON public.msg_history_backup USING btree (msg_id) WHERE (create_time >= '2017-12-06 00:00:00+08'::timestamp with time zone);


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

CREATE UNIQUE INDEX muc_room_history_backup_msg_id_idx ON public.muc_room_history_backup USING btree (msg_id) WHERE (create_time >= '2017-12-06 00:00:00+08'::timestamp with time zone);


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

