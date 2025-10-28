--
-- PostgreSQL database dump
--

\restrict du6AeJ0mo85iqfTya0vQRpunRlNikwt8qk17eXAkfYhrS0vXOWdhAzy4rW0L9iz

-- Dumped from database version 15.14 (Debian 15.14-1.pgdg13+1)
-- Dumped by pg_dump version 15.14 (Debian 15.14-1.pgdg13+1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: directus_access; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_access (
    id uuid NOT NULL,
    role uuid,
    "user" uuid,
    policy uuid NOT NULL,
    sort integer
);


ALTER TABLE public.directus_access OWNER TO directus;

--
-- Name: directus_activity; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_activity (
    id integer NOT NULL,
    action character varying(45) NOT NULL,
    "user" uuid,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ip character varying(50),
    user_agent text,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    origin character varying(255)
);


ALTER TABLE public.directus_activity OWNER TO directus;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_activity_id_seq OWNER TO directus;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_activity_id_seq OWNED BY public.directus_activity.id;


--
-- Name: directus_collections; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_collections (
    collection character varying(64) NOT NULL,
    icon character varying(64),
    note text,
    display_template character varying(255),
    hidden boolean DEFAULT false NOT NULL,
    singleton boolean DEFAULT false NOT NULL,
    translations json,
    archive_field character varying(64),
    archive_app_filter boolean DEFAULT true NOT NULL,
    archive_value character varying(255),
    unarchive_value character varying(255),
    sort_field character varying(64),
    accountability character varying(255) DEFAULT 'all'::character varying,
    color character varying(255),
    item_duplication_fields json,
    sort integer,
    "group" character varying(64),
    collapse character varying(255) DEFAULT 'open'::character varying NOT NULL,
    preview_url character varying(255),
    versioning boolean DEFAULT false NOT NULL
);


ALTER TABLE public.directus_collections OWNER TO directus;

--
-- Name: directus_comments; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_comments (
    id uuid NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    comment text NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_updated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    user_updated uuid
);


ALTER TABLE public.directus_comments OWNER TO directus;

--
-- Name: directus_dashboards; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_dashboards (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(64) DEFAULT 'dashboard'::character varying NOT NULL,
    note text,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    color character varying(255)
);


ALTER TABLE public.directus_dashboards OWNER TO directus;

--
-- Name: directus_extensions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_extensions (
    enabled boolean DEFAULT true NOT NULL,
    id uuid NOT NULL,
    folder character varying(255) NOT NULL,
    source character varying(255) NOT NULL,
    bundle uuid
);


ALTER TABLE public.directus_extensions OWNER TO directus;

--
-- Name: directus_fields; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_fields (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    field character varying(64) NOT NULL,
    special character varying(64),
    interface character varying(64),
    options json,
    display character varying(64),
    display_options json,
    readonly boolean DEFAULT false NOT NULL,
    hidden boolean DEFAULT false NOT NULL,
    sort integer,
    width character varying(30) DEFAULT 'full'::character varying,
    translations json,
    note text,
    conditions json,
    required boolean DEFAULT false,
    "group" character varying(64),
    validation json,
    validation_message text
);


ALTER TABLE public.directus_fields OWNER TO directus;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_fields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_fields_id_seq OWNER TO directus;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_fields_id_seq OWNED BY public.directus_fields.id;


--
-- Name: directus_files; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_files (
    id uuid NOT NULL,
    storage character varying(255) NOT NULL,
    filename_disk character varying(255),
    filename_download character varying(255) NOT NULL,
    title character varying(255),
    type character varying(255),
    folder uuid,
    uploaded_by uuid,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_by uuid,
    modified_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    charset character varying(50),
    filesize bigint,
    width integer,
    height integer,
    duration integer,
    embed character varying(200),
    description text,
    location text,
    tags text,
    metadata json,
    focal_point_x integer,
    focal_point_y integer,
    tus_id character varying(64),
    tus_data json,
    uploaded_on timestamp with time zone
);


ALTER TABLE public.directus_files OWNER TO directus;

--
-- Name: directus_flows; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_flows (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(64),
    color character varying(255),
    description text,
    status character varying(255) DEFAULT 'active'::character varying NOT NULL,
    trigger character varying(255),
    accountability character varying(255) DEFAULT 'all'::character varying,
    options json,
    operation uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_flows OWNER TO directus;

--
-- Name: directus_folders; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_folders (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    parent uuid
);


ALTER TABLE public.directus_folders OWNER TO directus;

--
-- Name: directus_migrations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_migrations (
    version character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.directus_migrations OWNER TO directus;

--
-- Name: directus_notifications; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_notifications (
    id integer NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(255) DEFAULT 'inbox'::character varying,
    recipient uuid NOT NULL,
    sender uuid,
    subject character varying(255) NOT NULL,
    message text,
    collection character varying(64),
    item character varying(255)
);


ALTER TABLE public.directus_notifications OWNER TO directus;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_notifications_id_seq OWNER TO directus;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_notifications_id_seq OWNED BY public.directus_notifications.id;


--
-- Name: directus_operations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_operations (
    id uuid NOT NULL,
    name character varying(255),
    key character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    options json,
    resolve uuid,
    reject uuid,
    flow uuid NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_operations OWNER TO directus;

--
-- Name: directus_panels; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_panels (
    id uuid NOT NULL,
    dashboard uuid NOT NULL,
    name character varying(255),
    icon character varying(64) DEFAULT NULL::character varying,
    color character varying(10),
    show_header boolean DEFAULT false NOT NULL,
    note text,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    width integer NOT NULL,
    height integer NOT NULL,
    options json,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_panels OWNER TO directus;

--
-- Name: directus_permissions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_permissions (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    action character varying(10) NOT NULL,
    permissions json,
    validation json,
    presets json,
    fields text,
    policy uuid NOT NULL
);


ALTER TABLE public.directus_permissions OWNER TO directus;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_permissions_id_seq OWNER TO directus;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_permissions_id_seq OWNED BY public.directus_permissions.id;


--
-- Name: directus_policies; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_policies (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(64) DEFAULT 'badge'::character varying NOT NULL,
    description text,
    ip_access text,
    enforce_tfa boolean DEFAULT false NOT NULL,
    admin_access boolean DEFAULT false NOT NULL,
    app_access boolean DEFAULT false NOT NULL
);


ALTER TABLE public.directus_policies OWNER TO directus;

--
-- Name: directus_presets; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_presets (
    id integer NOT NULL,
    bookmark character varying(255),
    "user" uuid,
    role uuid,
    collection character varying(64),
    search character varying(100),
    layout character varying(100) DEFAULT 'tabular'::character varying,
    layout_query json,
    layout_options json,
    refresh_interval integer,
    filter json,
    icon character varying(64) DEFAULT 'bookmark'::character varying,
    color character varying(255)
);


ALTER TABLE public.directus_presets OWNER TO directus;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_presets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_presets_id_seq OWNER TO directus;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_presets_id_seq OWNED BY public.directus_presets.id;


--
-- Name: directus_relations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_relations (
    id integer NOT NULL,
    many_collection character varying(64) NOT NULL,
    many_field character varying(64) NOT NULL,
    one_collection character varying(64),
    one_field character varying(64),
    one_collection_field character varying(64),
    one_allowed_collections text,
    junction_field character varying(64),
    sort_field character varying(64),
    one_deselect_action character varying(255) DEFAULT 'nullify'::character varying NOT NULL
);


ALTER TABLE public.directus_relations OWNER TO directus;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_relations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_relations_id_seq OWNER TO directus;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_relations_id_seq OWNED BY public.directus_relations.id;


--
-- Name: directus_revisions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_revisions (
    id integer NOT NULL,
    activity integer NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    data json,
    delta json,
    parent integer,
    version uuid
);


ALTER TABLE public.directus_revisions OWNER TO directus;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_revisions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_revisions_id_seq OWNER TO directus;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_revisions_id_seq OWNED BY public.directus_revisions.id;


--
-- Name: directus_roles; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_roles (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(64) DEFAULT 'supervised_user_circle'::character varying NOT NULL,
    description text,
    parent uuid
);


ALTER TABLE public.directus_roles OWNER TO directus;

--
-- Name: directus_sessions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_sessions (
    token character varying(64) NOT NULL,
    "user" uuid,
    expires timestamp with time zone NOT NULL,
    ip character varying(255),
    user_agent text,
    share uuid,
    origin character varying(255),
    next_token character varying(64)
);


ALTER TABLE public.directus_sessions OWNER TO directus;

--
-- Name: directus_settings; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_settings (
    id integer NOT NULL,
    project_name character varying(100) DEFAULT 'Directus'::character varying NOT NULL,
    project_url character varying(255),
    project_color character varying(255) DEFAULT '#6644FF'::character varying NOT NULL,
    project_logo uuid,
    public_foreground uuid,
    public_background uuid,
    public_note text,
    auth_login_attempts integer DEFAULT 25,
    auth_password_policy character varying(100),
    storage_asset_transform character varying(7) DEFAULT 'all'::character varying,
    storage_asset_presets json,
    custom_css text,
    storage_default_folder uuid,
    basemaps json,
    mapbox_key character varying(255),
    module_bar json,
    project_descriptor character varying(100),
    default_language character varying(255) DEFAULT 'en-US'::character varying NOT NULL,
    custom_aspect_ratios json,
    public_favicon uuid,
    default_appearance character varying(255) DEFAULT 'auto'::character varying NOT NULL,
    default_theme_light character varying(255),
    theme_light_overrides json,
    default_theme_dark character varying(255),
    theme_dark_overrides json,
    report_error_url character varying(255),
    report_bug_url character varying(255),
    report_feature_url character varying(255),
    public_registration boolean DEFAULT false NOT NULL,
    public_registration_verify_email boolean DEFAULT true NOT NULL,
    public_registration_role uuid,
    public_registration_email_filter json,
    visual_editor_urls json,
    accepted_terms boolean DEFAULT false,
    project_id uuid,
    mcp_enabled boolean DEFAULT false NOT NULL,
    mcp_allow_deletes boolean DEFAULT false NOT NULL,
    mcp_prompts_collection character varying(255) DEFAULT NULL::character varying,
    mcp_system_prompt_enabled boolean DEFAULT true NOT NULL,
    mcp_system_prompt text
);


ALTER TABLE public.directus_settings OWNER TO directus;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_settings_id_seq OWNER TO directus;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_settings_id_seq OWNED BY public.directus_settings.id;


--
-- Name: directus_shares; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_shares (
    id uuid NOT NULL,
    name character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    role uuid,
    password character varying(255),
    user_created uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_start timestamp with time zone,
    date_end timestamp with time zone,
    times_used integer DEFAULT 0,
    max_uses integer
);


ALTER TABLE public.directus_shares OWNER TO directus;

--
-- Name: directus_translations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_translations (
    id uuid NOT NULL,
    language character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.directus_translations OWNER TO directus;

--
-- Name: directus_users; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_users (
    id uuid NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(128),
    password character varying(255),
    location character varying(255),
    title character varying(50),
    description text,
    tags json,
    avatar uuid,
    language character varying(255) DEFAULT NULL::character varying,
    tfa_secret character varying(255),
    status character varying(16) DEFAULT 'active'::character varying NOT NULL,
    role uuid,
    token character varying(255),
    last_access timestamp with time zone,
    last_page character varying(255),
    provider character varying(128) DEFAULT 'default'::character varying NOT NULL,
    external_identifier character varying(255),
    auth_data json,
    email_notifications boolean DEFAULT true,
    appearance character varying(255),
    theme_dark character varying(255),
    theme_light character varying(255),
    theme_light_overrides json,
    theme_dark_overrides json,
    text_direction character varying(255) DEFAULT 'auto'::character varying NOT NULL
);


ALTER TABLE public.directus_users OWNER TO directus;

--
-- Name: directus_versions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_versions (
    id uuid NOT NULL,
    key character varying(64) NOT NULL,
    name character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    hash character varying(255),
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_updated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    user_updated uuid,
    delta json
);


ALTER TABLE public.directus_versions OWNER TO directus;

--
-- Name: directus_webhooks; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_webhooks (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    method character varying(10) DEFAULT 'POST'::character varying NOT NULL,
    url character varying(255) NOT NULL,
    status character varying(10) DEFAULT 'active'::character varying NOT NULL,
    data boolean DEFAULT true NOT NULL,
    actions character varying(100) NOT NULL,
    collections character varying(255) NOT NULL,
    headers json,
    was_active_before_deprecation boolean DEFAULT false NOT NULL,
    migrated_flow uuid
);


ALTER TABLE public.directus_webhooks OWNER TO directus;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_webhooks_id_seq OWNER TO directus;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_webhooks_id_seq OWNED BY public.directus_webhooks.id;


--
-- Name: wholesale; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.wholesale (
    id uuid NOT NULL,
    hero uuid
);


ALTER TABLE public.wholesale OWNER TO directus;

--
-- Name: wholesale_advant; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.wholesale_advant (
    id uuid NOT NULL,
    image uuid,
    content text
);


ALTER TABLE public.wholesale_advant OWNER TO directus;

--
-- Name: wholesale_hero; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.wholesale_hero (
    id uuid NOT NULL,
    image uuid,
    tag character varying(255),
    title character varying(255),
    description text
);


ALTER TABLE public.wholesale_hero OWNER TO directus;

--
-- Name: wholesale_wholesale_advant; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.wholesale_wholesale_advant (
    id integer NOT NULL,
    wholesale_id uuid,
    wholesale_advant_id uuid
);


ALTER TABLE public.wholesale_wholesale_advant OWNER TO directus;

--
-- Name: wholesale_wholesale_advant_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.wholesale_wholesale_advant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wholesale_wholesale_advant_id_seq OWNER TO directus;

--
-- Name: wholesale_wholesale_advant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.wholesale_wholesale_advant_id_seq OWNED BY public.wholesale_wholesale_advant.id;


--
-- Name: directus_activity id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_activity ALTER COLUMN id SET DEFAULT nextval('public.directus_activity_id_seq'::regclass);


--
-- Name: directus_fields id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_fields ALTER COLUMN id SET DEFAULT nextval('public.directus_fields_id_seq'::regclass);


--
-- Name: directus_notifications id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications ALTER COLUMN id SET DEFAULT nextval('public.directus_notifications_id_seq'::regclass);


--
-- Name: directus_permissions id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions ALTER COLUMN id SET DEFAULT nextval('public.directus_permissions_id_seq'::regclass);


--
-- Name: directus_presets id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets ALTER COLUMN id SET DEFAULT nextval('public.directus_presets_id_seq'::regclass);


--
-- Name: directus_relations id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_relations ALTER COLUMN id SET DEFAULT nextval('public.directus_relations_id_seq'::regclass);


--
-- Name: directus_revisions id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions ALTER COLUMN id SET DEFAULT nextval('public.directus_revisions_id_seq'::regclass);


--
-- Name: directus_settings id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings ALTER COLUMN id SET DEFAULT nextval('public.directus_settings_id_seq'::regclass);


--
-- Name: directus_webhooks id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_webhooks ALTER COLUMN id SET DEFAULT nextval('public.directus_webhooks_id_seq'::regclass);


--
-- Name: wholesale_wholesale_advant id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.wholesale_wholesale_advant ALTER COLUMN id SET DEFAULT nextval('public.wholesale_wholesale_advant_id_seq'::regclass);


--
-- Data for Name: directus_access; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_access (id, role, "user", policy, sort) FROM stdin;
0ab57dac-ac44-43e5-91a2-eb951150ed6f	\N	\N	abf8a154-5b1c-4a46-ac9c-7300570f4f17	1
a91e12ed-d49c-4f17-a1bf-60f043bb096b	b7c96db7-0bcc-4ff4-8722-a320af6909dd	\N	2801595f-7663-4a38-ade4-e42250681f82	\N
50c87726-ebc9-4502-9708-10e4a787ab29	\N	5e7d0719-f6fa-4e9b-a681-d24bc8947984	7b920119-42aa-47ac-a60c-656664a5150d	1
\.


--
-- Data for Name: directus_activity; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, origin) FROM stdin;
1	login	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 10:49:11.97+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_users	d28ea43e-0087-4264-aad7-f52329173439	http://localhost:8055
2	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 10:49:18.207+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_settings	1	http://localhost:8055
3	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 10:51:48.416+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_users	d28ea43e-0087-4264-aad7-f52329173439	http://localhost:8055
4	login	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 10:52:18.61+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_users	d28ea43e-0087-4264-aad7-f52329173439	http://localhost:8055
5	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 10:54:33.588+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	1	http://localhost:8055
6	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 10:54:33.595+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_policies	7b920119-42aa-47ac-a60c-656664a5150d	http://localhost:8055
7	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 10:54:33.601+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_access	50c87726-ebc9-4502-9708-10e4a787ab29	http://localhost:8055
8	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 10:54:33.606+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_users	5e7d0719-f6fa-4e9b-a681-d24bc8947984	http://localhost:8055
9	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 10:55:02.525+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_settings	1	http://localhost:8055
10	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 10:59:38.75+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
11	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 11:01:03.538+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	seo_settings	http://localhost:8055
12	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 11:01:09.95+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	seo_settings	http://localhost:8055
13	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 11:01:09.958+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
14	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 11:05:16.47+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	1	http://localhost:8055
15	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 11:05:16.475+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	page_wholesale	http://localhost:8055
16	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 11:05:20.773+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	page_wholesale	http://localhost:8055
17	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 11:05:20.859+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	seo_settings	http://localhost:8055
18	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 11:05:20.87+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
19	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 11:07:45.479+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	page_wholesale	http://localhost:8055
20	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 11:08:30.748+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	2	http://localhost:8055
21	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 11:08:30.754+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_hero	http://localhost:8055
22	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 11:09:47.65+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_hero	http://localhost:8055
23	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 11:09:51.572+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_hero	http://localhost:8055
24	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 11:09:51.622+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	seo_settings	http://localhost:8055
25	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 11:09:51.628+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
26	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 11:09:54.666+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_hero	http://localhost:8055
27	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 11:10:52.876+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	3	http://localhost:8055
28	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 11:11:22.932+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_hero	http://localhost:8055
29	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 11:11:35.89+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_hero	http://localhost:8055
30	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 11:12:38.467+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	4	http://localhost:8055
31	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 11:13:43.589+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	4	http://localhost:8055
32	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 11:17:30.743+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	5	http://localhost:8055
33	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 11:19:25.397+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	6	http://localhost:8055
34	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 11:19:39.548+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	6	http://localhost:8055
35	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 11:20:36.903+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	7	http://localhost:8055
36	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 11:21:19.231+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_files	c49375f7-06d0-47d3-babd-0515605ec99f	http://localhost:8055
39	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 11:22:30.835+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	3	http://localhost:8055
40	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 11:22:52.715+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_hero	http://localhost:8055
41	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 11:24:45.002+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	3	http://localhost:8055
42	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 11:24:57.361+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	3	http://localhost:8055
43	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 11:25:16.677+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	3	http://localhost:8055
44	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 11:25:30.661+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	3	http://localhost:8055
45	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:14:12.902+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_users	5e7d0719-f6fa-4e9b-a681-d24bc8947984	http://localhost:8055
46	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:14:31.568+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	2	http://localhost:8055
47	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:14:31.573+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	3	http://localhost:8055
48	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:14:31.577+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_policies	7b920119-42aa-47ac-a60c-656664a5150d	http://localhost:8055
49	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:14:31.587+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_access	50c87726-ebc9-4502-9708-10e4a787ab29	http://localhost:8055
50	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:14:31.595+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_users	5e7d0719-f6fa-4e9b-a681-d24bc8947984	http://localhost:8055
51	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:51:28.832+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	3	http://localhost:8055
52	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:51:28.918+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_hero	http://localhost:8055
53	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:51:28.921+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	2	http://localhost:8055
54	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:51:28.922+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	4	http://localhost:8055
55	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:51:28.923+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	5	http://localhost:8055
56	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:51:28.924+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	6	http://localhost:8055
57	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:51:28.926+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	7	http://localhost:8055
58	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:51:59.391+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	8	http://localhost:8055
59	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:52:55.769+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	9	http://localhost:8055
60	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:52:58.723+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	1	http://localhost:8055
61	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:52:58.739+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	8	http://localhost:8055
62	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:52:58.771+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	9	http://localhost:8055
63	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:53:36.297+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	10	http://localhost:8055
64	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:53:39.365+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	1	http://localhost:8055
65	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:53:39.377+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	8	http://localhost:8055
66	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:53:39.42+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	9	http://localhost:8055
67	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:53:39.445+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	10	http://localhost:8055
68	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:55:02.719+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	9	http://localhost:8055
69	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:55:05.548+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	10	http://localhost:8055
70	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:58:37.971+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	11	http://localhost:8055
71	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:58:42.075+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	1	http://localhost:8055
72	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:58:42.085+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	8	http://localhost:8055
73	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:58:42.12+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	11	http://localhost:8055
74	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:59:04.384+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	12	http://localhost:8055
75	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:59:08.524+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	12	http://localhost:8055
76	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:59:25.974+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	13	http://localhost:8055
77	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:59:28.631+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	1	http://localhost:8055
78	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:59:28.646+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	8	http://localhost:8055
79	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:59:28.673+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	11	http://localhost:8055
80	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 12:59:28.696+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	13	http://localhost:8055
81	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 13:00:01.903+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	14	http://localhost:8055
82	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 13:00:04.321+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	1	http://localhost:8055
83	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 13:00:04.335+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	8	http://localhost:8055
84	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 13:00:04.369+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	11	http://localhost:8055
85	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 13:00:04.395+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	13	http://localhost:8055
86	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 13:00:04.412+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	14	http://localhost:8055
87	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 13:00:37.137+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	15	http://localhost:8055
88	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 13:00:39.965+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	1	http://localhost:8055
89	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 13:00:39.98+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	8	http://localhost:8055
90	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 13:00:40.014+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	11	http://localhost:8055
91	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 13:00:40.035+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	13	http://localhost:8055
92	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 13:00:40.044+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	14	http://localhost:8055
93	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 13:00:40.055+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	15	http://localhost:8055
94	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 13:01:08.713+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	8	http://localhost:8055
95	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 13:01:32.505+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	8	http://localhost:8055
96	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 13:02:07.996+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	8	http://localhost:8055
97	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 13:03:39.062+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	16	http://localhost:8055
98	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 13:03:42.327+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	1	http://localhost:8055
99	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 13:03:42.339+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	16	http://localhost:8055
100	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 13:03:42.347+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	8	http://localhost:8055
101	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 13:03:48.411+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	1	http://localhost:8055
102	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 13:03:48.412+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	8	http://localhost:8055
103	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 13:03:48.422+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	16	http://localhost:8055
104	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 13:04:08.504+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	1	http://localhost:8055
105	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 13:04:08.514+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	8	http://localhost:8055
106	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 13:04:08.521+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	16	http://localhost:8055
107	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 13:04:14.04+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	16	http://localhost:8055
108	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 13:04:52.612+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	17	http://localhost:8055
109	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 13:04:57.271+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	1	http://localhost:8055
110	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 13:04:57.28+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	17	http://localhost:8055
111	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 13:04:57.322+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	8	http://localhost:8055
112	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 13:05:12.385+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	8	http://localhost:8055
113	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 13:05:22.007+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	17	http://localhost:8055
115	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:00:43.213+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_users	5e7d0719-f6fa-4e9b-a681-d24bc8947984	http://localhost:8055
116	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:14:36.217+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	4	http://localhost:8055
117	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:14:36.23+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	5	http://localhost:8055
118	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:14:36.235+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_policies	7b920119-42aa-47ac-a60c-656664a5150d	http://localhost:8055
119	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:14:36.242+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_access	50c87726-ebc9-4502-9708-10e4a787ab29	http://localhost:8055
120	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:14:36.251+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_users	5e7d0719-f6fa-4e9b-a681-d24bc8947984	http://localhost:8055
121	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:15:55.244+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_access	0cd8fc43-4c24-4176-8d1c-c33416370bd5	http://localhost:8055
122	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:15:55.253+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_policies	abf8a154-5b1c-4a46-ac9c-7300570f4f17	http://localhost:8055
123	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:16:10.473+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_access	0cd8fc43-4c24-4176-8d1c-c33416370bd5	http://localhost:8055
124	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:16:10.477+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_policies	abf8a154-5b1c-4a46-ac9c-7300570f4f17	http://localhost:8055
125	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:16:26.246+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	6	http://localhost:8055
126	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:16:26.254+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_policies	abf8a154-5b1c-4a46-ac9c-7300570f4f17	http://localhost:8055
127	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:17:30.32+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	7	http://localhost:8055
128	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:17:30.326+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	8	http://localhost:8055
129	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:17:30.329+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	9	http://localhost:8055
130	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:17:30.333+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	10	http://localhost:8055
131	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:17:30.337+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	11	http://localhost:8055
132	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:17:30.341+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	12	http://localhost:8055
133	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:17:30.346+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	13	http://localhost:8055
134	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:17:30.349+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	14	http://localhost:8055
135	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:17:30.353+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	15	http://localhost:8055
136	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:17:30.358+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	16	http://localhost:8055
137	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:17:30.362+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	17	http://localhost:8055
138	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:17:30.366+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_policies	abf8a154-5b1c-4a46-ac9c-7300570f4f17	http://localhost:8055
139	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:17:57.16+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	6	http://localhost:8055
140	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:17:57.162+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	7	http://localhost:8055
141	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:17:57.163+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	8	http://localhost:8055
142	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:17:57.164+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	9	http://localhost:8055
143	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:17:57.166+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	10	http://localhost:8055
144	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:17:57.167+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	11	http://localhost:8055
145	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:17:57.168+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	12	http://localhost:8055
146	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:17:57.17+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	13	http://localhost:8055
147	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:17:57.171+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	14	http://localhost:8055
148	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:17:57.172+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	15	http://localhost:8055
149	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:17:57.173+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	16	http://localhost:8055
150	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:17:57.174+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	17	http://localhost:8055
151	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:17:57.175+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_policies	abf8a154-5b1c-4a46-ac9c-7300570f4f17	http://localhost:8055
152	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:18:06.143+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_policies	7b920119-42aa-47ac-a60c-656664a5150d	http://localhost:8055
153	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:18:53.631+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_policies	7b920119-42aa-47ac-a60c-656664a5150d	http://localhost:8055
154	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:21:15.725+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_users	d28ea43e-0087-4264-aad7-f52329173439	http://localhost:8055
155	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 12:24:16.985+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_users	d28ea43e-0087-4264-aad7-f52329173439	http://localhost:8055
156	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:03:00.906+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	11	http://localhost:8055
157	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:03:03.183+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	13	http://localhost:8055
158	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:03:06.433+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	14	http://localhost:8055
159	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:03:09.044+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	15	http://localhost:8055
160	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:03:12.007+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	8	http://localhost:8055
161	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:03:15.095+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	17	http://localhost:8055
162	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:04:13.759+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	page_wholesale	http://localhost:8055
163	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:04:13.764+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	1	http://localhost:8055
164	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:04:29.095+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	18	http://localhost:8055
165	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:04:29.101+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale	http://localhost:8055
166	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:04:44.254+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale	http://localhost:8055
167	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:04:44.316+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	seo_settings	http://localhost:8055
168	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:04:44.322+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
169	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:04:57.376+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale	http://localhost:8055
170	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:05:30.366+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	19	http://localhost:8055
171	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:05:30.37+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_hero	http://localhost:8055
172	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:06:20.738+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	20	http://localhost:8055
173	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:06:39.63+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	21	http://localhost:8055
174	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:06:58.369+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	22	http://localhost:8055
175	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:07:05.455+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	21	http://localhost:8055
176	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:07:30.937+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	23	http://localhost:8055
177	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:07:35.298+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_hero	http://localhost:8055
178	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:07:35.361+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	seo_settings	http://localhost:8055
179	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:07:35.367+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
180	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:07:37.71+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_hero	http://localhost:8055
181	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:08:09.167+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	24	http://localhost:8055
182	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:08:37.438+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_hero	e82cad0e-a2cd-4c50-9dcf-2ccee2d96251	http://localhost:8055
183	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:08:37.442+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	http://localhost:8055
184	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:10:11.798+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	18	http://localhost:8055
185	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:10:11.802+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	19	http://localhost:8055
186	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:10:11.805+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_policies	7b920119-42aa-47ac-a60c-656664a5150d	http://localhost:8055
187	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:10:11.814+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_access	50c87726-ebc9-4502-9708-10e4a787ab29	http://localhost:8055
188	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:10:11.82+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_users	5e7d0719-f6fa-4e9b-a681-d24bc8947984	http://localhost:8055
189	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:35:04.553+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	20	http://localhost:8055
190	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:35:04.559+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_policies	abf8a154-5b1c-4a46-ac9c-7300570f4f17	http://localhost:8055
191	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:37:07.003+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	25	http://localhost:8055
192	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:37:07.009+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_advant	http://localhost:8055
193	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:38:28.692+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	26	http://localhost:8055
194	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:39:40.212+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	27	http://localhost:8055
195	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:39:50.146+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_hero	http://localhost:8055
196	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:39:50.151+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_advant	http://localhost:8055
197	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:39:50.227+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	seo_settings	http://localhost:8055
198	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:39:50.234+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
199	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:40:06.009+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_advant	http://localhost:8055
200	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:40:35.957+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	28	http://localhost:8055
201	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:41:20.993+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_advant	2f0849a4-651e-440a-8dad-dbec47699b12	http://localhost:8055
202	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:41:20.997+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	http://localhost:8055
203	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:41:35.542+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	http://localhost:8055
204	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:41:41.645+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	28	http://localhost:8055
205	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:42:46.34+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	29	http://localhost:8055
206	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:43:02.88+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	29	http://localhost:8055
207	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:43:28.53+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	30	http://localhost:8055
208	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:43:28.616+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	31	http://localhost:8055
209	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:43:28.62+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_wholesale_advant	http://localhost:8055
210	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:43:28.657+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	32	http://localhost:8055
211	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:43:28.709+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	33	http://localhost:8055
212	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:44:04.209+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_wholesale_advant	1	http://localhost:8055
213	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:44:04.213+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	http://localhost:8055
214	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:44:22.98+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_wholesale_advant	http://localhost:8055
215	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:44:23.064+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	seo_settings	http://localhost:8055
216	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:44:23.071+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
217	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:44:53.785+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	30	http://localhost:8055
218	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:45:23.285+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	30	http://localhost:8055
219	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:45:34.489+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	30	http://localhost:8055
220	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:45:49.595+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	27	http://localhost:8055
221	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:47:23.33+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_advant	f788e31c-3da1-4501-8704-9567751d89c4	http://localhost:8055
222	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:47:23.336+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_wholesale_advant	2	http://localhost:8055
223	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:47:23.34+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	http://localhost:8055
224	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:47:38.462+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_advant	cc7f15af-e83c-437a-88df-79c14ed947e0	http://localhost:8055
225	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:47:38.468+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_wholesale_advant	3	http://localhost:8055
226	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:47:38.473+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	http://localhost:8055
227	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:47:57.805+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	21	http://localhost:8055
228	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:47:57.809+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	22	http://localhost:8055
229	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:47:57.814+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_policies	7b920119-42aa-47ac-a60c-656664a5150d	http://localhost:8055
230	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:47:57.819+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_access	50c87726-ebc9-4502-9708-10e4a787ab29	http://localhost:8055
231	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:47:57.826+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_users	5e7d0719-f6fa-4e9b-a681-d24bc8947984	http://localhost:8055
\.


--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability, color, item_duplication_fields, sort, "group", collapse, preview_url, versioning) FROM stdin;
wholesale	two_pager	\N	\N	f	t	\N	\N	t	\N	\N	\N	all	\N	\N	1	pages	open	\N	f
wholesale_hero	\N	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	1	wholesale	open	\N	f
wholesale_advant	\N	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	2	wholesale	open	\N	f
wholesale_wholesale_advant	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	1	wholesale_advant	open	\N	f
seo_settings	folder	Содержит коллекции, связанные с SEO-настройками страниц	\N	f	f	[{"language":"ru-RU","translation":"SEO настройки"}]	\N	t	\N	\N	\N	all	\N	\N	1	\N	open	\N	f
pages	folder	Содержит коллекции, связанные с контентной частью сайта	\N	f	f	[{"language":"ru-RU","translation":"Страницы"}]	\N	t	\N	\N	\N	all	\N	\N	2	\N	open	\N	f
\.


--
-- Data for Name: directus_comments; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_comments (id, collection, item, comment, date_created, date_updated, user_created, user_updated) FROM stdin;
\.


--
-- Data for Name: directus_dashboards; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_dashboards (id, name, icon, note, date_created, user_created, color) FROM stdin;
\.


--
-- Data for Name: directus_extensions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_extensions (enabled, id, folder, source, bundle) FROM stdin;
\.


--
-- Data for Name: directus_fields; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, translations, note, conditions, required, "group", validation, validation_message) FROM stdin;
18	wholesale	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
19	wholesale_hero	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
20	wholesale_hero	image	file	file-image	{}	image	\N	f	f	2	full	\N	\N	\N	t	\N	\N	\N
22	wholesale_hero	title	\N	input	{"iconLeft":"title"}	raw	\N	f	f	4	full	\N	\N	\N	f	\N	\N	\N
21	wholesale_hero	tag	\N	input	{"iconLeft":"tag"}	raw	\N	f	f	3	full	\N	\N	\N	f	\N	\N	\N
23	wholesale_hero	description	\N	input-multiline	\N	raw	\N	f	f	5	full	\N	\N	\N	f	\N	\N	\N
24	wholesale	hero	m2o	select-dropdown-m2o	{"template":"{{image}}{{title}}","enableSelect":false}	\N	\N	f	f	2	full	\N	\N	\N	f	\N	\N	\N
25	wholesale_advant	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
26	wholesale_advant	image	file	file-image	\N	image	\N	f	f	2	full	\N	\N	\N	f	\N	\N	\N
31	wholesale_wholesale_advant	id	\N	\N	\N	\N	\N	f	t	1	full	\N	\N	\N	f	\N	\N	\N
32	wholesale_wholesale_advant	wholesale_id	\N	\N	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N
33	wholesale_wholesale_advant	wholesale_advant_id	\N	\N	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
30	wholesale	advant	m2m	list-m2m	{"enableSelect":false}	related-values	{"template":"{{wholesale_advant_id.image}}"}	f	f	3	full	\N	\N	\N	f	\N	\N	\N
27	wholesale_advant	content	\N	input-rich-text-html	{"toolbar":["bold","italic","underline","h2","h3","h4","numlist","bullist","removeformat","customLink","hr","fullscreen","code"]}	formatted-value	\N	f	f	3	full	\N	\N	\N	f	\N	\N	\N
\.


--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, created_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata, focal_point_x, focal_point_y, tus_id, tus_data, uploaded_on) FROM stdin;
c49375f7-06d0-47d3-babd-0515605ec99f	local	c49375f7-06d0-47d3-babd-0515605ec99f.jpg	temp1.jpg	Temp1	image/jpeg	\N	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 11:21:19.228+00	\N	2025-10-27 11:21:19.269+00	\N	248197	1464	2000	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-10-27 11:21:19.269+00
\.


--
-- Data for Name: directus_flows; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_flows (id, name, icon, color, description, status, trigger, accountability, options, operation, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_folders; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_folders (id, name, parent) FROM stdin;
\.


--
-- Data for Name: directus_migrations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_migrations (version, name, "timestamp") FROM stdin;
20201028A	Remove Collection Foreign Keys	2025-10-27 10:47:50.502701+00
20201029A	Remove System Relations	2025-10-27 10:47:50.511162+00
20201029B	Remove System Collections	2025-10-27 10:47:50.520069+00
20201029C	Remove System Fields	2025-10-27 10:47:50.529417+00
20201105A	Add Cascade System Relations	2025-10-27 10:47:50.576793+00
20201105B	Change Webhook URL Type	2025-10-27 10:47:50.585846+00
20210225A	Add Relations Sort Field	2025-10-27 10:47:50.592637+00
20210304A	Remove Locked Fields	2025-10-27 10:47:50.596906+00
20210312A	Webhooks Collections Text	2025-10-27 10:47:50.605523+00
20210331A	Add Refresh Interval	2025-10-27 10:47:50.609378+00
20210415A	Make Filesize Nullable	2025-10-27 10:47:50.621658+00
20210416A	Add Collections Accountability	2025-10-27 10:47:50.627293+00
20210422A	Remove Files Interface	2025-10-27 10:47:50.631007+00
20210506A	Rename Interfaces	2025-10-27 10:47:50.652717+00
20210510A	Restructure Relations	2025-10-27 10:47:50.669549+00
20210518A	Add Foreign Key Constraints	2025-10-27 10:47:50.677099+00
20210519A	Add System Fk Triggers	2025-10-27 10:47:50.704091+00
20210521A	Add Collections Icon Color	2025-10-27 10:47:50.707943+00
20210525A	Add Insights	2025-10-27 10:47:50.726663+00
20210608A	Add Deep Clone Config	2025-10-27 10:47:50.730056+00
20210626A	Change Filesize Bigint	2025-10-27 10:47:50.743465+00
20210716A	Add Conditions to Fields	2025-10-27 10:47:50.74717+00
20210721A	Add Default Folder	2025-10-27 10:47:50.753515+00
20210802A	Replace Groups	2025-10-27 10:47:50.758892+00
20210803A	Add Required to Fields	2025-10-27 10:47:50.762922+00
20210805A	Update Groups	2025-10-27 10:47:50.767382+00
20210805B	Change Image Metadata Structure	2025-10-27 10:47:50.772322+00
20210811A	Add Geometry Config	2025-10-27 10:47:50.776162+00
20210831A	Remove Limit Column	2025-10-27 10:47:50.782363+00
20210903A	Add Auth Provider	2025-10-27 10:47:50.800805+00
20210907A	Webhooks Collections Not Null	2025-10-27 10:47:50.808262+00
20210910A	Move Module Setup	2025-10-27 10:47:50.812895+00
20210920A	Webhooks URL Not Null	2025-10-27 10:47:50.821091+00
20210924A	Add Collection Organization	2025-10-27 10:47:50.827992+00
20210927A	Replace Fields Group	2025-10-27 10:47:50.83769+00
20210927B	Replace M2M Interface	2025-10-27 10:47:50.840454+00
20210929A	Rename Login Action	2025-10-27 10:47:50.843753+00
20211007A	Update Presets	2025-10-27 10:47:50.850928+00
20211009A	Add Auth Data	2025-10-27 10:47:50.854145+00
20211016A	Add Webhook Headers	2025-10-27 10:47:50.857816+00
20211103A	Set Unique to User Token	2025-10-27 10:47:50.863887+00
20211103B	Update Special Geometry	2025-10-27 10:47:50.867814+00
20211104A	Remove Collections Listing	2025-10-27 10:47:50.934783+00
20211118A	Add Notifications	2025-10-27 10:47:50.953121+00
20211211A	Add Shares	2025-10-27 10:47:50.974225+00
20211230A	Add Project Descriptor	2025-10-27 10:47:50.978219+00
20220303A	Remove Default Project Color	2025-10-27 10:47:50.98702+00
20220308A	Add Bookmark Icon and Color	2025-10-27 10:47:50.991388+00
20220314A	Add Translation Strings	2025-10-27 10:47:50.995479+00
20220322A	Rename Field Typecast Flags	2025-10-27 10:47:51.000041+00
20220323A	Add Field Validation	2025-10-27 10:47:51.003998+00
20220325A	Fix Typecast Flags	2025-10-27 10:47:51.0089+00
20220325B	Add Default Language	2025-10-27 10:47:51.018757+00
20220402A	Remove Default Value Panel Icon	2025-10-27 10:47:51.026744+00
20220429A	Add Flows	2025-10-27 10:47:51.057955+00
20220429B	Add Color to Insights Icon	2025-10-27 10:47:51.061552+00
20220429C	Drop Non Null From IP of Activity	2025-10-27 10:47:51.065322+00
20220429D	Drop Non Null From Sender of Notifications	2025-10-27 10:47:51.069571+00
20220614A	Rename Hook Trigger to Event	2025-10-27 10:47:51.073025+00
20220801A	Update Notifications Timestamp Column	2025-10-27 10:47:51.080806+00
20220802A	Add Custom Aspect Ratios	2025-10-27 10:47:51.084515+00
20220826A	Add Origin to Accountability	2025-10-27 10:47:51.089519+00
20230401A	Update Material Icons	2025-10-27 10:47:51.097942+00
20230525A	Add Preview Settings	2025-10-27 10:47:51.101506+00
20230526A	Migrate Translation Strings	2025-10-27 10:47:51.112242+00
20230721A	Require Shares Fields	2025-10-27 10:47:51.118974+00
20230823A	Add Content Versioning	2025-10-27 10:47:51.138764+00
20230927A	Themes	2025-10-27 10:47:51.155328+00
20231009A	Update CSV Fields to Text	2025-10-27 10:47:51.160705+00
20231009B	Update Panel Options	2025-10-27 10:47:51.163862+00
20231010A	Add Extensions	2025-10-27 10:47:51.16945+00
20231215A	Add Focalpoints	2025-10-27 10:47:51.172867+00
20240122A	Add Report URL Fields	2025-10-27 10:47:51.176668+00
20240204A	Marketplace	2025-10-27 10:47:51.211774+00
20240305A	Change Useragent Type	2025-10-27 10:47:51.223792+00
20240311A	Deprecate Webhooks	2025-10-27 10:47:51.233638+00
20240422A	Public Registration	2025-10-27 10:47:51.239721+00
20240515A	Add Session Window	2025-10-27 10:47:51.243153+00
20240701A	Add Tus Data	2025-10-27 10:47:51.246581+00
20240716A	Update Files Date Fields	2025-10-27 10:47:51.254411+00
20240806A	Permissions Policies	2025-10-27 10:47:51.29744+00
20240817A	Update Icon Fields Length	2025-10-27 10:47:51.326878+00
20240909A	Separate Comments	2025-10-27 10:47:51.339465+00
20240909B	Consolidate Content Versioning	2025-10-27 10:47:51.34321+00
20240924A	Migrate Legacy Comments	2025-10-27 10:47:51.350762+00
20240924B	Populate Versioning Deltas	2025-10-27 10:47:51.355307+00
20250224A	Visual Editor	2025-10-27 10:47:51.359854+00
20250609A	License Banner	2025-10-27 10:47:51.365545+00
20250613A	Add Project ID	2025-10-27 10:47:51.385897+00
20250718A	Add Direction	2025-10-27 10:47:51.390252+00
20250813A	Add MCP	2025-10-27 10:47:51.397364+00
\.


--
-- Data for Name: directus_notifications; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_notifications (id, "timestamp", status, recipient, sender, subject, message, collection, item) FROM stdin;
\.


--
-- Data for Name: directus_operations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_operations (id, name, key, type, position_x, position_y, options, resolve, reject, flow, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_panels; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_panels (id, dashboard, name, icon, color, show_header, note, type, position_x, position_y, width, height, options, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_permissions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_permissions (id, collection, action, permissions, validation, presets, fields, policy) FROM stdin;
1	directus_files	read	\N	\N	\N	*	7b920119-42aa-47ac-a60c-656664a5150d
4	directus_fields	read	\N	\N	\N	*	7b920119-42aa-47ac-a60c-656664a5150d
5	directus_collections	read	\N	\N	\N	*	7b920119-42aa-47ac-a60c-656664a5150d
18	wholesale	read	\N	\N	\N	*	7b920119-42aa-47ac-a60c-656664a5150d
19	wholesale_hero	read	\N	\N	\N	*	7b920119-42aa-47ac-a60c-656664a5150d
20	directus_files	read	\N	\N	\N	*	abf8a154-5b1c-4a46-ac9c-7300570f4f17
21	wholesale_advant	read	\N	\N	\N	*	7b920119-42aa-47ac-a60c-656664a5150d
22	wholesale_wholesale_advant	read	\N	\N	\N	*	7b920119-42aa-47ac-a60c-656664a5150d
\.


--
-- Data for Name: directus_policies; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_policies (id, name, icon, description, ip_access, enforce_tfa, admin_access, app_access) FROM stdin;
abf8a154-5b1c-4a46-ac9c-7300570f4f17	$t:public_label	public	$t:public_description	\N	f	f	f
2801595f-7663-4a38-ade4-e42250681f82	Administrator	verified	$t:admin_description	\N	f	t	t
7b920119-42aa-47ac-a60c-656664a5150d	read_only	badge	\N	\N	f	f	f
\.


--
-- Data for Name: directus_presets; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_presets (id, bookmark, "user", role, collection, search, layout, layout_query, layout_options, refresh_interval, filter, icon, color) FROM stdin;
\.


--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_relations (id, many_collection, many_field, one_collection, one_field, one_collection_field, one_allowed_collections, junction_field, sort_field, one_deselect_action) FROM stdin;
5	wholesale_hero	image	directus_files	\N	\N	\N	\N	\N	nullify
6	wholesale	hero	wholesale_hero	\N	\N	\N	\N	\N	nullify
7	wholesale_advant	image	directus_files	\N	\N	\N	\N	\N	nullify
9	wholesale_wholesale_advant	wholesale_advant_id	wholesale_advant	\N	\N	\N	wholesale_id	\N	nullify
10	wholesale_wholesale_advant	wholesale_id	wholesale	advant	\N	\N	wholesale_advant_id	\N	nullify
\.


--
-- Data for Name: directus_revisions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_revisions (id, activity, collection, item, data, delta, parent, version) FROM stdin;
1	2	directus_settings	1	{"id":1,"project_name":"Directus","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":null,"default_language":"en-US","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019a2548-1157-764f-9203-0c2a15838d83","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"accepted_terms":true}	\N	\N
2	3	directus_users	d28ea43e-0087-4264-aad7-f52329173439	{"id":"d28ea43e-0087-4264-aad7-f52329173439","first_name":"Admin","last_name":"User","email":"melnikov.works166@gmail.com","password":"**********","location":null,"title":null,"description":null,"tags":null,"avatar":null,"language":null,"tfa_secret":"**********","status":"active","role":"b7c96db7-0bcc-4ff4-8722-a320af6909dd","token":null,"last_access":"2025-10-27T10:49:11.977Z","last_page":"/users/d28ea43e-0087-4264-aad7-f52329173439","provider":"default","external_identifier":null,"auth_data":null,"email_notifications":true,"appearance":null,"theme_dark":null,"theme_light":null,"theme_light_overrides":null,"theme_dark_overrides":null,"text_direction":"auto","policies":[]}	{"tfa_secret":"**********"}	\N	\N
3	5	directus_permissions	1	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}	4	\N
4	6	directus_policies	7b920119-42aa-47ac-a60c-656664a5150d	{"name":"read_only","permissions":{"create":[{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}],"update":[],"delete":[]}}	{"name":"read_only","permissions":{"create":[{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}],"update":[],"delete":[]}}	5	\N
6	8	directus_users	5e7d0719-f6fa-4e9b-a681-d24bc8947984	{"first_name":"frontend","policies":{"create":[{"policy":{"name":"read_only","permissions":{"create":[{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}],"update":[],"delete":[]}}}],"update":[],"delete":[]}}	{"first_name":"frontend","policies":{"create":[{"policy":{"name":"read_only","permissions":{"create":[{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}],"update":[],"delete":[]}}}],"update":[],"delete":[]}}	\N	\N
5	7	directus_access	50c87726-ebc9-4502-9708-10e4a787ab29	{"policy":{"name":"read_only","permissions":{"create":[{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}],"update":[],"delete":[]}},"sort":1,"user":"5e7d0719-f6fa-4e9b-a681-d24bc8947984"}	{"policy":{"name":"read_only","permissions":{"create":[{"policy":"+","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}],"update":[],"delete":[]}},"sort":1,"user":"5e7d0719-f6fa-4e9b-a681-d24bc8947984"}	6	\N
7	9	directus_settings	1	{"id":1,"project_name":"Directus","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":null,"default_language":"ru-RU","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019a2548-1157-764f-9203-0c2a15838d83","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null}	{"default_language":"ru-RU"}	\N	\N
8	10	directus_collections	pages	{"collection":"pages","icon":"folder","note":"Содержит коллекции, связанные с контентной частью сайта","color":null,"translations":[{"language":"ru-RU","translation":"Страницы"}]}	{"collection":"pages","icon":"folder","note":"Содержит коллекции, связанные с контентной частью сайта","color":null,"translations":[{"language":"ru-RU","translation":"Страницы"}]}	\N	\N
9	11	directus_collections	seo_settings	{"collection":"seo_settings","icon":"folder","note":"Содержит коллекции, связанные с SEO-настройками страниц","color":null,"translations":[{"language":"ru-RU","translation":"SEO настройки"}]}	{"collection":"seo_settings","icon":"folder","note":"Содержит коллекции, связанные с SEO-настройками страниц","color":null,"translations":[{"language":"ru-RU","translation":"SEO настройки"}]}	\N	\N
10	12	directus_collections	seo_settings	{"collection":"seo_settings","icon":"folder","note":"Содержит коллекции, связанные с SEO-настройками страниц","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"SEO настройки"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
11	13	directus_collections	pages	{"collection":"pages","icon":"folder","note":"Содержит коллекции, связанные с контентной частью сайта","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
12	14	directus_fields	1	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"page_wholesale"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"page_wholesale"}	\N	\N
13	15	directus_collections	page_wholesale	{"singleton":true,"collection":"page_wholesale"}	{"singleton":true,"collection":"page_wholesale"}	\N	\N
14	16	directus_collections	page_wholesale	{"collection":"page_wholesale","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":true,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"pages"}	\N	\N
15	17	directus_collections	seo_settings	{"collection":"seo_settings","icon":"folder","note":"Содержит коллекции, связанные с SEO-настройками страниц","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"SEO настройки"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
16	18	directus_collections	pages	{"collection":"pages","icon":"folder","note":"Содержит коллекции, связанные с контентной частью сайта","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
17	19	directus_collections	page_wholesale	{"collection":"page_wholesale","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":[{"language":"ru-RU","translation":"Страница \\"Цветы оптом\\" ","singular":"Страница \\"Цветы оптом\\" ","plural":"Страницы \\"Цветы оптом\\" "}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"icon":"two_pager","translations":[{"language":"ru-RU","translation":"Страница \\"Цветы оптом\\" ","singular":"Страница \\"Цветы оптом\\" ","plural":"Страницы \\"Цветы оптом\\" "}]}	\N	\N
18	20	directus_fields	2	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"wholesale_hero"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"wholesale_hero"}	\N	\N
19	21	directus_collections	wholesale_hero	{"singleton":false,"collection":"wholesale_hero"}	{"singleton":false,"collection":"wholesale_hero"}	\N	\N
20	22	directus_collections	wholesale_hero	{"collection":"wholesale_hero","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Первый экран страницы","singular":"Первый экран страницы","plural":"Первые экраны страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"translations":[{"language":"ru-RU","translation":"Первый экран страницы","singular":"Первый экран страницы","plural":"Первые экраны страницы"}]}	\N	\N
21	23	directus_collections	wholesale_hero	{"collection":"wholesale_hero","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Первый экран страницы","singular":"Первый экран страницы","plural":"Первые экраны страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"page_wholesale","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"page_wholesale"}	\N	\N
22	24	directus_collections	seo_settings	{"collection":"seo_settings","icon":"folder","note":"Содержит коллекции, связанные с SEO-настройками страниц","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"SEO настройки"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
23	25	directus_collections	pages	{"collection":"pages","icon":"folder","note":"Содержит коллекции, связанные с контентной частью сайта","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
87	101	directus_fields	1	{"id":1,"collection":"page_wholesale","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"id","sort":1,"group":null}	\N	\N
24	26	directus_collections	wholesale_hero	{"collection":"wholesale_hero","icon":null,"note":null,"display_template":null,"hidden":true,"singleton":false,"translations":[{"language":"ru-RU","translation":"Первый экран страницы","singular":"Первый экран страницы","plural":"Первые экраны страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"page_wholesale","collapse":"open","preview_url":null,"versioning":false}	{"hidden":true}	\N	\N
25	27	directus_fields	3	{"sort":2,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"enableSelect":false},"collection":"page_wholesale","field":"hero"}	{"sort":2,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"enableSelect":false},"collection":"page_wholesale","field":"hero"}	\N	\N
26	28	directus_collections	wholesale_hero	{"collection":"wholesale_hero","icon":null,"note":null,"display_template":null,"hidden":true,"singleton":true,"translations":[{"language":"ru-RU","translation":"Первый экран страницы","singular":"Первый экран страницы","plural":"Первые экраны страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"page_wholesale","collapse":"open","preview_url":null,"versioning":false}	{"singleton":true}	\N	\N
27	29	directus_collections	wholesale_hero	{"collection":"wholesale_hero","icon":null,"note":null,"display_template":null,"hidden":true,"singleton":false,"translations":[{"language":"ru-RU","translation":"Первый экран страницы","singular":"Первый экран страницы","plural":"Первые экраны страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"page_wholesale","collapse":"open","preview_url":null,"versioning":false}	{"singleton":false}	\N	\N
28	30	directus_fields	4	{"sort":2,"interface":"file-image","special":["file"],"required":true,"options":{"enableSelect":false},"collection":"wholesale_hero","field":"image"}	{"sort":2,"interface":"file-image","special":["file"],"required":true,"options":{"enableSelect":false},"collection":"wholesale_hero","field":"image"}	\N	\N
29	31	directus_fields	4	{"id":4,"collection":"wholesale_hero","field":"image","special":["file"],"interface":"file-image","options":{"enableSelect":false},"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Фоновое изображение"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale_hero","field":"image","display":"image","translations":[{"language":"ru-RU","translation":"Фоновое изображение"}]}	\N	\N
30	32	directus_fields	5	{"sort":3,"special":null,"interface":"input","translations":[{"language":"ru-RU","translation":"Тег (закрашенная надпись сверху)"}],"options":{"iconLeft":"tag","softLength":64},"display":"raw","collection":"wholesale_hero","field":"tag"}	{"sort":3,"special":null,"interface":"input","translations":[{"language":"ru-RU","translation":"Тег (закрашенная надпись сверху)"}],"options":{"iconLeft":"tag","softLength":64},"display":"raw","collection":"wholesale_hero","field":"tag"}	\N	\N
31	33	directus_fields	6	{"sort":4,"special":null,"interface":"input","translations":[{"language":"ru-RU","translation":"Заголовок"}],"options":{"choices":null,"iconLeft":"title"},"display":"raw","collection":"wholesale_hero","field":"title"}	{"sort":4,"special":null,"interface":"input","translations":[{"language":"ru-RU","translation":"Заголовок"}],"options":{"choices":null,"iconLeft":"title"},"display":"raw","collection":"wholesale_hero","field":"title"}	\N	\N
32	34	directus_fields	6	{"id":6,"collection":"wholesale_hero","field":"title","special":null,"interface":"input","options":{"choices":null,"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale_hero","field":"title","required":false}	\N	\N
33	35	directus_fields	7	{"sort":5,"special":null,"interface":"input-multiline","translations":[{"language":"ru-RU","translation":"Текст-описание"}],"display":"raw","collection":"wholesale_hero","field":"description"}	{"sort":5,"special":null,"interface":"input-multiline","translations":[{"language":"ru-RU","translation":"Текст-описание"}],"display":"raw","collection":"wholesale_hero","field":"description"}	\N	\N
34	36	directus_files	c49375f7-06d0-47d3-babd-0515605ec99f	{"title":"Temp1","filename_download":"temp1.jpg","type":"image/jpeg","storage":"local"}	{"title":"Temp1","filename_download":"temp1.jpg","type":"image/jpeg","storage":"local"}	\N	\N
37	39	directus_fields	3	{"id":3,"collection":"page_wholesale","field":"hero","special":["m2o"],"interface":"select-dropdown-m2o","options":{"enableSelect":false},"display":"related-values","display_options":{"template":"{{image}}{{title}}"},"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"hero","display":"related-values","display_options":{"template":"{{image}}{{title}}"}}	\N	\N
38	40	directus_collections	wholesale_hero	{"collection":"wholesale_hero","icon":null,"note":null,"display_template":"{{image}}{{title}}","hidden":true,"singleton":false,"translations":[{"language":"ru-RU","translation":"Первый экран страницы","singular":"Первый экран страницы","plural":"Первые экраны страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"page_wholesale","collapse":"open","preview_url":null,"versioning":false}	{"display_template":"{{image}}{{title}}"}	\N	\N
39	41	directus_fields	3	{"id":3,"collection":"page_wholesale","field":"hero","special":["m2o"],"interface":"select-dropdown-m2o","options":{"enableSelect":false},"display":"related-values","display_options":{"template":null},"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Главный экран страницы"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"hero","display_options":{"template":null},"translations":[{"language":"ru-RU","translation":"Главный экран страницы"}]}	\N	\N
40	42	directus_fields	3	{"id":3,"collection":"page_wholesale","field":"hero","special":["m2o"],"interface":"select-dropdown-m2o","options":{"enableSelect":false,"enableCreate":false},"display":"related-values","display_options":{"template":null},"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Главный экран страницы"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"hero","options":{"enableSelect":false,"enableCreate":false}}	\N	\N
41	43	directus_fields	3	{"id":3,"collection":"page_wholesale","field":"hero","special":["m2o"],"interface":"select-dropdown-m2o","options":{},"display":"related-values","display_options":{"template":null},"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Главный экран страницы"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"hero","options":{}}	\N	\N
42	44	directus_fields	3	{"id":3,"collection":"page_wholesale","field":"hero","special":["m2o"],"interface":"select-dropdown-m2o","options":{"enableSelect":false},"display":"related-values","display_options":{"template":null},"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Главный экран страницы"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"hero","options":{"enableSelect":false}}	\N	\N
43	45	directus_users	5e7d0719-f6fa-4e9b-a681-d24bc8947984	{"id":"5e7d0719-f6fa-4e9b-a681-d24bc8947984","first_name":"frontend","last_name":null,"email":null,"password":null,"location":null,"title":null,"description":null,"tags":null,"avatar":null,"language":null,"tfa_secret":null,"status":"active","role":null,"token":"**********","last_access":null,"last_page":null,"provider":"default","external_identifier":null,"auth_data":null,"email_notifications":true,"appearance":null,"theme_dark":null,"theme_light":null,"theme_light_overrides":null,"theme_dark_overrides":null,"text_direction":"auto","policies":["50c87726-ebc9-4502-9708-10e4a787ab29"]}	{"token":"**********"}	\N	\N
44	46	directus_permissions	2	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"page_wholesale","action":"read"}	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"page_wholesale","action":"read"}	\N	\N
45	47	directus_permissions	3	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"wholesale_hero","action":"read"}	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"wholesale_hero","action":"read"}	\N	\N
46	49	directus_access	50c87726-ebc9-4502-9708-10e4a787ab29	{"id":"50c87726-ebc9-4502-9708-10e4a787ab29","role":null,"user":"5e7d0719-f6fa-4e9b-a681-d24bc8947984","policy":"7b920119-42aa-47ac-a60c-656664a5150d","sort":1}	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d"}	\N	\N
47	58	directus_fields	8	{"sort":2,"interface":"group-raw","special":["alias","no-data","group"],"collection":"page_wholesale","field":"hero"}	{"sort":2,"interface":"group-raw","special":["alias","no-data","group"],"collection":"page_wholesale","field":"hero"}	\N	\N
48	59	directus_fields	9	{"sort":3,"special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Фоновое изображение"}],"interface":"file-image","options":{},"display":"image","collection":"page_wholesale","field":"image"}	{"sort":3,"special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Фоновое изображение"}],"interface":"file-image","options":{},"display":"image","collection":"page_wholesale","field":"image"}	\N	\N
49	60	directus_fields	1	{"id":1,"collection":"page_wholesale","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"id","sort":1,"group":null}	\N	\N
50	61	directus_fields	8	{"id":8,"collection":"page_wholesale","field":"hero","special":["alias","no-data","group"],"interface":"group-raw","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"hero","sort":2,"group":null}	\N	\N
51	62	directus_fields	9	{"id":9,"collection":"page_wholesale","field":"image","special":["file"],"interface":"file-image","options":{},"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Фоновое изображение"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"image","sort":1,"group":"hero"}	\N	\N
52	63	directus_fields	10	{"sort":3,"special":null,"interface":"input","display":"raw","collection":"page_wholesale","field":"tag"}	{"sort":3,"special":null,"interface":"input","display":"raw","collection":"page_wholesale","field":"tag"}	\N	\N
53	64	directus_fields	1	{"id":1,"collection":"page_wholesale","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"id","sort":1,"group":null}	\N	\N
54	65	directus_fields	8	{"id":8,"collection":"page_wholesale","field":"hero","special":["alias","no-data","group"],"interface":"group-raw","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"hero","sort":2,"group":null}	\N	\N
55	66	directus_fields	9	{"id":9,"collection":"page_wholesale","field":"image","special":["file"],"interface":"file-image","options":{},"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Фоновое изображение"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"image","sort":1,"group":"hero"}	\N	\N
56	67	directus_fields	10	{"id":10,"collection":"page_wholesale","field":"tag","special":null,"interface":"input","options":null,"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":"hero","validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"tag","sort":2,"group":"hero"}	\N	\N
57	70	directus_fields	11	{"sort":3,"special":["file"],"required":true,"interface":"file-image","display":"image","collection":"page_wholesale","field":"hero_image"}	{"sort":3,"special":["file"],"required":true,"interface":"file-image","display":"image","collection":"page_wholesale","field":"hero_image"}	\N	\N
58	71	directus_fields	1	{"id":1,"collection":"page_wholesale","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"id","sort":1,"group":null}	\N	\N
59	72	directus_fields	8	{"id":8,"collection":"page_wholesale","field":"hero","special":["alias","no-data","group"],"interface":"group-raw","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"hero","sort":2,"group":null}	\N	\N
60	73	directus_fields	11	{"id":11,"collection":"page_wholesale","field":"hero_image","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"hero_image","sort":1,"group":"hero"}	\N	\N
61	74	directus_fields	12	{"sort":3,"special":null,"interface":"input","display":"raw","collection":"page_wholesale","field":"tag"}	{"sort":3,"special":null,"interface":"input","display":"raw","collection":"page_wholesale","field":"tag"}	\N	\N
62	76	directus_fields	13	{"sort":3,"special":null,"interface":"input","display":"raw","collection":"page_wholesale","field":"hero_tag"}	{"sort":3,"special":null,"interface":"input","display":"raw","collection":"page_wholesale","field":"hero_tag"}	\N	\N
63	77	directus_fields	1	{"id":1,"collection":"page_wholesale","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"id","sort":1,"group":null}	\N	\N
64	78	directus_fields	8	{"id":8,"collection":"page_wholesale","field":"hero","special":["alias","no-data","group"],"interface":"group-raw","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"hero","sort":2,"group":null}	\N	\N
65	79	directus_fields	11	{"id":11,"collection":"page_wholesale","field":"hero_image","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"hero_image","sort":1,"group":"hero"}	\N	\N
66	80	directus_fields	13	{"id":13,"collection":"page_wholesale","field":"hero_tag","special":null,"interface":"input","options":null,"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":"hero","validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"hero_tag","sort":2,"group":"hero"}	\N	\N
67	81	directus_fields	14	{"sort":3,"special":null,"interface":"input","collection":"page_wholesale","field":"hero_title"}	{"sort":3,"special":null,"interface":"input","collection":"page_wholesale","field":"hero_title"}	\N	\N
68	82	directus_fields	1	{"id":1,"collection":"page_wholesale","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"id","sort":1,"group":null}	\N	\N
69	83	directus_fields	8	{"id":8,"collection":"page_wholesale","field":"hero","special":["alias","no-data","group"],"interface":"group-raw","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"hero","sort":2,"group":null}	\N	\N
70	84	directus_fields	11	{"id":11,"collection":"page_wholesale","field":"hero_image","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"hero_image","sort":1,"group":"hero"}	\N	\N
71	85	directus_fields	13	{"id":13,"collection":"page_wholesale","field":"hero_tag","special":null,"interface":"input","options":null,"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":"hero","validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"hero_tag","sort":2,"group":"hero"}	\N	\N
72	86	directus_fields	14	{"id":14,"collection":"page_wholesale","field":"hero_title","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":"hero","validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"hero_title","sort":3,"group":"hero"}	\N	\N
73	87	directus_fields	15	{"sort":4,"special":null,"interface":"input-multiline","collection":"page_wholesale","field":"hero_description"}	{"sort":4,"special":null,"interface":"input-multiline","collection":"page_wholesale","field":"hero_description"}	\N	\N
74	88	directus_fields	1	{"id":1,"collection":"page_wholesale","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"id","sort":1,"group":null}	\N	\N
75	89	directus_fields	8	{"id":8,"collection":"page_wholesale","field":"hero","special":["alias","no-data","group"],"interface":"group-raw","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"hero","sort":2,"group":null}	\N	\N
76	90	directus_fields	11	{"id":11,"collection":"page_wholesale","field":"hero_image","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"hero_image","sort":1,"group":"hero"}	\N	\N
77	91	directus_fields	13	{"id":13,"collection":"page_wholesale","field":"hero_tag","special":null,"interface":"input","options":null,"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":"hero","validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"hero_tag","sort":2,"group":"hero"}	\N	\N
78	92	directus_fields	14	{"id":14,"collection":"page_wholesale","field":"hero_title","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":"hero","validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"hero_title","sort":3,"group":"hero"}	\N	\N
79	93	directus_fields	15	{"id":15,"collection":"page_wholesale","field":"hero_description","special":null,"interface":"input-multiline","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":"hero","validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"hero_description","sort":4,"group":"hero"}	\N	\N
80	94	directus_fields	8	{"id":8,"collection":"page_wholesale","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"hero","interface":"group-detail"}	\N	\N
81	95	directus_fields	8	{"id":8,"collection":"page_wholesale","field":"hero","special":["alias","no-data","group"],"interface":"group-accordion","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"hero","interface":"group-accordion"}	\N	\N
82	96	directus_fields	8	{"id":8,"collection":"page_wholesale","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"hero","interface":"group-detail"}	\N	\N
83	97	directus_fields	16	{"sort":5,"interface":"group-accordion","special":["alias","no-data","group"],"options":{"start":"first"},"collection":"page_wholesale","field":"accordion-vysphn"}	{"sort":5,"interface":"group-accordion","special":["alias","no-data","group"],"options":{"start":"first"},"collection":"page_wholesale","field":"accordion-vysphn"}	\N	\N
84	98	directus_fields	1	{"id":1,"collection":"page_wholesale","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"id","sort":1,"group":null}	\N	\N
85	99	directus_fields	16	{"id":16,"collection":"page_wholesale","field":"accordion-vysphn","special":["alias","no-data","group"],"interface":"group-accordion","options":{"start":"first"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"accordion-vysphn","sort":2,"group":null}	\N	\N
86	100	directus_fields	8	{"id":8,"collection":"page_wholesale","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"hero","sort":3,"group":null}	\N	\N
88	102	directus_fields	8	{"id":8,"collection":"page_wholesale","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":"accordion-vysphn","validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"hero","sort":1,"group":"accordion-vysphn"}	\N	\N
89	103	directus_fields	16	{"id":16,"collection":"page_wholesale","field":"accordion-vysphn","special":["alias","no-data","group"],"interface":"group-accordion","options":{"start":"first"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"accordion-vysphn","sort":2,"group":null}	\N	\N
90	104	directus_fields	1	{"id":1,"collection":"page_wholesale","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"id","sort":1,"group":null}	\N	\N
91	105	directus_fields	8	{"id":8,"collection":"page_wholesale","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"hero","sort":2,"group":null}	\N	\N
92	106	directus_fields	16	{"id":16,"collection":"page_wholesale","field":"accordion-vysphn","special":["alias","no-data","group"],"interface":"group-accordion","options":{"start":"first"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"accordion-vysphn","sort":3,"group":null}	\N	\N
93	108	directus_fields	17	{"sort":5,"interface":"group-detail","special":["alias","no-data","group"],"collection":"page_wholesale","field":"content"}	{"sort":5,"interface":"group-detail","special":["alias","no-data","group"],"collection":"page_wholesale","field":"content"}	\N	\N
94	109	directus_fields	1	{"id":1,"collection":"page_wholesale","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"id","sort":1,"group":null}	\N	\N
95	110	directus_fields	17	{"id":17,"collection":"page_wholesale","field":"content","special":["alias","no-data","group"],"interface":"group-detail","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"content","sort":2,"group":null}	\N	\N
96	111	directus_fields	8	{"id":8,"collection":"page_wholesale","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":"content","validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"hero","sort":1,"group":"content"}	\N	\N
97	112	directus_fields	8	{"id":8,"collection":"page_wholesale","field":"hero","special":["alias","no-data","group"],"interface":"group-raw","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":"content","validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"hero","interface":"group-raw"}	\N	\N
98	113	directus_fields	17	{"id":17,"collection":"page_wholesale","field":"content","special":["alias","no-data","group"],"interface":"group-accordion","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"page_wholesale","field":"content","interface":"group-accordion"}	\N	\N
100	115	directus_users	5e7d0719-f6fa-4e9b-a681-d24bc8947984	{"id":"5e7d0719-f6fa-4e9b-a681-d24bc8947984","first_name":"frontend","last_name":null,"email":null,"password":null,"location":null,"title":null,"description":null,"tags":null,"avatar":null,"language":null,"tfa_secret":null,"status":"active","role":null,"token":"**********","last_access":null,"last_page":null,"provider":"default","external_identifier":null,"auth_data":null,"email_notifications":true,"appearance":null,"theme_dark":null,"theme_light":null,"theme_light_overrides":null,"theme_dark_overrides":null,"text_direction":"auto","policies":["50c87726-ebc9-4502-9708-10e4a787ab29"]}	{"token":"**********"}	\N	\N
101	116	directus_permissions	4	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_fields","action":"read"}	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_fields","action":"read"}	\N	\N
102	117	directus_permissions	5	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_collections","action":"read"}	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_collections","action":"read"}	\N	\N
103	119	directus_access	50c87726-ebc9-4502-9708-10e4a787ab29	{"id":"50c87726-ebc9-4502-9708-10e4a787ab29","role":null,"user":"5e7d0719-f6fa-4e9b-a681-d24bc8947984","policy":"7b920119-42aa-47ac-a60c-656664a5150d","sort":1}	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d"}	\N	\N
104	121	directus_access	0cd8fc43-4c24-4176-8d1c-c33416370bd5	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","user":{"id":"5e7d0719-f6fa-4e9b-a681-d24bc8947984"}}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","user":{"id":"5e7d0719-f6fa-4e9b-a681-d24bc8947984"}}	\N	\N
105	125	directus_permissions	6	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"page_wholesale","action":"read"}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"page_wholesale","action":"read"}	\N	\N
106	127	directus_permissions	7	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_access","action":"read"}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_access","action":"read"}	\N	\N
107	128	directus_permissions	8	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_activity","action":"read"}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_activity","action":"read"}	\N	\N
108	129	directus_permissions	9	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_collections","action":"read"}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_collections","action":"read"}	\N	\N
109	130	directus_permissions	10	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_comments","action":"read"}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_comments","action":"read"}	\N	\N
110	131	directus_permissions	11	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_dashboards","action":"read"}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_dashboards","action":"read"}	\N	\N
111	132	directus_permissions	12	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_extensions","action":"read"}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_extensions","action":"read"}	\N	\N
112	133	directus_permissions	13	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_fields","action":"read"}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_fields","action":"read"}	\N	\N
113	134	directus_permissions	14	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}	\N	\N
114	135	directus_permissions	15	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_flows","action":"read"}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_flows","action":"read"}	\N	\N
115	136	directus_permissions	16	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_folders","action":"read"}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_folders","action":"read"}	\N	\N
116	137	directus_permissions	17	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_migrations","action":"read"}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_migrations","action":"read"}	\N	\N
117	152	directus_policies	7b920119-42aa-47ac-a60c-656664a5150d	{"id":"7b920119-42aa-47ac-a60c-656664a5150d","name":"read_only","icon":"badge","description":null,"ip_access":null,"enforce_tfa":false,"admin_access":false,"app_access":true,"permissions":[1,2,4,5],"users":["50c87726-ebc9-4502-9708-10e4a787ab29"],"roles":["50c87726-ebc9-4502-9708-10e4a787ab29"]}	{"app_access":true}	\N	\N
118	153	directus_policies	7b920119-42aa-47ac-a60c-656664a5150d	{"id":"7b920119-42aa-47ac-a60c-656664a5150d","name":"read_only","icon":"badge","description":null,"ip_access":null,"enforce_tfa":false,"admin_access":false,"app_access":false,"permissions":[1,2,4,5],"users":["50c87726-ebc9-4502-9708-10e4a787ab29"],"roles":["50c87726-ebc9-4502-9708-10e4a787ab29"]}	{"app_access":false}	\N	\N
119	154	directus_users	d28ea43e-0087-4264-aad7-f52329173439	{"id":"d28ea43e-0087-4264-aad7-f52329173439","first_name":"Admin","last_name":"User","email":"melnikov.works166@gmail.com","password":"**********","location":null,"title":null,"description":null,"tags":null,"avatar":null,"language":null,"tfa_secret":"**********","status":"active","role":"b7c96db7-0bcc-4ff4-8722-a320af6909dd","token":"**********","last_access":"2025-10-28T10:01:33.713Z","last_page":"/users/d28ea43e-0087-4264-aad7-f52329173439","provider":"default","external_identifier":null,"auth_data":null,"email_notifications":true,"appearance":null,"theme_dark":null,"theme_light":null,"theme_light_overrides":null,"theme_dark_overrides":null,"text_direction":"auto","policies":[]}	{"token":"**********"}	\N	\N
120	155	directus_users	d28ea43e-0087-4264-aad7-f52329173439	{"id":"d28ea43e-0087-4264-aad7-f52329173439","first_name":"Admin","last_name":"User","email":"melnikov.works166@gmail.com","password":"**********","location":null,"title":null,"description":null,"tags":null,"avatar":null,"language":null,"tfa_secret":"**********","status":"active","role":"b7c96db7-0bcc-4ff4-8722-a320af6909dd","token":null,"last_access":"2025-10-28T10:01:33.713Z","last_page":"/users/d28ea43e-0087-4264-aad7-f52329173439","provider":"default","external_identifier":null,"auth_data":null,"email_notifications":true,"appearance":null,"theme_dark":null,"theme_light":null,"theme_light_overrides":null,"theme_dark_overrides":null,"text_direction":"auto","policies":[]}	{"token":null}	\N	\N
121	164	directus_fields	18	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"wholesale"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"wholesale"}	\N	\N
122	165	directus_collections	wholesale	{"singleton":true,"collection":"wholesale"}	{"singleton":true,"collection":"wholesale"}	\N	\N
123	166	directus_collections	wholesale	{"collection":"wholesale","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":true,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"pages"}	\N	\N
124	167	directus_collections	seo_settings	{"collection":"seo_settings","icon":"folder","note":"Содержит коллекции, связанные с SEO-настройками страниц","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"SEO настройки"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
125	168	directus_collections	pages	{"collection":"pages","icon":"folder","note":"Содержит коллекции, связанные с контентной частью сайта","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
126	169	directus_collections	wholesale	{"collection":"wholesale","icon":"two_pager","note":null,"display_template":null,"hidden":false,"singleton":true,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"pages","collapse":"open","preview_url":null,"versioning":false}	{"icon":"two_pager"}	\N	\N
127	170	directus_fields	19	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"wholesale_hero"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"wholesale_hero"}	\N	\N
128	171	directus_collections	wholesale_hero	{"singleton":false,"collection":"wholesale_hero"}	{"singleton":false,"collection":"wholesale_hero"}	\N	\N
129	172	directus_fields	20	{"sort":2,"special":["file"],"required":true,"interface":"file-image","options":{},"display":"image","collection":"wholesale_hero","field":"image"}	{"sort":2,"special":["file"],"required":true,"interface":"file-image","options":{},"display":"image","collection":"wholesale_hero","field":"image"}	\N	\N
130	173	directus_fields	21	{"sort":3,"special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","collection":"wholesale_hero","field":"tag"}	{"sort":3,"special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","collection":"wholesale_hero","field":"tag"}	\N	\N
131	174	directus_fields	22	{"sort":4,"special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","collection":"wholesale_hero","field":"title"}	{"sort":4,"special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","collection":"wholesale_hero","field":"title"}	\N	\N
132	175	directus_fields	21	{"id":21,"collection":"wholesale_hero","field":"tag","special":null,"interface":"input","options":{"iconLeft":"tag"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale_hero","field":"tag","options":{"iconLeft":"tag"}}	\N	\N
133	176	directus_fields	23	{"sort":5,"special":null,"interface":"input-multiline","display":"raw","collection":"wholesale_hero","field":"description"}	{"sort":5,"special":null,"interface":"input-multiline","display":"raw","collection":"wholesale_hero","field":"description"}	\N	\N
134	177	directus_collections	wholesale_hero	{"collection":"wholesale_hero","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"wholesale","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"wholesale"}	\N	\N
135	178	directus_collections	seo_settings	{"collection":"seo_settings","icon":"folder","note":"Содержит коллекции, связанные с SEO-настройками страниц","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"SEO настройки"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
136	179	directus_collections	pages	{"collection":"pages","icon":"folder","note":"Содержит коллекции, связанные с контентной частью сайта","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
137	180	directus_collections	wholesale_hero	{"collection":"wholesale_hero","icon":null,"note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"wholesale","collapse":"open","preview_url":null,"versioning":false}	{"hidden":true}	\N	\N
138	181	directus_fields	24	{"sort":2,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{image}}{{title}}","enableSelect":false},"collection":"wholesale","field":"hero"}	{"sort":2,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{image}}{{title}}","enableSelect":false},"collection":"wholesale","field":"hero"}	\N	\N
145	191	directus_fields	25	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"wholesale_advant"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"wholesale_advant"}	\N	\N
146	192	directus_collections	wholesale_advant	{"singleton":false,"collection":"wholesale_advant"}	{"singleton":false,"collection":"wholesale_advant"}	\N	\N
140	183	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	{"hero":{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","tag":"Оптовикам","title":"Всегда свежие цветы для бизнеса","description":"Свежие цветы с нашей собственной фермы в Самарской области. Наши официальные оптовики получают доступ к многоуровневой партнёрской программе, скидки на продукцию, подарки и многое другое"}}	{"hero":{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","tag":"Оптовикам","title":"Всегда свежие цветы для бизнеса","description":"Свежие цветы с нашей собственной фермы в Самарской области. Наши официальные оптовики получают доступ к многоуровневой партнёрской программе, скидки на продукцию, подарки и многое другое"}}	\N	\N
139	182	wholesale_hero	e82cad0e-a2cd-4c50-9dcf-2ccee2d96251	{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","tag":"Оптовикам","title":"Всегда свежие цветы для бизнеса","description":"Свежие цветы с нашей собственной фермы в Самарской области. Наши официальные оптовики получают доступ к многоуровневой партнёрской программе, скидки на продукцию, подарки и многое другое"}	{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","tag":"Оптовикам","title":"Всегда свежие цветы для бизнеса","description":"Свежие цветы с нашей собственной фермы в Самарской области. Наши официальные оптовики получают доступ к многоуровневой партнёрской программе, скидки на продукцию, подарки и многое другое"}	140	\N
141	184	directus_permissions	18	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"wholesale","action":"read"}	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"wholesale","action":"read"}	\N	\N
142	185	directus_permissions	19	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"wholesale_hero","action":"read"}	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"wholesale_hero","action":"read"}	\N	\N
143	187	directus_access	50c87726-ebc9-4502-9708-10e4a787ab29	{"id":"50c87726-ebc9-4502-9708-10e4a787ab29","role":null,"user":"5e7d0719-f6fa-4e9b-a681-d24bc8947984","policy":"7b920119-42aa-47ac-a60c-656664a5150d","sort":1}	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d"}	\N	\N
144	189	directus_permissions	20	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_files","action":"read"}	\N	\N
147	193	directus_fields	26	{"sort":2,"special":["file"],"interface":"file-image","display":"image","collection":"wholesale_advant","field":"image"}	{"sort":2,"special":["file"],"interface":"file-image","display":"image","collection":"wholesale_advant","field":"image"}	\N	\N
148	194	directus_fields	27	{"sort":3,"special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","h2","h3","h4","numlist","bullist","removeformat","customLink","hr","fullscreen","code"]},"display":"raw","collection":"wholesale_advant","field":"content"}	{"sort":3,"special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","h2","h3","h4","numlist","bullist","removeformat","customLink","hr","fullscreen","code"]},"display":"raw","collection":"wholesale_advant","field":"content"}	\N	\N
149	195	directus_collections	wholesale_hero	{"collection":"wholesale_hero","icon":null,"note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"wholesale","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"wholesale"}	\N	\N
150	196	directus_collections	wholesale_advant	{"collection":"wholesale_advant","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"wholesale","collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":"wholesale"}	\N	\N
151	197	directus_collections	seo_settings	{"collection":"seo_settings","icon":"folder","note":"Содержит коллекции, связанные с SEO-настройками страниц","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"SEO настройки"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
152	198	directus_collections	pages	{"collection":"pages","icon":"folder","note":"Содержит коллекции, связанные с контентной частью сайта","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
153	199	directus_collections	wholesale_advant	{"collection":"wholesale_advant","icon":null,"note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"wholesale","collapse":"open","preview_url":null,"versioning":false}	{"hidden":true}	\N	\N
154	200	directus_fields	28	{"sort":3,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{image}}"},"collection":"wholesale","field":"advant"}	{"sort":3,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{image}}"},"collection":"wholesale","field":"advant"}	\N	\N
156	202	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	{"id":"9be4e10a-bc62-4144-afc5-1adc89ebdcd2","hero":"e82cad0e-a2cd-4c50-9dcf-2ccee2d96251","advant":"2f0849a4-651e-440a-8dad-dbec47699b12"}	{"advant":"2f0849a4-651e-440a-8dad-dbec47699b12"}	\N	\N
155	201	wholesale_advant	2f0849a4-651e-440a-8dad-dbec47699b12	{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"            <h2>Для флористов, маркетинговых и свадебных агентств</h2>\\n            <p>Покупая цветы оптом у нас, вы получаете множество преимуществ:</p>\\n            <ul>\\n            <li>\\n            Накопление бонусов: За каждую покупку на сумму от 5000 рублей вы\\n            получаете бонусы, которые можно использовать для получения скидок.\\n            </li>\\n            <li>\\n                                Эксклюзивные скидки: Чем больше вы покупаете, тем выше ваша скидка в\\n                                следующем месяце.\\n                            </li>\\n                            <li>\\n                            Качество от производителя: Все цветы поступают с нашей фермы, что\\n                            гарантирует свежесть и высокое качество.\\n                            </li>\\n                            </ul>"}	{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"            <h2>Для флористов, маркетинговых и свадебных агентств</h2>\\n            <p>Покупая цветы оптом у нас, вы получаете множество преимуществ:</p>\\n            <ul>\\n            <li>\\n            Накопление бонусов: За каждую покупку на сумму от 5000 рублей вы\\n            получаете бонусы, которые можно использовать для получения скидок.\\n            </li>\\n            <li>\\n                                Эксклюзивные скидки: Чем больше вы покупаете, тем выше ваша скидка в\\n                                следующем месяце.\\n                            </li>\\n                            <li>\\n                            Качество от производителя: Все цветы поступают с нашей фермы, что\\n                            гарантирует свежесть и высокое качество.\\n                            </li>\\n                            </ul>"}	156	\N
157	203	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	{"id":"9be4e10a-bc62-4144-afc5-1adc89ebdcd2","hero":"e82cad0e-a2cd-4c50-9dcf-2ccee2d96251","advant":null}	{"advant":null}	\N	\N
158	205	directus_fields	29	{"sort":3,"interface":"list-o2m","special":["o2m"],"options":{"template":"{{image}}{{content}}"},"collection":"wholesale","field":"advant"}	{"sort":3,"interface":"list-o2m","special":["o2m"],"options":{"template":"{{image}}{{content}}"},"collection":"wholesale","field":"advant"}	\N	\N
159	207	directus_fields	30	{"sort":3,"interface":"list-m2m","special":["m2m"],"collection":"wholesale","field":"advant"}	{"sort":3,"interface":"list-m2m","special":["m2m"],"collection":"wholesale","field":"advant"}	\N	\N
160	208	directus_fields	31	{"sort":1,"hidden":true,"field":"id","collection":"wholesale_wholesale_advant"}	{"sort":1,"hidden":true,"field":"id","collection":"wholesale_wholesale_advant"}	\N	\N
161	209	directus_collections	wholesale_wholesale_advant	{"hidden":true,"icon":"import_export","collection":"wholesale_wholesale_advant"}	{"hidden":true,"icon":"import_export","collection":"wholesale_wholesale_advant"}	\N	\N
162	210	directus_fields	32	{"sort":2,"hidden":true,"collection":"wholesale_wholesale_advant","field":"wholesale_id"}	{"sort":2,"hidden":true,"collection":"wholesale_wholesale_advant","field":"wholesale_id"}	\N	\N
163	211	directus_fields	33	{"sort":3,"hidden":true,"collection":"wholesale_wholesale_advant","field":"wholesale_advant_id"}	{"sort":3,"hidden":true,"collection":"wholesale_wholesale_advant","field":"wholesale_advant_id"}	\N	\N
164	212	wholesale_wholesale_advant	1	{"wholesale_id":"9be4e10a-bc62-4144-afc5-1adc89ebdcd2","wholesale_advant_id":{"id":"2f0849a4-651e-440a-8dad-dbec47699b12"}}	{"wholesale_id":"9be4e10a-bc62-4144-afc5-1adc89ebdcd2","wholesale_advant_id":{"id":"2f0849a4-651e-440a-8dad-dbec47699b12"}}	\N	\N
165	214	directus_collections	wholesale_wholesale_advant	{"collection":"wholesale_wholesale_advant","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"wholesale_advant","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"wholesale_advant"}	\N	\N
166	215	directus_collections	seo_settings	{"collection":"seo_settings","icon":"folder","note":"Содержит коллекции, связанные с SEO-настройками страниц","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"SEO настройки"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
167	216	directus_collections	pages	{"collection":"pages","icon":"folder","note":"Содержит коллекции, связанные с контентной частью сайта","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
168	217	directus_fields	30	{"id":30,"collection":"wholesale","field":"advant","special":["m2m"],"interface":"list-m2m","options":null,"display":"related-values","display_options":{"template":"{{wholesale_advant_id.image}}"},"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"advant","display":"related-values","display_options":{"template":"{{wholesale_advant_id.image}}"}}	\N	\N
169	218	directus_fields	30	{"id":30,"collection":"wholesale","field":"advant","special":["m2m"],"interface":"list-m2m","options":{"enableSelect":false},"display":null,"display_options":{"template":"{{wholesale_advant_id.image}}"},"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"advant","options":{"enableSelect":false},"display":null}	\N	\N
170	219	directus_fields	30	{"id":30,"collection":"wholesale","field":"advant","special":["m2m"],"interface":"list-m2m","options":{"enableSelect":false},"display":"related-values","display_options":{"template":"{{wholesale_advant_id.image}}"},"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"advant","display":"related-values"}	\N	\N
171	220	directus_fields	27	{"id":27,"collection":"wholesale_advant","field":"content","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","h2","h3","h4","numlist","bullist","removeformat","customLink","hr","fullscreen","code"]},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale_advant","field":"content","display":"formatted-value"}	\N	\N
173	222	wholesale_wholesale_advant	2	{"wholesale_advant_id":{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"            <h2>Для флористов, маркетинговых и свадебных агентств</h2>\\n            <p>Покупая цветы оптом у нас, вы получаете множество преимуществ:</p>\\n            <ul>\\n            <li>\\n            Накопление бонусов: За каждую покупку на сумму от 5000 рублей вы\\n            получаете бонусы, которые можно использовать для получения скидок.\\n            </li>\\n            <li>\\n                                Эксклюзивные скидки: Чем больше вы покупаете, тем выше ваша скидка в\\n                                следующем месяце.\\n                            </li>\\n                            <li>\\n                            Качество от производителя: Все цветы поступают с нашей фермы, что\\n                            гарантирует свежесть и высокое качество.\\n                            </li>\\n                            </ul>"},"wholesale_id":"9be4e10a-bc62-4144-afc5-1adc89ebdcd2"}	{"wholesale_advant_id":{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"            <h2>Для флористов, маркетинговых и свадебных агентств</h2>\\n            <p>Покупая цветы оптом у нас, вы получаете множество преимуществ:</p>\\n            <ul>\\n            <li>\\n            Накопление бонусов: За каждую покупку на сумму от 5000 рублей вы\\n            получаете бонусы, которые можно использовать для получения скидок.\\n            </li>\\n            <li>\\n                                Эксклюзивные скидки: Чем больше вы покупаете, тем выше ваша скидка в\\n                                следующем месяце.\\n                            </li>\\n                            <li>\\n                            Качество от производителя: Все цветы поступают с нашей фермы, что\\n                            гарантирует свежесть и высокое качество.\\n                            </li>\\n                            </ul>"},"wholesale_id":"9be4e10a-bc62-4144-afc5-1adc89ebdcd2"}	\N	\N
172	221	wholesale_advant	f788e31c-3da1-4501-8704-9567751d89c4	{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"            <h2>Для флористов, маркетинговых и свадебных агентств</h2>\\n            <p>Покупая цветы оптом у нас, вы получаете множество преимуществ:</p>\\n            <ul>\\n            <li>\\n            Накопление бонусов: За каждую покупку на сумму от 5000 рублей вы\\n            получаете бонусы, которые можно использовать для получения скидок.\\n            </li>\\n            <li>\\n                                Эксклюзивные скидки: Чем больше вы покупаете, тем выше ваша скидка в\\n                                следующем месяце.\\n                            </li>\\n                            <li>\\n                            Качество от производителя: Все цветы поступают с нашей фермы, что\\n                            гарантирует свежесть и высокое качество.\\n                            </li>\\n                            </ul>"}	{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"            <h2>Для флористов, маркетинговых и свадебных агентств</h2>\\n            <p>Покупая цветы оптом у нас, вы получаете множество преимуществ:</p>\\n            <ul>\\n            <li>\\n            Накопление бонусов: За каждую покупку на сумму от 5000 рублей вы\\n            получаете бонусы, которые можно использовать для получения скидок.\\n            </li>\\n            <li>\\n                                Эксклюзивные скидки: Чем больше вы покупаете, тем выше ваша скидка в\\n                                следующем месяце.\\n                            </li>\\n                            <li>\\n                            Качество от производителя: Все цветы поступают с нашей фермы, что\\n                            гарантирует свежесть и высокое качество.\\n                            </li>\\n                            </ul>"}	173	\N
175	225	wholesale_wholesale_advant	3	{"wholesale_advant_id":{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"            <h2>Для флористов, маркетинговых и свадебных агентств</h2>\\n            <p>Покупая цветы оптом у нас, вы получаете множество преимуществ:</p>\\n            <ul>\\n            <li>\\n            Накопление бонусов: За каждую покупку на сумму от 5000 рублей вы\\n            получаете бонусы, которые можно использовать для получения скидок.\\n            </li>\\n            <li>\\n                                Эксклюзивные скидки: Чем больше вы покупаете, тем выше ваша скидка в\\n                                следующем месяце.\\n                            </li>\\n                            <li>\\n                            Качество от производителя: Все цветы поступают с нашей фермы, что\\n                            гарантирует свежесть и высокое качество.\\n                            </li>\\n                            </ul>"},"wholesale_id":"9be4e10a-bc62-4144-afc5-1adc89ebdcd2"}	{"wholesale_advant_id":{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"            <h2>Для флористов, маркетинговых и свадебных агентств</h2>\\n            <p>Покупая цветы оптом у нас, вы получаете множество преимуществ:</p>\\n            <ul>\\n            <li>\\n            Накопление бонусов: За каждую покупку на сумму от 5000 рублей вы\\n            получаете бонусы, которые можно использовать для получения скидок.\\n            </li>\\n            <li>\\n                                Эксклюзивные скидки: Чем больше вы покупаете, тем выше ваша скидка в\\n                                следующем месяце.\\n                            </li>\\n                            <li>\\n                            Качество от производителя: Все цветы поступают с нашей фермы, что\\n                            гарантирует свежесть и высокое качество.\\n                            </li>\\n                            </ul>"},"wholesale_id":"9be4e10a-bc62-4144-afc5-1adc89ebdcd2"}	\N	\N
174	224	wholesale_advant	cc7f15af-e83c-437a-88df-79c14ed947e0	{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"            <h2>Для флористов, маркетинговых и свадебных агентств</h2>\\n            <p>Покупая цветы оптом у нас, вы получаете множество преимуществ:</p>\\n            <ul>\\n            <li>\\n            Накопление бонусов: За каждую покупку на сумму от 5000 рублей вы\\n            получаете бонусы, которые можно использовать для получения скидок.\\n            </li>\\n            <li>\\n                                Эксклюзивные скидки: Чем больше вы покупаете, тем выше ваша скидка в\\n                                следующем месяце.\\n                            </li>\\n                            <li>\\n                            Качество от производителя: Все цветы поступают с нашей фермы, что\\n                            гарантирует свежесть и высокое качество.\\n                            </li>\\n                            </ul>"}	{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"            <h2>Для флористов, маркетинговых и свадебных агентств</h2>\\n            <p>Покупая цветы оптом у нас, вы получаете множество преимуществ:</p>\\n            <ul>\\n            <li>\\n            Накопление бонусов: За каждую покупку на сумму от 5000 рублей вы\\n            получаете бонусы, которые можно использовать для получения скидок.\\n            </li>\\n            <li>\\n                                Эксклюзивные скидки: Чем больше вы покупаете, тем выше ваша скидка в\\n                                следующем месяце.\\n                            </li>\\n                            <li>\\n                            Качество от производителя: Все цветы поступают с нашей фермы, что\\n                            гарантирует свежесть и высокое качество.\\n                            </li>\\n                            </ul>"}	175	\N
176	227	directus_permissions	21	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"wholesale_advant","action":"read"}	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"wholesale_advant","action":"read"}	\N	\N
177	228	directus_permissions	22	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"wholesale_wholesale_advant","action":"read"}	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"wholesale_wholesale_advant","action":"read"}	\N	\N
178	230	directus_access	50c87726-ebc9-4502-9708-10e4a787ab29	{"id":"50c87726-ebc9-4502-9708-10e4a787ab29","role":null,"user":"5e7d0719-f6fa-4e9b-a681-d24bc8947984","policy":"7b920119-42aa-47ac-a60c-656664a5150d","sort":1}	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d"}	\N	\N
\.


--
-- Data for Name: directus_roles; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_roles (id, name, icon, description, parent) FROM stdin;
b7c96db7-0bcc-4ff4-8722-a320af6909dd	Administrator	verified	$t:admin_description	\N
\.


--
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_sessions (token, "user", expires, ip, user_agent, share, origin, next_token) FROM stdin;
JMXlxFzhmpGZqQumd286UlM3Mu4I4AepDskYYWseWz7YVWTSIw3J_S2YPl8CS6l0	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:02:54.473+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	\N	http://localhost:8055	j5uAbxOw2a5gFqCEh9IUCgs95dLrUflWwCRvlDrVJIpx2K8-nOnTfNOia1xI6452
j5uAbxOw2a5gFqCEh9IUCgs95dLrUflWwCRvlDrVJIpx2K8-nOnTfNOia1xI6452	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:02:44.473+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	\N	http://localhost:8055	\N
\.


--
-- Data for Name: directus_settings; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_settings (id, project_name, project_url, project_color, project_logo, public_foreground, public_background, public_note, auth_login_attempts, auth_password_policy, storage_asset_transform, storage_asset_presets, custom_css, storage_default_folder, basemaps, mapbox_key, module_bar, project_descriptor, default_language, custom_aspect_ratios, public_favicon, default_appearance, default_theme_light, theme_light_overrides, default_theme_dark, theme_dark_overrides, report_error_url, report_bug_url, report_feature_url, public_registration, public_registration_verify_email, public_registration_role, public_registration_email_filter, visual_editor_urls, accepted_terms, project_id, mcp_enabled, mcp_allow_deletes, mcp_prompts_collection, mcp_system_prompt_enabled, mcp_system_prompt) FROM stdin;
1	Directus	\N	#6644FF	\N	\N	\N	\N	25	\N	all	\N	\N	\N	\N	\N	\N	\N	ru-RU	\N	\N	auto	\N	\N	\N	\N	\N	\N	\N	f	t	\N	\N	\N	t	019a2548-1157-764f-9203-0c2a15838d83	f	f	\N	t	\N
\.


--
-- Data for Name: directus_shares; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_shares (id, name, collection, item, role, password, user_created, date_created, date_start, date_end, times_used, max_uses) FROM stdin;
\.


--
-- Data for Name: directus_translations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_translations (id, language, key, value) FROM stdin;
\.


--
-- Data for Name: directus_users; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_users (id, first_name, last_name, email, password, location, title, description, tags, avatar, language, tfa_secret, status, role, token, last_access, last_page, provider, external_identifier, auth_data, email_notifications, appearance, theme_dark, theme_light, theme_light_overrides, theme_dark_overrides, text_direction) FROM stdin;
5e7d0719-f6fa-4e9b-a681-d24bc8947984	frontend	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	active	\N	JBHIGfwD5GSGJng17iTDvIOV86zpLKLC	\N	\N	default	\N	\N	t	\N	\N	\N	\N	\N	auto
d28ea43e-0087-4264-aad7-f52329173439	Admin	User	melnikov.works166@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$kjp3TNg9+bo3CPu1QsccKA$JVJuzUAKSKma20RrPV2rHT684ExVJoEmLv7ISi0ZgFs	\N	\N	\N	\N	\N	\N	FVEQKZCLNZDSCSCX	active	b7c96db7-0bcc-4ff4-8722-a320af6909dd	\N	2025-10-28 13:02:44.482+00	/users	default	\N	\N	t	\N	\N	\N	\N	\N	auto
\.


--
-- Data for Name: directus_versions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_versions (id, key, name, collection, item, hash, date_created, date_updated, user_created, user_updated, delta) FROM stdin;
\.


--
-- Data for Name: directus_webhooks; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_webhooks (id, name, method, url, status, data, actions, collections, headers, was_active_before_deprecation, migrated_flow) FROM stdin;
\.


--
-- Data for Name: wholesale; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.wholesale (id, hero) FROM stdin;
9be4e10a-bc62-4144-afc5-1adc89ebdcd2	e82cad0e-a2cd-4c50-9dcf-2ccee2d96251
\.


--
-- Data for Name: wholesale_advant; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.wholesale_advant (id, image, content) FROM stdin;
2f0849a4-651e-440a-8dad-dbec47699b12	c49375f7-06d0-47d3-babd-0515605ec99f	            <h2>Для флористов, маркетинговых и свадебных агентств</h2>\n            <p>Покупая цветы оптом у нас, вы получаете множество преимуществ:</p>\n            <ul>\n            <li>\n            Накопление бонусов: За каждую покупку на сумму от 5000 рублей вы\n            получаете бонусы, которые можно использовать для получения скидок.\n            </li>\n            <li>\n                                Эксклюзивные скидки: Чем больше вы покупаете, тем выше ваша скидка в\n                                следующем месяце.\n                            </li>\n                            <li>\n                            Качество от производителя: Все цветы поступают с нашей фермы, что\n                            гарантирует свежесть и высокое качество.\n                            </li>\n                            </ul>
f788e31c-3da1-4501-8704-9567751d89c4	c49375f7-06d0-47d3-babd-0515605ec99f	            <h2>Для флористов, маркетинговых и свадебных агентств</h2>\n            <p>Покупая цветы оптом у нас, вы получаете множество преимуществ:</p>\n            <ul>\n            <li>\n            Накопление бонусов: За каждую покупку на сумму от 5000 рублей вы\n            получаете бонусы, которые можно использовать для получения скидок.\n            </li>\n            <li>\n                                Эксклюзивные скидки: Чем больше вы покупаете, тем выше ваша скидка в\n                                следующем месяце.\n                            </li>\n                            <li>\n                            Качество от производителя: Все цветы поступают с нашей фермы, что\n                            гарантирует свежесть и высокое качество.\n                            </li>\n                            </ul>
cc7f15af-e83c-437a-88df-79c14ed947e0	c49375f7-06d0-47d3-babd-0515605ec99f	            <h2>Для флористов, маркетинговых и свадебных агентств</h2>\n            <p>Покупая цветы оптом у нас, вы получаете множество преимуществ:</p>\n            <ul>\n            <li>\n            Накопление бонусов: За каждую покупку на сумму от 5000 рублей вы\n            получаете бонусы, которые можно использовать для получения скидок.\n            </li>\n            <li>\n                                Эксклюзивные скидки: Чем больше вы покупаете, тем выше ваша скидка в\n                                следующем месяце.\n                            </li>\n                            <li>\n                            Качество от производителя: Все цветы поступают с нашей фермы, что\n                            гарантирует свежесть и высокое качество.\n                            </li>\n                            </ul>
\.


--
-- Data for Name: wholesale_hero; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.wholesale_hero (id, image, tag, title, description) FROM stdin;
e82cad0e-a2cd-4c50-9dcf-2ccee2d96251	c49375f7-06d0-47d3-babd-0515605ec99f	Оптовикам	Всегда свежие цветы для бизнеса	Свежие цветы с нашей собственной фермы в Самарской области. Наши официальные оптовики получают доступ к многоуровневой партнёрской программе, скидки на продукцию, подарки и многое другое
\.


--
-- Data for Name: wholesale_wholesale_advant; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.wholesale_wholesale_advant (id, wholesale_id, wholesale_advant_id) FROM stdin;
1	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	2f0849a4-651e-440a-8dad-dbec47699b12
2	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	f788e31c-3da1-4501-8704-9567751d89c4
3	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	cc7f15af-e83c-437a-88df-79c14ed947e0
\.


--
-- Name: directus_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_activity_id_seq', 231, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 33, true);


--
-- Name: directus_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_notifications_id_seq', 1, false);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 22, true);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 1, false);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 10, true);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 178, true);


--
-- Name: directus_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_settings_id_seq', 1, true);


--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_webhooks_id_seq', 1, false);


--
-- Name: wholesale_wholesale_advant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.wholesale_wholesale_advant_id_seq', 3, true);


--
-- Name: directus_access directus_access_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_pkey PRIMARY KEY (id);


--
-- Name: directus_activity directus_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_activity
    ADD CONSTRAINT directus_activity_pkey PRIMARY KEY (id);


--
-- Name: directus_collections directus_collections_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_pkey PRIMARY KEY (collection);


--
-- Name: directus_comments directus_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_pkey PRIMARY KEY (id);


--
-- Name: directus_dashboards directus_dashboards_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_pkey PRIMARY KEY (id);


--
-- Name: directus_extensions directus_extensions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_extensions
    ADD CONSTRAINT directus_extensions_pkey PRIMARY KEY (id);


--
-- Name: directus_fields directus_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_fields
    ADD CONSTRAINT directus_fields_pkey PRIMARY KEY (id);


--
-- Name: directus_files directus_files_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_pkey PRIMARY KEY (id);


--
-- Name: directus_flows directus_flows_operation_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_operation_unique UNIQUE (operation);


--
-- Name: directus_flows directus_flows_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_pkey PRIMARY KEY (id);


--
-- Name: directus_folders directus_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_pkey PRIMARY KEY (id);


--
-- Name: directus_migrations directus_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_migrations
    ADD CONSTRAINT directus_migrations_pkey PRIMARY KEY (version);


--
-- Name: directus_notifications directus_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_reject_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_unique UNIQUE (reject);


--
-- Name: directus_operations directus_operations_resolve_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_unique UNIQUE (resolve);


--
-- Name: directus_panels directus_panels_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_pkey PRIMARY KEY (id);


--
-- Name: directus_permissions directus_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_pkey PRIMARY KEY (id);


--
-- Name: directus_policies directus_policies_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_policies
    ADD CONSTRAINT directus_policies_pkey PRIMARY KEY (id);


--
-- Name: directus_presets directus_presets_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_pkey PRIMARY KEY (id);


--
-- Name: directus_relations directus_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_relations
    ADD CONSTRAINT directus_relations_pkey PRIMARY KEY (id);


--
-- Name: directus_revisions directus_revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_pkey PRIMARY KEY (id);


--
-- Name: directus_roles directus_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_pkey PRIMARY KEY (id);


--
-- Name: directus_sessions directus_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_pkey PRIMARY KEY (token);


--
-- Name: directus_settings directus_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_pkey PRIMARY KEY (id);


--
-- Name: directus_shares directus_shares_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_pkey PRIMARY KEY (id);


--
-- Name: directus_translations directus_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_translations
    ADD CONSTRAINT directus_translations_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_email_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_email_unique UNIQUE (email);


--
-- Name: directus_users directus_users_external_identifier_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_external_identifier_unique UNIQUE (external_identifier);


--
-- Name: directus_users directus_users_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_token_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_token_unique UNIQUE (token);


--
-- Name: directus_versions directus_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_pkey PRIMARY KEY (id);


--
-- Name: directus_webhooks directus_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_pkey PRIMARY KEY (id);


--
-- Name: wholesale_advant wholesale_advant_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.wholesale_advant
    ADD CONSTRAINT wholesale_advant_pkey PRIMARY KEY (id);


--
-- Name: wholesale_hero wholesale_hero_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.wholesale_hero
    ADD CONSTRAINT wholesale_hero_pkey PRIMARY KEY (id);


--
-- Name: wholesale wholesale_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.wholesale
    ADD CONSTRAINT wholesale_pkey PRIMARY KEY (id);


--
-- Name: wholesale_wholesale_advant wholesale_wholesale_advant_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.wholesale_wholesale_advant
    ADD CONSTRAINT wholesale_wholesale_advant_pkey PRIMARY KEY (id);


--
-- Name: directus_access directus_access_policy_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_policy_foreign FOREIGN KEY (policy) REFERENCES public.directus_policies(id) ON DELETE CASCADE;


--
-- Name: directus_access directus_access_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_access directus_access_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_collections directus_collections_group_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_group_foreign FOREIGN KEY ("group") REFERENCES public.directus_collections(collection);


--
-- Name: directus_comments directus_comments_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_comments directus_comments_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: directus_dashboards directus_dashboards_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_folder_foreign FOREIGN KEY (folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_modified_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_modified_by_foreign FOREIGN KEY (modified_by) REFERENCES public.directus_users(id);


--
-- Name: directus_files directus_files_uploaded_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_uploaded_by_foreign FOREIGN KEY (uploaded_by) REFERENCES public.directus_users(id);


--
-- Name: directus_flows directus_flows_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_folders directus_folders_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_folders(id);


--
-- Name: directus_notifications directus_notifications_recipient_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_recipient_foreign FOREIGN KEY (recipient) REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_notifications directus_notifications_sender_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_sender_foreign FOREIGN KEY (sender) REFERENCES public.directus_users(id);


--
-- Name: directus_operations directus_operations_flow_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_flow_foreign FOREIGN KEY (flow) REFERENCES public.directus_flows(id) ON DELETE CASCADE;


--
-- Name: directus_operations directus_operations_reject_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_foreign FOREIGN KEY (reject) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_resolve_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_foreign FOREIGN KEY (resolve) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_panels directus_panels_dashboard_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_dashboard_foreign FOREIGN KEY (dashboard) REFERENCES public.directus_dashboards(id) ON DELETE CASCADE;


--
-- Name: directus_panels directus_panels_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_permissions directus_permissions_policy_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_policy_foreign FOREIGN KEY (policy) REFERENCES public.directus_policies(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_activity_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_activity_foreign FOREIGN KEY (activity) REFERENCES public.directus_activity(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_revisions(id);


--
-- Name: directus_revisions directus_revisions_version_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_version_foreign FOREIGN KEY (version) REFERENCES public.directus_versions(id) ON DELETE CASCADE;


--
-- Name: directus_roles directus_roles_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_roles(id);


--
-- Name: directus_sessions directus_sessions_share_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_share_foreign FOREIGN KEY (share) REFERENCES public.directus_shares(id) ON DELETE CASCADE;


--
-- Name: directus_sessions directus_sessions_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_settings directus_settings_project_logo_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_project_logo_foreign FOREIGN KEY (project_logo) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_background_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_background_foreign FOREIGN KEY (public_background) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_favicon_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_favicon_foreign FOREIGN KEY (public_favicon) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_foreground_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_foreground_foreign FOREIGN KEY (public_foreground) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_registration_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_registration_role_foreign FOREIGN KEY (public_registration_role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: directus_settings directus_settings_storage_default_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_storage_default_folder_foreign FOREIGN KEY (storage_default_folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_shares directus_shares_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_users directus_users_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: directus_versions directus_versions_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON DELETE CASCADE;


--
-- Name: directus_versions directus_versions_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_versions directus_versions_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: directus_webhooks directus_webhooks_migrated_flow_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_migrated_flow_foreign FOREIGN KEY (migrated_flow) REFERENCES public.directus_flows(id) ON DELETE SET NULL;


--
-- Name: wholesale_advant wholesale_advant_image_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.wholesale_advant
    ADD CONSTRAINT wholesale_advant_image_foreign FOREIGN KEY (image) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: wholesale wholesale_hero_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.wholesale
    ADD CONSTRAINT wholesale_hero_foreign FOREIGN KEY (hero) REFERENCES public.wholesale_hero(id) ON DELETE SET NULL;


--
-- Name: wholesale_hero wholesale_hero_image_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.wholesale_hero
    ADD CONSTRAINT wholesale_hero_image_foreign FOREIGN KEY (image) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: wholesale_wholesale_advant wholesale_wholesale_advant_wholesale_advant_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.wholesale_wholesale_advant
    ADD CONSTRAINT wholesale_wholesale_advant_wholesale_advant_id_foreign FOREIGN KEY (wholesale_advant_id) REFERENCES public.wholesale_advant(id) ON DELETE SET NULL;


--
-- Name: wholesale_wholesale_advant wholesale_wholesale_advant_wholesale_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.wholesale_wholesale_advant
    ADD CONSTRAINT wholesale_wholesale_advant_wholesale_id_foreign FOREIGN KEY (wholesale_id) REFERENCES public.wholesale(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

\unrestrict du6AeJ0mo85iqfTya0vQRpunRlNikwt8qk17eXAkfYhrS0vXOWdhAzy4rW0L9iz

