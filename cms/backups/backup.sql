--
-- PostgreSQL database dump
--

\restrict 2ATln3pCghj4c6AoahbQV753D1KYnwCOLa45W5zM0ReE8bBJUlceXoeHpgTDCOS

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
-- Name: categories; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.categories (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    sort integer,
    available boolean DEFAULT true
);


ALTER TABLE public.categories OWNER TO directus;

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
-- Name: products; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.products (
    id bigint NOT NULL,
    date_created timestamp with time zone,
    date_updated timestamp with time zone,
    available boolean DEFAULT true NOT NULL,
    sort integer,
    title character varying(255) NOT NULL,
    description text,
    size character varying(255),
    price integer NOT NULL,
    discount integer,
    seo_title character varying(255),
    seo_description text,
    seo_keywords text
);


ALTER TABLE public.products OWNER TO directus;

--
-- Name: products_categories; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.products_categories (
    id integer NOT NULL,
    products_id bigint,
    categories_id uuid
);


ALTER TABLE public.products_categories OWNER TO directus;

--
-- Name: products_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.products_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_categories_id_seq OWNER TO directus;

--
-- Name: products_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.products_categories_id_seq OWNED BY public.products_categories.id;


--
-- Name: products_files; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.products_files (
    id integer NOT NULL,
    products_id bigint,
    directus_files_id uuid
);


ALTER TABLE public.products_files OWNER TO directus;

--
-- Name: products_files_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.products_files_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_files_id_seq OWNER TO directus;

--
-- Name: products_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.products_files_id_seq OWNED BY public.products_files.id;


--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO directus;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: products_reason; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.products_reason (
    id integer NOT NULL,
    products_id bigint,
    reason_id uuid
);


ALTER TABLE public.products_reason OWNER TO directus;

--
-- Name: products_reason_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.products_reason_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_reason_id_seq OWNER TO directus;

--
-- Name: products_reason_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.products_reason_id_seq OWNED BY public.products_reason.id;


--
-- Name: products_structure; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.products_structure (
    id integer NOT NULL,
    products_id bigint,
    structure_id uuid
);


ALTER TABLE public.products_structure OWNER TO directus;

--
-- Name: products_structure_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.products_structure_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_structure_id_seq OWNER TO directus;

--
-- Name: products_structure_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.products_structure_id_seq OWNED BY public.products_structure.id;


--
-- Name: products_styles; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.products_styles (
    id integer NOT NULL,
    products_id bigint,
    styles_id uuid
);


ALTER TABLE public.products_styles OWNER TO directus;

--
-- Name: products_styles_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.products_styles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_styles_id_seq OWNER TO directus;

--
-- Name: products_styles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.products_styles_id_seq OWNED BY public.products_styles.id;


--
-- Name: reason; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.reason (
    id uuid NOT NULL,
    name character varying(255) DEFAULT NULL::character varying NOT NULL
);


ALTER TABLE public.reason OWNER TO directus;

--
-- Name: structure; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.structure (
    id uuid NOT NULL,
    name character varying(255) DEFAULT NULL::character varying,
    sort integer
);


ALTER TABLE public.structure OWNER TO directus;

--
-- Name: styles; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.styles (
    id uuid NOT NULL,
    name character varying(255) DEFAULT NULL::character varying NOT NULL
);


ALTER TABLE public.styles OWNER TO directus;

--
-- Name: wholesale; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.wholesale (
    id uuid NOT NULL,
    image uuid,
    tag character varying(255),
    title character varying(255),
    description text,
    faq_title character varying(255),
    faq_description text,
    faq_blocks json,
    banner_image uuid,
    banner_title character varying(255),
    banner_content text
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
-- Name: products id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: products_categories id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.products_categories ALTER COLUMN id SET DEFAULT nextval('public.products_categories_id_seq'::regclass);


--
-- Name: products_files id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.products_files ALTER COLUMN id SET DEFAULT nextval('public.products_files_id_seq'::regclass);


--
-- Name: products_reason id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.products_reason ALTER COLUMN id SET DEFAULT nextval('public.products_reason_id_seq'::regclass);


--
-- Name: products_structure id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.products_structure ALTER COLUMN id SET DEFAULT nextval('public.products_structure_id_seq'::regclass);


--
-- Name: products_styles id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.products_styles ALTER COLUMN id SET DEFAULT nextval('public.products_styles_id_seq'::regclass);


--
-- Name: wholesale_wholesale_advant id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.wholesale_wholesale_advant ALTER COLUMN id SET DEFAULT nextval('public.wholesale_wholesale_advant_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.categories (id, name, sort, available) FROM stdin;
7841a067-65d4-479d-9156-9a13a2977d1e	День матери	1	t
a679dd91-d1c7-43af-aebb-c4d4e7a5dc69	Букет невесты	2	t
1917a463-21c7-4d04-926b-d07259019930	Корзины	9	t
2283bf24-7eba-41b2-9fd2-0facadacbd0a	Декор для дома	5	t
f2112df7-4000-4c51-b9e1-6bc542d831be	Букеты	6	t
6addc28c-47ea-45da-95a7-501f9fa094e6	8 марта	7	t
418fbdf9-519a-466f-aa5d-35e277d0857a	Весенняя коллекция	8	t
0e35dd7f-aa20-4700-b38e-c175cfd6a3b0	14 февраля	3	f
435b14c8-e7e1-4652-bfcb-e33505d51375	Цветы собственного производства	4	f
c33dd427-fc81-4ae0-9216-d151df0b12c0	День знаний	10	t
ba876a60-d0d1-410d-b150-c23729a09b18	Зимняя коллекция	11	t
4fd5c56a-c30c-41ce-9ce8-43d6e0c8756f	Кустовые розы	12	t
d4cee2b2-a9f1-4b77-bbc2-63b260cc28e2	Летняя коллекция	13	t
5867ef07-53ec-4b1d-887d-7bd674e248bd	Монобукеты	14	t
21f9bb16-16c2-4d61-82f1-fd2d6c11d567	Новый год	15	t
0c008a34-fd3f-4ce4-967a-6f45c75ca8e4	Осенняя коллекция	16	t
dcb8248a-781e-429e-8cde-9bb728b6e1b5	Открытки	17	t
b655a38a-10c2-458a-9abf-53cbb749bbe8	Пионы	18	t
429a34dd-6cd9-49da-8efb-f40bc69e786b	Подарки	19	t
e9a2bde1-47fe-4116-a6b6-c23854d55f57	Популярное	20	t
8ac35f92-430d-4ee9-8945-f0ae75f4a7c5	Премиум	21	t
92b40a19-2513-441f-830f-f63c8280728f	Розы	22	t
61dd73b1-655e-4ace-a922-b42741961d7d	Свадебные букеты	23	t
9847eb03-e3bc-42ec-ab47-8966b7380d40	Тюльпаны	24	t
647d44f1-c459-4ee9-b7f4-65c0bd107999	Цветы в коробке	25	t
88601e48-6abc-4303-a9a6-f73465a71478	1 сентября	26	t
e991d516-4de4-4378-aff2-f425417050f2	Эко-букеты	27	t
\.


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
213	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:44:04.213+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	http://localhost:8055
214	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:44:22.98+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_wholesale_advant	http://localhost:8055
215	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:44:23.064+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	seo_settings	http://localhost:8055
216	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:44:23.071+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
217	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:44:53.785+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	30	http://localhost:8055
218	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:45:23.285+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	30	http://localhost:8055
219	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:45:34.489+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	30	http://localhost:8055
220	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:45:49.595+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	27	http://localhost:8055
223	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:47:23.34+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	http://localhost:8055
226	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:47:38.473+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	http://localhost:8055
227	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:47:57.805+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	21	http://localhost:8055
228	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:47:57.809+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	22	http://localhost:8055
229	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:47:57.814+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_policies	7b920119-42aa-47ac-a60c-656664a5150d	http://localhost:8055
230	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:47:57.819+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_access	50c87726-ebc9-4502-9708-10e4a787ab29	http://localhost:8055
231	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-28 13:47:57.826+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_users	5e7d0719-f6fa-4e9b-a681-d24bc8947984	http://localhost:8055
232	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:26:54.589+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	34	http://localhost:8055
233	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:26:54.618+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	35	http://localhost:8055
234	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:26:54.637+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	36	http://localhost:8055
235	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:26:54.654+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products	http://localhost:8055
236	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:27:14.37+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	seo_settings	http://localhost:8055
237	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:27:14.386+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products	http://localhost:8055
238	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:27:14.402+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
239	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:27:18.841+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products	http://localhost:8055
240	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:27:18.851+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	seo_settings	http://localhost:8055
241	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:27:18.859+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
242	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:30:54.492+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products	http://localhost:8055
243	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:33:24.39+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	37	http://localhost:8055
244	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:35:05.311+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	37	http://localhost:8055
245	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:37:49.334+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	38	http://localhost:8055
246	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:37:52.876+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	34	http://localhost:8055
247	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:37:52.896+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	35	http://localhost:8055
248	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:37:52.908+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	36	http://localhost:8055
249	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:37:52.921+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	38	http://localhost:8055
250	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:37:52.932+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	37	http://localhost:8055
251	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:37:56.23+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	38	http://localhost:8055
252	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:37:58.705+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	37	http://localhost:8055
253	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:38:29.387+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	38	http://localhost:8055
254	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:40:10.434+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	38	http://localhost:8055
255	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:41:17.015+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	products	1	http://localhost:8055
256	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:41:24.081+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	products	1	http://localhost:8055
257	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:42:31.093+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	38	http://localhost:8055
258	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:42:39.535+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	products	2	http://localhost:8055
259	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:42:48.001+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	products	2	http://localhost:8055
260	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:43:18.686+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	38	http://localhost:8055
261	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:43:27.061+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	products	3	http://localhost:8055
262	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:43:37.85+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	products	3	http://localhost:8055
263	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:43:56.863+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	38	http://localhost:8055
264	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:44:26.88+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	38	http://localhost:8055
265	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:44:39.418+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	products	4	http://localhost:8055
266	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:44:46.131+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	products	4	http://localhost:8055
267	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:46:32.722+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	39	http://localhost:8055
268	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:47:28.751+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	40	http://localhost:8055
269	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:49:55.399+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	41	http://localhost:8055
270	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:51:54.855+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	42	http://localhost:8055
271	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:53:31.778+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	42	http://localhost:8055
272	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:56:43.123+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	42	http://localhost:8055
273	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:58:02.572+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	42	http://localhost:8055
274	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:58:07.474+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	42	http://localhost:8055
275	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 07:59:31.916+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	products	5	http://localhost:8055
276	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:00:57.4+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	products	5	http://localhost:8055
277	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:02:11.034+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	43	http://localhost:8055
278	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:02:13.725+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	43	http://localhost:8055
279	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:02:34.142+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	43	http://localhost:8055
280	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:03:35.546+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	43	http://localhost:8055
281	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:04:58.66+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	44	http://localhost:8055
282	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:05:29.393+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	products	6	http://localhost:8055
283	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:05:44.519+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	42	http://localhost:8055
284	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:06:07.281+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	products	6	http://localhost:8055
285	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:08:48.648+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	45	http://localhost:8055
286	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:08:48.654+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	styles	http://localhost:8055
287	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:09:01.446+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	46	http://localhost:8055
288	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:09:13.664+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	styles	cce34f44-c758-4353-ab37-17ef50157655	http://localhost:8055
289	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:09:19.663+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	styles	09bdc67b-cc5b-4266-8879-18edbdbbbb5b	http://localhost:8055
290	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:09:25.968+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	styles	73767c67-d3cf-4899-82a7-721b64939fa3	http://localhost:8055
291	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:09:32.406+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	styles	8e5604c8-3d86-48a8-8e94-3ef8a57d72cd	http://localhost:8055
292	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:09:56.92+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	47	http://localhost:8055
293	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:10:24.161+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	47	http://localhost:8055
294	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:17:25.796+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	48	http://localhost:8055
295	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:18:08.484+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	46	http://localhost:8055
296	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:18:26.835+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	48	http://localhost:8055
297	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:19:38.721+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	49	http://localhost:8055
298	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:19:38.8+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	50	http://localhost:8055
299	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:19:38.805+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_style	http://localhost:8055
300	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:19:38.846+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	51	http://localhost:8055
301	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:19:38.922+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	52	http://localhost:8055
302	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:19:38.994+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	53	http://localhost:8055
303	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:20:37.965+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	49	http://localhost:8055
304	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:21:01.176+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	54	http://localhost:8055
305	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:22:16.87+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	54	http://localhost:8055
306	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:23:19.933+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	55	http://localhost:8055
307	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:23:30.863+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	55	http://localhost:8055
308	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:31:43.306+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	56	http://localhost:8055
309	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:32:11.266+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	56	http://localhost:8055
310	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:33:08.682+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	57	http://localhost:8055
311	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:33:35.877+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	57	http://localhost:8055
312	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:35:09.129+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	58	http://localhost:8055
313	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:35:24.833+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	58	http://localhost:8055
314	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:35:38.21+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	styles	08d998f7-4405-4432-a27a-78bdb4af08b0	http://localhost:8055
315	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:35:50.044+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	styles	09bdc67b-cc5b-4266-8879-18edbdbbbb5b	http://localhost:8055
316	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:35:50.045+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	styles	73767c67-d3cf-4899-82a7-721b64939fa3	http://localhost:8055
317	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:35:50.046+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	styles	8e5604c8-3d86-48a8-8e94-3ef8a57d72cd	http://localhost:8055
318	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:35:50.047+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	styles	cce34f44-c758-4353-ab37-17ef50157655	http://localhost:8055
319	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:35:50.048+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	styles	08d998f7-4405-4432-a27a-78bdb4af08b0	http://localhost:8055
320	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:36:29.411+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	59	http://localhost:8055
321	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:37:03.265+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	58	http://localhost:8055
322	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:37:11.677+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	59	http://localhost:8055
323	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:38:05.194+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	60	http://localhost:8055
324	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:38:09.71+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	60	http://localhost:8055
325	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:38:35.222+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	61	http://localhost:8055
326	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:38:35.303+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	62	http://localhost:8055
327	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:38:35.308+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_styles	http://localhost:8055
328	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:38:35.348+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	63	http://localhost:8055
329	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:38:35.407+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	64	http://localhost:8055
330	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:38:44.629+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	styles	08f3242b-c68d-4b30-b9bb-f55f74a69e1b	http://localhost:8055
331	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:38:49.123+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	styles	b81e5e55-b021-41f3-8bc1-9a8aa7c8f2e3	http://localhost:8055
332	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:38:52.701+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	styles	ce78c5ec-3b62-4934-bcc7-70c543b24029	http://localhost:8055
333	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:38:57.677+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	styles	a73e2648-e98e-43c0-8b49-bf883de7d5d4	http://localhost:8055
334	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:39:50.894+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	products_styles	1	http://localhost:8055
335	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:39:50.9+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	products_styles	2	http://localhost:8055
336	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:39:50.904+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	products	7	http://localhost:8055
337	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:40:38.558+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	styles	08f3242b-c68d-4b30-b9bb-f55f74a69e1b	http://localhost:8055
338	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:40:38.559+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	styles	a73e2648-e98e-43c0-8b49-bf883de7d5d4	http://localhost:8055
339	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:40:38.561+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	styles	b81e5e55-b021-41f3-8bc1-9a8aa7c8f2e3	http://localhost:8055
340	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:40:38.562+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	styles	ce78c5ec-3b62-4934-bcc7-70c543b24029	http://localhost:8055
341	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:40:49.5+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	products	7	http://localhost:8055
342	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:41:41.77+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	attrs	http://localhost:8055
343	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:41:49.752+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products	http://localhost:8055
344	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:41:49.758+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	attrs	http://localhost:8055
345	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:41:49.764+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	seo_settings	http://localhost:8055
346	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:41:49.77+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
347	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:41:49.776+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_style	http://localhost:8055
348	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:41:49.78+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_styles	http://localhost:8055
349	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:41:49.786+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	styles	http://localhost:8055
350	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:41:53.834+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	styles	http://localhost:8055
351	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:41:53.835+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products	http://localhost:8055
352	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:41:53.845+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	attrs	http://localhost:8055
353	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:41:53.852+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	seo_settings	http://localhost:8055
354	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:41:53.861+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
355	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:41:53.874+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_style	http://localhost:8055
356	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:41:53.878+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_styles	http://localhost:8055
357	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:42:15.144+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	styles	http://localhost:8055
358	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:44:12.086+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	styles	http://localhost:8055
359	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:45:06.858+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	65	http://localhost:8055
360	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:45:06.862+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	structure	http://localhost:8055
361	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:45:18.504+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	66	http://localhost:8055
362	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:45:30.362+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	66	http://localhost:8055
363	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:45:38.825+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	styles	http://localhost:8055
364	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:45:38.83+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	structure	http://localhost:8055
365	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:45:38.868+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products	http://localhost:8055
366	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:45:38.875+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	attrs	http://localhost:8055
367	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:45:38.88+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	seo_settings	http://localhost:8055
368	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:45:38.885+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
369	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:45:38.89+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_style	http://localhost:8055
370	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:45:38.896+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_styles	http://localhost:8055
371	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:45:49.264+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	structure	http://localhost:8055
372	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:47:34.14+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	structure	http://localhost:8055
373	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:48:18.444+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	44	http://localhost:8055
374	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:48:23.542+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	61	http://localhost:8055
375	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:48:58.814+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	67	http://localhost:8055
376	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:48:58.819+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	reason	http://localhost:8055
377	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:49:40.656+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	68	http://localhost:8055
378	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:50:05.135+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	reason	http://localhost:8055
379	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:50:10.121+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	styles	http://localhost:8055
380	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:50:10.127+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	structure	http://localhost:8055
381	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:50:10.133+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	reason	http://localhost:8055
382	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:50:10.168+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products	http://localhost:8055
383	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:50:10.174+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	attrs	http://localhost:8055
384	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:50:10.181+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	seo_settings	http://localhost:8055
385	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:50:10.186+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
386	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:50:10.191+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_style	http://localhost:8055
387	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:50:10.198+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_styles	http://localhost:8055
388	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:51:03.472+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	69	http://localhost:8055
389	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:51:03.546+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	70	http://localhost:8055
390	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:51:03.549+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_reason	http://localhost:8055
391	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:51:03.586+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	71	http://localhost:8055
392	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:51:03.646+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	72	http://localhost:8055
393	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:51:07.432+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	69	http://localhost:8055
394	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:54:02.249+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	40	http://localhost:8055
395	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:54:57.109+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	61	http://localhost:8055
396	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:55:06.415+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	69	http://localhost:8055
397	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:57:25.116+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	73	http://localhost:8055
398	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:57:35.607+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	34	http://localhost:8055
399	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:57:35.618+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	35	http://localhost:8055
400	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:57:35.626+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	36	http://localhost:8055
401	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:57:35.634+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	38	http://localhost:8055
402	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:57:35.646+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	37	http://localhost:8055
403	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:57:35.657+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	39	http://localhost:8055
404	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:57:35.667+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	73	http://localhost:8055
405	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:57:35.682+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	40	http://localhost:8055
406	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:57:35.691+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	41	http://localhost:8055
407	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:57:35.7+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	61	http://localhost:8055
408	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:57:35.707+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	69	http://localhost:8055
409	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:57:39.201+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	73	http://localhost:8055
410	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 08:59:28.437+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	74	http://localhost:8055
411	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:00:24.984+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	74	http://localhost:8055
412	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:00:59.874+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	74	http://localhost:8055
413	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:01:03.233+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	74	http://localhost:8055
414	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:01:05.565+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	34	http://localhost:8055
415	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:01:05.578+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	35	http://localhost:8055
416	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:01:05.588+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	36	http://localhost:8055
417	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:01:05.597+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	38	http://localhost:8055
418	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:01:05.606+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	37	http://localhost:8055
419	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:01:05.614+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	39	http://localhost:8055
420	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:01:05.623+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	73	http://localhost:8055
421	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:01:05.633+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	74	http://localhost:8055
422	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:01:05.642+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	40	http://localhost:8055
423	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:01:05.652+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	41	http://localhost:8055
424	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:01:05.663+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	61	http://localhost:8055
425	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:01:05.681+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	69	http://localhost:8055
426	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:05:34.498+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	75	http://localhost:8055
427	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:05:34.579+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	76	http://localhost:8055
428	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:05:34.582+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_files	http://localhost:8055
429	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:05:34.623+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	77	http://localhost:8055
430	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:05:34.704+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	78	http://localhost:8055
431	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:05:39.551+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	34	http://localhost:8055
432	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:05:39.56+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	35	http://localhost:8055
433	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:05:39.566+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	36	http://localhost:8055
434	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:05:39.574+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	38	http://localhost:8055
435	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:05:39.583+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	37	http://localhost:8055
436	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:05:39.592+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	39	http://localhost:8055
437	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:05:39.605+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	73	http://localhost:8055
438	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:05:39.615+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	74	http://localhost:8055
439	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:05:39.624+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	40	http://localhost:8055
440	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:05:39.63+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	75	http://localhost:8055
441	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:05:39.639+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	41	http://localhost:8055
442	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:05:39.645+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	61	http://localhost:8055
443	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:05:39.655+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	69	http://localhost:8055
444	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:06:03.792+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	75	http://localhost:8055
445	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:08:14.505+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	79	http://localhost:8055
446	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:08:14.629+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	80	http://localhost:8055
447	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:08:14.635+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_structure	http://localhost:8055
448	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:08:14.703+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	81	http://localhost:8055
449	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:08:14.803+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	82	http://localhost:8055
450	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:11:23.483+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	83	http://localhost:8055
451	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:12:14.719+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	83	http://localhost:8055
452	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:13:22.063+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	84	http://localhost:8055
453	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:13:44.315+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	85	http://localhost:8055
454	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:13:47.328+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	34	http://localhost:8055
455	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:13:47.338+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	35	http://localhost:8055
456	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:13:47.348+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	36	http://localhost:8055
457	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:13:47.363+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	38	http://localhost:8055
458	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:13:47.363+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	85	http://localhost:8055
459	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:13:47.378+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	37	http://localhost:8055
460	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:13:47.391+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	39	http://localhost:8055
461	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:13:47.402+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	73	http://localhost:8055
462	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:13:47.422+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	74	http://localhost:8055
463	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:13:47.433+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	40	http://localhost:8055
464	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:13:47.44+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	75	http://localhost:8055
465	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:13:47.448+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	41	http://localhost:8055
466	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:13:47.457+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	61	http://localhost:8055
467	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:13:47.468+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	69	http://localhost:8055
468	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:13:47.475+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	79	http://localhost:8055
469	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:13:47.484+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	84	http://localhost:8055
470	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:14:14.664+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	86	http://localhost:8055
471	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:14:17.663+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	34	http://localhost:8055
472	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:14:17.681+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	35	http://localhost:8055
473	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:14:17.715+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	85	http://localhost:8055
474	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:14:17.731+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	36	http://localhost:8055
475	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:14:17.75+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	86	http://localhost:8055
476	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:14:17.78+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	38	http://localhost:8055
477	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:14:17.817+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	37	http://localhost:8055
478	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:14:17.858+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	39	http://localhost:8055
479	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:14:17.939+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	73	http://localhost:8055
480	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:14:17.974+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	74	http://localhost:8055
481	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:14:17.992+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	40	http://localhost:8055
482	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:14:18.016+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	75	http://localhost:8055
483	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:14:18.041+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	41	http://localhost:8055
484	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:14:18.084+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	61	http://localhost:8055
485	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:14:18.096+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	69	http://localhost:8055
486	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:14:18.105+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	79	http://localhost:8055
487	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:14:18.113+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	84	http://localhost:8055
488	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:15:21.617+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	87	http://localhost:8055
489	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:15:23.887+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	34	http://localhost:8055
490	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:15:23.895+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	35	http://localhost:8055
491	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:15:23.905+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	36	http://localhost:8055
492	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:15:23.92+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	38	http://localhost:8055
494	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:15:23.939+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	37	http://localhost:8055
496	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:15:23.95+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	39	http://localhost:8055
498	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:15:23.964+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	73	http://localhost:8055
499	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:15:23.975+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	74	http://localhost:8055
500	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:15:23.987+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	40	http://localhost:8055
501	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:15:24.006+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	75	http://localhost:8055
502	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:15:24.024+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	41	http://localhost:8055
503	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:15:24.033+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	61	http://localhost:8055
504	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:15:24.04+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	69	http://localhost:8055
505	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:15:24.048+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	79	http://localhost:8055
506	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:15:24.056+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	84	http://localhost:8055
493	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:15:23.93+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	85	http://localhost:8055
495	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:15:23.943+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	86	http://localhost:8055
497	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:15:23.955+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	87	http://localhost:8055
507	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:17:31.533+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products	http://localhost:8055
508	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:47.149+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	88	http://localhost:8055
509	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:50.594+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	34	http://localhost:8055
510	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:50.6+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	35	http://localhost:8055
511	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:50.609+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	36	http://localhost:8055
512	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:50.615+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	38	http://localhost:8055
513	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:50.628+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	37	http://localhost:8055
514	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:50.635+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	39	http://localhost:8055
515	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:50.643+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	73	http://localhost:8055
516	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:50.65+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	74	http://localhost:8055
517	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:50.657+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	40	http://localhost:8055
518	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:50.663+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	75	http://localhost:8055
519	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:50.671+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	41	http://localhost:8055
520	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:50.678+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	88	http://localhost:8055
521	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:50.686+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	61	http://localhost:8055
522	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:50.694+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	69	http://localhost:8055
523	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:50.702+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	79	http://localhost:8055
524	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:50.71+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	84	http://localhost:8055
525	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:53.356+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	61	http://localhost:8055
526	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:53.359+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	34	http://localhost:8055
527	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:53.374+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	35	http://localhost:8055
528	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:53.383+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	36	http://localhost:8055
529	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:53.396+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	38	http://localhost:8055
530	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:53.42+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	37	http://localhost:8055
531	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:53.431+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	39	http://localhost:8055
532	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:53.44+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	73	http://localhost:8055
533	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:53.447+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	74	http://localhost:8055
534	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:53.454+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	40	http://localhost:8055
535	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:53.461+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	75	http://localhost:8055
536	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:53.468+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	41	http://localhost:8055
537	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:53.475+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	88	http://localhost:8055
538	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:53.483+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	69	http://localhost:8055
539	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:53.49+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	79	http://localhost:8055
540	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:53.498+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	84	http://localhost:8055
541	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:55.208+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	61	http://localhost:8055
542	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:55.208+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	34	http://localhost:8055
543	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:55.218+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	69	http://localhost:8055
544	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:55.219+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	35	http://localhost:8055
545	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:55.23+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	36	http://localhost:8055
546	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:55.238+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	38	http://localhost:8055
547	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:55.25+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	37	http://localhost:8055
548	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:55.27+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	39	http://localhost:8055
549	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:55.28+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	73	http://localhost:8055
550	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:55.288+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	74	http://localhost:8055
551	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:55.296+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	40	http://localhost:8055
552	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:55.303+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	75	http://localhost:8055
553	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:55.312+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	41	http://localhost:8055
554	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:55.32+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	88	http://localhost:8055
555	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:55.329+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	79	http://localhost:8055
556	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:55.336+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	84	http://localhost:8055
557	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:56.799+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	34	http://localhost:8055
558	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:56.799+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	61	http://localhost:8055
559	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:56.81+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	35	http://localhost:8055
560	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:56.813+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	69	http://localhost:8055
561	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:56.818+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	36	http://localhost:8055
562	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:56.821+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	79	http://localhost:8055
563	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:56.827+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	38	http://localhost:8055
564	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:56.834+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	37	http://localhost:8055
565	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:56.844+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	39	http://localhost:8055
566	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:56.851+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	73	http://localhost:8055
567	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:56.871+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	74	http://localhost:8055
568	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:56.879+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	40	http://localhost:8055
569	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:56.886+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	75	http://localhost:8055
570	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:56.893+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	41	http://localhost:8055
571	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:56.899+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	88	http://localhost:8055
572	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:18:56.905+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	84	http://localhost:8055
573	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:20:08.136+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	88	http://localhost:8055
574	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:14.46+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	89	http://localhost:8055
575	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:26.79+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	34	http://localhost:8055
576	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:26.802+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	35	http://localhost:8055
577	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:26.81+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	36	http://localhost:8055
578	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:26.818+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	38	http://localhost:8055
579	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:26.828+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	37	http://localhost:8055
580	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:26.836+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	39	http://localhost:8055
581	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:26.847+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	73	http://localhost:8055
582	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:26.857+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	74	http://localhost:8055
583	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:26.868+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	40	http://localhost:8055
584	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:26.877+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	75	http://localhost:8055
585	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:26.883+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	41	http://localhost:8055
586	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:26.892+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	88	http://localhost:8055
587	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:26.899+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	89	http://localhost:8055
588	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:26.907+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	84	http://localhost:8055
589	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:32.708+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	38	http://localhost:8055
590	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:32.708+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	34	http://localhost:8055
591	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:32.72+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	35	http://localhost:8055
592	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:32.734+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	36	http://localhost:8055
593	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:32.744+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	37	http://localhost:8055
594	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:32.779+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	39	http://localhost:8055
595	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:32.791+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	73	http://localhost:8055
596	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:32.799+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	74	http://localhost:8055
597	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:32.809+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	40	http://localhost:8055
598	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:32.821+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	75	http://localhost:8055
599	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:32.831+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	41	http://localhost:8055
600	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:32.843+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	88	http://localhost:8055
601	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:32.853+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	89	http://localhost:8055
602	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:32.863+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	84	http://localhost:8055
603	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:38.218+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	38	http://localhost:8055
604	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:38.22+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	34	http://localhost:8055
605	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:38.235+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	37	http://localhost:8055
606	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:38.24+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	35	http://localhost:8055
607	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:38.251+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	36	http://localhost:8055
608	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:38.265+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	39	http://localhost:8055
609	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:38.276+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	73	http://localhost:8055
610	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:38.29+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	74	http://localhost:8055
611	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:38.3+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	40	http://localhost:8055
612	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:38.309+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	75	http://localhost:8055
613	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:38.317+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	41	http://localhost:8055
614	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:38.324+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	88	http://localhost:8055
615	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:38.331+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	89	http://localhost:8055
616	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:21:38.34+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	84	http://localhost:8055
617	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:37.402+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	90	http://localhost:8055
618	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:46.347+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	34	http://localhost:8055
619	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:46.359+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	35	http://localhost:8055
620	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:46.367+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	36	http://localhost:8055
621	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:46.374+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	90	http://localhost:8055
622	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:46.383+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	39	http://localhost:8055
623	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:46.391+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	73	http://localhost:8055
624	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:46.399+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	74	http://localhost:8055
625	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:46.405+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	40	http://localhost:8055
626	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:46.414+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	75	http://localhost:8055
627	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:46.42+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	41	http://localhost:8055
628	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:46.43+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	88	http://localhost:8055
629	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:46.441+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	89	http://localhost:8055
630	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:46.451+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	84	http://localhost:8055
631	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:48.506+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	39	http://localhost:8055
632	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:48.506+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	34	http://localhost:8055
633	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:48.532+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	35	http://localhost:8055
634	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:48.551+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	36	http://localhost:8055
635	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:48.573+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	90	http://localhost:8055
636	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:48.583+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	73	http://localhost:8055
637	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:48.593+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	74	http://localhost:8055
638	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:48.602+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	40	http://localhost:8055
639	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:48.608+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	75	http://localhost:8055
640	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:48.614+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	41	http://localhost:8055
641	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:48.621+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	88	http://localhost:8055
642	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:48.628+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	89	http://localhost:8055
643	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:48.635+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	84	http://localhost:8055
644	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:51.127+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	39	http://localhost:8055
645	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:51.127+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	34	http://localhost:8055
646	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:51.14+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	73	http://localhost:8055
647	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:51.142+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	35	http://localhost:8055
648	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:51.158+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	36	http://localhost:8055
649	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:51.172+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	90	http://localhost:8055
650	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:51.19+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	74	http://localhost:8055
651	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:51.201+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	40	http://localhost:8055
652	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:51.21+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	75	http://localhost:8055
653	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:51.218+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	41	http://localhost:8055
654	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:51.226+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	88	http://localhost:8055
655	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:51.233+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	89	http://localhost:8055
656	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:51.241+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	84	http://localhost:8055
657	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:55.316+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	34	http://localhost:8055
658	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:55.317+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	39	http://localhost:8055
659	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:55.329+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	73	http://localhost:8055
660	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:55.331+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	35	http://localhost:8055
661	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:55.34+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	74	http://localhost:8055
671	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:02.116+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	34	http://localhost:8055
673	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:02.126+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	35	http://localhost:8055
675	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:02.139+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	36	http://localhost:8055
677	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:02.153+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	90	http://localhost:8055
678	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:02.161+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	75	http://localhost:8055
679	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:02.174+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	41	http://localhost:8055
680	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:02.185+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	88	http://localhost:8055
681	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:02.207+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	89	http://localhost:8055
682	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:02.224+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	84	http://localhost:8055
683	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:04.168+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	39	http://localhost:8055
685	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:04.178+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	73	http://localhost:8055
687	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:04.196+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	74	http://localhost:8055
689	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:04.208+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	40	http://localhost:8055
691	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:04.221+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	75	http://localhost:8055
662	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:55.341+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	36	http://localhost:8055
663	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:55.35+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	90	http://localhost:8055
664	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:55.361+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	40	http://localhost:8055
665	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:55.376+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	75	http://localhost:8055
666	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:55.396+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	41	http://localhost:8055
667	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:55.411+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	88	http://localhost:8055
668	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:55.42+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	89	http://localhost:8055
669	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:22:55.427+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	84	http://localhost:8055
670	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:02.113+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	39	http://localhost:8055
672	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:02.124+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	73	http://localhost:8055
674	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:02.135+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	74	http://localhost:8055
676	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:02.145+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	40	http://localhost:8055
684	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:04.169+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	34	http://localhost:8055
686	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:04.182+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	35	http://localhost:8055
688	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:04.199+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	36	http://localhost:8055
690	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:04.214+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	90	http://localhost:8055
692	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:04.228+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	41	http://localhost:8055
693	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:04.24+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	88	http://localhost:8055
694	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:04.255+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	89	http://localhost:8055
695	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:04.266+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	84	http://localhost:8055
696	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:06.22+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	39	http://localhost:8055
697	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:06.223+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	34	http://localhost:8055
698	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:06.234+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	73	http://localhost:8055
699	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:06.234+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	35	http://localhost:8055
700	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:06.248+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	74	http://localhost:8055
701	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:06.25+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	36	http://localhost:8055
702	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:06.261+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	40	http://localhost:8055
703	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:06.262+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	90	http://localhost:8055
704	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:06.277+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	75	http://localhost:8055
705	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:06.279+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	88	http://localhost:8055
707	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:06.288+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	89	http://localhost:8055
708	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:06.298+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	84	http://localhost:8055
709	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:08.985+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	39	http://localhost:8055
710	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:08.993+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	73	http://localhost:8055
711	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:09.002+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	74	http://localhost:8055
712	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:09.012+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	40	http://localhost:8055
713	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:09.021+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	41	http://localhost:8055
714	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:09.03+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	75	http://localhost:8055
706	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:06.286+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	41	http://localhost:8055
715	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:23:58.858+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	88	http://localhost:8055
716	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:24:05.846+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	89	http://localhost:8055
717	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:25:10.428+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	46	http://localhost:8055
718	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:25:41.366+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	66	http://localhost:8055
719	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:25:57.991+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	68	http://localhost:8055
720	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:28:33.258+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	reason	e28a40e5-9360-41b1-85ff-60766ea4a980	http://localhost:8055
721	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:28:55.582+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	reason	a923bcc4-931a-4709-bade-317c342fedf1	http://localhost:8055
722	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:29:09.483+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	reason	bc74959a-ef74-4834-866f-c62b9e6fd322	http://localhost:8055
723	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:29:16.984+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	reason	097fb6db-20ea-47d8-a585-342b1bfd11eb	http://localhost:8055
724	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:29:24.442+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	reason	1cfd6194-2a22-4624-9113-920dde9b8cbb	http://localhost:8055
725	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:29:36.19+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	reason	49c8687b-daf7-432a-ba7b-ed8328f3844f	http://localhost:8055
726	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:29:44.137+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	reason	6371556d-6178-4fd7-891d-259db73c76bc	http://localhost:8055
727	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:29:49.787+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	reason	b9350ae7-2ec4-429a-95d8-0178f036fc53	http://localhost:8055
728	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:29:56.521+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	reason	26a1af3b-7771-435d-a34c-f8dcd3606257	http://localhost:8055
729	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:30:03.646+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	reason	b859a8d7-dffb-4f76-bd96-ee254285ecce	http://localhost:8055
730	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:31:50.344+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	61	http://localhost:8055
731	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:32:02.784+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	69	http://localhost:8055
732	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:32:14.194+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	79	http://localhost:8055
733	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:33:40.873+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	66	http://localhost:8055
734	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:33:46.802+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	23e7926b-f2a1-4068-908c-6bb690233bc8	http://localhost:8055
735	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:33:52.824+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	516f6fd3-32fa-45e5-bb80-0aaefe47cb3f	http://localhost:8055
736	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:33:57.867+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	9a7268c1-6b81-4c93-9beb-2af9e8ee1148	http://localhost:8055
737	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:34:03.882+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	6c0d5a40-2f0a-43a8-9e37-f67c547b0c10	http://localhost:8055
738	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:34:23.302+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	bf7a62bb-143d-45b2-9b66-6a819f552439	http://localhost:8055
739	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:34:31.888+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	560ca460-cbc0-45fd-8480-5ea0f9d2db10	http://localhost:8055
740	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:34:38.673+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	560ca460-cbc0-45fd-8480-5ea0f9d2db10	http://localhost:8055
741	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:35:30.643+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	d3c2e4e1-0ac1-4f31-88ca-7854ac907cd9	http://localhost:8055
742	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:35:36.524+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	caab1f2d-2b8c-4433-83da-0bb00e5dbad4	http://localhost:8055
743	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:35:43.338+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	ef0c0577-64cf-422b-be6d-c609d5864a5e	http://localhost:8055
744	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:35:48.587+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	7a983be4-4016-4d99-8943-8e308f75ee9a	http://localhost:8055
745	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:35:53.584+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	73d6b923-98d6-4438-a9d4-9281d3870534	http://localhost:8055
746	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:35:57.479+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	1e621a84-e48c-45a3-916b-0737cda0095d	http://localhost:8055
747	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:36:01.512+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	807524d5-6d38-4d71-b54d-e78848a1a3b3	http://localhost:8055
748	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:36:05.585+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	6c806a81-0850-416a-8bbc-03b3f5c81773	http://localhost:8055
749	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:36:10.5+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	58ab621c-5a51-4ddb-b2e9-95d0b5ec884c	http://localhost:8055
750	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:36:14.923+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	14c95af4-698a-43c0-995a-9103eb34f406	http://localhost:8055
751	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:36:19.563+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	48d9020f-3f1c-4537-b8fa-ce7c9d8b8a4f	http://localhost:8055
752	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:36:24.886+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	89e9466c-e2b4-4110-ab4c-7566086a7769	http://localhost:8055
753	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:36:28.767+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	9506efda-91ac-4a62-a882-b71ee65f3e44	http://localhost:8055
754	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:36:32.214+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	92a43dc2-c2f5-454a-9439-60e4c0592f88	http://localhost:8055
755	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:36:35.918+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	36b76a3f-b020-4410-8f05-dbb0878fe98d	http://localhost:8055
756	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:36:40.56+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	40aa380b-4cb5-4c03-aad4-d9f26ccf6e8c	http://localhost:8055
757	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:36:43.903+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	973917e8-a8d3-427d-a1a5-bd03d7d23dda	http://localhost:8055
758	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:36:48.011+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	6edf1b21-221b-4326-97ff-0a83ebb5c515	http://localhost:8055
759	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:36:52.46+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	1c1b6933-84db-4547-9154-b3df828ee978	http://localhost:8055
760	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:36:55.968+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	72c19c46-5eba-4c2c-bd06-5b3e0afa059b	http://localhost:8055
761	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:37:00.061+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	74267c8e-6ddd-429a-bc74-c113517c73ff	http://localhost:8055
762	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:37:03.535+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	ca7af4ff-3ba5-404d-aab5-3fe132776edc	http://localhost:8055
763	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:37:06.905+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	d1d6be9d-ee52-471d-b599-30c7d83490cb	http://localhost:8055
764	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:37:11.685+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	fcd43968-5e80-4c3e-83df-7572f5abc6ac	http://localhost:8055
765	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:37:14.683+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	bebc96d9-1e70-4f51-abc4-a3898595f7d6	http://localhost:8055
766	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:37:18.459+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	1bf665f4-4a56-412d-a7e9-2fabc037b3ea	http://localhost:8055
767	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:37:21.517+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	2f0308a5-49f9-4bba-bb00-c0768cb131e2	http://localhost:8055
768	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:37:26.443+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	798d8553-02f6-4b1a-b1ef-b0b040049afc	http://localhost:8055
769	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:37:29.84+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	5a5f6a68-21db-4206-b28d-1e5b306a8e04	http://localhost:8055
770	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:37:33.993+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	513d8e30-8a1c-457d-a9ac-dc80c0060d5d	http://localhost:8055
771	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:37:39.388+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	2e7828b8-606a-4ba1-95ab-7318df95ebc3	http://localhost:8055
772	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:37:43.207+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	b369ba1d-ca4f-489a-ade9-17f88029d71e	http://localhost:8055
773	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:37:47.128+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	af6537ef-e504-4f18-8b70-59669339c5d6	http://localhost:8055
774	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:37:51.424+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	af13f74f-e163-4d06-a031-e64d8abfd766	http://localhost:8055
775	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:37:55.071+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	1c47e146-d72e-4034-8aa9-11faabcba8e7	http://localhost:8055
776	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:37:58.452+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	5849a7b0-af52-42e6-b4a4-61e818497a87	http://localhost:8055
777	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:38:02.003+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	dfdefbbe-cd79-40f6-9096-076c050f7a19	http://localhost:8055
778	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:38:05.105+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	cb040715-c359-48c8-bb07-83f20a8f26ef	http://localhost:8055
779	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:38:08.838+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	b7d2e8bc-3ed8-4ee8-bf87-a12f28de63fd	http://localhost:8055
780	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:38:12.835+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	40df7fb3-d5bf-40fe-935c-a4487bb675be	http://localhost:8055
781	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:38:15.815+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	a7ab3255-eb33-463f-aaa2-adb8c37b3356	http://localhost:8055
782	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:38:19.702+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	99d724cd-dd9c-4b39-80c4-3e08585086f4	http://localhost:8055
783	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:38:22.981+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	c821b4e3-af39-4fc5-9739-f3a3c5847ef7	http://localhost:8055
784	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:38:26.225+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	625b0b22-02b5-4356-9165-1fa5cc611179	http://localhost:8055
785	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:38:29.96+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	8ba2d15b-1fdf-4101-8213-c021025349e3	http://localhost:8055
786	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:38:33.591+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	a36a3250-3b78-45f0-a232-c295959ce15d	http://localhost:8055
787	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:38:37.386+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	9c4cd5ce-f2d5-42a2-a0b5-9fa35abdbd04	http://localhost:8055
788	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:38:40.448+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	fe1d63b9-d0d1-4d72-b74d-faa3d0886cea	http://localhost:8055
789	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:38:44.058+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	f5daed79-87af-4d4e-8cb5-5ef17dc1c204	http://localhost:8055
790	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:38:47.681+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	f119a603-67c6-4478-8c67-9101bab7cda9	http://localhost:8055
791	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:38:51.241+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	50b586b8-025a-44ec-a397-ce1e46373686	http://localhost:8055
792	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:38:54.278+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	22c486a9-ecf5-4432-837e-cff833b00590	http://localhost:8055
793	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:38:57.875+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	structure	4101b4ca-dab3-4809-913b-56ba9d6d70b7	http://localhost:8055
794	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:44:51.136+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_style	http://localhost:8055
795	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:44:51.144+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	50	http://localhost:8055
796	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:44:51.146+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	51	http://localhost:8055
797	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:44:51.148+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	52	http://localhost:8055
798	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:44:51.15+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	53	http://localhost:8055
799	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:47:14.418+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	91	http://localhost:8055
800	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:47:14.422+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	categories	http://localhost:8055
801	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:47:54.09+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	92	http://localhost:8055
802	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:48:32.627+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	categories	http://localhost:8055
803	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:48:43.149+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	styles	http://localhost:8055
804	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:48:43.155+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	structure	http://localhost:8055
805	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:48:43.16+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	reason	http://localhost:8055
806	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:48:43.167+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	categories	http://localhost:8055
807	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:48:43.205+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products	http://localhost:8055
808	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:48:43.21+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	attrs	http://localhost:8055
809	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:48:43.218+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	seo_settings	http://localhost:8055
810	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:48:43.224+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
811	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:48:43.229+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_styles	http://localhost:8055
812	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:48:43.235+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_files	http://localhost:8055
813	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:48:43.241+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_reason	http://localhost:8055
814	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 09:48:43.248+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_structure	http://localhost:8055
815	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:03:21.107+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products	http://localhost:8055
816	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:03:21.107+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_styles	http://localhost:8055
817	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:03:21.117+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	attrs	http://localhost:8055
818	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:03:21.126+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	seo_settings	http://localhost:8055
819	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:03:21.14+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
820	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:03:21.159+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_files	http://localhost:8055
821	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:03:21.172+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_reason	http://localhost:8055
822	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:03:21.178+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_structure	http://localhost:8055
824	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:03:23.24+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_files	http://localhost:8055
826	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:03:23.25+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_styles	http://localhost:8055
832	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:03:29.847+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products	http://localhost:8055
834	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:03:29.856+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	attrs	http://localhost:8055
836	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:03:29.865+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	seo_settings	http://localhost:8055
837	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:03:29.871+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
838	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:03:29.876+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_structure	http://localhost:8055
839	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:03:33.308+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_files	http://localhost:8055
841	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:03:33.316+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_styles	http://localhost:8055
843	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:03:33.325+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_reason	http://localhost:8055
845	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:03:33.332+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_structure	http://localhost:8055
823	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:03:23.24+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products	http://localhost:8055
825	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:03:23.247+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	attrs	http://localhost:8055
827	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:03:23.255+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	seo_settings	http://localhost:8055
828	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:03:23.264+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
829	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:03:23.27+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_reason	http://localhost:8055
830	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:03:23.278+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_structure	http://localhost:8055
831	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:03:29.846+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_files	http://localhost:8055
833	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:03:29.856+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_styles	http://localhost:8055
835	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:03:29.863+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_reason	http://localhost:8055
840	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:03:33.309+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products	http://localhost:8055
842	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:03:33.317+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	attrs	http://localhost:8055
844	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:03:33.326+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	seo_settings	http://localhost:8055
846	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:03:33.337+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
847	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:04:24.289+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	categories	b7c7b6cb-bf68-4852-ba8a-032b41a4c97d	http://localhost:8055
848	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:04:33.327+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	categories	b7c7b6cb-bf68-4852-ba8a-032b41a4c97d	http://localhost:8055
849	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:04:50.809+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	categories	88601e48-6abc-4303-a9a6-f73465a71478	http://localhost:8055
850	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:04:57.163+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	categories	0e35dd7f-aa20-4700-b38e-c175cfd6a3b0	http://localhost:8055
851	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:05:01.96+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	categories	6addc28c-47ea-45da-95a7-501f9fa094e6	http://localhost:8055
852	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:05:36.725+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	categories	a679dd91-d1c7-43af-aebb-c4d4e7a5dc69	http://localhost:8055
853	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:05:40.709+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	categories	f2112df7-4000-4c51-b9e1-6bc542d831be	http://localhost:8055
854	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:05:46.954+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	categories	418fbdf9-519a-466f-aa5d-35e277d0857a	http://localhost:8055
855	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:05:52.138+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	categories	2283bf24-7eba-41b2-9fd2-0facadacbd0a	http://localhost:8055
856	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:05:58.14+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	categories	c33dd427-fc81-4ae0-9216-d151df0b12c0	http://localhost:8055
857	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:06:02.743+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	categories	7841a067-65d4-479d-9156-9a13a2977d1e	http://localhost:8055
858	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:06:06.819+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	categories	ba876a60-d0d1-410d-b150-c23729a09b18	http://localhost:8055
859	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:08:09.644+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	93	http://localhost:8055
860	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:08:16.913+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	91	http://localhost:8055
861	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:08:16.923+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	93	http://localhost:8055
862	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:08:16.931+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	92	http://localhost:8055
900	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:17:06.192+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	34	http://localhost:8055
902	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:17:06.204+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	35	http://localhost:8055
904	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:17:06.214+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	36	http://localhost:8055
906	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:17:06.224+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	90	http://localhost:8055
907	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:17:06.235+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	88	http://localhost:8055
908	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:17:06.246+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	89	http://localhost:8055
909	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:17:06.255+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	84	http://localhost:8055
863	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:09:02.921+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	categories	1917a463-21c7-4d04-926b-d07259019930	http://localhost:8055
864	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:09:08.924+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	categories	4fd5c56a-c30c-41ce-9ce8-43d6e0c8756f	http://localhost:8055
865	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:09:13.302+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	categories	d4cee2b2-a9f1-4b77-bbc2-63b260cc28e2	http://localhost:8055
866	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:09:19.456+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	categories	5867ef07-53ec-4b1d-887d-7bd674e248bd	http://localhost:8055
867	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:09:23.012+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	categories	21f9bb16-16c2-4d61-82f1-fd2d6c11d567	http://localhost:8055
868	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:09:27.345+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	categories	0c008a34-fd3f-4ce4-967a-6f45c75ca8e4	http://localhost:8055
869	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:09:45.527+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	categories	dcb8248a-781e-429e-8cde-9bb728b6e1b5	http://localhost:8055
870	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:09:49.485+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	categories	b655a38a-10c2-458a-9abf-53cbb749bbe8	http://localhost:8055
871	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:09:54.664+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	categories	429a34dd-6cd9-49da-8efb-f40bc69e786b	http://localhost:8055
872	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:10:00.056+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	categories	e9a2bde1-47fe-4116-a6b6-c23854d55f57	http://localhost:8055
873	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:10:03.834+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	categories	8ac35f92-430d-4ee9-8945-f0ae75f4a7c5	http://localhost:8055
874	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:10:08.112+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	categories	92b40a19-2513-441f-830f-f63c8280728f	http://localhost:8055
875	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:10:11.888+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	categories	61dd73b1-655e-4ace-a922-b42741961d7d	http://localhost:8055
876	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:10:20.701+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	categories	9847eb03-e3bc-42ec-ab47-8966b7380d40	http://localhost:8055
877	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:10:27.141+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	categories	647d44f1-c459-4ee9-b7f4-65c0bd107999	http://localhost:8055
878	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:10:31.983+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	categories	435b14c8-e7e1-4652-bfcb-e33505d51375	http://localhost:8055
879	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:10:36.537+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	categories	e991d516-4de4-4378-aff2-f425417050f2	http://localhost:8055
880	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:10:56.346+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	categories	http://localhost:8055
881	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:10:56.356+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	styles	http://localhost:8055
882	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:10:56.361+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	structure	http://localhost:8055
883	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:10:56.367+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	reason	http://localhost:8055
884	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:12:37.565+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	94	http://localhost:8055
885	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:12:47.355+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	91	http://localhost:8055
886	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:12:47.363+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	92	http://localhost:8055
887	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:12:47.373+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	93	http://localhost:8055
888	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:12:47.38+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	94	http://localhost:8055
889	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:12:51.264+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	93	http://localhost:8055
890	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:12:53.721+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	94	http://localhost:8055
891	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:13:28.218+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	categories	0e35dd7f-aa20-4700-b38e-c175cfd6a3b0	http://localhost:8055
892	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:15:32.701+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	79	http://localhost:8055
893	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:16:58.605+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	95	http://localhost:8055
894	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:16:58.699+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	96	http://localhost:8055
895	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:16:58.703+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_categories	http://localhost:8055
896	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:16:58.736+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	97	http://localhost:8055
897	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:16:58.848+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	98	http://localhost:8055
898	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:17:03.311+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	95	http://localhost:8055
899	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:17:06.191+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	61	http://localhost:8055
901	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:17:06.201+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	69	http://localhost:8055
903	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:17:06.212+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	79	http://localhost:8055
905	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:17:06.222+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	95	http://localhost:8055
910	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:17:37.739+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	categories	http://localhost:8055
911	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:20:21.788+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	categories	435b14c8-e7e1-4652-bfcb-e33505d51375	http://localhost:8055
912	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:20:49.531+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	categories	88601e48-6abc-4303-a9a6-f73465a71478	http://localhost:8055
913	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:22:25.551+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	categories	1917a463-21c7-4d04-926b-d07259019930	http://localhost:8055
914	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:22:47.017+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	categories	http://localhost:8055
915	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:23:58.904+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	categories	0e35dd7f-aa20-4700-b38e-c175cfd6a3b0	http://localhost:8055
916	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:25:12.091+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	93	http://localhost:8055
917	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:25:15.269+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	94	http://localhost:8055
918	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:25:17.626+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	93	http://localhost:8055
919	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:25:19.158+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	91	http://localhost:8055
920	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:25:19.167+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	93	http://localhost:8055
921	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:25:19.174+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	92	http://localhost:8055
922	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:25:19.18+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	94	http://localhost:8055
923	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:26:25.975+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	38	http://localhost:8055
924	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:26:29.042+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	37	http://localhost:8055
925	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:26:35.881+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	38	http://localhost:8055
930	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:28:32.422+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	structure	http://localhost:8055
926	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:28:20.158+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	99	http://localhost:8055
927	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:28:22.364+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	65	http://localhost:8055
928	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:28:22.372+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	99	http://localhost:8055
929	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 10:28:22.378+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	66	http://localhost:8055
931	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 11:11:22.644+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	23	http://localhost:8055
932	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 11:11:22.65+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	24	http://localhost:8055
933	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 11:11:22.654+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	25	http://localhost:8055
934	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 11:11:22.657+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	26	http://localhost:8055
935	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 11:11:22.661+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	27	http://localhost:8055
936	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 11:11:22.664+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	28	http://localhost:8055
937	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 11:11:22.667+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	29	http://localhost:8055
938	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 11:11:22.671+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	30	http://localhost:8055
939	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 11:11:22.674+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	31	http://localhost:8055
940	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 11:11:22.677+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	32	http://localhost:8055
941	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 11:11:22.682+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_policies	7b920119-42aa-47ac-a60c-656664a5150d	http://localhost:8055
942	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 11:11:22.689+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_access	50c87726-ebc9-4502-9708-10e4a787ab29	http://localhost:8055
943	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 11:11:22.699+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_users	5e7d0719-f6fa-4e9b-a681-d24bc8947984	http://localhost:8055
944	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 11:57:34.825+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_files	http://localhost:8055
945	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 11:57:34.836+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_styles	http://localhost:8055
946	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 11:57:34.841+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_reason	http://localhost:8055
947	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 11:57:34.846+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_structure	http://localhost:8055
948	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 11:57:34.853+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products_categories	http://localhost:8055
949	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 11:57:34.898+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products	http://localhost:8055
950	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 11:57:34.906+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	attrs	http://localhost:8055
951	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 11:57:34.911+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	seo_settings	http://localhost:8055
952	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 11:57:34.918+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
953	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 11:59:00.432+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	30	http://localhost:8055
954	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 11:59:33.094+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	30	http://localhost:8055
955	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 11:59:54.775+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_advant	http://localhost:8055
956	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:00:06.109+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_advant	http://localhost:8055
957	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:43:26.231+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	24	http://localhost:8055
958	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:43:29.421+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	30	http://localhost:8055
959	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:43:34.694+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_hero	http://localhost:8055
960	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:43:34.699+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	19	http://localhost:8055
961	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:43:34.701+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	20	http://localhost:8055
962	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:43:34.703+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	21	http://localhost:8055
963	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:43:34.705+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	22	http://localhost:8055
964	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:43:34.706+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	23	http://localhost:8055
965	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:43:41.099+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	33	http://localhost:8055
966	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:43:41.17+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_advant	http://localhost:8055
967	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:43:41.173+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	25	http://localhost:8055
968	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:43:41.174+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	26	http://localhost:8055
969	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:43:41.175+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	27	http://localhost:8055
970	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:44:17.566+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	100	http://localhost:8055
971	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:45:25.475+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	101	http://localhost:8055
972	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:45:56.992+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	102	http://localhost:8055
973	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:46:53.865+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	103	http://localhost:8055
974	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:47:40.029+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	103	http://localhost:8055
975	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:48:15.634+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	104	http://localhost:8055
976	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:48:59.863+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	http://localhost:8055
977	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:53:32.707+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_wholesale_advant	http://localhost:8055
978	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:53:32.711+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	31	http://localhost:8055
979	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:53:32.712+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	32	http://localhost:8055
980	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:54:29.433+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	105	http://localhost:8055
981	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:54:32.699+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	18	http://localhost:8055
982	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:54:32.708+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	101	http://localhost:8055
983	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:54:32.717+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	102	http://localhost:8055
984	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:54:32.731+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	104	http://localhost:8055
985	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:54:32.734+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	100	http://localhost:8055
986	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:54:32.752+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	105	http://localhost:8055
987	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:54:36.728+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	100	http://localhost:8055
988	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:54:36.728+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	18	http://localhost:8055
989	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:54:36.743+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	102	http://localhost:8055
990	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:54:36.744+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	101	http://localhost:8055
991	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:54:36.756+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	104	http://localhost:8055
992	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:54:36.776+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	105	http://localhost:8055
993	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:54:38.781+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	100	http://localhost:8055
994	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:54:38.782+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	18	http://localhost:8055
995	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:54:38.795+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	101	http://localhost:8055
996	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:54:38.796+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	104	http://localhost:8055
997	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:54:38.809+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	102	http://localhost:8055
998	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:54:38.814+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	105	http://localhost:8055
999	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:54:40.572+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	18	http://localhost:8055
1000	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:54:40.573+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	100	http://localhost:8055
1001	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:54:40.583+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	105	http://localhost:8055
1002	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:54:40.589+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	101	http://localhost:8055
1003	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:54:40.601+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	102	http://localhost:8055
1004	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:54:40.611+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	104	http://localhost:8055
1005	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:55:50.468+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	106	http://localhost:8055
1006	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:04:15.233+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	106	http://localhost:8055
1007	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:05:18.433+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	107	http://localhost:8055
1008	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:05:18.437+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_advant	http://localhost:8055
1009	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:05:53.839+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	108	http://localhost:8055
1010	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:07:19.41+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	109	http://localhost:8055
1011	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:07:29.539+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_advant	http://localhost:8055
1012	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:07:29.621+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products	http://localhost:8055
1013	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:07:29.627+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	attrs	http://localhost:8055
1014	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:07:29.632+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	seo_settings	http://localhost:8055
1015	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:07:29.64+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
1016	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:07:31.543+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_advant	http://localhost:8055
1017	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:08:35.699+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	110	http://localhost:8055
1018	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:08:35.778+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	111	http://localhost:8055
1019	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:08:35.783+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_wholesale_advant	http://localhost:8055
1020	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:08:35.819+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	112	http://localhost:8055
1021	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:08:35.882+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	113	http://localhost:8055
1022	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:09:02.775+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_wholesale_advant	http://localhost:8055
1023	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:09:02.852+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products	http://localhost:8055
1024	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:09:02.857+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	attrs	http://localhost:8055
1025	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:09:02.862+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	seo_settings	http://localhost:8055
1026	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:09:02.868+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
1027	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:09:32.013+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	110	http://localhost:8055
1028	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:10:30.266+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	114	http://localhost:8055
1029	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:10:30.337+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	115	http://localhost:8055
1030	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:10:30.34+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_wholesale_advant_1	http://localhost:8055
1031	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:10:30.375+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	116	http://localhost:8055
1032	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:10:30.458+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	117	http://localhost:8055
1033	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:10:53.317+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_advant	c11cc4c8-57d9-46fb-93d2-fa19a48302b8	http://localhost:8055
1035	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:10:53.326+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	http://localhost:8055
1036	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:11:14.083+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_wholesale_advant	http://localhost:8055
1037	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:11:14.085+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	111	http://localhost:8055
1038	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:11:14.087+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	112	http://localhost:8055
1039	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:11:14.088+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	113	http://localhost:8055
1040	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:11:39.8+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_wholesale_advant_1	http://localhost:8055
1041	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:11:39.803+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	115	http://localhost:8055
1042	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:11:39.804+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	116	http://localhost:8055
1043	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:11:39.805+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	117	http://localhost:8055
1044	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:11:39.82+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	114	http://localhost:8055
1045	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:12:41.177+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	118	http://localhost:8055
1046	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:13:17.753+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	119	http://localhost:8055
1047	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:13:17.824+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	120	http://localhost:8055
1048	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:13:17.828+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_wholesale_advant	http://localhost:8055
1049	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:13:17.867+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	121	http://localhost:8055
1050	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:13:17.927+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	122	http://localhost:8055
1051	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:13:21.293+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	18	http://localhost:8055
1052	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:13:21.302+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	105	http://localhost:8055
1053	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:13:21.311+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	118	http://localhost:8055
1054	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:13:21.342+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	119	http://localhost:8055
1055	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:13:47.803+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_advant	ee022322-8cca-44a7-a7c2-620090f44779	http://localhost:8055
1056	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:13:47.808+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_wholesale_advant	1	http://localhost:8055
1057	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:13:47.812+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_advant	04b5d690-4c36-4e26-8efc-a61481d2bab5	http://localhost:8055
1058	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:13:47.814+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_wholesale_advant	2	http://localhost:8055
1059	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:13:47.819+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	http://localhost:8055
1060	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:13:51.901+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_wholesale_advant	http://localhost:8055
1061	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:13:51.979+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	products	http://localhost:8055
1062	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:13:51.984+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	attrs	http://localhost:8055
1063	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:13:51.988+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	seo_settings	http://localhost:8055
1064	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:13:51.994+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	pages	http://localhost:8055
1065	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:14:03.981+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	119	http://localhost:8055
1066	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:14:24.896+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_advant	http://localhost:8055
1067	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:14:44.79+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	119	http://localhost:8055
1068	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:15:03.757+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_advant	http://localhost:8055
1069	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:15:07.85+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_advant	http://localhost:8055
1070	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:15:10.698+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_advant	http://localhost:8055
1071	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:15:21.662+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_wholesale_advant	1	http://localhost:8055
1072	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:15:21.663+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_wholesale_advant	2	http://localhost:8055
1073	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:15:21.668+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	http://localhost:8055
1074	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:15:59.55+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_advant	04b5d690-4c36-4e26-8efc-a61481d2bab5	http://localhost:8055
1075	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:15:59.551+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_advant	c11cc4c8-57d9-46fb-93d2-fa19a48302b8	http://localhost:8055
1076	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:15:59.553+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_advant	ee022322-8cca-44a7-a7c2-620090f44779	http://localhost:8055
1077	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:16:14.377+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_advant	c57c2627-290f-401e-a6fe-bf745c5cdbea	http://localhost:8055
1078	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:16:14.381+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_wholesale_advant	3	http://localhost:8055
1079	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:16:14.386+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	http://localhost:8055
1080	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:16:19.677+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_wholesale_advant	3	http://localhost:8055
1081	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:16:19.679+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	http://localhost:8055
1082	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:16:26.013+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_advant	c57c2627-290f-401e-a6fe-bf745c5cdbea	http://localhost:8055
1083	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:17:13.093+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_advant	af006291-e9d7-4fe6-9ebd-371100016034	http://localhost:8055
1084	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:17:13.097+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_wholesale_advant	4	http://localhost:8055
1085	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:17:13.101+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	http://localhost:8055
1086	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:17:18.028+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_wholesale_advant	4	http://localhost:8055
1087	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:17:18.029+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	http://localhost:8055
1088	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:20:14.912+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_advant	961fcf39-e0da-4092-b4f4-def775b32e8d	http://localhost:8055
1089	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:20:14.916+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_wholesale_advant	5	http://localhost:8055
1090	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:20:14.92+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	http://localhost:8055
1091	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:20:21.764+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_wholesale_advant	5	http://localhost:8055
1092	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:20:21.765+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	http://localhost:8055
1093	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:20:47.556+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_advant	961fcf39-e0da-4092-b4f4-def775b32e8d	http://localhost:8055
1094	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:20:47.558+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_advant	af006291-e9d7-4fe6-9ebd-371100016034	http://localhost:8055
1095	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:22:51.811+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_advant	89c8fc0f-00d3-4129-9a1f-a72d924101bd	http://localhost:8055
1096	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:22:51.816+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_wholesale_advant	6	http://localhost:8055
1097	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:22:51.82+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	http://localhost:8055
1098	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:22:58.249+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_wholesale_advant	6	http://localhost:8055
1099	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:22:58.253+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	http://localhost:8055
1100	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:23:53.808+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	119	http://localhost:8055
1101	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:24:35.48+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	119	http://localhost:8055
1102	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:26:20.32+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_advant	a96d6a1d-9b15-43ee-8755-d242c92bcc03	http://localhost:8055
1103	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:26:20.324+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_wholesale_advant	7	http://localhost:8055
1104	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:26:20.329+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_advant	78b365d9-ec54-4337-af8b-c62ad45e9d92	http://localhost:8055
1105	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:26:20.332+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_wholesale_advant	8	http://localhost:8055
1106	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:26:20.336+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_advant	350f1de0-a24f-491b-9d6c-b1f8e12dc93f	http://localhost:8055
1107	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:26:20.339+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_wholesale_advant	9	http://localhost:8055
1108	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:26:20.342+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_advant	0be59b02-5267-401c-90d9-be80a41f44a6	http://localhost:8055
1109	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:26:20.346+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale_wholesale_advant	10	http://localhost:8055
1110	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:26:20.351+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	http://localhost:8055
1111	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:26:26.452+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_collections	wholesale_advant	http://localhost:8055
1112	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:28:40.043+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	123	http://localhost:8055
1113	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:29:30.297+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	33	http://localhost:8055
1114	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:29:30.301+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_permissions	34	http://localhost:8055
1115	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:29:30.306+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_policies	7b920119-42aa-47ac-a60c-656664a5150d	http://localhost:8055
1116	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:29:30.313+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_access	50c87726-ebc9-4502-9708-10e4a787ab29	http://localhost:8055
1117	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:29:30.323+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_users	5e7d0719-f6fa-4e9b-a681-d24bc8947984	http://localhost:8055
1118	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:31:55.974+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	124	http://localhost:8055
1119	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:31:58.676+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	18	http://localhost:8055
1120	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:31:58.689+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	105	http://localhost:8055
1121	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:31:58.699+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	118	http://localhost:8055
1122	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:31:58.71+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	124	http://localhost:8055
1123	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:31:58.718+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	123	http://localhost:8055
1124	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:33:22.501+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	125	http://localhost:8055
1125	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:33:25.349+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	18	http://localhost:8055
1126	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:33:25.358+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	105	http://localhost:8055
1127	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:33:25.37+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	118	http://localhost:8055
1128	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:33:25.378+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	123	http://localhost:8055
1129	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:33:25.391+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	124	http://localhost:8055
1130	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:33:25.407+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	125	http://localhost:8055
1131	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:37:09.033+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	126	http://localhost:8055
1132	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:37:13.308+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	18	http://localhost:8055
1133	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:37:13.319+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	105	http://localhost:8055
1134	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:37:13.329+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	118	http://localhost:8055
1135	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:37:13.336+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	123	http://localhost:8055
1136	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:37:13.347+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	124	http://localhost:8055
1137	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:37:13.359+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	125	http://localhost:8055
1138	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:37:13.374+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	126	http://localhost:8055
1139	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:40:22.378+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	http://localhost:8055
1140	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:41:34.864+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	http://localhost:8055
1141	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:45:09.863+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	http://localhost:8055
1142	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:58:03.082+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	127	http://localhost:8055
1143	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:59:01.687+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	128	http://localhost:8055
1144	delete	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:59:07.204+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	128	http://localhost:8055
1145	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:59:40.231+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	129	http://localhost:8055
1146	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:59:42.224+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	18	http://localhost:8055
1147	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:59:42.234+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	105	http://localhost:8055
1148	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:59:42.241+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	118	http://localhost:8055
1149	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:59:42.25+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	123	http://localhost:8055
1150	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:59:42.264+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	129	http://localhost:8055
1151	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 13:59:42.264+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	127	http://localhost:8055
1152	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 14:00:19.677+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	130	http://localhost:8055
1153	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 14:00:22.671+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	18	http://localhost:8055
1154	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 14:00:22.682+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	105	http://localhost:8055
1155	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 14:00:22.69+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	118	http://localhost:8055
1156	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 14:00:22.702+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	123	http://localhost:8055
1157	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 14:00:22.712+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	129	http://localhost:8055
1158	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 14:00:22.72+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	127	http://localhost:8055
1159	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 14:00:22.726+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	130	http://localhost:8055
1160	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 14:01:39.482+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	131	http://localhost:8055
1161	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 14:01:42.873+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	18	http://localhost:8055
1162	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 14:01:42.881+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	105	http://localhost:8055
1163	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 14:01:42.891+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	118	http://localhost:8055
1164	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 14:01:42.901+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	123	http://localhost:8055
1165	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 14:01:42.91+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	129	http://localhost:8055
1166	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 14:01:42.917+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	127	http://localhost:8055
1167	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 14:01:42.922+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	130	http://localhost:8055
1168	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 14:01:42.937+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_fields	131	http://localhost:8055
1169	create	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 14:03:13.802+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	directus_files	09be7688-d281-480b-9a0d-f7966781057a	http://localhost:8055
1170	update	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 14:04:52.971+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	http://localhost:8055
\.


--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability, color, item_duplication_fields, sort, "group", collapse, preview_url, versioning) FROM stdin;
products_styles	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	2	products	open	\N	f
products_reason	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	3	products	open	\N	f
products_structure	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	4	products	open	\N	f
products_categories	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	5	products	open	\N	f
wholesale_advant	\N	\N	{{image}}{{content}}	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	1	wholesale	open	\N	f
wholesale	two_pager	\N	\N	f	t	\N	\N	t	\N	\N	\N	all	\N	\N	1	pages	open	\N	f
styles	settings_suggest	\N	\N	f	f	[{"language":"ru-RU","translation":"Стиль","singular":"Стиль","plural":"Стили"}]	\N	t	\N	\N	\N	all	\N	\N	2	attrs	open	\N	f
reason	settings_suggest	\N	\N	f	f	[{"language":"ru-RU","translation":"Поводы","singular":"Повод","plural":"Поводы"}]	\N	t	\N	\N	\N	all	\N	\N	4	attrs	open	\N	f
categories	settings_suggest	\N	{{name}}	f	f	[{"language":"ru-RU","translation":"Категории","singular":"Категория","plural":"Категории"}]	\N	t	\N	\N	sort	all	\N	["sort"]	1	attrs	open	\N	f
structure	settings_suggest	\N	\N	f	f	[{"language":"ru-RU","translation":"Состав","singular":"Состав","plural":"Составы"}]	\N	t	\N	\N	sort	all	\N	\N	3	attrs	open	\N	f
wholesale_wholesale_advant	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	1	wholesale_advant	open	\N	f
products	stacks	\N	\N	f	f	[{"language":"ru-RU","translation":"Товары","singular":"Товар","plural":"Товары"}]	\N	t	\N	\N	sort	all	\N	\N	1	\N	open	\N	f
attrs	folder	\N	\N	f	f	[{"language":"ru-RU","translation":"Атрибуты товаров"}]	\N	t	\N	\N	\N	all	\N	\N	2	\N	open	\N	f
products_files	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	1	products	open	\N	f
seo_settings	folder	Содержит коллекции, связанные с SEO-настройками страниц	\N	f	f	[{"language":"ru-RU","translation":"SEO настройки"}]	\N	t	\N	\N	\N	all	\N	\N	3	\N	open	\N	f
pages	folder	Содержит коллекции, связанные с контентной частью сайта	\N	f	f	[{"language":"ru-RU","translation":"Страницы"}]	\N	t	\N	\N	\N	all	\N	\N	4	\N	open	\N	f
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
101	wholesale	tag	\N	input	{"iconLeft":"tag"}	raw	\N	f	f	2	full	[{"language":"ru-RU","translation":"Тег страницы"}]	Отображается над заголовком	\N	f	hero	\N	\N
80	products_structure	id	\N	\N	\N	\N	\N	f	t	1	full	\N	\N	\N	f	\N	\N	\N
102	wholesale	title	\N	input	{"iconLeft":"title"}	raw	\N	f	f	3	full	[{"language":"ru-RU","translation":"Заголовок страницы"}]	\N	\N	f	hero	\N	\N
107	wholesale_advant	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
131	wholesale	banner_content	\N	input-rich-text-html	{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h3","h4","h5","h6","numlist","bullist","customLink","hr","fullscreen"]}	formatted-value	\N	f	f	3	full	[{"language":"ru-RU","translation":"Текстовое содержимое"}]	\N	\N	f	banner	\N	\N
125	wholesale	faq_description	\N	input-rich-text-html	{"toolbar":["bold","italic","underline","strikethrough","h3","h4","h5","h6","numlist","bullist","removeformat","customLink","customImage","hr","fullscreen"]}	formatted-value	\N	f	f	2	full	[{"language":"ru-RU","translation":"Описание блока"}]	\N	\N	f	faq	\N	\N
127	wholesale	banner	alias,no-data,group	group-detail	{"headerIcon":"image_aspect_ratio"}	\N	\N	f	f	5	full	[{"language":"ru-RU","translation":"Баннер"}]	\N	\N	f	\N	\N	\N
123	wholesale	faq	alias,no-data,group	group-detail	{"headerIcon":"question_mark"}	\N	\N	f	f	4	full	[{"language":"ru-RU","translation":"Раздел FAQ"}]	\N	\N	f	\N	\N	\N
81	products_structure	products_id	\N	\N	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N
82	products_structure	structure_id	\N	\N	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
45	styles	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
61	products	style	m2m	list-m2m	{"enableCreate":false,"template":"{{styles_id.name}}"}	\N	\N	f	f	1	half	[{"language":"ru-RU","translation":"Стиль"}]	\N	\N	f	attrs	\N	\N
62	products_styles	id	\N	\N	\N	\N	\N	f	t	1	full	\N	\N	\N	f	\N	\N	\N
63	products_styles	products_id	\N	\N	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N
64	products_styles	styles_id	\N	\N	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
68	reason	name	\N	input	{"iconLeft":"drive_file_rename_outline"}	raw	\N	f	f	2	full	[{"language":"ru-RU","translation":"Наименование"}]	\N	\N	t	\N	\N	\N
74	products	discount	\N	input	{"iconLeft":"currency_ruble"}	raw	\N	f	f	3	half	[{"language":"ru-RU","translation":"Цена со скидкой"}]	\N	\N	f	data	\N	\N
67	reason	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
70	products_reason	id	\N	\N	\N	\N	\N	f	t	1	full	\N	\N	\N	f	\N	\N	\N
71	products_reason	products_id	\N	\N	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N
72	products_reason	reason_id	\N	\N	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
41	products	size	\N	input	{"iconLeft":"resize"}	\N	\N	f	f	5	full	[{"language":"ru-RU","translation":"Описание размера товара"}]	Ожидается формат "10x10x10см"	\N	f	data	\N	\N
89	products	tech	alias,no-data,group	group-detail	{"headerIcon":"admin_panel_settings","start":"closed"}	\N	\N	f	f	6	full	[{"language":"ru-RU","translation":"Настройки"}]	\N	\N	f	\N	\N	\N
76	products_files	id	\N	\N	\N	\N	\N	f	t	1	full	\N	\N	\N	f	\N	\N	\N
77	products_files	products_id	\N	\N	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N
78	products_files	directus_files_id	\N	\N	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
86	products	seo_description	\N	input-multiline	\N	\N	\N	f	f	2	full	\N	\N	\N	f	seo	\N	\N
39	products	title	\N	input	{"iconLeft":"title"}	raw	\N	f	f	1	full	[{"language":"ru-RU","translation":"Заголовок товара"}]	\N	\N	t	data	\N	\N
85	products	seo_title	\N	input	{"iconLeft":"title"}	\N	\N	f	f	1	full	\N	\N	\N	f	seo	\N	\N
73	products	price	\N	input	{"iconLeft":"currency_ruble"}	raw	\N	f	f	2	half	[{"language":"ru-RU","translation":"Цена"}]	\N	\N	t	data	\N	\N
87	products	seo_keywords	cast-csv	tags	{"whitespace":"-","capitalization":"lowercase"}	\N	\N	f	f	3	full	\N	\N	\N	f	seo	\N	\N
40	products	description	\N	input-rich-text-html	{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","alignleft","aligncenter","alignright","numlist","bullist","removeformat","customLink","hr","fullscreen","code"]}	raw	\N	f	f	4	full	[{"language":"ru-RU","translation":"Описание товара"}]	\N	\N	f	data	\N	\N
36	products	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	3	half	\N	\N	\N	f	\N	\N	\N
75	products	images	files	files	{}	related-values	\N	f	f	6	full	[{"language":"ru-RU","translation":"Изображения"}]	\N	\N	t	data	\N	\N
38	products	sort	\N	input	{"iconLeft":"sort_by_alpha","min":0}	\N	\N	t	t	1	full	[{"language":"ru-RU","translation":"Сортировка"}]	Значение от 0 до ∞, где 0 - первая позиция 	\N	f	tech	{"_and":[{"sort":{"_gte":"0"}}]}	\N
91	categories	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
90	products	data	alias,no-data,group	group-detail	{"headerIcon":"database"}	\N	\N	f	f	4	full	[{"language":"ru-RU","translation":"Основные данные"}]	\N	\N	f	\N	\N	\N
69	products	reason	m2m	list-m2m	{"enableCreate":false,"template":"{{reason_id.name}}"}	\N	\N	f	f	2	half	[{"language":"ru-RU","translation":"Повод"}]	\N	\N	f	attrs	\N	\N
37	products	available	cast-boolean	boolean	{"label":"Доступно к покупке"}	boolean	{"labelOn":"Доступен","labelOff":"Недоступен"}	f	f	2	full	[{"language":"ru-RU","translation":"В наличии"}]	\N	\N	f	tech	\N	\N
46	styles	name	\N	input	{"iconLeft":"drive_file_rename_outline"}	raw	\N	f	f	2	full	[{"language":"ru-RU","translation":"Наименование"}]	\N	\N	t	\N	\N	\N
88	products	attrs	alias,no-data,group	group-detail	{"headerIcon":"tag","start":"closed"}	\N	\N	f	f	5	full	[{"language":"ru-RU","translation":"Атрибуты"}]	\N	\N	f	\N	\N	\N
35	products	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	2	half	\N	\N	\N	f	\N	\N	\N
84	products	seo	alias,no-data,group	group-detail	{"start":"closed","headerIcon":"settings"}	\N	\N	f	f	7	full	\N	\N	\N	f	\N	\N	\N
92	categories	name	\N	input	{"iconLeft":"drive_file_rename_outline"}	raw	\N	f	f	3	full	[{"language":"ru-RU","translation":"Наименование"}]	\N	\N	t	\N	\N	\N
65	structure	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
34	products	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
66	structure	name	\N	input	{"iconLeft":"drive_file_rename_outline"}	raw	\N	f	f	3	full	[{"language":"ru-RU","translation":"Наименование"}]	\N	\N	t	\N	\N	\N
124	wholesale	faq_title	\N	input	{"iconLeft":"title"}	raw	\N	f	f	1	full	[{"language":"ru-RU","translation":"Заголовок блока"}]	\N	\N	f	faq	\N	\N
126	wholesale	faq_blocks	cast-json	list	{"fields":[{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"interface":"input","options":{"iconLeft":"title","softLength":null},"display":"formatted-value"}},{"field":"content","name":"content","type":"text","meta":{"field":"content","type":"text","required":true,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h3","h4","h5","h6","alignleft","aligncenter","alignright","numlist","bullist","removeformat","customLink","customImage","hr","fullscreen"]},"display":"formatted-value"}}]}	raw	\N	f	f	3	full	[{"language":"ru-RU","translation":"Блоки аккордеона"}]	\N	\N	f	faq	\N	\N
96	products_categories	id	\N	\N	\N	\N	\N	f	t	1	full	\N	\N	\N	f	\N	\N	\N
97	products_categories	products_id	\N	\N	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N
98	products_categories	categories_id	\N	\N	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
79	products	structure	m2m	list-m2m	{"enableCreate":false,"template":"{{structure_id.name}}"}	related-values	\N	f	f	3	half	[{"language":"ru-RU","translation":"Состав"}]	\N	\N	f	attrs	\N	\N
95	products	category	m2m	list-m2m	{"enableCreate":false,"limit":100}	related-values	\N	f	f	4	half	[{"language":"ru-RU","translation":"Категории"}]	В каких категориях будет отображаться товар	\N	f	attrs	\N	\N
100	wholesale	image	file	file-image	\N	image	\N	f	f	1	full	[{"language":"ru-RU","translation":"Фоновое изображение"}]	\N	\N	t	hero	\N	\N
104	wholesale	description	\N	input-multiline	\N	\N	\N	f	f	4	full	[{"language":"ru-RU","translation":"Описание страницы"}]	\N	\N	f	hero	\N	\N
93	categories	sort	\N	input	{"min":0,"iconLeft":"sort_by_alpha"}	raw	\N	t	t	2	full	[{"language":"ru-RU","translation":"Сортировка"}]	Значение от 0 до ∞, где 0 начало	\N	f	\N	{"_and":[{"sort":{"_gte":"0"}}]}	\N
94	categories	available	cast-boolean	boolean	{"label":"Отображать на сайте"}	boolean	{"labelOn":"Отображается","labelOff":"Скрыто"}	f	f	4	full	[{"language":"ru-RU","translation":"Видимость"}]	\N	\N	f	\N	\N	\N
99	structure	sort	\N	input	{"min":0}	raw	\N	t	t	2	full	[{"language":"ru-RU","translation":"Сортировка"}]	\N	\N	f	\N	{"_and":[{"sort":{"_gte":"0"}}]}	\N
108	wholesale_advant	image	file	file-image	\N	image	\N	f	f	2	full	[{"language":"ru-RU","translation":"Изображение"}]	\N	\N	f	\N	\N	\N
109	wholesale_advant	content	\N	input-rich-text-html	{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","alignleft","aligncenter","alignright","numlist","bullist","removeformat","customLink","hr","fullscreen"]}	\N	\N	f	f	3	full	[{"language":"ru-RU","translation":"Содержание"}]	\N	\N	f	\N	\N	\N
120	wholesale_wholesale_advant	id	\N	\N	\N	\N	\N	f	t	1	full	\N	\N	\N	f	\N	\N	\N
121	wholesale_wholesale_advant	wholesale_id	\N	\N	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N
122	wholesale_wholesale_advant	wholesale_advant_id	\N	\N	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
18	wholesale	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
105	wholesale	hero	alias,no-data,group	group-detail	{}	\N	\N	f	f	2	full	[{"language":"ru-RU","translation":"Хироскрин"}]	\N	\N	f	\N	\N	\N
118	wholesale	list	alias,no-data,group	group-detail	{"headerIcon":"list"}	\N	\N	f	f	3	full	[{"language":"ru-RU","translation":"Список преимуществ"}]	\N	\N	f	\N	\N	\N
129	wholesale	banner_image	file	file-image	\N	image	\N	f	f	1	full	[{"language":"ru-RU","translation":"Фоновое изображение"}]	\N	\N	f	banner	\N	\N
119	wholesale	advant	m2m	list-m2m	{"enableSelect":false}	related-values	{"template":"{{wholesale_advant_id.image}}{{wholesale_advant_id.content}}"}	f	f	1	full	[{"language":"ru-RU","translation":"Блок"}]	\N	\N	f	list	\N	\N
130	wholesale	banner_title	\N	input	{"iconLeft":"title"}	raw	\N	f	f	2	full	[{"language":"ru-RU","translation":"Заголовок баннера"}]	\N	\N	f	banner	\N	\N
\.


--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, created_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata, focal_point_x, focal_point_y, tus_id, tus_data, uploaded_on) FROM stdin;
c49375f7-06d0-47d3-babd-0515605ec99f	local	c49375f7-06d0-47d3-babd-0515605ec99f.jpg	temp1.jpg	Temp1	image/jpeg	\N	d28ea43e-0087-4264-aad7-f52329173439	2025-10-27 11:21:19.228+00	\N	2025-10-27 11:21:19.269+00	\N	248197	1464	2000	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-10-27 11:21:19.269+00
09be7688-d281-480b-9a0d-f7966781057a	local	09be7688-d281-480b-9a0d-f7966781057a.gif	flowers.gif	Flowers	image/gif	\N	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 14:03:13.798+00	\N	2025-10-29 14:03:15.148+00	\N	51083012	702	1248	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2025-10-29 14:03:15.147+00
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
20	directus_files	read	\N	\N	\N	*	abf8a154-5b1c-4a46-ac9c-7300570f4f17
23	categories	read	\N	\N	\N	*	7b920119-42aa-47ac-a60c-656664a5150d
24	products	read	\N	\N	\N	*	7b920119-42aa-47ac-a60c-656664a5150d
25	products_categories	read	\N	\N	\N	*	7b920119-42aa-47ac-a60c-656664a5150d
26	products_files	read	\N	\N	\N	*	7b920119-42aa-47ac-a60c-656664a5150d
27	products_reason	read	\N	\N	\N	*	7b920119-42aa-47ac-a60c-656664a5150d
28	products_structure	read	\N	\N	\N	*	7b920119-42aa-47ac-a60c-656664a5150d
29	products_styles	read	\N	\N	\N	*	7b920119-42aa-47ac-a60c-656664a5150d
30	reason	read	\N	\N	\N	*	7b920119-42aa-47ac-a60c-656664a5150d
31	structure	read	\N	\N	\N	*	7b920119-42aa-47ac-a60c-656664a5150d
32	styles	read	\N	\N	\N	*	7b920119-42aa-47ac-a60c-656664a5150d
33	wholesale_advant	read	\N	\N	\N	*	7b920119-42aa-47ac-a60c-656664a5150d
34	wholesale_wholesale_advant	read	\N	\N	\N	*	7b920119-42aa-47ac-a60c-656664a5150d
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
3	\N	d28ea43e-0087-4264-aad7-f52329173439	\N	products	\N	\N	{"tabular":{"page":1}}	\N	\N	\N	bookmark	\N
2	\N	d28ea43e-0087-4264-aad7-f52329173439	\N	reason	\N	\N	{"tabular":{"fields":["name"],"sort":["-name"],"page":1}}	{"tabular":{"widths":{"name":524,"id":160},"align":{"name":"left"}}}	\N	\N	bookmark	\N
4	\N	d28ea43e-0087-4264-aad7-f52329173439	\N	structure	\N	tabular	{"tabular":{"page":1,"sort":["name"]},"map":{"limit":1000}}	{"tabular":{"spacing":"cozy"},"cards":{"title":"{{name}}"},"kanban":{"titleField":"name"},"calendar":{"viewInfo":{"type":"dayGridMonth","startDateStr":"2025-10-01T00:00:00+03:00"}}}	\N	\N	bookmark	\N
5	\N	d28ea43e-0087-4264-aad7-f52329173439	\N	categories	\N	\N	{"tabular":{"page":1,"fields":["sort","name","available"],"sort":["sort"],"limit":100}}	{"tabular":{"widths":{"sort":32,"name":729,"available":160}}}	\N	\N	bookmark	\N
1	\N	d28ea43e-0087-4264-aad7-f52329173439	\N	styles	\N	\N	{"tabular":{"page":1}}	\N	\N	\N	bookmark	\N
\.


--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_relations (id, many_collection, many_field, one_collection, one_field, one_collection_field, one_allowed_collections, junction_field, sort_field, one_deselect_action) FROM stdin;
12	products_styles	styles_id	styles	\N	\N	\N	products_id	\N	nullify
13	products_styles	products_id	products	style	\N	\N	styles_id	\N	nullify
14	products_reason	reason_id	reason	\N	\N	\N	products_id	\N	nullify
15	products_reason	products_id	products	reason	\N	\N	reason_id	\N	nullify
16	products_files	directus_files_id	directus_files	\N	\N	\N	products_id	\N	nullify
17	products_files	products_id	products	images	\N	\N	directus_files_id	\N	nullify
18	products_structure	structure_id	structure	\N	\N	\N	products_id	\N	nullify
19	products_structure	products_id	products	structure	\N	\N	structure_id	\N	nullify
20	products_categories	categories_id	categories	\N	\N	\N	products_id	\N	nullify
21	products_categories	products_id	products	category	\N	\N	categories_id	\N	nullify
22	wholesale	image	directus_files	\N	\N	\N	\N	\N	nullify
23	wholesale_advant	image	directus_files	\N	\N	\N	\N	\N	nullify
27	wholesale_wholesale_advant	wholesale_advant_id	wholesale_advant	\N	\N	\N	wholesale_id	\N	nullify
28	wholesale_wholesale_advant	wholesale_id	wholesale	advant	\N	\N	wholesale_advant_id	\N	nullify
30	wholesale	banner_image	directus_files	\N	\N	\N	\N	\N	nullify
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
676	760	structure	72c19c46-5eba-4c2c-bd06-5b3e0afa059b	{"name":"Георгины"}	{"name":"Георгины"}	\N	\N
677	761	structure	74267c8e-6ddd-429a-bc74-c113517c73ff	{"name":"Гербера"}	{"name":"Гербера"}	\N	\N
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
224	285	directus_fields	45	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"styles"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"styles"}	\N	\N
225	286	directus_collections	styles	{"singleton":false,"collection":"styles"}	{"singleton":false,"collection":"styles"}	\N	\N
227	288	styles	cce34f44-c758-4353-ab37-17ef50157655	{"name":"test"}	{"name":"test"}	\N	\N
678	762	structure	ca7af4ff-3ba5-404d-aab5-3fe132776edc	{"name":"Гермини"}	{"name":"Гермини"}	\N	\N
679	763	structure	d1d6be9d-ee52-471d-b599-30c7d83490cb	{"name":"Гиацинт"}	{"name":"Гиацинт"}	\N	\N
140	183	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	{"hero":{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","tag":"Оптовикам","title":"Всегда свежие цветы для бизнеса","description":"Свежие цветы с нашей собственной фермы в Самарской области. Наши официальные оптовики получают доступ к многоуровневой партнёрской программе, скидки на продукцию, подарки и многое другое"}}	{"hero":{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","tag":"Оптовикам","title":"Всегда свежие цветы для бизнеса","description":"Свежие цветы с нашей собственной фермы в Самарской области. Наши официальные оптовики получают доступ к многоуровневой партнёрской программе, скидки на продукцию, подарки и многое другое"}}	\N	\N
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
228	289	styles	09bdc67b-cc5b-4266-8879-18edbdbbbb5b	{"name":"test1"}	{"name":"test1"}	\N	\N
229	290	styles	73767c67-d3cf-4899-82a7-721b64939fa3	{"name":"test2"}	{"name":"test2"}	\N	\N
680	764	structure	fcd43968-5e80-4c3e-83df-7572f5abc6ac	{"name":"Гиперикум"}	{"name":"Гиперикум"}	\N	\N
156	202	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	{"id":"9be4e10a-bc62-4144-afc5-1adc89ebdcd2","hero":"e82cad0e-a2cd-4c50-9dcf-2ccee2d96251","advant":"2f0849a4-651e-440a-8dad-dbec47699b12"}	{"advant":"2f0849a4-651e-440a-8dad-dbec47699b12"}	\N	\N
157	203	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	{"id":"9be4e10a-bc62-4144-afc5-1adc89ebdcd2","hero":"e82cad0e-a2cd-4c50-9dcf-2ccee2d96251","advant":null}	{"advant":null}	\N	\N
158	205	directus_fields	29	{"sort":3,"interface":"list-o2m","special":["o2m"],"options":{"template":"{{image}}{{content}}"},"collection":"wholesale","field":"advant"}	{"sort":3,"interface":"list-o2m","special":["o2m"],"options":{"template":"{{image}}{{content}}"},"collection":"wholesale","field":"advant"}	\N	\N
159	207	directus_fields	30	{"sort":3,"interface":"list-m2m","special":["m2m"],"collection":"wholesale","field":"advant"}	{"sort":3,"interface":"list-m2m","special":["m2m"],"collection":"wholesale","field":"advant"}	\N	\N
160	208	directus_fields	31	{"sort":1,"hidden":true,"field":"id","collection":"wholesale_wholesale_advant"}	{"sort":1,"hidden":true,"field":"id","collection":"wholesale_wholesale_advant"}	\N	\N
161	209	directus_collections	wholesale_wholesale_advant	{"hidden":true,"icon":"import_export","collection":"wholesale_wholesale_advant"}	{"hidden":true,"icon":"import_export","collection":"wholesale_wholesale_advant"}	\N	\N
162	210	directus_fields	32	{"sort":2,"hidden":true,"collection":"wholesale_wholesale_advant","field":"wholesale_id"}	{"sort":2,"hidden":true,"collection":"wholesale_wholesale_advant","field":"wholesale_id"}	\N	\N
163	211	directus_fields	33	{"sort":3,"hidden":true,"collection":"wholesale_wholesale_advant","field":"wholesale_advant_id"}	{"sort":3,"hidden":true,"collection":"wholesale_wholesale_advant","field":"wholesale_advant_id"}	\N	\N
165	214	directus_collections	wholesale_wholesale_advant	{"collection":"wholesale_wholesale_advant","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"wholesale_advant","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"wholesale_advant"}	\N	\N
166	215	directus_collections	seo_settings	{"collection":"seo_settings","icon":"folder","note":"Содержит коллекции, связанные с SEO-настройками страниц","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"SEO настройки"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
167	216	directus_collections	pages	{"collection":"pages","icon":"folder","note":"Содержит коллекции, связанные с контентной частью сайта","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
168	217	directus_fields	30	{"id":30,"collection":"wholesale","field":"advant","special":["m2m"],"interface":"list-m2m","options":null,"display":"related-values","display_options":{"template":"{{wholesale_advant_id.image}}"},"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"advant","display":"related-values","display_options":{"template":"{{wholesale_advant_id.image}}"}}	\N	\N
169	218	directus_fields	30	{"id":30,"collection":"wholesale","field":"advant","special":["m2m"],"interface":"list-m2m","options":{"enableSelect":false},"display":null,"display_options":{"template":"{{wholesale_advant_id.image}}"},"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"advant","options":{"enableSelect":false},"display":null}	\N	\N
170	219	directus_fields	30	{"id":30,"collection":"wholesale","field":"advant","special":["m2m"],"interface":"list-m2m","options":{"enableSelect":false},"display":"related-values","display_options":{"template":"{{wholesale_advant_id.image}}"},"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"advant","display":"related-values"}	\N	\N
171	220	directus_fields	27	{"id":27,"collection":"wholesale_advant","field":"content","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","h2","h3","h4","numlist","bullist","removeformat","customLink","hr","fullscreen","code"]},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale_advant","field":"content","display":"formatted-value"}	\N	\N
230	291	styles	8e5604c8-3d86-48a8-8e94-3ef8a57d72cd	{"name":"test3"}	{"name":"test3"}	\N	\N
176	227	directus_permissions	21	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"wholesale_advant","action":"read"}	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"wholesale_advant","action":"read"}	\N	\N
177	228	directus_permissions	22	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"wholesale_wholesale_advant","action":"read"}	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"wholesale_wholesale_advant","action":"read"}	\N	\N
178	230	directus_access	50c87726-ebc9-4502-9708-10e4a787ab29	{"id":"50c87726-ebc9-4502-9708-10e4a787ab29","role":null,"user":"5e7d0719-f6fa-4e9b-a681-d24bc8947984","policy":"7b920119-42aa-47ac-a60c-656664a5150d","sort":1}	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d"}	\N	\N
179	232	directus_fields	34	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"products"}	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"products"}	\N	\N
231	292	directus_fields	47	{"sort":11,"interface":"collection-item-dropdown","special":["cast-json"],"options":{"selectedCollection":"styles"},"collection":"products","field":"style"}	{"sort":11,"interface":"collection-item-dropdown","special":["cast-json"],"options":{"selectedCollection":"styles"},"collection":"products","field":"style"}	\N	\N
180	233	directus_fields	35	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"products"}	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"products"}	\N	\N
181	234	directus_fields	36	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"products"}	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"products"}	\N	\N
182	235	directus_collections	products	{"singleton":false,"collection":"products"}	{"singleton":false,"collection":"products"}	\N	\N
183	236	directus_collections	seo_settings	{"collection":"seo_settings","icon":"folder","note":"Содержит коллекции, связанные с SEO-настройками страниц","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"SEO настройки"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
184	237	directus_collections	products	{"collection":"products","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
185	238	directus_collections	pages	{"collection":"pages","icon":"folder","note":"Содержит коллекции, связанные с контентной частью сайта","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
186	239	directus_collections	products	{"collection":"products","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
187	240	directus_collections	seo_settings	{"collection":"seo_settings","icon":"folder","note":"Содержит коллекции, связанные с SEO-настройками страниц","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"SEO настройки"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
188	241	directus_collections	pages	{"collection":"pages","icon":"folder","note":"Содержит коллекции, связанные с контентной частью сайта","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
189	242	directus_collections	products	{"collection":"products","icon":"stacks","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Товары","singular":"Товар","plural":"Товары"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"icon":"stacks","translations":[{"language":"ru-RU","translation":"Товары","singular":"Товар","plural":"Товары"}]}	\N	\N
190	243	directus_fields	37	{"sort":4,"interface":"boolean","special":["cast-boolean"],"collection":"products","field":"available"}	{"sort":4,"interface":"boolean","special":["cast-boolean"],"collection":"products","field":"available"}	\N	\N
191	244	directus_fields	37	{"id":37,"collection":"products","field":"available","special":["cast-boolean"],"interface":"boolean","options":{"label":"Доступно к покупке"},"display":"boolean","display_options":{"labelOn":"Доступен","labelOff":"Недоступен"},"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"В наличии"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"available","options":{"label":"Доступно к покупке"},"display":"boolean","display_options":{"labelOn":"Доступен","labelOff":"Недоступен"},"translations":[{"language":"ru-RU","translation":"В наличии"}]}	\N	\N
192	245	directus_fields	38	{"sort":5,"interface":"input","special":null,"options":{"iconLeft":"sort_by_alpha"},"collection":"products","field":"sort"}	{"sort":5,"interface":"input","special":null,"options":{"iconLeft":"sort_by_alpha"},"collection":"products","field":"sort"}	\N	\N
193	246	directus_fields	34	{"id":34,"collection":"products","field":"id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"id","sort":1,"group":null}	\N	\N
194	247	directus_fields	35	{"id":35,"collection":"products","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_created","sort":2,"group":null}	\N	\N
195	248	directus_fields	36	{"id":36,"collection":"products","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_updated","sort":3,"group":null}	\N	\N
196	249	directus_fields	38	{"id":38,"collection":"products","field":"sort","special":null,"interface":"input","options":{"iconLeft":"sort_by_alpha"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"sort","sort":4,"group":null}	\N	\N
197	250	directus_fields	37	{"id":37,"collection":"products","field":"available","special":["cast-boolean"],"interface":"boolean","options":{"label":"Доступно к покупке"},"display":"boolean","display_options":{"labelOn":"Доступен","labelOff":"Недоступен"},"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"В наличии"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"available","sort":5,"group":null}	\N	\N
198	251	directus_fields	38	{"id":38,"collection":"products","field":"sort","special":null,"interface":"input","options":{"iconLeft":"sort_by_alpha"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"sort","width":"half"}	\N	\N
199	252	directus_fields	37	{"id":37,"collection":"products","field":"available","special":["cast-boolean"],"interface":"boolean","options":{"label":"Доступно к покупке"},"display":"boolean","display_options":{"labelOn":"Доступен","labelOff":"Недоступен"},"readonly":false,"hidden":false,"sort":5,"width":"half","translations":[{"language":"ru-RU","translation":"В наличии"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"available","width":"half"}	\N	\N
200	253	directus_fields	38	{"id":38,"collection":"products","field":"sort","special":null,"interface":"input","options":{"iconLeft":"sort_by_alpha","min":0},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Сортировка"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"sort","options":{"iconLeft":"sort_by_alpha","min":0},"translations":[{"language":"ru-RU","translation":"Сортировка"}]}	\N	\N
201	254	directus_fields	38	{"id":38,"collection":"products","field":"sort","special":null,"interface":"input","options":{"iconLeft":"sort_by_alpha","min":0},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Сортировка"}],"note":"Значение от 0 до ∞, где 0 - первая позиция ","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"sort","note":"Значение от 0 до ∞, где 0 - первая позиция "}	\N	\N
202	255	products	1	{"sort":-124}	{"sort":-124}	\N	\N
203	257	directus_fields	38	{"id":38,"collection":"products","field":"sort","special":null,"interface":"input","options":{"iconLeft":"sort_by_alpha","min":0},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Сортировка"}],"note":"Значение от 0 до ∞, где 0 - первая позиция ","conditions":[{"name":"Сортировка товаров","rule":{"_and":[{"sort":{"_gte":"0"}}]}}],"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"sort","conditions":[{"name":"Сортировка товаров","rule":{"_and":[{"sort":{"_gte":"0"}}]}}]}	\N	\N
204	258	products	2	{"sort":-124}	{"sort":-124}	\N	\N
205	260	directus_fields	38	{"id":38,"collection":"products","field":"sort","special":null,"interface":"input","options":{"iconLeft":"sort_by_alpha","min":0},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Сортировка"}],"note":"Значение от 0 до ∞, где 0 - первая позиция ","conditions":[{"name":"Сортировка товаров","rule":{"_and":[{"sort":{"_gte":"0"}}]},"required":true,"options":{"min":0}}],"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"sort","conditions":[{"name":"Сортировка товаров","rule":{"_and":[{"sort":{"_gte":"0"}}]},"required":true,"options":{"min":0}}]}	\N	\N
206	261	products	3	{"sort":-124}	{"sort":-124}	\N	\N
207	263	directus_fields	38	{"id":38,"collection":"products","field":"sort","special":null,"interface":"input","options":{"iconLeft":"sort_by_alpha","min":0},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Сортировка"}],"note":"Значение от 0 до ∞, где 0 - первая позиция ","conditions":[{"name":"Сортировка товаров","rule":{"_and":[{"sort":{"_gte":"0"}}]},"required":true,"options":{"min":0}}],"required":false,"group":null,"validation":{"_and":[{"sort":{"_gte":"0"}}]},"validation_message":null}	{"collection":"products","field":"sort","validation":{"_and":[{"sort":{"_gte":"0"}}]}}	\N	\N
208	264	directus_fields	38	{"id":38,"collection":"products","field":"sort","special":null,"interface":"input","options":{"iconLeft":"sort_by_alpha","min":0},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Сортировка"}],"note":"Значение от 0 до ∞, где 0 - первая позиция ","conditions":null,"required":false,"group":null,"validation":{"_and":[{"sort":{"_gte":"0"}}]},"validation_message":null}	{"collection":"products","field":"sort","conditions":null}	\N	\N
209	265	products	4	{"sort":0}	{"sort":0}	\N	\N
210	267	directus_fields	39	{"sort":6,"special":null,"interface":"input","required":true,"translations":[{"language":"ru-RU","translation":"Заголовок товара"}],"options":{"iconLeft":"title"},"display":"raw","collection":"products","field":"title"}	{"sort":6,"special":null,"interface":"input","required":true,"translations":[{"language":"ru-RU","translation":"Заголовок товара"}],"options":{"iconLeft":"title"},"display":"raw","collection":"products","field":"title"}	\N	\N
211	268	directus_fields	40	{"sort":7,"special":null,"interface":"input-multiline","translations":[{"language":"ru-RU","translation":"Описание товара"}],"display":"raw","collection":"products","field":"description"}	{"sort":7,"special":null,"interface":"input-multiline","translations":[{"language":"ru-RU","translation":"Описание товара"}],"display":"raw","collection":"products","field":"description"}	\N	\N
294	376	directus_collections	reason	{"singleton":false,"collection":"reason"}	{"singleton":false,"collection":"reason"}	\N	\N
681	765	structure	bebc96d9-1e70-4f51-abc4-a3898595f7d6	{"name":"Гипсофила"}	{"name":"Гипсофила"}	\N	\N
212	269	directus_fields	41	{"sort":8,"special":null,"interface":"input","translations":[{"language":"ru-RU","translation":"Описание размера товара"}],"note":"Ожидается формат \\"10x10x10см\\"","options":{"iconLeft":"resize"},"collection":"products","field":"size"}	{"sort":8,"special":null,"interface":"input","translations":[{"language":"ru-RU","translation":"Описание размера товара"}],"note":"Ожидается формат \\"10x10x10см\\"","options":{"iconLeft":"resize"},"collection":"products","field":"size"}	\N	\N
213	270	directus_fields	42	{"sort":9,"interface":"list","special":["cast-json"],"options":{"fields":[],"template":null},"collection":"products","field":"style"}	{"sort":9,"interface":"list","special":["cast-json"],"options":{"fields":[],"template":null},"collection":"products","field":"style"}	\N	\N
214	271	directus_fields	42	{"id":42,"collection":"products","field":"style","special":["cast-json"],"interface":"list","options":{"fields":[{"field":"item","name":"item","type":"string","meta":{"field":"item","type":"string","interface":"input","display":"formatted-value"}}],"template":null},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"style","options":{"fields":[{"field":"item","name":"item","type":"string","meta":{"field":"item","type":"string","interface":"input","display":"formatted-value"}}],"template":null}}	\N	\N
215	272	directus_fields	42	{"id":42,"collection":"products","field":"style","special":["cast-json"],"interface":"list","options":{"fields":[{"field":"item","name":"item","type":"string","meta":{"field":"item","type":"string","interface":"input","display":"formatted-value","width":"half","required":true,"options":{"softLength":25},"note":"Название"}}],"template":null},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":[{"language":"ru-RU","translation":"Стиль товара"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"style","options":{"fields":[{"field":"item","name":"item","type":"string","meta":{"field":"item","type":"string","interface":"input","display":"formatted-value","width":"half","required":true,"options":{"softLength":25},"note":"Название"}}],"template":null},"display":"raw","translations":[{"language":"ru-RU","translation":"Стиль товара"}]}	\N	\N
216	273	directus_fields	42	{"id":42,"collection":"products","field":"style","special":["cast-json"],"interface":"list","options":{"fields":[{"field":"item","name":"item","type":"string","meta":{"field":"item","type":"string","interface":"input","display":"formatted-value","width":"full","required":true,"options":{"softLength":25,"placeholder":"Название"},"note":null}}],"template":null},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":[{"language":"ru-RU","translation":"Стиль товара"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"style","options":{"fields":[{"field":"item","name":"item","type":"string","meta":{"field":"item","type":"string","interface":"input","display":"formatted-value","width":"full","required":true,"options":{"softLength":25,"placeholder":"Название"},"note":null}}],"template":null}}	\N	\N
217	274	directus_fields	42	{"id":42,"collection":"products","field":"style","special":["cast-json"],"interface":"list","options":{"fields":[{"field":"item","name":"item","type":"string","meta":{"field":"item","type":"string","interface":"input","display":"formatted-value","width":"full","required":true,"options":{"softLength":25,"placeholder":"Название"},"note":null}}],"template":null},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"half","translations":[{"language":"ru-RU","translation":"Стиль товара"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"style","width":"half"}	\N	\N
218	275	products	5	{"sort":1,"title":"Название букета","description":"Описание товара","size":"10х10х10см","style":[{"item":"Траурный"},{"item":"Праздничный"},{"item":"На свадьбу"}]}	{"sort":1,"title":"Название букета","description":"Описание товара","size":"10х10х10см","style":[{"item":"Траурный"},{"item":"Праздничный"},{"item":"На свадьбу"}]}	\N	\N
219	277	directus_fields	43	{"sort":10,"interface":"list","special":["cast-json"],"options":{"fields":[{"field":"item","name":"item","type":"string","meta":{"field":"item","width":"full","type":"string","interface":"input","options":{"placeholder":"Название","softLength":25},"display":"formatted-value"}}]},"collection":"products","field":"reason"}	{"sort":10,"interface":"list","special":["cast-json"],"options":{"fields":[{"field":"item","name":"item","type":"string","meta":{"field":"item","width":"full","type":"string","interface":"input","options":{"placeholder":"Название","softLength":25},"display":"formatted-value"}}]},"collection":"products","field":"reason"}	\N	\N
220	278	directus_fields	43	{"id":43,"collection":"products","field":"reason","special":["cast-json"],"interface":"list","options":{"fields":[{"field":"item","name":"item","type":"string","meta":{"field":"item","width":"full","type":"string","interface":"input","options":{"placeholder":"Название","softLength":25},"display":"formatted-value"}}]},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"reason","width":"half"}	\N	\N
221	279	directus_fields	43	{"id":43,"collection":"products","field":"reason","special":["cast-json"],"interface":"list","options":{"fields":[{"field":"item","name":"item","type":"string","meta":{"field":"item","width":"full","type":"string","interface":"input","options":{"placeholder":"Название","softLength":25},"display":"formatted-value"}}]},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"half","translations":[{"language":"ru-RU","translation":"Повод"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"reason","translations":[{"language":"ru-RU","translation":"Повод"}]}	\N	\N
222	281	directus_fields	44	{"sort":10,"special":["cast-csv"],"interface":"tags","options":{"choices":null,"whitespace":"-"},"display":"labels","collection":"products","field":"reason"}	{"sort":10,"special":["cast-csv"],"interface":"tags","options":{"choices":null,"whitespace":"-"},"display":"labels","collection":"products","field":"reason"}	\N	\N
223	282	products	6	{"reason":["ааа","sdbsbsdb","test","tag"],"title":"заголовок "}	{"reason":["ааа","sdbsbsdb","test","tag"],"title":"заголовок "}	\N	\N
226	287	directus_fields	46	{"sort":2,"interface":"input","special":null,"collection":"styles","field":"name"}	{"sort":2,"interface":"input","special":null,"collection":"styles","field":"name"}	\N	\N
232	294	directus_fields	48	{"sort":11,"interface":"list-o2m-tree-view","special":["o2m"],"options":{"choices":null,"enableCreate":false},"collection":"products","field":"style"}	{"sort":11,"interface":"list-o2m-tree-view","special":["o2m"],"options":{"choices":null,"enableCreate":false},"collection":"products","field":"style"}	\N	\N
233	295	directus_fields	46	{"id":46,"collection":"styles","field":"name","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"styles","field":"name","required":true}	\N	\N
234	297	directus_fields	49	{"sort":11,"interface":"list-o2m","special":["o2m"],"options":{"choices":null},"collection":"products","field":"style"}	{"sort":11,"interface":"list-o2m","special":["o2m"],"options":{"choices":null},"collection":"products","field":"style"}	\N	\N
235	298	directus_fields	50	{"sort":1,"hidden":true,"field":"id","collection":"products_style"}	{"sort":1,"hidden":true,"field":"id","collection":"products_style"}	\N	\N
236	299	directus_collections	products_style	{"hidden":true,"icon":"import_export","collection":"products_style"}	{"hidden":true,"icon":"import_export","collection":"products_style"}	\N	\N
237	300	directus_fields	51	{"sort":2,"hidden":true,"collection":"products_style","field":"products_id"}	{"sort":2,"hidden":true,"collection":"products_style","field":"products_id"}	\N	\N
238	301	directus_fields	52	{"sort":3,"hidden":true,"collection":"products_style","field":"item"}	{"sort":3,"hidden":true,"collection":"products_style","field":"item"}	\N	\N
239	302	directus_fields	53	{"sort":4,"hidden":true,"collection":"products_style","field":"collection"}	{"sort":4,"hidden":true,"collection":"products_style","field":"collection"}	\N	\N
240	304	directus_fields	54	{"sort":11,"interface":"list-o2m","special":["o2m"],"collection":"products","field":"style"}	{"sort":11,"interface":"list-o2m","special":["o2m"],"collection":"products","field":"style"}	\N	\N
241	306	directus_fields	55	{"sort":11,"interface":"list-o2m","special":["o2m"],"collection":"products","field":"style"}	{"sort":11,"interface":"list-o2m","special":["o2m"],"collection":"products","field":"style"}	\N	\N
242	308	directus_fields	56	{"sort":11,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"enableCreate":false},"collection":"products","field":"style"}	{"sort":11,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"enableCreate":false},"collection":"products","field":"style"}	\N	\N
243	310	directus_fields	57	{"sort":11,"interface":"list-o2m","special":["o2m"],"collection":"products","field":"style"}	{"sort":11,"interface":"list-o2m","special":["o2m"],"collection":"products","field":"style"}	\N	\N
244	312	directus_fields	58	{"sort":3,"special":["date-created"],"collection":"styles","field":"key"}	{"sort":3,"special":["date-created"],"collection":"styles","field":"key"}	\N	\N
245	313	directus_fields	58	{"id":58,"collection":"styles","field":"key","special":["date-created"],"interface":null,"options":null,"display":null,"display_options":null,"readonly":true,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"styles","field":"key","readonly":true}	\N	\N
246	314	styles	08d998f7-4405-4432-a27a-78bdb4af08b0	{"name":"ватват"}	{"name":"ватват"}	\N	\N
247	320	directus_fields	59	{"sort":11,"interface":"list-o2m","special":["o2m"],"collection":"products","field":"style"}	{"sort":11,"interface":"list-o2m","special":["o2m"],"collection":"products","field":"style"}	\N	\N
248	323	directus_fields	60	{"sort":11,"interface":"list-o2m","special":["o2m"],"collection":"products","field":"style"}	{"sort":11,"interface":"list-o2m","special":["o2m"],"collection":"products","field":"style"}	\N	\N
249	325	directus_fields	61	{"sort":11,"interface":"list-m2m","special":["m2m"],"options":{"enableCreate":false},"collection":"products","field":"style"}	{"sort":11,"interface":"list-m2m","special":["m2m"],"options":{"enableCreate":false},"collection":"products","field":"style"}	\N	\N
250	326	directus_fields	62	{"sort":1,"hidden":true,"field":"id","collection":"products_styles"}	{"sort":1,"hidden":true,"field":"id","collection":"products_styles"}	\N	\N
251	327	directus_collections	products_styles	{"hidden":true,"icon":"import_export","collection":"products_styles"}	{"hidden":true,"icon":"import_export","collection":"products_styles"}	\N	\N
252	328	directus_fields	63	{"sort":2,"hidden":true,"collection":"products_styles","field":"products_id"}	{"sort":2,"hidden":true,"collection":"products_styles","field":"products_id"}	\N	\N
253	329	directus_fields	64	{"sort":3,"hidden":true,"collection":"products_styles","field":"styles_id"}	{"sort":3,"hidden":true,"collection":"products_styles","field":"styles_id"}	\N	\N
254	330	styles	08f3242b-c68d-4b30-b9bb-f55f74a69e1b	{"name":"test"}	{"name":"test"}	\N	\N
255	331	styles	b81e5e55-b021-41f3-8bc1-9a8aa7c8f2e3	{"name":"test1"}	{"name":"test1"}	\N	\N
256	332	styles	ce78c5ec-3b62-4934-bcc7-70c543b24029	{"name":"test2"}	{"name":"test2"}	\N	\N
257	333	styles	a73e2648-e98e-43c0-8b49-bf883de7d5d4	{"name":"test3"}	{"name":"test3"}	\N	\N
260	336	products	7	{"sort":1,"title":"заголовок","description":"описание ","size":"10х10х10","style":{"create":[{"products_id":"+","styles_id":{"id":"08f3242b-c68d-4b30-b9bb-f55f74a69e1b"}},{"products_id":"+","styles_id":{"id":"a73e2648-e98e-43c0-8b49-bf883de7d5d4"}}],"update":[],"delete":[]}}	{"sort":1,"title":"заголовок","description":"описание ","size":"10х10х10","style":{"create":[{"products_id":"+","styles_id":{"id":"08f3242b-c68d-4b30-b9bb-f55f74a69e1b"}},{"products_id":"+","styles_id":{"id":"a73e2648-e98e-43c0-8b49-bf883de7d5d4"}}],"update":[],"delete":[]}}	\N	\N
258	334	products_styles	1	{"products_id":"7","styles_id":{"id":"08f3242b-c68d-4b30-b9bb-f55f74a69e1b"}}	{"products_id":"7","styles_id":{"id":"08f3242b-c68d-4b30-b9bb-f55f74a69e1b"}}	260	\N
259	335	products_styles	2	{"products_id":"7","styles_id":{"id":"a73e2648-e98e-43c0-8b49-bf883de7d5d4"}}	{"products_id":"7","styles_id":{"id":"a73e2648-e98e-43c0-8b49-bf883de7d5d4"}}	260	\N
261	342	directus_collections	attrs	{"collection":"attrs","icon":"folder","note":null,"color":null,"translations":[{"language":"ru-RU","translation":"Атрибуты товаров"}]}	{"collection":"attrs","icon":"folder","note":null,"color":null,"translations":[{"language":"ru-RU","translation":"Атрибуты товаров"}]}	\N	\N
262	343	directus_collections	products	{"collection":"products","icon":"stacks","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Товары","singular":"Товар","plural":"Товары"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
263	344	directus_collections	attrs	{"collection":"attrs","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Атрибуты товаров"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
264	345	directus_collections	seo_settings	{"collection":"seo_settings","icon":"folder","note":"Содержит коллекции, связанные с SEO-настройками страниц","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"SEO настройки"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
265	346	directus_collections	pages	{"collection":"pages","icon":"folder","note":"Содержит коллекции, связанные с контентной частью сайта","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":null}	\N	\N
266	347	directus_collections	products_style	{"collection":"products_style","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":5,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":5,"group":null}	\N	\N
267	348	directus_collections	products_styles	{"collection":"products_styles","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":6,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":6,"group":null}	\N	\N
268	349	directus_collections	styles	{"collection":"styles","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":7,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":7,"group":null}	\N	\N
269	351	directus_collections	products	{"collection":"products","icon":"stacks","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Товары","singular":"Товар","plural":"Товары"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
270	350	directus_collections	styles	{"collection":"styles","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"attrs","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"attrs"}	\N	\N
271	352	directus_collections	attrs	{"collection":"attrs","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Атрибуты товаров"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
272	353	directus_collections	seo_settings	{"collection":"seo_settings","icon":"folder","note":"Содержит коллекции, связанные с SEO-настройками страниц","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"SEO настройки"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
273	354	directus_collections	pages	{"collection":"pages","icon":"folder","note":"Содержит коллекции, связанные с контентной частью сайта","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":null}	\N	\N
274	355	directus_collections	products_style	{"collection":"products_style","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":5,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":5,"group":null}	\N	\N
275	356	directus_collections	products_styles	{"collection":"products_styles","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":6,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":6,"group":null}	\N	\N
276	357	directus_collections	styles	{"collection":"styles","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Стиль","singular":"Стиль","plural":"Стили"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"attrs","collapse":"open","preview_url":null,"versioning":false}	{"translations":[{"language":"ru-RU","translation":"Стиль","singular":"Стиль","plural":"Стили"}]}	\N	\N
295	377	directus_fields	68	{"sort":2,"interface":"input","special":null,"required":true,"translations":null,"collection":"reason","field":"name"}	{"sort":2,"interface":"input","special":null,"required":true,"translations":null,"collection":"reason","field":"name"}	\N	\N
277	358	directus_collections	styles	{"collection":"styles","icon":"settings_suggest","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Стиль","singular":"Стиль","plural":"Стили"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"attrs","collapse":"open","preview_url":null,"versioning":false}	{"icon":"settings_suggest"}	\N	\N
278	359	directus_fields	65	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"structure"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"structure"}	\N	\N
279	360	directus_collections	structure	{"singleton":false,"collection":"structure"}	{"singleton":false,"collection":"structure"}	\N	\N
280	361	directus_fields	66	{"sort":2,"interface":"input","special":null,"collection":"structure","field":"name"}	{"sort":2,"interface":"input","special":null,"collection":"structure","field":"name"}	\N	\N
281	362	directus_fields	66	{"id":66,"collection":"structure","field":"name","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"structure","field":"name","required":true}	\N	\N
282	363	directus_collections	styles	{"collection":"styles","icon":"settings_suggest","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Стиль","singular":"Стиль","plural":"Стили"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"attrs","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"attrs"}	\N	\N
283	364	directus_collections	structure	{"collection":"structure","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"attrs","collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":"attrs"}	\N	\N
284	365	directus_collections	products	{"collection":"products","icon":"stacks","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Товары","singular":"Товар","plural":"Товары"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
285	366	directus_collections	attrs	{"collection":"attrs","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Атрибуты товаров"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
286	367	directus_collections	seo_settings	{"collection":"seo_settings","icon":"folder","note":"Содержит коллекции, связанные с SEO-настройками страниц","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"SEO настройки"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
287	368	directus_collections	pages	{"collection":"pages","icon":"folder","note":"Содержит коллекции, связанные с контентной частью сайта","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":null}	\N	\N
288	369	directus_collections	products_style	{"collection":"products_style","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":5,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":5,"group":null}	\N	\N
289	370	directus_collections	products_styles	{"collection":"products_styles","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":6,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":6,"group":null}	\N	\N
290	371	directus_collections	structure	{"collection":"structure","icon":"settings_suggest","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"attrs","collapse":"open","preview_url":null,"versioning":false}	{"icon":"settings_suggest"}	\N	\N
291	372	directus_collections	structure	{"collection":"structure","icon":"settings_suggest","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Состав","singular":"Состав","plural":"Составы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"attrs","collapse":"open","preview_url":null,"versioning":false}	{"translations":[{"language":"ru-RU","translation":"Состав","singular":"Состав","plural":"Составы"}]}	\N	\N
292	374	directus_fields	61	{"id":61,"collection":"products","field":"style","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"style","width":"half"}	\N	\N
293	375	directus_fields	67	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"reason"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"reason"}	\N	\N
296	378	directus_collections	reason	{"collection":"reason","icon":"settings_suggest","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Поводы","singular":"Повод","plural":"Поводы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"icon":"settings_suggest","translations":[{"language":"ru-RU","translation":"Поводы","singular":"Повод","plural":"Поводы"}]}	\N	\N
297	379	directus_collections	styles	{"collection":"styles","icon":"settings_suggest","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Стиль","singular":"Стиль","plural":"Стили"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"attrs","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"attrs"}	\N	\N
298	380	directus_collections	structure	{"collection":"structure","icon":"settings_suggest","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Состав","singular":"Состав","plural":"Составы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"attrs","collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":"attrs"}	\N	\N
299	381	directus_collections	reason	{"collection":"reason","icon":"settings_suggest","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Поводы","singular":"Повод","plural":"Поводы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":"attrs","collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":"attrs"}	\N	\N
300	382	directus_collections	products	{"collection":"products","icon":"stacks","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Товары","singular":"Товар","plural":"Товары"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
301	383	directus_collections	attrs	{"collection":"attrs","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Атрибуты товаров"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
302	384	directus_collections	seo_settings	{"collection":"seo_settings","icon":"folder","note":"Содержит коллекции, связанные с SEO-настройками страниц","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"SEO настройки"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
303	385	directus_collections	pages	{"collection":"pages","icon":"folder","note":"Содержит коллекции, связанные с контентной частью сайта","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":null}	\N	\N
304	386	directus_collections	products_style	{"collection":"products_style","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":5,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":5,"group":null}	\N	\N
305	387	directus_collections	products_styles	{"collection":"products_styles","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":6,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":6,"group":null}	\N	\N
306	388	directus_fields	69	{"sort":12,"interface":"list-m2m","special":["m2m"],"options":{"enableCreate":false},"collection":"products","field":"reason"}	{"sort":12,"interface":"list-m2m","special":["m2m"],"options":{"enableCreate":false},"collection":"products","field":"reason"}	\N	\N
307	389	directus_fields	70	{"sort":1,"hidden":true,"field":"id","collection":"products_reason"}	{"sort":1,"hidden":true,"field":"id","collection":"products_reason"}	\N	\N
308	390	directus_collections	products_reason	{"hidden":true,"icon":"import_export","collection":"products_reason"}	{"hidden":true,"icon":"import_export","collection":"products_reason"}	\N	\N
309	391	directus_fields	71	{"sort":2,"hidden":true,"collection":"products_reason","field":"products_id"}	{"sort":2,"hidden":true,"collection":"products_reason","field":"products_id"}	\N	\N
310	392	directus_fields	72	{"sort":3,"hidden":true,"collection":"products_reason","field":"reason_id"}	{"sort":3,"hidden":true,"collection":"products_reason","field":"reason_id"}	\N	\N
311	393	directus_fields	69	{"id":69,"collection":"products","field":"reason","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"reason","width":"half"}	\N	\N
312	394	directus_fields	40	{"id":40,"collection":"products","field":"description","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","alignleft","aligncenter","alignright","numlist","bullist","removeformat","customLink","hr","fullscreen","code"]},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Описание товара"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"description","interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","alignleft","aligncenter","alignright","numlist","bullist","removeformat","customLink","hr","fullscreen","code"]}}	\N	\N
682	766	structure	1bf665f4-4a56-412d-a7e9-2fabc037b3ea	{"name":"Гортензия"}	{"name":"Гортензия"}	\N	\N
683	767	structure	2f0308a5-49f9-4bba-bb00-c0768cb131e2	{"name":"Декор"}	{"name":"Декор"}	\N	\N
313	395	directus_fields	61	{"id":61,"collection":"products","field":"style","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"half","translations":[{"language":"ru-RU","translation":"Стиль"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"style","translations":[{"language":"ru-RU","translation":"Стиль"}]}	\N	\N
314	396	directus_fields	69	{"id":69,"collection":"products","field":"reason","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"half","translations":[{"language":"ru-RU","translation":"Повод"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"reason","translations":[{"language":"ru-RU","translation":"Повод"}]}	\N	\N
315	397	directus_fields	73	{"sort":13,"interface":"input","special":null,"translations":[{"language":"ru-RU","translation":"Цена"}],"required":true,"options":{"iconLeft":"currency_ruble"},"display":"raw","collection":"products","field":"price"}	{"sort":13,"interface":"input","special":null,"translations":[{"language":"ru-RU","translation":"Цена"}],"required":true,"options":{"iconLeft":"currency_ruble"},"display":"raw","collection":"products","field":"price"}	\N	\N
316	398	directus_fields	34	{"id":34,"collection":"products","field":"id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"id","sort":1,"group":null}	\N	\N
317	399	directus_fields	35	{"id":35,"collection":"products","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_created","sort":2,"group":null}	\N	\N
318	400	directus_fields	36	{"id":36,"collection":"products","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_updated","sort":3,"group":null}	\N	\N
319	401	directus_fields	38	{"id":38,"collection":"products","field":"sort","special":null,"interface":"input","options":{"iconLeft":"sort_by_alpha","min":0},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Сортировка"}],"note":"Значение от 0 до ∞, где 0 - первая позиция ","conditions":null,"required":false,"group":null,"validation":{"_and":[{"sort":{"_gte":"0"}}]},"validation_message":null}	{"collection":"products","field":"sort","sort":4,"group":null}	\N	\N
320	402	directus_fields	37	{"id":37,"collection":"products","field":"available","special":["cast-boolean"],"interface":"boolean","options":{"label":"Доступно к покупке"},"display":"boolean","display_options":{"labelOn":"Доступен","labelOff":"Недоступен"},"readonly":false,"hidden":false,"sort":5,"width":"half","translations":[{"language":"ru-RU","translation":"В наличии"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"available","sort":5,"group":null}	\N	\N
321	403	directus_fields	39	{"id":39,"collection":"products","field":"title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок товара"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"title","sort":6,"group":null}	\N	\N
322	404	directus_fields	73	{"id":73,"collection":"products","field":"price","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Цена"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"price","sort":7,"group":null}	\N	\N
323	405	directus_fields	40	{"id":40,"collection":"products","field":"description","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","alignleft","aligncenter","alignright","numlist","bullist","removeformat","customLink","hr","fullscreen","code"]},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":[{"language":"ru-RU","translation":"Описание товара"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"description","sort":8,"group":null}	\N	\N
324	406	directus_fields	41	{"id":41,"collection":"products","field":"size","special":null,"interface":"input","options":{"iconLeft":"resize"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":[{"language":"ru-RU","translation":"Описание размера товара"}],"note":"Ожидается формат \\"10x10x10см\\"","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"size","sort":9,"group":null}	\N	\N
325	407	directus_fields	61	{"id":61,"collection":"products","field":"style","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"half","translations":[{"language":"ru-RU","translation":"Стиль"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"style","sort":10,"group":null}	\N	\N
326	408	directus_fields	69	{"id":69,"collection":"products","field":"reason","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"half","translations":[{"language":"ru-RU","translation":"Повод"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"reason","sort":11,"group":null}	\N	\N
684	768	structure	798d8553-02f6-4b1a-b1ef-b0b040049afc	{"name":"Дельфиниум"}	{"name":"Дельфиниум"}	\N	\N
685	769	structure	5a5f6a68-21db-4206-b28d-1e5b306a8e04	{"name":"Гениста"}	{"name":"Гениста"}	\N	\N
686	770	structure	513d8e30-8a1c-457d-a9ac-dc80c0060d5d	{"name":"Папоротник"}	{"name":"Папоротник"}	\N	\N
327	409	directus_fields	73	{"id":73,"collection":"products","field":"price","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"half","translations":[{"language":"ru-RU","translation":"Цена"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"price","width":"half"}	\N	\N
328	410	directus_fields	74	{"sort":12,"interface":"input","special":null,"translations":[{"language":"ru-RU","translation":"Цена со скидкой"}],"options":{"iconLeft":"currency_ruble"},"display":"raw","validation":{"_and":[{"discount":{"_lt":"price"}}]},"collection":"products","field":"discount"}	{"sort":12,"interface":"input","special":null,"translations":[{"language":"ru-RU","translation":"Цена со скидкой"}],"options":{"iconLeft":"currency_ruble"},"display":"raw","validation":{"_and":[{"discount":{"_lt":"price"}}]},"collection":"products","field":"discount"}	\N	\N
329	411	directus_fields	74	{"id":74,"collection":"products","field":"discount","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"full","translations":[{"language":"ru-RU","translation":"Цена со скидкой"}],"note":null,"conditions":null,"required":false,"group":null,"validation":{"_and":[{"discount":{"_lt":null}}]},"validation_message":null}	{"collection":"products","field":"discount","validation":{"_and":[{"discount":{"_lt":null}}]}}	\N	\N
330	412	directus_fields	74	{"id":74,"collection":"products","field":"discount","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"full","translations":[{"language":"ru-RU","translation":"Цена со скидкой"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"discount","validation":null}	\N	\N
331	413	directus_fields	74	{"id":74,"collection":"products","field":"discount","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"half","translations":[{"language":"ru-RU","translation":"Цена со скидкой"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"discount","width":"half"}	\N	\N
332	414	directus_fields	34	{"id":34,"collection":"products","field":"id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"id","sort":1,"group":null}	\N	\N
333	415	directus_fields	35	{"id":35,"collection":"products","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_created","sort":2,"group":null}	\N	\N
334	416	directus_fields	36	{"id":36,"collection":"products","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_updated","sort":3,"group":null}	\N	\N
335	417	directus_fields	38	{"id":38,"collection":"products","field":"sort","special":null,"interface":"input","options":{"iconLeft":"sort_by_alpha","min":0},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Сортировка"}],"note":"Значение от 0 до ∞, где 0 - первая позиция ","conditions":null,"required":false,"group":null,"validation":{"_and":[{"sort":{"_gte":"0"}}]},"validation_message":null}	{"collection":"products","field":"sort","sort":4,"group":null}	\N	\N
336	418	directus_fields	37	{"id":37,"collection":"products","field":"available","special":["cast-boolean"],"interface":"boolean","options":{"label":"Доступно к покупке"},"display":"boolean","display_options":{"labelOn":"Доступен","labelOff":"Недоступен"},"readonly":false,"hidden":false,"sort":5,"width":"half","translations":[{"language":"ru-RU","translation":"В наличии"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"available","sort":5,"group":null}	\N	\N
337	419	directus_fields	39	{"id":39,"collection":"products","field":"title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок товара"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"title","sort":6,"group":null}	\N	\N
338	420	directus_fields	73	{"id":73,"collection":"products","field":"price","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"half","translations":[{"language":"ru-RU","translation":"Цена"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"price","sort":7,"group":null}	\N	\N
339	421	directus_fields	74	{"id":74,"collection":"products","field":"discount","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"half","translations":[{"language":"ru-RU","translation":"Цена со скидкой"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"discount","sort":8,"group":null}	\N	\N
340	422	directus_fields	40	{"id":40,"collection":"products","field":"description","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","alignleft","aligncenter","alignright","numlist","bullist","removeformat","customLink","hr","fullscreen","code"]},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":[{"language":"ru-RU","translation":"Описание товара"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"description","sort":9,"group":null}	\N	\N
687	771	structure	2e7828b8-606a-4ba1-95ab-7318df95ebc3	{"name":"Илекс"}	{"name":"Илекс"}	\N	\N
688	772	structure	b369ba1d-ca4f-489a-ade9-17f88029d71e	{"name":"Ирис"}	{"name":"Ирис"}	\N	\N
341	423	directus_fields	41	{"id":41,"collection":"products","field":"size","special":null,"interface":"input","options":{"iconLeft":"resize"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":[{"language":"ru-RU","translation":"Описание размера товара"}],"note":"Ожидается формат \\"10x10x10см\\"","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"size","sort":10,"group":null}	\N	\N
342	424	directus_fields	61	{"id":61,"collection":"products","field":"style","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"half","translations":[{"language":"ru-RU","translation":"Стиль"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"style","sort":11,"group":null}	\N	\N
343	425	directus_fields	69	{"id":69,"collection":"products","field":"reason","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"half","translations":[{"language":"ru-RU","translation":"Повод"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"reason","sort":12,"group":null}	\N	\N
344	426	directus_fields	75	{"sort":13,"interface":"files","special":["files"],"required":true,"translations":[{"language":"ru-RU","translation":"Изображения"}],"display":"related-values","options":{"enableSelect":false},"collection":"products","field":"images"}	{"sort":13,"interface":"files","special":["files"],"required":true,"translations":[{"language":"ru-RU","translation":"Изображения"}],"display":"related-values","options":{"enableSelect":false},"collection":"products","field":"images"}	\N	\N
345	427	directus_fields	76	{"sort":1,"hidden":true,"field":"id","collection":"products_files"}	{"sort":1,"hidden":true,"field":"id","collection":"products_files"}	\N	\N
346	428	directus_collections	products_files	{"hidden":true,"icon":"import_export","collection":"products_files"}	{"hidden":true,"icon":"import_export","collection":"products_files"}	\N	\N
347	429	directus_fields	77	{"sort":2,"hidden":true,"collection":"products_files","field":"products_id"}	{"sort":2,"hidden":true,"collection":"products_files","field":"products_id"}	\N	\N
348	430	directus_fields	78	{"sort":3,"hidden":true,"collection":"products_files","field":"directus_files_id"}	{"sort":3,"hidden":true,"collection":"products_files","field":"directus_files_id"}	\N	\N
349	431	directus_fields	34	{"id":34,"collection":"products","field":"id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"id","sort":1,"group":null}	\N	\N
350	432	directus_fields	35	{"id":35,"collection":"products","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_created","sort":2,"group":null}	\N	\N
351	433	directus_fields	36	{"id":36,"collection":"products","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_updated","sort":3,"group":null}	\N	\N
352	434	directus_fields	38	{"id":38,"collection":"products","field":"sort","special":null,"interface":"input","options":{"iconLeft":"sort_by_alpha","min":0},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Сортировка"}],"note":"Значение от 0 до ∞, где 0 - первая позиция ","conditions":null,"required":false,"group":null,"validation":{"_and":[{"sort":{"_gte":"0"}}]},"validation_message":null}	{"collection":"products","field":"sort","sort":4,"group":null}	\N	\N
353	435	directus_fields	37	{"id":37,"collection":"products","field":"available","special":["cast-boolean"],"interface":"boolean","options":{"label":"Доступно к покупке"},"display":"boolean","display_options":{"labelOn":"Доступен","labelOff":"Недоступен"},"readonly":false,"hidden":false,"sort":5,"width":"half","translations":[{"language":"ru-RU","translation":"В наличии"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"available","sort":5,"group":null}	\N	\N
354	436	directus_fields	39	{"id":39,"collection":"products","field":"title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок товара"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"title","sort":6,"group":null}	\N	\N
355	437	directus_fields	73	{"id":73,"collection":"products","field":"price","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"half","translations":[{"language":"ru-RU","translation":"Цена"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"price","sort":7,"group":null}	\N	\N
356	438	directus_fields	74	{"id":74,"collection":"products","field":"discount","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"half","translations":[{"language":"ru-RU","translation":"Цена со скидкой"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"discount","sort":8,"group":null}	\N	\N
357	439	directus_fields	40	{"id":40,"collection":"products","field":"description","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","alignleft","aligncenter","alignright","numlist","bullist","removeformat","customLink","hr","fullscreen","code"]},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":[{"language":"ru-RU","translation":"Описание товара"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"description","sort":9,"group":null}	\N	\N
358	440	directus_fields	75	{"id":75,"collection":"products","field":"images","special":["files"],"interface":"files","options":{"enableSelect":false},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":[{"language":"ru-RU","translation":"Изображения"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"images","sort":10,"group":null}	\N	\N
359	441	directus_fields	41	{"id":41,"collection":"products","field":"size","special":null,"interface":"input","options":{"iconLeft":"resize"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"full","translations":[{"language":"ru-RU","translation":"Описание размера товара"}],"note":"Ожидается формат \\"10x10x10см\\"","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"size","sort":11,"group":null}	\N	\N
360	442	directus_fields	61	{"id":61,"collection":"products","field":"style","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"half","translations":[{"language":"ru-RU","translation":"Стиль"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"style","sort":12,"group":null}	\N	\N
361	443	directus_fields	69	{"id":69,"collection":"products","field":"reason","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":13,"width":"half","translations":[{"language":"ru-RU","translation":"Повод"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"reason","sort":13,"group":null}	\N	\N
362	444	directus_fields	75	{"id":75,"collection":"products","field":"images","special":["files"],"interface":"files","options":{},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":[{"language":"ru-RU","translation":"Изображения"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"images","options":{}}	\N	\N
363	445	directus_fields	79	{"sort":14,"interface":"list-m2m","special":["m2m"],"options":{"enableCreate":false},"translations":[{"language":"ru-RU","translation":"Состав"}],"display":"related-values","collection":"products","field":"structure"}	{"sort":14,"interface":"list-m2m","special":["m2m"],"options":{"enableCreate":false},"translations":[{"language":"ru-RU","translation":"Состав"}],"display":"related-values","collection":"products","field":"structure"}	\N	\N
364	446	directus_fields	80	{"sort":1,"hidden":true,"field":"id","collection":"products_structure"}	{"sort":1,"hidden":true,"field":"id","collection":"products_structure"}	\N	\N
365	447	directus_collections	products_structure	{"hidden":true,"icon":"import_export","collection":"products_structure"}	{"hidden":true,"icon":"import_export","collection":"products_structure"}	\N	\N
366	448	directus_fields	81	{"sort":2,"hidden":true,"collection":"products_structure","field":"products_id"}	{"sort":2,"hidden":true,"collection":"products_structure","field":"products_id"}	\N	\N
367	449	directus_fields	82	{"sort":3,"hidden":true,"collection":"products_structure","field":"structure_id"}	{"sort":3,"hidden":true,"collection":"products_structure","field":"structure_id"}	\N	\N
368	450	directus_fields	83	{"sort":15,"special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"settings","start":"closed"},"collection":"products","field":"tech"}	{"sort":15,"special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"settings","start":"closed"},"collection":"products","field":"tech"}	\N	\N
369	452	directus_fields	84	{"sort":15,"interface":"group-detail","special":["alias","no-data","group"],"options":{"start":"closed","headerIcon":"settings"},"collection":"products","field":"seo"}	{"sort":15,"interface":"group-detail","special":["alias","no-data","group"],"options":{"start":"closed","headerIcon":"settings"},"collection":"products","field":"seo"}	\N	\N
370	453	directus_fields	85	{"sort":16,"interface":"input","special":null,"options":{"iconLeft":"title"},"collection":"products","field":"seo_title"}	{"sort":16,"interface":"input","special":null,"options":{"iconLeft":"title"},"collection":"products","field":"seo_title"}	\N	\N
371	454	directus_fields	34	{"id":34,"collection":"products","field":"id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"id","sort":1,"group":null}	\N	\N
372	455	directus_fields	35	{"id":35,"collection":"products","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_created","sort":2,"group":null}	\N	\N
373	456	directus_fields	36	{"id":36,"collection":"products","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_updated","sort":3,"group":null}	\N	\N
374	457	directus_fields	38	{"id":38,"collection":"products","field":"sort","special":null,"interface":"input","options":{"iconLeft":"sort_by_alpha","min":0},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Сортировка"}],"note":"Значение от 0 до ∞, где 0 - первая позиция ","conditions":null,"required":false,"group":null,"validation":{"_and":[{"sort":{"_gte":"0"}}]},"validation_message":null}	{"collection":"products","field":"sort","sort":4,"group":null}	\N	\N
375	458	directus_fields	85	{"id":85,"collection":"products","field":"seo_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":"seo","validation":null,"validation_message":null}	{"collection":"products","field":"seo_title","sort":1,"group":"seo"}	\N	\N
392	475	directus_fields	86	{"id":86,"collection":"products","field":"seo_description","special":null,"interface":"input-multiline","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":"seo","validation":null,"validation_message":null}	{"collection":"products","field":"seo_description","sort":2,"group":"seo"}	\N	\N
376	459	directus_fields	37	{"id":37,"collection":"products","field":"available","special":["cast-boolean"],"interface":"boolean","options":{"label":"Доступно к покупке"},"display":"boolean","display_options":{"labelOn":"Доступен","labelOff":"Недоступен"},"readonly":false,"hidden":false,"sort":5,"width":"half","translations":[{"language":"ru-RU","translation":"В наличии"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"available","sort":5,"group":null}	\N	\N
377	460	directus_fields	39	{"id":39,"collection":"products","field":"title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок товара"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"title","sort":6,"group":null}	\N	\N
378	461	directus_fields	73	{"id":73,"collection":"products","field":"price","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"half","translations":[{"language":"ru-RU","translation":"Цена"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"price","sort":7,"group":null}	\N	\N
379	462	directus_fields	74	{"id":74,"collection":"products","field":"discount","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"half","translations":[{"language":"ru-RU","translation":"Цена со скидкой"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"discount","sort":8,"group":null}	\N	\N
380	463	directus_fields	40	{"id":40,"collection":"products","field":"description","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","alignleft","aligncenter","alignright","numlist","bullist","removeformat","customLink","hr","fullscreen","code"]},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":[{"language":"ru-RU","translation":"Описание товара"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"description","sort":9,"group":null}	\N	\N
381	464	directus_fields	75	{"id":75,"collection":"products","field":"images","special":["files"],"interface":"files","options":{},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":[{"language":"ru-RU","translation":"Изображения"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"images","sort":10,"group":null}	\N	\N
382	465	directus_fields	41	{"id":41,"collection":"products","field":"size","special":null,"interface":"input","options":{"iconLeft":"resize"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"full","translations":[{"language":"ru-RU","translation":"Описание размера товара"}],"note":"Ожидается формат \\"10x10x10см\\"","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"size","sort":11,"group":null}	\N	\N
383	466	directus_fields	61	{"id":61,"collection":"products","field":"style","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"half","translations":[{"language":"ru-RU","translation":"Стиль"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"style","sort":12,"group":null}	\N	\N
384	467	directus_fields	69	{"id":69,"collection":"products","field":"reason","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":13,"width":"half","translations":[{"language":"ru-RU","translation":"Повод"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"reason","sort":13,"group":null}	\N	\N
385	468	directus_fields	79	{"id":79,"collection":"products","field":"structure","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":14,"width":"full","translations":[{"language":"ru-RU","translation":"Состав"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"structure","sort":14,"group":null}	\N	\N
386	469	directus_fields	84	{"id":84,"collection":"products","field":"seo","special":["alias","no-data","group"],"interface":"group-detail","options":{"start":"closed","headerIcon":"settings"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":15,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"seo","sort":15,"group":null}	\N	\N
387	470	directus_fields	86	{"sort":16,"interface":"input-multiline","special":null,"collection":"products","field":"seo_description"}	{"sort":16,"interface":"input-multiline","special":null,"collection":"products","field":"seo_description"}	\N	\N
388	471	directus_fields	34	{"id":34,"collection":"products","field":"id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"id","sort":1,"group":null}	\N	\N
389	472	directus_fields	35	{"id":35,"collection":"products","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_created","sort":2,"group":null}	\N	\N
390	473	directus_fields	85	{"id":85,"collection":"products","field":"seo_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":"seo","validation":null,"validation_message":null}	{"collection":"products","field":"seo_title","sort":1,"group":"seo"}	\N	\N
689	773	structure	af6537ef-e504-4f18-8b70-59669339c5d6	{"name":"Калла"}	{"name":"Калла"}	\N	\N
690	774	structure	af13f74f-e163-4d06-a031-e64d8abfd766	{"name":"Клематис"}	{"name":"Клематис"}	\N	\N
391	474	directus_fields	36	{"id":36,"collection":"products","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_updated","sort":3,"group":null}	\N	\N
393	476	directus_fields	38	{"id":38,"collection":"products","field":"sort","special":null,"interface":"input","options":{"iconLeft":"sort_by_alpha","min":0},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Сортировка"}],"note":"Значение от 0 до ∞, где 0 - первая позиция ","conditions":null,"required":false,"group":null,"validation":{"_and":[{"sort":{"_gte":"0"}}]},"validation_message":null}	{"collection":"products","field":"sort","sort":4,"group":null}	\N	\N
394	477	directus_fields	37	{"id":37,"collection":"products","field":"available","special":["cast-boolean"],"interface":"boolean","options":{"label":"Доступно к покупке"},"display":"boolean","display_options":{"labelOn":"Доступен","labelOff":"Недоступен"},"readonly":false,"hidden":false,"sort":5,"width":"half","translations":[{"language":"ru-RU","translation":"В наличии"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"available","sort":5,"group":null}	\N	\N
395	478	directus_fields	39	{"id":39,"collection":"products","field":"title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок товара"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"title","sort":6,"group":null}	\N	\N
396	479	directus_fields	73	{"id":73,"collection":"products","field":"price","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"half","translations":[{"language":"ru-RU","translation":"Цена"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"price","sort":7,"group":null}	\N	\N
397	480	directus_fields	74	{"id":74,"collection":"products","field":"discount","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"half","translations":[{"language":"ru-RU","translation":"Цена со скидкой"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"discount","sort":8,"group":null}	\N	\N
398	481	directus_fields	40	{"id":40,"collection":"products","field":"description","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","alignleft","aligncenter","alignright","numlist","bullist","removeformat","customLink","hr","fullscreen","code"]},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":[{"language":"ru-RU","translation":"Описание товара"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"description","sort":9,"group":null}	\N	\N
399	482	directus_fields	75	{"id":75,"collection":"products","field":"images","special":["files"],"interface":"files","options":{},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":[{"language":"ru-RU","translation":"Изображения"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"images","sort":10,"group":null}	\N	\N
400	483	directus_fields	41	{"id":41,"collection":"products","field":"size","special":null,"interface":"input","options":{"iconLeft":"resize"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"full","translations":[{"language":"ru-RU","translation":"Описание размера товара"}],"note":"Ожидается формат \\"10x10x10см\\"","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"size","sort":11,"group":null}	\N	\N
401	484	directus_fields	61	{"id":61,"collection":"products","field":"style","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"half","translations":[{"language":"ru-RU","translation":"Стиль"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"style","sort":12,"group":null}	\N	\N
402	485	directus_fields	69	{"id":69,"collection":"products","field":"reason","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":13,"width":"half","translations":[{"language":"ru-RU","translation":"Повод"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"reason","sort":13,"group":null}	\N	\N
403	486	directus_fields	79	{"id":79,"collection":"products","field":"structure","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":14,"width":"full","translations":[{"language":"ru-RU","translation":"Состав"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"structure","sort":14,"group":null}	\N	\N
404	487	directus_fields	84	{"id":84,"collection":"products","field":"seo","special":["alias","no-data","group"],"interface":"group-detail","options":{"start":"closed","headerIcon":"settings"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":15,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"seo","sort":15,"group":null}	\N	\N
405	488	directus_fields	87	{"sort":16,"interface":"tags","special":["cast-csv"],"options":{"whitespace":"-","capitalization":"lowercase"},"collection":"products","field":"seo_keywords"}	{"sort":16,"interface":"tags","special":["cast-csv"],"options":{"whitespace":"-","capitalization":"lowercase"},"collection":"products","field":"seo_keywords"}	\N	\N
406	489	directus_fields	34	{"id":34,"collection":"products","field":"id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"id","sort":1,"group":null}	\N	\N
407	490	directus_fields	35	{"id":35,"collection":"products","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_created","sort":2,"group":null}	\N	\N
408	491	directus_fields	36	{"id":36,"collection":"products","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_updated","sort":3,"group":null}	\N	\N
409	492	directus_fields	38	{"id":38,"collection":"products","field":"sort","special":null,"interface":"input","options":{"iconLeft":"sort_by_alpha","min":0},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Сортировка"}],"note":"Значение от 0 до ∞, где 0 - первая позиция ","conditions":null,"required":false,"group":null,"validation":{"_and":[{"sort":{"_gte":"0"}}]},"validation_message":null}	{"collection":"products","field":"sort","sort":4,"group":null}	\N	\N
410	493	directus_fields	85	{"id":85,"collection":"products","field":"seo_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":"seo","validation":null,"validation_message":null}	{"collection":"products","field":"seo_title","sort":1,"group":"seo"}	\N	\N
411	494	directus_fields	37	{"id":37,"collection":"products","field":"available","special":["cast-boolean"],"interface":"boolean","options":{"label":"Доступно к покупке"},"display":"boolean","display_options":{"labelOn":"Доступен","labelOff":"Недоступен"},"readonly":false,"hidden":false,"sort":5,"width":"half","translations":[{"language":"ru-RU","translation":"В наличии"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"available","sort":5,"group":null}	\N	\N
412	495	directus_fields	86	{"id":86,"collection":"products","field":"seo_description","special":null,"interface":"input-multiline","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":"seo","validation":null,"validation_message":null}	{"collection":"products","field":"seo_description","sort":2,"group":"seo"}	\N	\N
413	496	directus_fields	39	{"id":39,"collection":"products","field":"title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок товара"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"title","sort":6,"group":null}	\N	\N
414	497	directus_fields	87	{"id":87,"collection":"products","field":"seo_keywords","special":["cast-csv"],"interface":"tags","options":{"whitespace":"-","capitalization":"lowercase"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":"seo","validation":null,"validation_message":null}	{"collection":"products","field":"seo_keywords","sort":3,"group":"seo"}	\N	\N
415	498	directus_fields	73	{"id":73,"collection":"products","field":"price","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"half","translations":[{"language":"ru-RU","translation":"Цена"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"price","sort":7,"group":null}	\N	\N
416	499	directus_fields	74	{"id":74,"collection":"products","field":"discount","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"half","translations":[{"language":"ru-RU","translation":"Цена со скидкой"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"discount","sort":8,"group":null}	\N	\N
417	500	directus_fields	40	{"id":40,"collection":"products","field":"description","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","alignleft","aligncenter","alignright","numlist","bullist","removeformat","customLink","hr","fullscreen","code"]},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":[{"language":"ru-RU","translation":"Описание товара"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"description","sort":9,"group":null}	\N	\N
418	501	directus_fields	75	{"id":75,"collection":"products","field":"images","special":["files"],"interface":"files","options":{},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":[{"language":"ru-RU","translation":"Изображения"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"images","sort":10,"group":null}	\N	\N
419	502	directus_fields	41	{"id":41,"collection":"products","field":"size","special":null,"interface":"input","options":{"iconLeft":"resize"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"full","translations":[{"language":"ru-RU","translation":"Описание размера товара"}],"note":"Ожидается формат \\"10x10x10см\\"","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"size","sort":11,"group":null}	\N	\N
420	503	directus_fields	61	{"id":61,"collection":"products","field":"style","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"half","translations":[{"language":"ru-RU","translation":"Стиль"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"style","sort":12,"group":null}	\N	\N
421	504	directus_fields	69	{"id":69,"collection":"products","field":"reason","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":13,"width":"half","translations":[{"language":"ru-RU","translation":"Повод"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"reason","sort":13,"group":null}	\N	\N
422	505	directus_fields	79	{"id":79,"collection":"products","field":"structure","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":14,"width":"full","translations":[{"language":"ru-RU","translation":"Состав"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"structure","sort":14,"group":null}	\N	\N
423	506	directus_fields	84	{"id":84,"collection":"products","field":"seo","special":["alias","no-data","group"],"interface":"group-detail","options":{"start":"closed","headerIcon":"settings"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":15,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"seo","sort":15,"group":null}	\N	\N
424	507	directus_collections	products	{"collection":"products","icon":"stacks","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Товары","singular":"Товар","plural":"Товары"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort_field":"sort"}	\N	\N
425	508	directus_fields	88	{"sort":16,"interface":"group-detail","special":["alias","no-data","group"],"options":{"headerIcon":"tag"},"collection":"products","field":"attrs"}	{"sort":16,"interface":"group-detail","special":["alias","no-data","group"],"options":{"headerIcon":"tag"},"collection":"products","field":"attrs"}	\N	\N
426	509	directus_fields	34	{"id":34,"collection":"products","field":"id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"id","sort":1,"group":null}	\N	\N
427	510	directus_fields	35	{"id":35,"collection":"products","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_created","sort":2,"group":null}	\N	\N
428	511	directus_fields	36	{"id":36,"collection":"products","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_updated","sort":3,"group":null}	\N	\N
429	512	directus_fields	38	{"id":38,"collection":"products","field":"sort","special":null,"interface":"input","options":{"iconLeft":"sort_by_alpha","min":0},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Сортировка"}],"note":"Значение от 0 до ∞, где 0 - первая позиция ","conditions":null,"required":false,"group":null,"validation":{"_and":[{"sort":{"_gte":"0"}}]},"validation_message":null}	{"collection":"products","field":"sort","sort":4,"group":null}	\N	\N
430	513	directus_fields	37	{"id":37,"collection":"products","field":"available","special":["cast-boolean"],"interface":"boolean","options":{"label":"Доступно к покупке"},"display":"boolean","display_options":{"labelOn":"Доступен","labelOff":"Недоступен"},"readonly":false,"hidden":false,"sort":5,"width":"half","translations":[{"language":"ru-RU","translation":"В наличии"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"available","sort":5,"group":null}	\N	\N
431	514	directus_fields	39	{"id":39,"collection":"products","field":"title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок товара"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"title","sort":6,"group":null}	\N	\N
432	515	directus_fields	73	{"id":73,"collection":"products","field":"price","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"half","translations":[{"language":"ru-RU","translation":"Цена"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"price","sort":7,"group":null}	\N	\N
433	516	directus_fields	74	{"id":74,"collection":"products","field":"discount","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"half","translations":[{"language":"ru-RU","translation":"Цена со скидкой"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"discount","sort":8,"group":null}	\N	\N
434	517	directus_fields	40	{"id":40,"collection":"products","field":"description","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","alignleft","aligncenter","alignright","numlist","bullist","removeformat","customLink","hr","fullscreen","code"]},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":[{"language":"ru-RU","translation":"Описание товара"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"description","sort":9,"group":null}	\N	\N
435	518	directus_fields	75	{"id":75,"collection":"products","field":"images","special":["files"],"interface":"files","options":{},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":[{"language":"ru-RU","translation":"Изображения"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"images","sort":10,"group":null}	\N	\N
436	519	directus_fields	41	{"id":41,"collection":"products","field":"size","special":null,"interface":"input","options":{"iconLeft":"resize"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"full","translations":[{"language":"ru-RU","translation":"Описание размера товара"}],"note":"Ожидается формат \\"10x10x10см\\"","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"size","sort":11,"group":null}	\N	\N
437	520	directus_fields	88	{"id":88,"collection":"products","field":"attrs","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"tag"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"attrs","sort":12,"group":null}	\N	\N
438	521	directus_fields	61	{"id":61,"collection":"products","field":"style","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":13,"width":"half","translations":[{"language":"ru-RU","translation":"Стиль"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"style","sort":13,"group":null}	\N	\N
439	522	directus_fields	69	{"id":69,"collection":"products","field":"reason","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":14,"width":"half","translations":[{"language":"ru-RU","translation":"Повод"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"reason","sort":14,"group":null}	\N	\N
440	523	directus_fields	79	{"id":79,"collection":"products","field":"structure","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":15,"width":"full","translations":[{"language":"ru-RU","translation":"Состав"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"structure","sort":15,"group":null}	\N	\N
441	524	directus_fields	84	{"id":84,"collection":"products","field":"seo","special":["alias","no-data","group"],"interface":"group-detail","options":{"start":"closed","headerIcon":"settings"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":16,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"seo","sort":16,"group":null}	\N	\N
442	525	directus_fields	61	{"id":61,"collection":"products","field":"style","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":[{"language":"ru-RU","translation":"Стиль"}],"note":null,"conditions":null,"required":false,"group":"attrs","validation":null,"validation_message":null}	{"collection":"products","field":"style","sort":1,"group":"attrs"}	\N	\N
443	526	directus_fields	34	{"id":34,"collection":"products","field":"id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"id","sort":1,"group":null}	\N	\N
444	527	directus_fields	35	{"id":35,"collection":"products","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_created","sort":2,"group":null}	\N	\N
445	528	directus_fields	36	{"id":36,"collection":"products","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_updated","sort":3,"group":null}	\N	\N
446	529	directus_fields	38	{"id":38,"collection":"products","field":"sort","special":null,"interface":"input","options":{"iconLeft":"sort_by_alpha","min":0},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Сортировка"}],"note":"Значение от 0 до ∞, где 0 - первая позиция ","conditions":null,"required":false,"group":null,"validation":{"_and":[{"sort":{"_gte":"0"}}]},"validation_message":null}	{"collection":"products","field":"sort","sort":4,"group":null}	\N	\N
447	530	directus_fields	37	{"id":37,"collection":"products","field":"available","special":["cast-boolean"],"interface":"boolean","options":{"label":"Доступно к покупке"},"display":"boolean","display_options":{"labelOn":"Доступен","labelOff":"Недоступен"},"readonly":false,"hidden":false,"sort":5,"width":"half","translations":[{"language":"ru-RU","translation":"В наличии"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"available","sort":5,"group":null}	\N	\N
448	531	directus_fields	39	{"id":39,"collection":"products","field":"title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок товара"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"title","sort":6,"group":null}	\N	\N
449	532	directus_fields	73	{"id":73,"collection":"products","field":"price","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"half","translations":[{"language":"ru-RU","translation":"Цена"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"price","sort":7,"group":null}	\N	\N
450	533	directus_fields	74	{"id":74,"collection":"products","field":"discount","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"half","translations":[{"language":"ru-RU","translation":"Цена со скидкой"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"discount","sort":8,"group":null}	\N	\N
451	534	directus_fields	40	{"id":40,"collection":"products","field":"description","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","alignleft","aligncenter","alignright","numlist","bullist","removeformat","customLink","hr","fullscreen","code"]},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":[{"language":"ru-RU","translation":"Описание товара"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"description","sort":9,"group":null}	\N	\N
452	535	directus_fields	75	{"id":75,"collection":"products","field":"images","special":["files"],"interface":"files","options":{},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":[{"language":"ru-RU","translation":"Изображения"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"images","sort":10,"group":null}	\N	\N
453	536	directus_fields	41	{"id":41,"collection":"products","field":"size","special":null,"interface":"input","options":{"iconLeft":"resize"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"full","translations":[{"language":"ru-RU","translation":"Описание размера товара"}],"note":"Ожидается формат \\"10x10x10см\\"","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"size","sort":11,"group":null}	\N	\N
454	537	directus_fields	88	{"id":88,"collection":"products","field":"attrs","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"tag"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"attrs","sort":12,"group":null}	\N	\N
455	538	directus_fields	69	{"id":69,"collection":"products","field":"reason","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":13,"width":"half","translations":[{"language":"ru-RU","translation":"Повод"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"reason","sort":13,"group":null}	\N	\N
456	539	directus_fields	79	{"id":79,"collection":"products","field":"structure","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":14,"width":"full","translations":[{"language":"ru-RU","translation":"Состав"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"structure","sort":14,"group":null}	\N	\N
457	540	directus_fields	84	{"id":84,"collection":"products","field":"seo","special":["alias","no-data","group"],"interface":"group-detail","options":{"start":"closed","headerIcon":"settings"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":15,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"seo","sort":15,"group":null}	\N	\N
458	541	directus_fields	61	{"id":61,"collection":"products","field":"style","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":[{"language":"ru-RU","translation":"Стиль"}],"note":null,"conditions":null,"required":false,"group":"attrs","validation":null,"validation_message":null}	{"collection":"products","field":"style","sort":1,"group":"attrs"}	\N	\N
459	542	directus_fields	34	{"id":34,"collection":"products","field":"id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"id","sort":1,"group":null}	\N	\N
460	543	directus_fields	69	{"id":69,"collection":"products","field":"reason","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":[{"language":"ru-RU","translation":"Повод"}],"note":null,"conditions":null,"required":false,"group":"attrs","validation":null,"validation_message":null}	{"collection":"products","field":"reason","sort":2,"group":"attrs"}	\N	\N
461	544	directus_fields	35	{"id":35,"collection":"products","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_created","sort":2,"group":null}	\N	\N
462	545	directus_fields	36	{"id":36,"collection":"products","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_updated","sort":3,"group":null}	\N	\N
463	546	directus_fields	38	{"id":38,"collection":"products","field":"sort","special":null,"interface":"input","options":{"iconLeft":"sort_by_alpha","min":0},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Сортировка"}],"note":"Значение от 0 до ∞, где 0 - первая позиция ","conditions":null,"required":false,"group":null,"validation":{"_and":[{"sort":{"_gte":"0"}}]},"validation_message":null}	{"collection":"products","field":"sort","sort":4,"group":null}	\N	\N
464	547	directus_fields	37	{"id":37,"collection":"products","field":"available","special":["cast-boolean"],"interface":"boolean","options":{"label":"Доступно к покупке"},"display":"boolean","display_options":{"labelOn":"Доступен","labelOff":"Недоступен"},"readonly":false,"hidden":false,"sort":5,"width":"half","translations":[{"language":"ru-RU","translation":"В наличии"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"available","sort":5,"group":null}	\N	\N
465	548	directus_fields	39	{"id":39,"collection":"products","field":"title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок товара"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"title","sort":6,"group":null}	\N	\N
466	549	directus_fields	73	{"id":73,"collection":"products","field":"price","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"half","translations":[{"language":"ru-RU","translation":"Цена"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"price","sort":7,"group":null}	\N	\N
691	775	structure	1c47e146-d72e-4034-8aa9-11faabcba8e7	{"name":"Краспедия"}	{"name":"Краспедия"}	\N	\N
467	550	directus_fields	74	{"id":74,"collection":"products","field":"discount","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"half","translations":[{"language":"ru-RU","translation":"Цена со скидкой"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"discount","sort":8,"group":null}	\N	\N
468	551	directus_fields	40	{"id":40,"collection":"products","field":"description","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","alignleft","aligncenter","alignright","numlist","bullist","removeformat","customLink","hr","fullscreen","code"]},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":[{"language":"ru-RU","translation":"Описание товара"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"description","sort":9,"group":null}	\N	\N
469	552	directus_fields	75	{"id":75,"collection":"products","field":"images","special":["files"],"interface":"files","options":{},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":[{"language":"ru-RU","translation":"Изображения"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"images","sort":10,"group":null}	\N	\N
470	553	directus_fields	41	{"id":41,"collection":"products","field":"size","special":null,"interface":"input","options":{"iconLeft":"resize"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"full","translations":[{"language":"ru-RU","translation":"Описание размера товара"}],"note":"Ожидается формат \\"10x10x10см\\"","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"size","sort":11,"group":null}	\N	\N
471	554	directus_fields	88	{"id":88,"collection":"products","field":"attrs","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"tag"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"attrs","sort":12,"group":null}	\N	\N
472	555	directus_fields	79	{"id":79,"collection":"products","field":"structure","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":13,"width":"full","translations":[{"language":"ru-RU","translation":"Состав"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"structure","sort":13,"group":null}	\N	\N
473	556	directus_fields	84	{"id":84,"collection":"products","field":"seo","special":["alias","no-data","group"],"interface":"group-detail","options":{"start":"closed","headerIcon":"settings"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":14,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"seo","sort":14,"group":null}	\N	\N
474	557	directus_fields	34	{"id":34,"collection":"products","field":"id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"id","sort":1,"group":null}	\N	\N
476	559	directus_fields	35	{"id":35,"collection":"products","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_created","sort":2,"group":null}	\N	\N
478	561	directus_fields	36	{"id":36,"collection":"products","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_updated","sort":3,"group":null}	\N	\N
480	563	directus_fields	38	{"id":38,"collection":"products","field":"sort","special":null,"interface":"input","options":{"iconLeft":"sort_by_alpha","min":0},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Сортировка"}],"note":"Значение от 0 до ∞, где 0 - первая позиция ","conditions":null,"required":false,"group":null,"validation":{"_and":[{"sort":{"_gte":"0"}}]},"validation_message":null}	{"collection":"products","field":"sort","sort":4,"group":null}	\N	\N
481	564	directus_fields	37	{"id":37,"collection":"products","field":"available","special":["cast-boolean"],"interface":"boolean","options":{"label":"Доступно к покупке"},"display":"boolean","display_options":{"labelOn":"Доступен","labelOff":"Недоступен"},"readonly":false,"hidden":false,"sort":5,"width":"half","translations":[{"language":"ru-RU","translation":"В наличии"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"available","sort":5,"group":null}	\N	\N
482	565	directus_fields	39	{"id":39,"collection":"products","field":"title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок товара"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"title","sort":6,"group":null}	\N	\N
483	566	directus_fields	73	{"id":73,"collection":"products","field":"price","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"half","translations":[{"language":"ru-RU","translation":"Цена"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"price","sort":7,"group":null}	\N	\N
507	590	directus_fields	34	{"id":34,"collection":"products","field":"id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"id","sort":1,"group":null}	\N	\N
475	558	directus_fields	61	{"id":61,"collection":"products","field":"style","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":[{"language":"ru-RU","translation":"Стиль"}],"note":null,"conditions":null,"required":false,"group":"attrs","validation":null,"validation_message":null}	{"collection":"products","field":"style","sort":1,"group":"attrs"}	\N	\N
477	560	directus_fields	69	{"id":69,"collection":"products","field":"reason","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":[{"language":"ru-RU","translation":"Повод"}],"note":null,"conditions":null,"required":false,"group":"attrs","validation":null,"validation_message":null}	{"collection":"products","field":"reason","sort":2,"group":"attrs"}	\N	\N
479	562	directus_fields	79	{"id":79,"collection":"products","field":"structure","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Состав"}],"note":null,"conditions":null,"required":false,"group":"attrs","validation":null,"validation_message":null}	{"collection":"products","field":"structure","sort":3,"group":"attrs"}	\N	\N
484	567	directus_fields	74	{"id":74,"collection":"products","field":"discount","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"half","translations":[{"language":"ru-RU","translation":"Цена со скидкой"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"discount","sort":8,"group":null}	\N	\N
485	568	directus_fields	40	{"id":40,"collection":"products","field":"description","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","alignleft","aligncenter","alignright","numlist","bullist","removeformat","customLink","hr","fullscreen","code"]},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":[{"language":"ru-RU","translation":"Описание товара"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"description","sort":9,"group":null}	\N	\N
486	569	directus_fields	75	{"id":75,"collection":"products","field":"images","special":["files"],"interface":"files","options":{},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":[{"language":"ru-RU","translation":"Изображения"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"images","sort":10,"group":null}	\N	\N
487	570	directus_fields	41	{"id":41,"collection":"products","field":"size","special":null,"interface":"input","options":{"iconLeft":"resize"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"full","translations":[{"language":"ru-RU","translation":"Описание размера товара"}],"note":"Ожидается формат \\"10x10x10см\\"","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"size","sort":11,"group":null}	\N	\N
488	571	directus_fields	88	{"id":88,"collection":"products","field":"attrs","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"tag"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"attrs","sort":12,"group":null}	\N	\N
489	572	directus_fields	84	{"id":84,"collection":"products","field":"seo","special":["alias","no-data","group"],"interface":"group-detail","options":{"start":"closed","headerIcon":"settings"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":13,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"seo","sort":13,"group":null}	\N	\N
490	573	directus_fields	88	{"id":88,"collection":"products","field":"attrs","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"tag"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"full","translations":[{"language":"ru-RU","translation":"Атрибуты"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"attrs","translations":[{"language":"ru-RU","translation":"Атрибуты"}]}	\N	\N
491	574	directus_fields	89	{"sort":14,"interface":"group-detail","special":["alias","no-data","group"],"options":{"headerIcon":"admin_panel_settings"},"translations":[{"language":"ru-RU","translation":"Настройки"}],"collection":"products","field":"tech"}	{"sort":14,"interface":"group-detail","special":["alias","no-data","group"],"options":{"headerIcon":"admin_panel_settings"},"translations":[{"language":"ru-RU","translation":"Настройки"}],"collection":"products","field":"tech"}	\N	\N
492	575	directus_fields	34	{"id":34,"collection":"products","field":"id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"id","sort":1,"group":null}	\N	\N
493	576	directus_fields	35	{"id":35,"collection":"products","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_created","sort":2,"group":null}	\N	\N
494	577	directus_fields	36	{"id":36,"collection":"products","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_updated","sort":3,"group":null}	\N	\N
495	578	directus_fields	38	{"id":38,"collection":"products","field":"sort","special":null,"interface":"input","options":{"iconLeft":"sort_by_alpha","min":0},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Сортировка"}],"note":"Значение от 0 до ∞, где 0 - первая позиция ","conditions":null,"required":false,"group":null,"validation":{"_and":[{"sort":{"_gte":"0"}}]},"validation_message":null}	{"collection":"products","field":"sort","sort":4,"group":null}	\N	\N
496	579	directus_fields	37	{"id":37,"collection":"products","field":"available","special":["cast-boolean"],"interface":"boolean","options":{"label":"Доступно к покупке"},"display":"boolean","display_options":{"labelOn":"Доступен","labelOff":"Недоступен"},"readonly":false,"hidden":false,"sort":5,"width":"half","translations":[{"language":"ru-RU","translation":"В наличии"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"available","sort":5,"group":null}	\N	\N
497	580	directus_fields	39	{"id":39,"collection":"products","field":"title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок товара"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"title","sort":6,"group":null}	\N	\N
664	748	structure	6c806a81-0850-416a-8bbc-03b3f5c81773	{"name":"Брассика"}	{"name":"Брассика"}	\N	\N
665	749	structure	58ab621c-5a51-4ddb-b2e9-95d0b5ec884c	{"name":"Бруния"}	{"name":"Бруния"}	\N	\N
666	750	structure	14c95af4-698a-43c0-995a-9103eb34f406	{"name":"Бавардия"}	{"name":"Бавардия"}	\N	\N
498	581	directus_fields	73	{"id":73,"collection":"products","field":"price","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"half","translations":[{"language":"ru-RU","translation":"Цена"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"price","sort":7,"group":null}	\N	\N
499	582	directus_fields	74	{"id":74,"collection":"products","field":"discount","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"half","translations":[{"language":"ru-RU","translation":"Цена со скидкой"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"discount","sort":8,"group":null}	\N	\N
500	583	directus_fields	40	{"id":40,"collection":"products","field":"description","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","alignleft","aligncenter","alignright","numlist","bullist","removeformat","customLink","hr","fullscreen","code"]},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":[{"language":"ru-RU","translation":"Описание товара"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"description","sort":9,"group":null}	\N	\N
501	584	directus_fields	75	{"id":75,"collection":"products","field":"images","special":["files"],"interface":"files","options":{},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":[{"language":"ru-RU","translation":"Изображения"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"images","sort":10,"group":null}	\N	\N
502	585	directus_fields	41	{"id":41,"collection":"products","field":"size","special":null,"interface":"input","options":{"iconLeft":"resize"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"full","translations":[{"language":"ru-RU","translation":"Описание размера товара"}],"note":"Ожидается формат \\"10x10x10см\\"","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"size","sort":11,"group":null}	\N	\N
503	586	directus_fields	88	{"id":88,"collection":"products","field":"attrs","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"tag"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"full","translations":[{"language":"ru-RU","translation":"Атрибуты"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"attrs","sort":12,"group":null}	\N	\N
504	587	directus_fields	89	{"id":89,"collection":"products","field":"tech","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"admin_panel_settings"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":13,"width":"full","translations":[{"language":"ru-RU","translation":"Настройки"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"tech","sort":13,"group":null}	\N	\N
505	588	directus_fields	84	{"id":84,"collection":"products","field":"seo","special":["alias","no-data","group"],"interface":"group-detail","options":{"start":"closed","headerIcon":"settings"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":14,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"seo","sort":14,"group":null}	\N	\N
506	589	directus_fields	38	{"id":38,"collection":"products","field":"sort","special":null,"interface":"input","options":{"iconLeft":"sort_by_alpha","min":0},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":[{"language":"ru-RU","translation":"Сортировка"}],"note":"Значение от 0 до ∞, где 0 - первая позиция ","conditions":null,"required":false,"group":"tech","validation":{"_and":[{"sort":{"_gte":"0"}}]},"validation_message":null}	{"collection":"products","field":"sort","sort":1,"group":"tech"}	\N	\N
508	591	directus_fields	35	{"id":35,"collection":"products","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_created","sort":2,"group":null}	\N	\N
509	592	directus_fields	36	{"id":36,"collection":"products","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_updated","sort":3,"group":null}	\N	\N
510	593	directus_fields	37	{"id":37,"collection":"products","field":"available","special":["cast-boolean"],"interface":"boolean","options":{"label":"Доступно к покупке"},"display":"boolean","display_options":{"labelOn":"Доступен","labelOff":"Недоступен"},"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"В наличии"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"available","sort":4,"group":null}	\N	\N
511	594	directus_fields	39	{"id":39,"collection":"products","field":"title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок товара"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"title","sort":5,"group":null}	\N	\N
512	595	directus_fields	73	{"id":73,"collection":"products","field":"price","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"half","translations":[{"language":"ru-RU","translation":"Цена"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"price","sort":6,"group":null}	\N	\N
513	596	directus_fields	74	{"id":74,"collection":"products","field":"discount","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"half","translations":[{"language":"ru-RU","translation":"Цена со скидкой"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"discount","sort":7,"group":null}	\N	\N
514	597	directus_fields	40	{"id":40,"collection":"products","field":"description","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","alignleft","aligncenter","alignright","numlist","bullist","removeformat","customLink","hr","fullscreen","code"]},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":[{"language":"ru-RU","translation":"Описание товара"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"description","sort":8,"group":null}	\N	\N
515	598	directus_fields	75	{"id":75,"collection":"products","field":"images","special":["files"],"interface":"files","options":{},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":[{"language":"ru-RU","translation":"Изображения"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"images","sort":9,"group":null}	\N	\N
516	599	directus_fields	41	{"id":41,"collection":"products","field":"size","special":null,"interface":"input","options":{"iconLeft":"resize"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":[{"language":"ru-RU","translation":"Описание размера товара"}],"note":"Ожидается формат \\"10x10x10см\\"","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"size","sort":10,"group":null}	\N	\N
517	600	directus_fields	88	{"id":88,"collection":"products","field":"attrs","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"tag"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"full","translations":[{"language":"ru-RU","translation":"Атрибуты"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"attrs","sort":11,"group":null}	\N	\N
518	601	directus_fields	89	{"id":89,"collection":"products","field":"tech","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"admin_panel_settings"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"full","translations":[{"language":"ru-RU","translation":"Настройки"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"tech","sort":12,"group":null}	\N	\N
519	602	directus_fields	84	{"id":84,"collection":"products","field":"seo","special":["alias","no-data","group"],"interface":"group-detail","options":{"start":"closed","headerIcon":"settings"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":13,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"seo","sort":13,"group":null}	\N	\N
520	603	directus_fields	38	{"id":38,"collection":"products","field":"sort","special":null,"interface":"input","options":{"iconLeft":"sort_by_alpha","min":0},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":[{"language":"ru-RU","translation":"Сортировка"}],"note":"Значение от 0 до ∞, где 0 - первая позиция ","conditions":null,"required":false,"group":"tech","validation":{"_and":[{"sort":{"_gte":"0"}}]},"validation_message":null}	{"collection":"products","field":"sort","sort":1,"group":"tech"}	\N	\N
521	604	directus_fields	34	{"id":34,"collection":"products","field":"id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"id","sort":1,"group":null}	\N	\N
667	751	structure	48d9020f-3f1c-4537-b8fa-ce7c9d8b8a4f	{"name":"Буплерум"}	{"name":"Буплерум"}	\N	\N
668	752	structure	89e9466c-e2b4-4110-ab4c-7566086a7769	{"name":"Орхидея Ванда"}	{"name":"Орхидея Ванда"}	\N	\N
522	605	directus_fields	37	{"id":37,"collection":"products","field":"available","special":["cast-boolean"],"interface":"boolean","options":{"label":"Доступно к покупке"},"display":"boolean","display_options":{"labelOn":"Доступен","labelOff":"Недоступен"},"readonly":false,"hidden":false,"sort":2,"width":"half","translations":[{"language":"ru-RU","translation":"В наличии"}],"note":null,"conditions":null,"required":false,"group":"tech","validation":null,"validation_message":null}	{"collection":"products","field":"available","sort":2,"group":"tech"}	\N	\N
523	606	directus_fields	35	{"id":35,"collection":"products","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_created","sort":2,"group":null}	\N	\N
524	607	directus_fields	36	{"id":36,"collection":"products","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_updated","sort":3,"group":null}	\N	\N
525	608	directus_fields	39	{"id":39,"collection":"products","field":"title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок товара"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"title","sort":4,"group":null}	\N	\N
526	609	directus_fields	73	{"id":73,"collection":"products","field":"price","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"half","translations":[{"language":"ru-RU","translation":"Цена"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"price","sort":5,"group":null}	\N	\N
527	610	directus_fields	74	{"id":74,"collection":"products","field":"discount","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"half","translations":[{"language":"ru-RU","translation":"Цена со скидкой"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"discount","sort":6,"group":null}	\N	\N
528	611	directus_fields	40	{"id":40,"collection":"products","field":"description","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","alignleft","aligncenter","alignright","numlist","bullist","removeformat","customLink","hr","fullscreen","code"]},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Описание товара"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"description","sort":7,"group":null}	\N	\N
529	612	directus_fields	75	{"id":75,"collection":"products","field":"images","special":["files"],"interface":"files","options":{},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":[{"language":"ru-RU","translation":"Изображения"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"images","sort":8,"group":null}	\N	\N
530	613	directus_fields	41	{"id":41,"collection":"products","field":"size","special":null,"interface":"input","options":{"iconLeft":"resize"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":[{"language":"ru-RU","translation":"Описание размера товара"}],"note":"Ожидается формат \\"10x10x10см\\"","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"size","sort":9,"group":null}	\N	\N
531	614	directus_fields	88	{"id":88,"collection":"products","field":"attrs","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"tag"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":[{"language":"ru-RU","translation":"Атрибуты"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"attrs","sort":10,"group":null}	\N	\N
532	615	directus_fields	89	{"id":89,"collection":"products","field":"tech","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"admin_panel_settings"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"full","translations":[{"language":"ru-RU","translation":"Настройки"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"tech","sort":11,"group":null}	\N	\N
533	616	directus_fields	84	{"id":84,"collection":"products","field":"seo","special":["alias","no-data","group"],"interface":"group-detail","options":{"start":"closed","headerIcon":"settings"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"seo","sort":12,"group":null}	\N	\N
534	617	directus_fields	90	{"sort":13,"interface":"group-detail","special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Основные данные"}],"options":{"headerIcon":"database"},"collection":"products","field":"data"}	{"sort":13,"interface":"group-detail","special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Основные данные"}],"options":{"headerIcon":"database"},"collection":"products","field":"data"}	\N	\N
535	618	directus_fields	34	{"id":34,"collection":"products","field":"id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"id","sort":1,"group":null}	\N	\N
536	619	directus_fields	35	{"id":35,"collection":"products","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_created","sort":2,"group":null}	\N	\N
537	620	directus_fields	36	{"id":36,"collection":"products","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_updated","sort":3,"group":null}	\N	\N
669	753	structure	9506efda-91ac-4a62-a882-b71ee65f3e44	{"name":"Верба"}	{"name":"Верба"}	\N	\N
538	621	directus_fields	90	{"id":90,"collection":"products","field":"data","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"database"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Основные данные"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"data","sort":4,"group":null}	\N	\N
539	622	directus_fields	39	{"id":39,"collection":"products","field":"title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок товара"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"title","sort":5,"group":null}	\N	\N
540	623	directus_fields	73	{"id":73,"collection":"products","field":"price","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"half","translations":[{"language":"ru-RU","translation":"Цена"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"price","sort":6,"group":null}	\N	\N
541	624	directus_fields	74	{"id":74,"collection":"products","field":"discount","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"half","translations":[{"language":"ru-RU","translation":"Цена со скидкой"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"discount","sort":7,"group":null}	\N	\N
542	625	directus_fields	40	{"id":40,"collection":"products","field":"description","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","alignleft","aligncenter","alignright","numlist","bullist","removeformat","customLink","hr","fullscreen","code"]},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":[{"language":"ru-RU","translation":"Описание товара"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"description","sort":8,"group":null}	\N	\N
543	626	directus_fields	75	{"id":75,"collection":"products","field":"images","special":["files"],"interface":"files","options":{},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":[{"language":"ru-RU","translation":"Изображения"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"images","sort":9,"group":null}	\N	\N
544	627	directus_fields	41	{"id":41,"collection":"products","field":"size","special":null,"interface":"input","options":{"iconLeft":"resize"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":[{"language":"ru-RU","translation":"Описание размера товара"}],"note":"Ожидается формат \\"10x10x10см\\"","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"size","sort":10,"group":null}	\N	\N
545	628	directus_fields	88	{"id":88,"collection":"products","field":"attrs","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"tag"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"full","translations":[{"language":"ru-RU","translation":"Атрибуты"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"attrs","sort":11,"group":null}	\N	\N
546	629	directus_fields	89	{"id":89,"collection":"products","field":"tech","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"admin_panel_settings"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"full","translations":[{"language":"ru-RU","translation":"Настройки"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"tech","sort":12,"group":null}	\N	\N
547	630	directus_fields	84	{"id":84,"collection":"products","field":"seo","special":["alias","no-data","group"],"interface":"group-detail","options":{"start":"closed","headerIcon":"settings"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":13,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"seo","sort":13,"group":null}	\N	\N
548	631	directus_fields	39	{"id":39,"collection":"products","field":"title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок товара"}],"note":null,"conditions":null,"required":true,"group":"data","validation":null,"validation_message":null}	{"collection":"products","field":"title","sort":1,"group":"data"}	\N	\N
549	632	directus_fields	34	{"id":34,"collection":"products","field":"id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"id","sort":1,"group":null}	\N	\N
550	633	directus_fields	35	{"id":35,"collection":"products","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_created","sort":2,"group":null}	\N	\N
551	634	directus_fields	36	{"id":36,"collection":"products","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_updated","sort":3,"group":null}	\N	\N
552	635	directus_fields	90	{"id":90,"collection":"products","field":"data","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"database"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Основные данные"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"data","sort":4,"group":null}	\N	\N
553	636	directus_fields	73	{"id":73,"collection":"products","field":"price","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"half","translations":[{"language":"ru-RU","translation":"Цена"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"price","sort":5,"group":null}	\N	\N
554	637	directus_fields	74	{"id":74,"collection":"products","field":"discount","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"half","translations":[{"language":"ru-RU","translation":"Цена со скидкой"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"discount","sort":6,"group":null}	\N	\N
555	638	directus_fields	40	{"id":40,"collection":"products","field":"description","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","alignleft","aligncenter","alignright","numlist","bullist","removeformat","customLink","hr","fullscreen","code"]},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Описание товара"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"description","sort":7,"group":null}	\N	\N
556	639	directus_fields	75	{"id":75,"collection":"products","field":"images","special":["files"],"interface":"files","options":{},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":[{"language":"ru-RU","translation":"Изображения"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"images","sort":8,"group":null}	\N	\N
557	640	directus_fields	41	{"id":41,"collection":"products","field":"size","special":null,"interface":"input","options":{"iconLeft":"resize"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":[{"language":"ru-RU","translation":"Описание размера товара"}],"note":"Ожидается формат \\"10x10x10см\\"","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"size","sort":9,"group":null}	\N	\N
558	641	directus_fields	88	{"id":88,"collection":"products","field":"attrs","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"tag"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":[{"language":"ru-RU","translation":"Атрибуты"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"attrs","sort":10,"group":null}	\N	\N
559	642	directus_fields	89	{"id":89,"collection":"products","field":"tech","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"admin_panel_settings"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"full","translations":[{"language":"ru-RU","translation":"Настройки"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"tech","sort":11,"group":null}	\N	\N
560	643	directus_fields	84	{"id":84,"collection":"products","field":"seo","special":["alias","no-data","group"],"interface":"group-detail","options":{"start":"closed","headerIcon":"settings"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"seo","sort":12,"group":null}	\N	\N
561	644	directus_fields	39	{"id":39,"collection":"products","field":"title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок товара"}],"note":null,"conditions":null,"required":true,"group":"data","validation":null,"validation_message":null}	{"collection":"products","field":"title","sort":1,"group":"data"}	\N	\N
562	645	directus_fields	34	{"id":34,"collection":"products","field":"id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"id","sort":1,"group":null}	\N	\N
563	646	directus_fields	73	{"id":73,"collection":"products","field":"price","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":[{"language":"ru-RU","translation":"Цена"}],"note":null,"conditions":null,"required":true,"group":"data","validation":null,"validation_message":null}	{"collection":"products","field":"price","sort":2,"group":"data"}	\N	\N
564	647	directus_fields	35	{"id":35,"collection":"products","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_created","sort":2,"group":null}	\N	\N
565	648	directus_fields	36	{"id":36,"collection":"products","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_updated","sort":3,"group":null}	\N	\N
566	649	directus_fields	90	{"id":90,"collection":"products","field":"data","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"database"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Основные данные"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"data","sort":4,"group":null}	\N	\N
567	650	directus_fields	74	{"id":74,"collection":"products","field":"discount","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"half","translations":[{"language":"ru-RU","translation":"Цена со скидкой"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"discount","sort":5,"group":null}	\N	\N
568	651	directus_fields	40	{"id":40,"collection":"products","field":"description","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","alignleft","aligncenter","alignright","numlist","bullist","removeformat","customLink","hr","fullscreen","code"]},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Описание товара"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"description","sort":6,"group":null}	\N	\N
569	652	directus_fields	75	{"id":75,"collection":"products","field":"images","special":["files"],"interface":"files","options":{},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Изображения"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"images","sort":7,"group":null}	\N	\N
570	653	directus_fields	41	{"id":41,"collection":"products","field":"size","special":null,"interface":"input","options":{"iconLeft":"resize"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":[{"language":"ru-RU","translation":"Описание размера товара"}],"note":"Ожидается формат \\"10x10x10см\\"","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"size","sort":8,"group":null}	\N	\N
571	654	directus_fields	88	{"id":88,"collection":"products","field":"attrs","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"tag"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":[{"language":"ru-RU","translation":"Атрибуты"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"attrs","sort":9,"group":null}	\N	\N
572	655	directus_fields	89	{"id":89,"collection":"products","field":"tech","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"admin_panel_settings"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":[{"language":"ru-RU","translation":"Настройки"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"tech","sort":10,"group":null}	\N	\N
573	656	directus_fields	84	{"id":84,"collection":"products","field":"seo","special":["alias","no-data","group"],"interface":"group-detail","options":{"start":"closed","headerIcon":"settings"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"seo","sort":11,"group":null}	\N	\N
575	657	directus_fields	34	{"id":34,"collection":"products","field":"id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"id","sort":1,"group":null}	\N	\N
577	660	directus_fields	35	{"id":35,"collection":"products","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_created","sort":2,"group":null}	\N	\N
579	662	directus_fields	36	{"id":36,"collection":"products","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_updated","sort":3,"group":null}	\N	\N
580	663	directus_fields	90	{"id":90,"collection":"products","field":"data","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"database"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Основные данные"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"data","sort":4,"group":null}	\N	\N
581	664	directus_fields	40	{"id":40,"collection":"products","field":"description","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","alignleft","aligncenter","alignright","numlist","bullist","removeformat","customLink","hr","fullscreen","code"]},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Описание товара"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"description","sort":5,"group":null}	\N	\N
582	665	directus_fields	75	{"id":75,"collection":"products","field":"images","special":["files"],"interface":"files","options":{},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Изображения"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"images","sort":6,"group":null}	\N	\N
583	666	directus_fields	41	{"id":41,"collection":"products","field":"size","special":null,"interface":"input","options":{"iconLeft":"resize"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Описание размера товара"}],"note":"Ожидается формат \\"10x10x10см\\"","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"size","sort":7,"group":null}	\N	\N
584	667	directus_fields	88	{"id":88,"collection":"products","field":"attrs","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"tag"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":[{"language":"ru-RU","translation":"Атрибуты"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"attrs","sort":8,"group":null}	\N	\N
670	754	structure	92a43dc2-c2f5-454a-9439-60e4c0592f88	{"name":"Вероника"}	{"name":"Вероника"}	\N	\N
671	755	structure	36b76a3f-b020-4410-8f05-dbb0878fe98d	{"name":"Орхидея Цимбидиум"}	{"name":"Орхидея Цимбидиум"}	\N	\N
574	658	directus_fields	39	{"id":39,"collection":"products","field":"title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок товара"}],"note":null,"conditions":null,"required":true,"group":"data","validation":null,"validation_message":null}	{"collection":"products","field":"title","sort":1,"group":"data"}	\N	\N
576	659	directus_fields	73	{"id":73,"collection":"products","field":"price","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":[{"language":"ru-RU","translation":"Цена"}],"note":null,"conditions":null,"required":true,"group":"data","validation":null,"validation_message":null}	{"collection":"products","field":"price","sort":2,"group":"data"}	\N	\N
578	661	directus_fields	74	{"id":74,"collection":"products","field":"discount","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"half","translations":[{"language":"ru-RU","translation":"Цена со скидкой"}],"note":null,"conditions":null,"required":false,"group":"data","validation":null,"validation_message":null}	{"collection":"products","field":"discount","sort":3,"group":"data"}	\N	\N
588	671	directus_fields	34	{"id":34,"collection":"products","field":"id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"id","sort":1,"group":null}	\N	\N
590	673	directus_fields	35	{"id":35,"collection":"products","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_created","sort":2,"group":null}	\N	\N
592	675	directus_fields	36	{"id":36,"collection":"products","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_updated","sort":3,"group":null}	\N	\N
594	677	directus_fields	90	{"id":90,"collection":"products","field":"data","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"database"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Основные данные"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"data","sort":4,"group":null}	\N	\N
595	678	directus_fields	75	{"id":75,"collection":"products","field":"images","special":["files"],"interface":"files","options":{},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Изображения"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"images","sort":5,"group":null}	\N	\N
596	679	directus_fields	41	{"id":41,"collection":"products","field":"size","special":null,"interface":"input","options":{"iconLeft":"resize"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Описание размера товара"}],"note":"Ожидается формат \\"10x10x10см\\"","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"size","sort":6,"group":null}	\N	\N
597	680	directus_fields	88	{"id":88,"collection":"products","field":"attrs","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"tag"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Атрибуты"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"attrs","sort":7,"group":null}	\N	\N
598	681	directus_fields	89	{"id":89,"collection":"products","field":"tech","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"admin_panel_settings"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":[{"language":"ru-RU","translation":"Настройки"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"tech","sort":8,"group":null}	\N	\N
599	682	directus_fields	84	{"id":84,"collection":"products","field":"seo","special":["alias","no-data","group"],"interface":"group-detail","options":{"start":"closed","headerIcon":"settings"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"seo","sort":9,"group":null}	\N	\N
600	683	directus_fields	39	{"id":39,"collection":"products","field":"title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок товара"}],"note":null,"conditions":null,"required":true,"group":"data","validation":null,"validation_message":null}	{"collection":"products","field":"title","sort":1,"group":"data"}	\N	\N
602	685	directus_fields	73	{"id":73,"collection":"products","field":"price","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":[{"language":"ru-RU","translation":"Цена"}],"note":null,"conditions":null,"required":true,"group":"data","validation":null,"validation_message":null}	{"collection":"products","field":"price","sort":2,"group":"data"}	\N	\N
604	687	directus_fields	74	{"id":74,"collection":"products","field":"discount","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"half","translations":[{"language":"ru-RU","translation":"Цена со скидкой"}],"note":null,"conditions":null,"required":false,"group":"data","validation":null,"validation_message":null}	{"collection":"products","field":"discount","sort":3,"group":"data"}	\N	\N
672	756	structure	40aa380b-4cb5-4c03-aad4-d9f26ccf6e8c	{"name":"Вибурнум"}	{"name":"Вибурнум"}	\N	\N
673	757	structure	973917e8-a8d3-427d-a1a5-bd03d7d23dda	{"name":"Гвоздика"}	{"name":"Гвоздика"}	\N	\N
585	668	directus_fields	89	{"id":89,"collection":"products","field":"tech","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"admin_panel_settings"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":[{"language":"ru-RU","translation":"Настройки"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"tech","sort":9,"group":null}	\N	\N
586	669	directus_fields	84	{"id":84,"collection":"products","field":"seo","special":["alias","no-data","group"],"interface":"group-detail","options":{"start":"closed","headerIcon":"settings"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"seo","sort":10,"group":null}	\N	\N
587	670	directus_fields	39	{"id":39,"collection":"products","field":"title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок товара"}],"note":null,"conditions":null,"required":true,"group":"data","validation":null,"validation_message":null}	{"collection":"products","field":"title","sort":1,"group":"data"}	\N	\N
589	672	directus_fields	73	{"id":73,"collection":"products","field":"price","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":[{"language":"ru-RU","translation":"Цена"}],"note":null,"conditions":null,"required":true,"group":"data","validation":null,"validation_message":null}	{"collection":"products","field":"price","sort":2,"group":"data"}	\N	\N
591	674	directus_fields	74	{"id":74,"collection":"products","field":"discount","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"half","translations":[{"language":"ru-RU","translation":"Цена со скидкой"}],"note":null,"conditions":null,"required":false,"group":"data","validation":null,"validation_message":null}	{"collection":"products","field":"discount","sort":3,"group":"data"}	\N	\N
593	676	directus_fields	40	{"id":40,"collection":"products","field":"description","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","alignleft","aligncenter","alignright","numlist","bullist","removeformat","customLink","hr","fullscreen","code"]},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Описание товара"}],"note":null,"conditions":null,"required":false,"group":"data","validation":null,"validation_message":null}	{"collection":"products","field":"description","sort":4,"group":"data"}	\N	\N
601	684	directus_fields	34	{"id":34,"collection":"products","field":"id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"id","sort":1,"group":null}	\N	\N
603	686	directus_fields	35	{"id":35,"collection":"products","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_created","sort":2,"group":null}	\N	\N
605	688	directus_fields	36	{"id":36,"collection":"products","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_updated","sort":3,"group":null}	\N	\N
607	690	directus_fields	90	{"id":90,"collection":"products","field":"data","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"database"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Основные данные"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"data","sort":4,"group":null}	\N	\N
609	692	directus_fields	41	{"id":41,"collection":"products","field":"size","special":null,"interface":"input","options":{"iconLeft":"resize"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Описание размера товара"}],"note":"Ожидается формат \\"10x10x10см\\"","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"size","sort":5,"group":null}	\N	\N
610	693	directus_fields	88	{"id":88,"collection":"products","field":"attrs","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"tag"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Атрибуты"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"attrs","sort":6,"group":null}	\N	\N
611	694	directus_fields	89	{"id":89,"collection":"products","field":"tech","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"admin_panel_settings"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":[{"language":"ru-RU","translation":"Настройки"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"tech","sort":7,"group":null}	\N	\N
612	695	directus_fields	84	{"id":84,"collection":"products","field":"seo","special":["alias","no-data","group"],"interface":"group-detail","options":{"start":"closed","headerIcon":"settings"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"seo","sort":8,"group":null}	\N	\N
613	696	directus_fields	39	{"id":39,"collection":"products","field":"title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок товара"}],"note":null,"conditions":null,"required":true,"group":"data","validation":null,"validation_message":null}	{"collection":"products","field":"title","sort":1,"group":"data"}	\N	\N
606	689	directus_fields	40	{"id":40,"collection":"products","field":"description","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","alignleft","aligncenter","alignright","numlist","bullist","removeformat","customLink","hr","fullscreen","code"]},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Описание товара"}],"note":null,"conditions":null,"required":false,"group":"data","validation":null,"validation_message":null}	{"collection":"products","field":"description","sort":4,"group":"data"}	\N	\N
608	691	directus_fields	75	{"id":75,"collection":"products","field":"images","special":["files"],"interface":"files","options":{},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Изображения"}],"note":null,"conditions":null,"required":true,"group":"data","validation":null,"validation_message":null}	{"collection":"products","field":"images","sort":5,"group":"data"}	\N	\N
614	697	directus_fields	34	{"id":34,"collection":"products","field":"id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"id","sort":1,"group":null}	\N	\N
616	699	directus_fields	35	{"id":35,"collection":"products","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_created","sort":2,"group":null}	\N	\N
618	701	directus_fields	36	{"id":36,"collection":"products","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_updated","sort":3,"group":null}	\N	\N
620	703	directus_fields	90	{"id":90,"collection":"products","field":"data","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"database"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Основные данные"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"data","sort":4,"group":null}	\N	\N
622	705	directus_fields	88	{"id":88,"collection":"products","field":"attrs","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"tag"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Атрибуты"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"attrs","sort":5,"group":null}	\N	\N
624	707	directus_fields	89	{"id":89,"collection":"products","field":"tech","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"admin_panel_settings"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Настройки"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"tech","sort":6,"group":null}	\N	\N
625	708	directus_fields	84	{"id":84,"collection":"products","field":"seo","special":["alias","no-data","group"],"interface":"group-detail","options":{"start":"closed","headerIcon":"settings"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"seo","sort":7,"group":null}	\N	\N
626	709	directus_fields	39	{"id":39,"collection":"products","field":"title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок товара"}],"note":null,"conditions":null,"required":true,"group":"data","validation":null,"validation_message":null}	{"collection":"products","field":"title","sort":1,"group":"data"}	\N	\N
627	710	directus_fields	73	{"id":73,"collection":"products","field":"price","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":[{"language":"ru-RU","translation":"Цена"}],"note":null,"conditions":null,"required":true,"group":"data","validation":null,"validation_message":null}	{"collection":"products","field":"price","sort":2,"group":"data"}	\N	\N
628	711	directus_fields	74	{"id":74,"collection":"products","field":"discount","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"half","translations":[{"language":"ru-RU","translation":"Цена со скидкой"}],"note":null,"conditions":null,"required":false,"group":"data","validation":null,"validation_message":null}	{"collection":"products","field":"discount","sort":3,"group":"data"}	\N	\N
629	712	directus_fields	40	{"id":40,"collection":"products","field":"description","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","alignleft","aligncenter","alignright","numlist","bullist","removeformat","customLink","hr","fullscreen","code"]},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Описание товара"}],"note":null,"conditions":null,"required":false,"group":"data","validation":null,"validation_message":null}	{"collection":"products","field":"description","sort":4,"group":"data"}	\N	\N
630	713	directus_fields	41	{"id":41,"collection":"products","field":"size","special":null,"interface":"input","options":{"iconLeft":"resize"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Описание размера товара"}],"note":"Ожидается формат \\"10x10x10см\\"","conditions":null,"required":false,"group":"data","validation":null,"validation_message":null}	{"collection":"products","field":"size","sort":5,"group":"data"}	\N	\N
674	758	structure	6edf1b21-221b-4326-97ff-0a83ebb5c515	{"name":"Гвоздика кустовая"}	{"name":"Гвоздика кустовая"}	\N	\N
675	759	structure	1c1b6933-84db-4547-9154-b3df828ee978	{"name":"Гелиантус"}	{"name":"Гелиантус"}	\N	\N
615	698	directus_fields	73	{"id":73,"collection":"products","field":"price","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":[{"language":"ru-RU","translation":"Цена"}],"note":null,"conditions":null,"required":true,"group":"data","validation":null,"validation_message":null}	{"collection":"products","field":"price","sort":2,"group":"data"}	\N	\N
617	700	directus_fields	74	{"id":74,"collection":"products","field":"discount","special":null,"interface":"input","options":{"iconLeft":"currency_ruble"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"half","translations":[{"language":"ru-RU","translation":"Цена со скидкой"}],"note":null,"conditions":null,"required":false,"group":"data","validation":null,"validation_message":null}	{"collection":"products","field":"discount","sort":3,"group":"data"}	\N	\N
619	702	directus_fields	40	{"id":40,"collection":"products","field":"description","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","alignleft","aligncenter","alignright","numlist","bullist","removeformat","customLink","hr","fullscreen","code"]},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Описание товара"}],"note":null,"conditions":null,"required":false,"group":"data","validation":null,"validation_message":null}	{"collection":"products","field":"description","sort":4,"group":"data"}	\N	\N
621	704	directus_fields	75	{"id":75,"collection":"products","field":"images","special":["files"],"interface":"files","options":{},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Изображения"}],"note":null,"conditions":null,"required":true,"group":"data","validation":null,"validation_message":null}	{"collection":"products","field":"images","sort":5,"group":"data"}	\N	\N
623	706	directus_fields	41	{"id":41,"collection":"products","field":"size","special":null,"interface":"input","options":{"iconLeft":"resize"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Описание размера товара"}],"note":"Ожидается формат \\"10x10x10см\\"","conditions":null,"required":false,"group":"data","validation":null,"validation_message":null}	{"collection":"products","field":"size","sort":6,"group":"data"}	\N	\N
632	715	directus_fields	88	{"id":88,"collection":"products","field":"attrs","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"tag","start":"closed"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Атрибуты"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"attrs","options":{"headerIcon":"tag","start":"closed"}}	\N	\N
633	716	directus_fields	89	{"id":89,"collection":"products","field":"tech","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"admin_panel_settings","start":"closed"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Настройки"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"tech","options":{"headerIcon":"admin_panel_settings","start":"closed"}}	\N	\N
631	714	directus_fields	75	{"id":75,"collection":"products","field":"images","special":["files"],"interface":"files","options":{},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Изображения"}],"note":null,"conditions":null,"required":true,"group":"data","validation":null,"validation_message":null}	{"collection":"products","field":"images","sort":6,"group":"data"}	\N	\N
634	717	directus_fields	46	{"id":46,"collection":"styles","field":"name","special":null,"interface":"input","options":{"iconLeft":"drive_file_rename_outline"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Наименование"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"styles","field":"name","options":{"iconLeft":"drive_file_rename_outline"},"display":"raw","translations":[{"language":"ru-RU","translation":"Наименование"}]}	\N	\N
635	718	directus_fields	66	{"id":66,"collection":"structure","field":"name","special":null,"interface":"input","options":null,"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Наименование"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"structure","field":"name","display":"raw","translations":[{"language":"ru-RU","translation":"Наименование"}]}	\N	\N
636	719	directus_fields	68	{"id":68,"collection":"reason","field":"name","special":null,"interface":"input","options":{"iconLeft":"drive_file_rename_outline"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Наименование"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"reason","field":"name","options":{"iconLeft":"drive_file_rename_outline"},"display":"raw","translations":[{"language":"ru-RU","translation":"Наименование"}]}	\N	\N
637	720	reason	e28a40e5-9360-41b1-85ff-60766ea4a980	{"name":"Для мамы"}	{"name":"Для мамы"}	\N	\N
638	721	reason	a923bcc4-931a-4709-bade-317c342fedf1	{"name":"Для любимой"}	{"name":"Для любимой"}	\N	\N
639	722	reason	bc74959a-ef74-4834-866f-c62b9e6fd322	{"name":"Для бабушки"}	{"name":"Для бабушки"}	\N	\N
640	723	reason	097fb6db-20ea-47d8-a585-342b1bfd11eb	{"name":"Для учителя"}	{"name":"Для учителя"}	\N	\N
641	724	reason	1cfd6194-2a22-4624-9113-920dde9b8cbb	{"name":"Для коллеги"}	{"name":"Для коллеги"}	\N	\N
642	725	reason	49c8687b-daf7-432a-ba7b-ed8328f3844f	{"name":"День рождения"}	{"name":"День рождения"}	\N	\N
643	726	reason	6371556d-6178-4fd7-891d-259db73c76bc	{"name":"На свадьбу"}	{"name":"На свадьбу"}	\N	\N
644	727	reason	b9350ae7-2ec4-429a-95d8-0178f036fc53	{"name":"На юбилей"}	{"name":"На юбилей"}	\N	\N
645	728	reason	26a1af3b-7771-435d-a34c-f8dcd3606257	{"name":"Выписка из роддома"}	{"name":"Выписка из роддома"}	\N	\N
646	729	reason	b859a8d7-dffb-4f76-bd96-ee254285ecce	{"name":"На выпускной"}	{"name":"На выпускной"}	\N	\N
647	730	directus_fields	61	{"id":61,"collection":"products","field":"style","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false,"template":"{{styles_id.name}}"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":[{"language":"ru-RU","translation":"Стиль"}],"note":null,"conditions":null,"required":false,"group":"attrs","validation":null,"validation_message":null}	{"collection":"products","field":"style","options":{"enableCreate":false,"template":"{{styles_id.name}}"}}	\N	\N
648	731	directus_fields	69	{"id":69,"collection":"products","field":"reason","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false,"template":"{{reason_id.name}}"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":[{"language":"ru-RU","translation":"Повод"}],"note":null,"conditions":null,"required":false,"group":"attrs","validation":null,"validation_message":null}	{"collection":"products","field":"reason","options":{"enableCreate":false,"template":"{{reason_id.name}}"}}	\N	\N
649	732	directus_fields	79	{"id":79,"collection":"products","field":"structure","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false,"template":"{{structure_id.name}}"},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Состав"}],"note":null,"conditions":null,"required":false,"group":"attrs","validation":null,"validation_message":null}	{"collection":"products","field":"structure","options":{"enableCreate":false,"template":"{{structure_id.name}}"}}	\N	\N
650	733	directus_fields	66	{"id":66,"collection":"structure","field":"name","special":null,"interface":"input","options":{"iconLeft":"drive_file_rename_outline"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Наименование"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"structure","field":"name","options":{"iconLeft":"drive_file_rename_outline"}}	\N	\N
651	734	structure	23e7926b-f2a1-4068-908c-6bb690233bc8	{"name":"Альстромерия"}	{"name":"Альстромерия"}	\N	\N
652	735	structure	516f6fd3-32fa-45e5-bb80-0aaefe47cb3f	{"name":"Амариллис"}	{"name":"Амариллис"}	\N	\N
653	736	structure	9a7268c1-6b81-4c93-9beb-2af9e8ee1148	{"name":"Амми"}	{"name":"Амми"}	\N	\N
654	737	structure	6c0d5a40-2f0a-43a8-9e37-f67c547b0c10	{"name":"Анемон"}	{"name":"Анемон"}	\N	\N
655	738	structure	bf7a62bb-143d-45b2-9b66-6a819f552439	{"name":"Антирринум"}	{"name":"Антирринум"}	\N	\N
656	739	structure	560ca460-cbc0-45fd-8480-5ea0f9d2db10	{"name":"Анемон"}	{"name":"Анемон"}	\N	\N
657	741	structure	d3c2e4e1-0ac1-4f31-88ca-7854ac907cd9	{"name":"Антуриум"}	{"name":"Антуриум"}	\N	\N
658	742	structure	caab1f2d-2b8c-4433-83da-0bb00e5dbad4	{"name":"Аспарагус"}	{"name":"Аспарагус"}	\N	\N
659	743	structure	ef0c0577-64cf-422b-be6d-c609d5864a5e	{"name":"Аспидистра"}	{"name":"Аспидистра"}	\N	\N
660	744	structure	7a983be4-4016-4d99-8943-8e308f75ee9a	{"name":"Астильба"}	{"name":"Астильба"}	\N	\N
661	745	structure	73d6b923-98d6-4438-a9d4-9281d3870534	{"name":"Астра"}	{"name":"Астра"}	\N	\N
662	746	structure	1e621a84-e48c-45a3-916b-0737cda0095d	{"name":"Ахилея"}	{"name":"Ахилея"}	\N	\N
663	747	structure	807524d5-6d38-4d71-b54d-e78848a1a3b3	{"name":"Берграс"}	{"name":"Берграс"}	\N	\N
692	776	structure	5849a7b0-af52-42e6-b4a4-61e818497a87	{"name":"Куэркус"}	{"name":"Куэркус"}	\N	\N
693	777	structure	dfdefbbe-cd79-40f6-9096-076c050f7a19	{"name":"Леукадендрон"}	{"name":"Леукадендрон"}	\N	\N
694	778	structure	cb040715-c359-48c8-bb07-83f20a8f26ef	{"name":"Лилия"}	{"name":"Лилия"}	\N	\N
695	779	structure	b7d2e8bc-3ed8-4ee8-bf87-a12f28de63fd	{"name":"Лимониум"}	{"name":"Лимониум"}	\N	\N
696	780	structure	40df7fb3-d5bf-40fe-935c-a4487bb675be	{"name":"Листья малины"}	{"name":"Листья малины"}	\N	\N
697	781	structure	a7ab3255-eb33-463f-aaa2-adb8c37b3356	{"name":"Маттиола"}	{"name":"Маттиола"}	\N	\N
698	782	structure	99d724cd-dd9c-4b39-80c4-3e08585086f4	{"name":"Танацетум"}	{"name":"Танацетум"}	\N	\N
699	783	structure	c821b4e3-af39-4fc5-9739-f3a3c5847ef7	{"name":"Мимоза"}	{"name":"Мимоза"}	\N	\N
700	784	structure	625b0b22-02b5-4356-9165-1fa5cc611179	{"name":"Нарцисс"}	{"name":"Нарцисс"}	\N	\N
701	785	structure	8ba2d15b-1fdf-4101-8213-c021025349e3	{"name":"Нобилис"}	{"name":"Нобилис"}	\N	\N
702	786	structure	a36a3250-3b78-45f0-a232-c295959ce15d	{"name":"Нутан"}	{"name":"Нутан"}	\N	\N
703	787	structure	9c4cd5ce-f2d5-42a2-a0b5-9fa35abdbd04	{"name":"Озотамнус"}	{"name":"Озотамнус"}	\N	\N
704	788	structure	fe1d63b9-d0d1-4d72-b74d-faa3d0886cea	{"name":"Оксипеталум"}	{"name":"Оксипеталум"}	\N	\N
705	789	structure	f5daed79-87af-4d4e-8cb5-5ef17dc1c204	{"name":"Орнитогалум"}	{"name":"Орнитогалум"}	\N	\N
706	790	structure	f119a603-67c6-4478-8c67-9101bab7cda9	{"name":"Пион"}	{"name":"Пион"}	\N	\N
707	791	structure	50b586b8-025a-44ec-a397-ce1e46373686	{"name":"Писташ"}	{"name":"Писташ"}	\N	\N
708	792	structure	22c486a9-ecf5-4432-837e-cff833b00590	{"name":"Питтоспорум"}	{"name":"Питтоспорум"}	\N	\N
709	793	structure	4101b4ca-dab3-4809-913b-56ba9d6d70b7	{"name":"Протея"}	{"name":"Протея"}	\N	\N
710	799	directus_fields	91	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"categories"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"categories"}	\N	\N
711	800	directus_collections	categories	{"singleton":false,"collection":"categories"}	{"singleton":false,"collection":"categories"}	\N	\N
712	801	directus_fields	92	{"sort":2,"interface":"input","special":null,"required":true,"translations":[{"language":"ru-RU","translation":"Наименование"}],"options":{"iconLeft":"drive_file_rename_outline"},"display":"raw","collection":"categories","field":"name"}	{"sort":2,"interface":"input","special":null,"required":true,"translations":[{"language":"ru-RU","translation":"Наименование"}],"options":{"iconLeft":"drive_file_rename_outline"},"display":"raw","collection":"categories","field":"name"}	\N	\N
713	802	directus_collections	categories	{"collection":"categories","icon":"settings_suggest","note":null,"display_template":"{{name}}","hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Категории","singular":"Категория","plural":"Категории"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"icon":"settings_suggest","display_template":"{{name}}","translations":[{"language":"ru-RU","translation":"Категории","singular":"Категория","plural":"Категории"}]}	\N	\N
714	803	directus_collections	styles	{"collection":"styles","icon":"settings_suggest","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Стиль","singular":"Стиль","plural":"Стили"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"attrs","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"attrs"}	\N	\N
715	804	directus_collections	structure	{"collection":"structure","icon":"settings_suggest","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Состав","singular":"Состав","plural":"Составы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"attrs","collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":"attrs"}	\N	\N
716	805	directus_collections	reason	{"collection":"reason","icon":"settings_suggest","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Поводы","singular":"Повод","plural":"Поводы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":"attrs","collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":"attrs"}	\N	\N
717	806	directus_collections	categories	{"collection":"categories","icon":"settings_suggest","note":null,"display_template":"{{name}}","hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Категории","singular":"Категория","plural":"Категории"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":"attrs","collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":"attrs"}	\N	\N
718	807	directus_collections	products	{"collection":"products","icon":"stacks","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Товары","singular":"Товар","plural":"Товары"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
719	808	directus_collections	attrs	{"collection":"attrs","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Атрибуты товаров"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
787	877	categories	647d44f1-c459-4ee9-b7f4-65c0bd107999	{"name":"Цветы в коробке"}	{"name":"Цветы в коробке"}	\N	\N
720	809	directus_collections	seo_settings	{"collection":"seo_settings","icon":"folder","note":"Содержит коллекции, связанные с SEO-настройками страниц","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"SEO настройки"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
721	810	directus_collections	pages	{"collection":"pages","icon":"folder","note":"Содержит коллекции, связанные с контентной частью сайта","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":null}	\N	\N
722	811	directus_collections	products_styles	{"collection":"products_styles","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":5,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":5,"group":null}	\N	\N
723	812	directus_collections	products_files	{"collection":"products_files","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":6,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":6,"group":null}	\N	\N
724	813	directus_collections	products_reason	{"collection":"products_reason","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":7,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":7,"group":null}	\N	\N
725	814	directus_collections	products_structure	{"collection":"products_structure","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":8,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":8,"group":null}	\N	\N
727	816	directus_collections	products_styles	{"collection":"products_styles","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"products","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"products"}	\N	\N
734	823	directus_collections	products	{"collection":"products","icon":"stacks","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Товары","singular":"Товар","plural":"Товары"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
736	825	directus_collections	attrs	{"collection":"attrs","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Атрибуты товаров"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
738	827	directus_collections	seo_settings	{"collection":"seo_settings","icon":"folder","note":"Содержит коллекции, связанные с SEO-настройками страниц","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"SEO настройки"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
739	828	directus_collections	pages	{"collection":"pages","icon":"folder","note":"Содержит коллекции, связанные с контентной частью сайта","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":null}	\N	\N
740	829	directus_collections	products_reason	{"collection":"products_reason","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":5,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":5,"group":null}	\N	\N
741	830	directus_collections	products_structure	{"collection":"products_structure","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":6,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":6,"group":null}	\N	\N
742	831	directus_collections	products_files	{"collection":"products_files","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"products","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"products"}	\N	\N
788	878	categories	435b14c8-e7e1-4652-bfcb-e33505d51375	{"name":"Цветы собственного производства"}	{"name":"Цветы собственного производства"}	\N	\N
789	879	categories	e991d516-4de4-4378-aff2-f425417050f2	{"name":"Эко-букеты"}	{"name":"Эко-букеты"}	\N	\N
726	815	directus_collections	products	{"collection":"products","icon":"stacks","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Товары","singular":"Товар","plural":"Товары"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
728	817	directus_collections	attrs	{"collection":"attrs","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Атрибуты товаров"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
729	818	directus_collections	seo_settings	{"collection":"seo_settings","icon":"folder","note":"Содержит коллекции, связанные с SEO-настройками страниц","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"SEO настройки"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
730	819	directus_collections	pages	{"collection":"pages","icon":"folder","note":"Содержит коллекции, связанные с контентной частью сайта","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":null}	\N	\N
731	820	directus_collections	products_files	{"collection":"products_files","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":5,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":5,"group":null}	\N	\N
732	821	directus_collections	products_reason	{"collection":"products_reason","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":6,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":6,"group":null}	\N	\N
733	822	directus_collections	products_structure	{"collection":"products_structure","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":7,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":7,"group":null}	\N	\N
735	824	directus_collections	products_files	{"collection":"products_files","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"products","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"products"}	\N	\N
737	826	directus_collections	products_styles	{"collection":"products_styles","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"products","collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":"products"}	\N	\N
743	832	directus_collections	products	{"collection":"products","icon":"stacks","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Товары","singular":"Товар","plural":"Товары"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
745	834	directus_collections	attrs	{"collection":"attrs","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Атрибуты товаров"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
747	836	directus_collections	seo_settings	{"collection":"seo_settings","icon":"folder","note":"Содержит коллекции, связанные с SEO-настройками страниц","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"SEO настройки"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
748	837	directus_collections	pages	{"collection":"pages","icon":"folder","note":"Содержит коллекции, связанные с контентной частью сайта","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":null}	\N	\N
749	838	directus_collections	products_structure	{"collection":"products_structure","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":5,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":5,"group":null}	\N	\N
908	1018	directus_fields	111	{"sort":1,"hidden":true,"field":"id","collection":"wholesale_wholesale_advant"}	{"sort":1,"hidden":true,"field":"id","collection":"wholesale_wholesale_advant"}	\N	\N
744	833	directus_collections	products_styles	{"collection":"products_styles","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"products","collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":"products"}	\N	\N
746	835	directus_collections	products_reason	{"collection":"products_reason","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":"products","collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":"products"}	\N	\N
751	840	directus_collections	products	{"collection":"products","icon":"stacks","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Товары","singular":"Товар","plural":"Товары"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
753	842	directus_collections	attrs	{"collection":"attrs","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Атрибуты товаров"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
755	844	directus_collections	seo_settings	{"collection":"seo_settings","icon":"folder","note":"Содержит коллекции, связанные с SEO-настройками страниц","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"SEO настройки"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
757	846	directus_collections	pages	{"collection":"pages","icon":"folder","note":"Содержит коллекции, связанные с контентной частью сайта","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":null}	\N	\N
750	839	directus_collections	products_files	{"collection":"products_files","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"products","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"products"}	\N	\N
752	841	directus_collections	products_styles	{"collection":"products_styles","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"products","collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":"products"}	\N	\N
754	843	directus_collections	products_reason	{"collection":"products_reason","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":"products","collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":"products"}	\N	\N
756	845	directus_collections	products_structure	{"collection":"products_structure","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":"products","collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":"products"}	\N	\N
758	847	categories	b7c7b6cb-bf68-4852-ba8a-032b41a4c97d	{"name":"d"}	{"name":"d"}	\N	\N
759	849	categories	88601e48-6abc-4303-a9a6-f73465a71478	{"name":"1 сентября"}	{"name":"1 сентября"}	\N	\N
760	850	categories	0e35dd7f-aa20-4700-b38e-c175cfd6a3b0	{"name":"14 февраля"}	{"name":"14 февраля"}	\N	\N
761	851	categories	6addc28c-47ea-45da-95a7-501f9fa094e6	{"name":"8 марта"}	{"name":"8 марта"}	\N	\N
762	852	categories	a679dd91-d1c7-43af-aebb-c4d4e7a5dc69	{"name":"Букет невесты"}	{"name":"Букет невесты"}	\N	\N
763	853	categories	f2112df7-4000-4c51-b9e1-6bc542d831be	{"name":"Букеты"}	{"name":"Букеты"}	\N	\N
764	854	categories	418fbdf9-519a-466f-aa5d-35e277d0857a	{"name":"Весенняя коллекция"}	{"name":"Весенняя коллекция"}	\N	\N
765	855	categories	2283bf24-7eba-41b2-9fd2-0facadacbd0a	{"name":"Декор для дома"}	{"name":"Декор для дома"}	\N	\N
766	856	categories	c33dd427-fc81-4ae0-9216-d151df0b12c0	{"name":"День знаний"}	{"name":"День знаний"}	\N	\N
767	857	categories	7841a067-65d4-479d-9156-9a13a2977d1e	{"name":"День матери"}	{"name":"День матери"}	\N	\N
768	858	categories	ba876a60-d0d1-410d-b150-c23729a09b18	{"name":"Зимняя коллекция"}	{"name":"Зимняя коллекция"}	\N	\N
769	859	directus_fields	93	{"sort":3,"interface":"input","special":null,"translations":[{"language":"ru-RU","translation":"Сортировка"}],"note":"Значение от 0 до ∞, где 0 начало","options":{"min":0,"iconLeft":"sort_by_alpha"},"display":"raw","validation":{"_and":[{"sort":{"_gte":"0"}}]},"collection":"categories","field":"sort"}	{"sort":3,"interface":"input","special":null,"translations":[{"language":"ru-RU","translation":"Сортировка"}],"note":"Значение от 0 до ∞, где 0 начало","options":{"min":0,"iconLeft":"sort_by_alpha"},"display":"raw","validation":{"_and":[{"sort":{"_gte":"0"}}]},"collection":"categories","field":"sort"}	\N	\N
770	860	directus_fields	91	{"id":91,"collection":"categories","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"categories","field":"id","sort":1,"group":null}	\N	\N
771	861	directus_fields	93	{"id":93,"collection":"categories","field":"sort","special":null,"interface":"input","options":{"min":0,"iconLeft":"sort_by_alpha"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Сортировка"}],"note":"Значение от 0 до ∞, где 0 начало","conditions":null,"required":false,"group":null,"validation":{"_and":[{"sort":{"_gte":"0"}}]},"validation_message":null}	{"collection":"categories","field":"sort","sort":2,"group":null}	\N	\N
772	862	directus_fields	92	{"id":92,"collection":"categories","field":"name","special":null,"interface":"input","options":{"iconLeft":"drive_file_rename_outline"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Наименование"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"categories","field":"name","sort":3,"group":null}	\N	\N
773	863	categories	1917a463-21c7-4d04-926b-d07259019930	{"name":"Корзины"}	{"name":"Корзины"}	\N	\N
774	864	categories	4fd5c56a-c30c-41ce-9ce8-43d6e0c8756f	{"name":"Кустовые розы"}	{"name":"Кустовые розы"}	\N	\N
775	865	categories	d4cee2b2-a9f1-4b77-bbc2-63b260cc28e2	{"name":"Летняя коллекция"}	{"name":"Летняя коллекция"}	\N	\N
776	866	categories	5867ef07-53ec-4b1d-887d-7bd674e248bd	{"name":"Монобукеты"}	{"name":"Монобукеты"}	\N	\N
777	867	categories	21f9bb16-16c2-4d61-82f1-fd2d6c11d567	{"name":"Новый год"}	{"name":"Новый год"}	\N	\N
778	868	categories	0c008a34-fd3f-4ce4-967a-6f45c75ca8e4	{"name":"Осенняя коллекция"}	{"name":"Осенняя коллекция"}	\N	\N
779	869	categories	dcb8248a-781e-429e-8cde-9bb728b6e1b5	{"name":"Открытки"}	{"name":"Открытки"}	\N	\N
780	870	categories	b655a38a-10c2-458a-9abf-53cbb749bbe8	{"name":"Пионы"}	{"name":"Пионы"}	\N	\N
781	871	categories	429a34dd-6cd9-49da-8efb-f40bc69e786b	{"name":"Подарки"}	{"name":"Подарки"}	\N	\N
782	872	categories	e9a2bde1-47fe-4116-a6b6-c23854d55f57	{"name":"Популярное"}	{"name":"Популярное"}	\N	\N
783	873	categories	8ac35f92-430d-4ee9-8945-f0ae75f4a7c5	{"name":"Премиум"}	{"name":"Премиум"}	\N	\N
784	874	categories	92b40a19-2513-441f-830f-f63c8280728f	{"name":"Розы"}	{"name":"Розы"}	\N	\N
785	875	categories	61dd73b1-655e-4ace-a922-b42741961d7d	{"name":"Свадебные букеты"}	{"name":"Свадебные букеты"}	\N	\N
786	876	categories	9847eb03-e3bc-42ec-ab47-8966b7380d40	{"name":"Тюльпаны"}	{"name":"Тюльпаны"}	\N	\N
790	880	directus_collections	categories	{"collection":"categories","icon":"settings_suggest","note":null,"display_template":"{{name}}","hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Категории","singular":"Категория","plural":"Категории"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"attrs","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"attrs"}	\N	\N
791	881	directus_collections	styles	{"collection":"styles","icon":"settings_suggest","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Стиль","singular":"Стиль","plural":"Стили"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"attrs","collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":"attrs"}	\N	\N
792	882	directus_collections	structure	{"collection":"structure","icon":"settings_suggest","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Состав","singular":"Состав","plural":"Составы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":"attrs","collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":"attrs"}	\N	\N
793	883	directus_collections	reason	{"collection":"reason","icon":"settings_suggest","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Поводы","singular":"Повод","plural":"Поводы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":"attrs","collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":"attrs"}	\N	\N
794	884	directus_fields	94	{"sort":4,"interface":"boolean","special":["cast-boolean"],"options":{"label":"Отображать на сайте"},"translations":[{"language":"ru-RU","translation":"Видимость"}],"display":"boolean","display_options":{"labelOn":"Отображается","labelOff":"Скрыто"},"collection":"categories","field":"available"}	{"sort":4,"interface":"boolean","special":["cast-boolean"],"options":{"label":"Отображать на сайте"},"translations":[{"language":"ru-RU","translation":"Видимость"}],"display":"boolean","display_options":{"labelOn":"Отображается","labelOff":"Скрыто"},"collection":"categories","field":"available"}	\N	\N
795	885	directus_fields	91	{"id":91,"collection":"categories","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"categories","field":"id","sort":1,"group":null}	\N	\N
796	886	directus_fields	92	{"id":92,"collection":"categories","field":"name","special":null,"interface":"input","options":{"iconLeft":"drive_file_rename_outline"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Наименование"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"categories","field":"name","sort":2,"group":null}	\N	\N
797	887	directus_fields	93	{"id":93,"collection":"categories","field":"sort","special":null,"interface":"input","options":{"min":0,"iconLeft":"sort_by_alpha"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Сортировка"}],"note":"Значение от 0 до ∞, где 0 начало","conditions":null,"required":false,"group":null,"validation":{"_and":[{"sort":{"_gte":"0"}}]},"validation_message":null}	{"collection":"categories","field":"sort","sort":3,"group":null}	\N	\N
798	888	directus_fields	94	{"id":94,"collection":"categories","field":"available","special":["cast-boolean"],"interface":"boolean","options":{"label":"Отображать на сайте"},"display":"boolean","display_options":{"labelOn":"Отображается","labelOff":"Скрыто"},"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Видимость"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"categories","field":"available","sort":4,"group":null}	\N	\N
799	889	directus_fields	93	{"id":93,"collection":"categories","field":"sort","special":null,"interface":"input","options":{"min":0,"iconLeft":"sort_by_alpha"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"half","translations":[{"language":"ru-RU","translation":"Сортировка"}],"note":"Значение от 0 до ∞, где 0 начало","conditions":null,"required":false,"group":null,"validation":{"_and":[{"sort":{"_gte":"0"}}]},"validation_message":null}	{"collection":"categories","field":"sort","width":"half"}	\N	\N
800	890	directus_fields	94	{"id":94,"collection":"categories","field":"available","special":["cast-boolean"],"interface":"boolean","options":{"label":"Отображать на сайте"},"display":"boolean","display_options":{"labelOn":"Отображается","labelOff":"Скрыто"},"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Видимость"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"categories","field":"available","width":"half"}	\N	\N
801	891	categories	0e35dd7f-aa20-4700-b38e-c175cfd6a3b0	{"id":"0e35dd7f-aa20-4700-b38e-c175cfd6a3b0","name":"14 февраля","sort":null,"available":false}	{"available":false}	\N	\N
802	892	directus_fields	79	{"id":79,"collection":"products","field":"structure","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false,"template":"{{structure_id.name}}"},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"half","translations":[{"language":"ru-RU","translation":"Состав"}],"note":null,"conditions":null,"required":false,"group":"attrs","validation":null,"validation_message":null}	{"collection":"products","field":"structure","width":"half"}	\N	\N
803	893	directus_fields	95	{"sort":8,"interface":"list-m2m","special":["m2m"],"options":{"enableCreate":false,"limit":100},"translations":[{"language":"ru-RU","translation":"Категории"}],"note":"В каких категориях будет отображаться товар","display":"related-values","collection":"products","field":"category"}	{"sort":8,"interface":"list-m2m","special":["m2m"],"options":{"enableCreate":false,"limit":100},"translations":[{"language":"ru-RU","translation":"Категории"}],"note":"В каких категориях будет отображаться товар","display":"related-values","collection":"products","field":"category"}	\N	\N
804	894	directus_fields	96	{"sort":1,"hidden":true,"field":"id","collection":"products_categories"}	{"sort":1,"hidden":true,"field":"id","collection":"products_categories"}	\N	\N
805	895	directus_collections	products_categories	{"hidden":true,"icon":"import_export","collection":"products_categories"}	{"hidden":true,"icon":"import_export","collection":"products_categories"}	\N	\N
806	896	directus_fields	97	{"sort":2,"hidden":true,"collection":"products_categories","field":"products_id"}	{"sort":2,"hidden":true,"collection":"products_categories","field":"products_id"}	\N	\N
807	897	directus_fields	98	{"sort":3,"hidden":true,"collection":"products_categories","field":"categories_id"}	{"sort":3,"hidden":true,"collection":"products_categories","field":"categories_id"}	\N	\N
808	898	directus_fields	95	{"id":95,"collection":"products","field":"category","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false,"limit":100},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"half","translations":[{"language":"ru-RU","translation":"Категории"}],"note":"В каких категориях будет отображаться товар","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"category","width":"half"}	\N	\N
809	899	directus_fields	61	{"id":61,"collection":"products","field":"style","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false,"template":"{{styles_id.name}}"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"half","translations":[{"language":"ru-RU","translation":"Стиль"}],"note":null,"conditions":null,"required":false,"group":"attrs","validation":null,"validation_message":null}	{"collection":"products","field":"style","sort":1,"group":"attrs"}	\N	\N
909	1019	directus_collections	wholesale_wholesale_advant	{"hidden":true,"icon":"import_export","collection":"wholesale_wholesale_advant"}	{"hidden":true,"icon":"import_export","collection":"wholesale_wholesale_advant"}	\N	\N
810	900	directus_fields	34	{"id":34,"collection":"products","field":"id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"id","sort":1,"group":null}	\N	\N
812	902	directus_fields	35	{"id":35,"collection":"products","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_created","sort":2,"group":null}	\N	\N
814	904	directus_fields	36	{"id":36,"collection":"products","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"date_updated","sort":3,"group":null}	\N	\N
816	906	directus_fields	90	{"id":90,"collection":"products","field":"data","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"database"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Основные данные"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"data","sort":4,"group":null}	\N	\N
817	907	directus_fields	88	{"id":88,"collection":"products","field":"attrs","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"tag","start":"closed"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Атрибуты"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"attrs","sort":5,"group":null}	\N	\N
818	908	directus_fields	89	{"id":89,"collection":"products","field":"tech","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"admin_panel_settings","start":"closed"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":[{"language":"ru-RU","translation":"Настройки"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"tech","sort":6,"group":null}	\N	\N
819	909	directus_fields	84	{"id":84,"collection":"products","field":"seo","special":["alias","no-data","group"],"interface":"group-detail","options":{"start":"closed","headerIcon":"settings"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"products","field":"seo","sort":7,"group":null}	\N	\N
811	901	directus_fields	69	{"id":69,"collection":"products","field":"reason","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false,"template":"{{reason_id.name}}"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":[{"language":"ru-RU","translation":"Повод"}],"note":null,"conditions":null,"required":false,"group":"attrs","validation":null,"validation_message":null}	{"collection":"products","field":"reason","sort":2,"group":"attrs"}	\N	\N
813	903	directus_fields	79	{"id":79,"collection":"products","field":"structure","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false,"template":"{{structure_id.name}}"},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"half","translations":[{"language":"ru-RU","translation":"Состав"}],"note":null,"conditions":null,"required":false,"group":"attrs","validation":null,"validation_message":null}	{"collection":"products","field":"structure","sort":3,"group":"attrs"}	\N	\N
815	905	directus_fields	95	{"id":95,"collection":"products","field":"category","special":["m2m"],"interface":"list-m2m","options":{"enableCreate":false,"limit":100},"display":"related-values","display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"half","translations":[{"language":"ru-RU","translation":"Категории"}],"note":"В каких категориях будет отображаться товар","conditions":null,"required":false,"group":"attrs","validation":null,"validation_message":null}	{"collection":"products","field":"category","sort":4,"group":"attrs"}	\N	\N
820	910	directus_collections	categories	{"collection":"categories","icon":"settings_suggest","note":null,"display_template":"{{name}}","hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Категории","singular":"Категория","plural":"Категории"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"attrs","collapse":"open","preview_url":null,"versioning":false}	{"sort_field":"sort"}	\N	\N
821	911	categories	435b14c8-e7e1-4652-bfcb-e33505d51375	{"id":"435b14c8-e7e1-4652-bfcb-e33505d51375","name":"Цветы собственного производства","sort":1,"available":false}	{"sort":1,"available":false}	\N	\N
822	912	categories	88601e48-6abc-4303-a9a6-f73465a71478	{"id":"88601e48-6abc-4303-a9a6-f73465a71478","name":"1 сентября","sort":25,"available":true}	{"sort":25}	\N	\N
823	913	categories	1917a463-21c7-4d04-926b-d07259019930	{"id":"1917a463-21c7-4d04-926b-d07259019930","name":"Корзины","sort":1,"available":true}	{"sort":1}	\N	\N
824	914	directus_collections	categories	{"collection":"categories","icon":"settings_suggest","note":null,"display_template":"{{name}}","hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Категории","singular":"Категория","plural":"Категории"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":["sort"],"sort":1,"group":"attrs","collapse":"open","preview_url":null,"versioning":false}	{"item_duplication_fields":["sort"]}	\N	\N
825	915	categories	0e35dd7f-aa20-4700-b38e-c175cfd6a3b0	{"id":"0e35dd7f-aa20-4700-b38e-c175cfd6a3b0","name":"14 февраля","sort":1,"available":false}	{"sort":1}	\N	\N
826	916	directus_fields	93	{"id":93,"collection":"categories","field":"sort","special":null,"interface":"input","options":{"min":0,"iconLeft":"sort_by_alpha"},"display":"raw","display_options":null,"readonly":true,"hidden":true,"sort":3,"width":"half","translations":[{"language":"ru-RU","translation":"Сортировка"}],"note":"Значение от 0 до ∞, где 0 начало","conditions":null,"required":false,"group":null,"validation":{"_and":[{"sort":{"_gte":"0"}}]},"validation_message":null}	{"collection":"categories","field":"sort","readonly":true,"hidden":true}	\N	\N
827	917	directus_fields	94	{"id":94,"collection":"categories","field":"available","special":["cast-boolean"],"interface":"boolean","options":{"label":"Отображать на сайте"},"display":"boolean","display_options":{"labelOn":"Отображается","labelOff":"Скрыто"},"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Видимость"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"categories","field":"available","width":"full"}	\N	\N
828	918	directus_fields	93	{"id":93,"collection":"categories","field":"sort","special":null,"interface":"input","options":{"min":0,"iconLeft":"sort_by_alpha"},"display":"raw","display_options":null,"readonly":true,"hidden":true,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Сортировка"}],"note":"Значение от 0 до ∞, где 0 начало","conditions":null,"required":false,"group":null,"validation":{"_and":[{"sort":{"_gte":"0"}}]},"validation_message":null}	{"collection":"categories","field":"sort","width":"full"}	\N	\N
829	919	directus_fields	91	{"id":91,"collection":"categories","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"categories","field":"id","sort":1,"group":null}	\N	\N
830	920	directus_fields	93	{"id":93,"collection":"categories","field":"sort","special":null,"interface":"input","options":{"min":0,"iconLeft":"sort_by_alpha"},"display":"raw","display_options":null,"readonly":true,"hidden":true,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Сортировка"}],"note":"Значение от 0 до ∞, где 0 начало","conditions":null,"required":false,"group":null,"validation":{"_and":[{"sort":{"_gte":"0"}}]},"validation_message":null}	{"collection":"categories","field":"sort","sort":2,"group":null}	\N	\N
831	921	directus_fields	92	{"id":92,"collection":"categories","field":"name","special":null,"interface":"input","options":{"iconLeft":"drive_file_rename_outline"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Наименование"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"categories","field":"name","sort":3,"group":null}	\N	\N
832	922	directus_fields	94	{"id":94,"collection":"categories","field":"available","special":["cast-boolean"],"interface":"boolean","options":{"label":"Отображать на сайте"},"display":"boolean","display_options":{"labelOn":"Отображается","labelOff":"Скрыто"},"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Видимость"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"categories","field":"available","sort":4,"group":null}	\N	\N
950	1072	wholesale_wholesale_advant	2	{"id":2,"wholesale_id":null,"wholesale_advant_id":"04b5d690-4c36-4e26-8efc-a61481d2bab5"}	{"wholesale_id":null}	\N	\N
833	923	directus_fields	38	{"id":38,"collection":"products","field":"sort","special":null,"interface":"input","options":{"iconLeft":"sort_by_alpha","min":0},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Сортировка"}],"note":"Значение от 0 до ∞, где 0 - первая позиция ","conditions":null,"required":false,"group":"tech","validation":{"_and":[{"sort":{"_gte":"0"}}]},"validation_message":null}	{"collection":"products","field":"sort","width":"full"}	\N	\N
834	924	directus_fields	37	{"id":37,"collection":"products","field":"available","special":["cast-boolean"],"interface":"boolean","options":{"label":"Доступно к покупке"},"display":"boolean","display_options":{"labelOn":"Доступен","labelOff":"Недоступен"},"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"В наличии"}],"note":null,"conditions":null,"required":false,"group":"tech","validation":null,"validation_message":null}	{"collection":"products","field":"available","width":"full"}	\N	\N
835	925	directus_fields	38	{"id":38,"collection":"products","field":"sort","special":null,"interface":"input","options":{"iconLeft":"sort_by_alpha","min":0},"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Сортировка"}],"note":"Значение от 0 до ∞, где 0 - первая позиция ","conditions":null,"required":false,"group":"tech","validation":{"_and":[{"sort":{"_gte":"0"}}]},"validation_message":null}	{"collection":"products","field":"sort","readonly":true,"hidden":true}	\N	\N
840	930	directus_collections	structure	{"collection":"structure","icon":"settings_suggest","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Состав","singular":"Состав","plural":"Составы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":"attrs","collapse":"open","preview_url":null,"versioning":false}	{"sort_field":"sort"}	\N	\N
836	926	directus_fields	99	{"sort":3,"interface":"input","special":null,"readonly":true,"hidden":true,"translations":[{"language":"ru-RU","translation":"Сортировка"}],"options":{"min":0},"display":"raw","validation":{"_and":[{"sort":{"_gte":"0"}}]},"collection":"structure","field":"sort"}	{"sort":3,"interface":"input","special":null,"readonly":true,"hidden":true,"translations":[{"language":"ru-RU","translation":"Сортировка"}],"options":{"min":0},"display":"raw","validation":{"_and":[{"sort":{"_gte":"0"}}]},"collection":"structure","field":"sort"}	\N	\N
837	927	directus_fields	65	{"id":65,"collection":"structure","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"structure","field":"id","sort":1,"group":null}	\N	\N
838	928	directus_fields	99	{"id":99,"collection":"structure","field":"sort","special":null,"interface":"input","options":{"min":0},"display":"raw","display_options":null,"readonly":true,"hidden":true,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Сортировка"}],"note":null,"conditions":null,"required":false,"group":null,"validation":{"_and":[{"sort":{"_gte":"0"}}]},"validation_message":null}	{"collection":"structure","field":"sort","sort":2,"group":null}	\N	\N
839	929	directus_fields	66	{"id":66,"collection":"structure","field":"name","special":null,"interface":"input","options":{"iconLeft":"drive_file_rename_outline"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Наименование"}],"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"structure","field":"name","sort":3,"group":null}	\N	\N
841	931	directus_permissions	23	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"categories","action":"read"}	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"categories","action":"read"}	\N	\N
842	932	directus_permissions	24	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"products","action":"read"}	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"products","action":"read"}	\N	\N
843	933	directus_permissions	25	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"products_categories","action":"read"}	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"products_categories","action":"read"}	\N	\N
844	934	directus_permissions	26	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"products_files","action":"read"}	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"products_files","action":"read"}	\N	\N
845	935	directus_permissions	27	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"products_reason","action":"read"}	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"products_reason","action":"read"}	\N	\N
846	936	directus_permissions	28	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"products_structure","action":"read"}	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"products_structure","action":"read"}	\N	\N
847	937	directus_permissions	29	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"products_styles","action":"read"}	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"products_styles","action":"read"}	\N	\N
848	938	directus_permissions	30	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"reason","action":"read"}	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"reason","action":"read"}	\N	\N
849	939	directus_permissions	31	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"structure","action":"read"}	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"structure","action":"read"}	\N	\N
850	940	directus_permissions	32	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"styles","action":"read"}	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"styles","action":"read"}	\N	\N
851	942	directus_access	50c87726-ebc9-4502-9708-10e4a787ab29	{"id":"50c87726-ebc9-4502-9708-10e4a787ab29","role":null,"user":"5e7d0719-f6fa-4e9b-a681-d24bc8947984","policy":"7b920119-42aa-47ac-a60c-656664a5150d","sort":1}	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d"}	\N	\N
852	944	directus_collections	products_files	{"collection":"products_files","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"products","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"products"}	\N	\N
853	945	directus_collections	products_styles	{"collection":"products_styles","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"products","collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":"products"}	\N	\N
854	946	directus_collections	products_reason	{"collection":"products_reason","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":"products","collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":"products"}	\N	\N
910	1020	directus_fields	112	{"sort":2,"hidden":true,"collection":"wholesale_wholesale_advant","field":"wholesale_id"}	{"sort":2,"hidden":true,"collection":"wholesale_wholesale_advant","field":"wholesale_id"}	\N	\N
855	947	directus_collections	products_structure	{"collection":"products_structure","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":"products","collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":"products"}	\N	\N
856	948	directus_collections	products_categories	{"collection":"products_categories","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":5,"group":"products","collapse":"open","preview_url":null,"versioning":false}	{"sort":5,"group":"products"}	\N	\N
857	949	directus_collections	products	{"collection":"products","icon":"stacks","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Товары","singular":"Товар","plural":"Товары"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
858	950	directus_collections	attrs	{"collection":"attrs","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Атрибуты товаров"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
859	951	directus_collections	seo_settings	{"collection":"seo_settings","icon":"folder","note":"Содержит коллекции, связанные с SEO-настройками страниц","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"SEO настройки"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
860	952	directus_collections	pages	{"collection":"pages","icon":"folder","note":"Содержит коллекции, связанные с контентной частью сайта","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":null}	\N	\N
861	953	directus_fields	30	{"id":30,"collection":"wholesale","field":"advant","special":["m2m"],"interface":"list-m2m","options":{"enableSelect":false},"display":"related-values","display_options":{"template":"{{wholesale_advant_id.image}}"},"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"advant","display":"related-values","display_options":{"template":"{{wholesale_advant_id.image}}"}}	\N	\N
862	954	directus_fields	30	{"id":30,"collection":"wholesale","field":"advant","special":["m2m"],"interface":"list-m2m","options":{"enableSelect":false},"display":null,"display_options":{"template":null},"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"advant","display":null,"display_options":{"template":null}}	\N	\N
863	955	directus_collections	wholesale_advant	{"collection":"wholesale_advant","icon":null,"note":null,"display_template":"{{image}}","hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"wholesale","collapse":"open","preview_url":null,"versioning":false}	{"display_template":"{{image}}"}	\N	\N
864	956	directus_collections	wholesale_advant	{"collection":"wholesale_advant","icon":null,"note":null,"display_template":"{{image}}{{content}}","hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":"wholesale","collapse":"open","preview_url":null,"versioning":false}	{"display_template":"{{image}}{{content}}"}	\N	\N
865	970	directus_fields	100	{"sort":2,"special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Фоновое изображение"}],"interface":"file-image","display":"image","collection":"wholesale","field":"image"}	{"sort":2,"special":["file"],"required":true,"translations":[{"language":"ru-RU","translation":"Фоновое изображение"}],"interface":"file-image","display":"image","collection":"wholesale","field":"image"}	\N	\N
866	971	directus_fields	101	{"sort":3,"interface":"input","special":null,"translations":[{"language":"ru-RU","translation":"Тег страницы"}],"note":"Отображается над заголовком","options":{"iconLeft":"tag"},"display":"raw","collection":"wholesale","field":"tag"}	{"sort":3,"interface":"input","special":null,"translations":[{"language":"ru-RU","translation":"Тег страницы"}],"note":"Отображается над заголовком","options":{"iconLeft":"tag"},"display":"raw","collection":"wholesale","field":"tag"}	\N	\N
867	972	directus_fields	102	{"sort":4,"interface":"input","special":null,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Заголовок страницы"}],"display":"raw","collection":"wholesale","field":"title"}	{"sort":4,"interface":"input","special":null,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Заголовок страницы"}],"display":"raw","collection":"wholesale","field":"title"}	\N	\N
868	973	directus_fields	103	{"sort":5,"interface":"input","special":null,"options":{"iconLeft":"text_fields"},"translations":[{"language":"ru-RU","translation":"Описание "}],"display":"raw","collection":"wholesale","field":"description"}	{"sort":5,"interface":"input","special":null,"options":{"iconLeft":"text_fields"},"translations":[{"language":"ru-RU","translation":"Описание "}],"display":"raw","collection":"wholesale","field":"description"}	\N	\N
911	1021	directus_fields	113	{"sort":3,"hidden":true,"collection":"wholesale_wholesale_advant","field":"wholesale_advant_id"}	{"sort":3,"hidden":true,"collection":"wholesale_wholesale_advant","field":"wholesale_advant_id"}	\N	\N
869	975	directus_fields	104	{"sort":5,"special":null,"interface":"input-multiline","translations":[{"language":"ru-RU","translation":"Описание страницы"}],"collection":"wholesale","field":"description"}	{"sort":5,"special":null,"interface":"input-multiline","translations":[{"language":"ru-RU","translation":"Описание страницы"}],"collection":"wholesale","field":"description"}	\N	\N
870	976	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	{"id":"9be4e10a-bc62-4144-afc5-1adc89ebdcd2","image":"c49375f7-06d0-47d3-babd-0515605ec99f","tag":"Оптовикам","title":"Всегда свежие цветы для бизнеса","description":"Свежие цветы с нашей собственной фермы в Самарской области. Наши официальные оптовики получают доступ к многоуровневой партнёрской программе, скидки на продукцию, подарки и многое другое"}	{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","tag":"Оптовикам","title":"Всегда свежие цветы для бизнеса","description":"Свежие цветы с нашей собственной фермы в Самарской области. Наши официальные оптовики получают доступ к многоуровневой партнёрской программе, скидки на продукцию, подарки и многое другое"}	\N	\N
871	980	directus_fields	105	{"sort":6,"interface":"group-detail","special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Хироскрин"}],"options":{},"collection":"wholesale","field":"hero"}	{"sort":6,"interface":"group-detail","special":["alias","no-data","group"],"translations":[{"language":"ru-RU","translation":"Хироскрин"}],"options":{},"collection":"wholesale","field":"hero"}	\N	\N
872	981	directus_fields	18	{"id":18,"collection":"wholesale","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"id","sort":1,"group":null}	\N	\N
873	982	directus_fields	101	{"id":101,"collection":"wholesale","field":"tag","special":null,"interface":"input","options":{"iconLeft":"tag"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Тег страницы"}],"note":"Отображается над заголовком","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"tag","sort":2,"group":null}	\N	\N
874	983	directus_fields	102	{"id":102,"collection":"wholesale","field":"title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок страницы"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"title","sort":3,"group":null}	\N	\N
875	984	directus_fields	104	{"id":104,"collection":"wholesale","field":"description","special":null,"interface":"input-multiline","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Описание страницы"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"description","sort":4,"group":null}	\N	\N
876	985	directus_fields	100	{"id":100,"collection":"wholesale","field":"image","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Фоновое изображение"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"wholesale","field":"image","sort":1,"group":"hero"}	\N	\N
877	986	directus_fields	105	{"id":105,"collection":"wholesale","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"hero","sort":5,"group":null}	\N	\N
878	988	directus_fields	18	{"id":18,"collection":"wholesale","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"id","sort":1,"group":null}	\N	\N
879	987	directus_fields	100	{"id":100,"collection":"wholesale","field":"image","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Фоновое изображение"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"wholesale","field":"image","sort":1,"group":"hero"}	\N	\N
880	989	directus_fields	102	{"id":102,"collection":"wholesale","field":"title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок страницы"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"title","sort":2,"group":null}	\N	\N
881	990	directus_fields	101	{"id":101,"collection":"wholesale","field":"tag","special":null,"interface":"input","options":{"iconLeft":"tag"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Тег страницы"}],"note":"Отображается над заголовком","conditions":null,"required":false,"group":"hero","validation":null,"validation_message":null}	{"collection":"wholesale","field":"tag","sort":2,"group":"hero"}	\N	\N
882	991	directus_fields	104	{"id":104,"collection":"wholesale","field":"description","special":null,"interface":"input-multiline","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Описание страницы"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"description","sort":3,"group":null}	\N	\N
949	1071	wholesale_wholesale_advant	1	{"id":1,"wholesale_id":null,"wholesale_advant_id":"ee022322-8cca-44a7-a7c2-620090f44779"}	{"wholesale_id":null}	\N	\N
883	992	directus_fields	105	{"id":105,"collection":"wholesale","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"hero","sort":4,"group":null}	\N	\N
884	993	directus_fields	100	{"id":100,"collection":"wholesale","field":"image","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Фоновое изображение"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"wholesale","field":"image","sort":1,"group":"hero"}	\N	\N
886	995	directus_fields	101	{"id":101,"collection":"wholesale","field":"tag","special":null,"interface":"input","options":{"iconLeft":"tag"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Тег страницы"}],"note":"Отображается над заголовком","conditions":null,"required":false,"group":"hero","validation":null,"validation_message":null}	{"collection":"wholesale","field":"tag","sort":2,"group":"hero"}	\N	\N
888	997	directus_fields	102	{"id":102,"collection":"wholesale","field":"title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок страницы"}],"note":null,"conditions":null,"required":false,"group":"hero","validation":null,"validation_message":null}	{"collection":"wholesale","field":"title","sort":3,"group":"hero"}	\N	\N
890	999	directus_fields	18	{"id":18,"collection":"wholesale","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"id","sort":1,"group":null}	\N	\N
892	1001	directus_fields	105	{"id":105,"collection":"wholesale","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"hero","sort":2,"group":null}	\N	\N
885	994	directus_fields	18	{"id":18,"collection":"wholesale","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"id","sort":1,"group":null}	\N	\N
887	996	directus_fields	104	{"id":104,"collection":"wholesale","field":"description","special":null,"interface":"input-multiline","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Описание страницы"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"description","sort":2,"group":null}	\N	\N
889	998	directus_fields	105	{"id":105,"collection":"wholesale","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"hero","sort":3,"group":null}	\N	\N
891	1000	directus_fields	100	{"id":100,"collection":"wholesale","field":"image","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Фоновое изображение"}],"note":null,"conditions":null,"required":true,"group":"hero","validation":null,"validation_message":null}	{"collection":"wholesale","field":"image","sort":1,"group":"hero"}	\N	\N
893	1002	directus_fields	101	{"id":101,"collection":"wholesale","field":"tag","special":null,"interface":"input","options":{"iconLeft":"tag"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Тег страницы"}],"note":"Отображается над заголовком","conditions":null,"required":false,"group":"hero","validation":null,"validation_message":null}	{"collection":"wholesale","field":"tag","sort":2,"group":"hero"}	\N	\N
894	1003	directus_fields	102	{"id":102,"collection":"wholesale","field":"title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок страницы"}],"note":null,"conditions":null,"required":false,"group":"hero","validation":null,"validation_message":null}	{"collection":"wholesale","field":"title","sort":3,"group":"hero"}	\N	\N
895	1004	directus_fields	104	{"id":104,"collection":"wholesale","field":"description","special":null,"interface":"input-multiline","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Описание страницы"}],"note":null,"conditions":null,"required":false,"group":"hero","validation":null,"validation_message":null}	{"collection":"wholesale","field":"description","sort":4,"group":"hero"}	\N	\N
896	1005	directus_fields	106	{"sort":5,"interface":"group-detail","special":["alias","no-data","group"],"options":{"headerIcon":"list"},"translations":[{"language":"ru-RU","translation":"Список преимуществ"}],"collection":"wholesale","field":"advant"}	{"sort":5,"interface":"group-detail","special":["alias","no-data","group"],"options":{"headerIcon":"list"},"translations":[{"language":"ru-RU","translation":"Список преимуществ"}],"collection":"wholesale","field":"advant"}	\N	\N
897	1007	directus_fields	107	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"wholesale_advant"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"wholesale_advant"}	\N	\N
898	1008	directus_collections	wholesale_advant	{"singleton":false,"collection":"wholesale_advant"}	{"singleton":false,"collection":"wholesale_advant"}	\N	\N
899	1009	directus_fields	108	{"sort":2,"interface":"file-image","special":["file"],"translations":[{"language":"ru-RU","translation":"Изображение"}],"display":"image","collection":"wholesale_advant","field":"image"}	{"sort":2,"interface":"file-image","special":["file"],"translations":[{"language":"ru-RU","translation":"Изображение"}],"display":"image","collection":"wholesale_advant","field":"image"}	\N	\N
900	1010	directus_fields	109	{"sort":3,"special":null,"interface":"input-rich-text-html","translations":[{"language":"ru-RU","translation":"Содержание"}],"options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","alignleft","aligncenter","alignright","numlist","bullist","removeformat","customLink","hr","fullscreen"]},"collection":"wholesale_advant","field":"content"}	{"sort":3,"special":null,"interface":"input-rich-text-html","translations":[{"language":"ru-RU","translation":"Содержание"}],"options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h2","h3","h4","h5","h6","alignleft","aligncenter","alignright","numlist","bullist","removeformat","customLink","hr","fullscreen"]},"collection":"wholesale_advant","field":"content"}	\N	\N
901	1011	directus_collections	wholesale_advant	{"collection":"wholesale_advant","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"wholesale","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"wholesale"}	\N	\N
902	1012	directus_collections	products	{"collection":"products","icon":"stacks","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Товары","singular":"Товар","plural":"Товары"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
903	1013	directus_collections	attrs	{"collection":"attrs","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Атрибуты товаров"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
907	1017	directus_fields	110	{"sort":5,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{image}}{{content}}","enableSelect":false},"collection":"wholesale","field":"advant"}	{"sort":5,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{image}}{{content}}","enableSelect":false},"collection":"wholesale","field":"advant"}	\N	\N
904	1014	directus_collections	seo_settings	{"collection":"seo_settings","icon":"folder","note":"Содержит коллекции, связанные с SEO-настройками страниц","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"SEO настройки"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
905	1015	directus_collections	pages	{"collection":"pages","icon":"folder","note":"Содержит коллекции, связанные с контентной частью сайта","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":null}	\N	\N
906	1016	directus_collections	wholesale_advant	{"collection":"wholesale_advant","icon":null,"note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"wholesale","collapse":"open","preview_url":null,"versioning":false}	{"hidden":true}	\N	\N
912	1022	directus_collections	wholesale_wholesale_advant	{"collection":"wholesale_wholesale_advant","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"wholesale_advant","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"wholesale_advant"}	\N	\N
913	1023	directus_collections	products	{"collection":"products","icon":"stacks","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Товары","singular":"Товар","plural":"Товары"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
914	1024	directus_collections	attrs	{"collection":"attrs","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Атрибуты товаров"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
915	1025	directus_collections	seo_settings	{"collection":"seo_settings","icon":"folder","note":"Содержит коллекции, связанные с SEO-настройками страниц","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"SEO настройки"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
916	1026	directus_collections	pages	{"collection":"pages","icon":"folder","note":"Содержит коллекции, связанные с контентной частью сайта","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":null}	\N	\N
917	1028	directus_fields	114	{"sort":5,"interface":"list-m2m","special":["m2m"],"options":{"enableSelect":false},"collection":"wholesale","field":"advant"}	{"sort":5,"interface":"list-m2m","special":["m2m"],"options":{"enableSelect":false},"collection":"wholesale","field":"advant"}	\N	\N
918	1029	directus_fields	115	{"sort":1,"hidden":true,"field":"id","collection":"wholesale_wholesale_advant_1"}	{"sort":1,"hidden":true,"field":"id","collection":"wholesale_wholesale_advant_1"}	\N	\N
919	1030	directus_collections	wholesale_wholesale_advant_1	{"hidden":true,"icon":"import_export","collection":"wholesale_wholesale_advant_1"}	{"hidden":true,"icon":"import_export","collection":"wholesale_wholesale_advant_1"}	\N	\N
920	1031	directus_fields	116	{"sort":2,"hidden":true,"collection":"wholesale_wholesale_advant_1","field":"wholesale_id"}	{"sort":2,"hidden":true,"collection":"wholesale_wholesale_advant_1","field":"wholesale_id"}	\N	\N
921	1032	directus_fields	117	{"sort":3,"hidden":true,"collection":"wholesale_wholesale_advant_1","field":"wholesale_advant_id"}	{"sort":3,"hidden":true,"collection":"wholesale_wholesale_advant_1","field":"wholesale_advant_id"}	\N	\N
922	1033	wholesale_advant	c11cc4c8-57d9-46fb-93d2-fa19a48302b8	{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<p>ddd</p>"}	{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<p>ddd</p>"}	\N	\N
924	1045	directus_fields	118	{"sort":5,"interface":"group-detail","special":["alias","no-data","group"],"options":{"headerIcon":"list"},"translations":[{"language":"ru-RU","translation":"Список преимуществ"}],"collection":"wholesale","field":"list"}	{"sort":5,"interface":"group-detail","special":["alias","no-data","group"],"options":{"headerIcon":"list"},"translations":[{"language":"ru-RU","translation":"Список преимуществ"}],"collection":"wholesale","field":"list"}	\N	\N
925	1046	directus_fields	119	{"sort":6,"interface":"list-m2m","special":["m2m"],"options":{"enableSelect":false},"collection":"wholesale","field":"advant"}	{"sort":6,"interface":"list-m2m","special":["m2m"],"options":{"enableSelect":false},"collection":"wholesale","field":"advant"}	\N	\N
926	1047	directus_fields	120	{"sort":1,"hidden":true,"field":"id","collection":"wholesale_wholesale_advant"}	{"sort":1,"hidden":true,"field":"id","collection":"wholesale_wholesale_advant"}	\N	\N
927	1048	directus_collections	wholesale_wholesale_advant	{"hidden":true,"icon":"import_export","collection":"wholesale_wholesale_advant"}	{"hidden":true,"icon":"import_export","collection":"wholesale_wholesale_advant"}	\N	\N
928	1049	directus_fields	121	{"sort":2,"hidden":true,"collection":"wholesale_wholesale_advant","field":"wholesale_id"}	{"sort":2,"hidden":true,"collection":"wholesale_wholesale_advant","field":"wholesale_id"}	\N	\N
929	1050	directus_fields	122	{"sort":3,"hidden":true,"collection":"wholesale_wholesale_advant","field":"wholesale_advant_id"}	{"sort":3,"hidden":true,"collection":"wholesale_wholesale_advant","field":"wholesale_advant_id"}	\N	\N
930	1051	directus_fields	18	{"id":18,"collection":"wholesale","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"id","sort":1,"group":null}	\N	\N
931	1052	directus_fields	105	{"id":105,"collection":"wholesale","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"hero","sort":2,"group":null}	\N	\N
932	1053	directus_fields	118	{"id":118,"collection":"wholesale","field":"list","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"list"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Список преимуществ"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"list","sort":3,"group":null}	\N	\N
933	1054	directus_fields	119	{"id":119,"collection":"wholesale","field":"advant","special":["m2m"],"interface":"list-m2m","options":{"enableSelect":false},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":"list","validation":null,"validation_message":null}	{"collection":"wholesale","field":"advant","sort":1,"group":"list"}	\N	\N
935	1056	wholesale_wholesale_advant	1	{"wholesale_advant_id":{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<p>dfbdfb</p>"},"wholesale_id":"9be4e10a-bc62-4144-afc5-1adc89ebdcd2"}	{"wholesale_advant_id":{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<p>dfbdfb</p>"},"wholesale_id":"9be4e10a-bc62-4144-afc5-1adc89ebdcd2"}	\N	\N
934	1055	wholesale_advant	ee022322-8cca-44a7-a7c2-620090f44779	{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<p>dfbdfb</p>"}	{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<p>dfbdfb</p>"}	935	\N
937	1058	wholesale_wholesale_advant	2	{"wholesale_advant_id":{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<p>SDvzsvsdv</p>"},"wholesale_id":"9be4e10a-bc62-4144-afc5-1adc89ebdcd2"}	{"wholesale_advant_id":{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<p>SDvzsvsdv</p>"},"wholesale_id":"9be4e10a-bc62-4144-afc5-1adc89ebdcd2"}	\N	\N
936	1057	wholesale_advant	04b5d690-4c36-4e26-8efc-a61481d2bab5	{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<p>SDvzsvsdv</p>"}	{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<p>SDvzsvsdv</p>"}	937	\N
938	1060	directus_collections	wholesale_wholesale_advant	{"collection":"wholesale_wholesale_advant","icon":"import_export","note":null,"display_template":null,"hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"wholesale_advant","collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":"wholesale_advant"}	\N	\N
939	1061	directus_collections	products	{"collection":"products","icon":"stacks","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Товары","singular":"Товар","plural":"Товары"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":"sort","accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":1,"group":null}	\N	\N
940	1062	directus_collections	attrs	{"collection":"attrs","icon":"folder","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Атрибуты товаров"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":2,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":2,"group":null}	\N	\N
941	1063	directus_collections	seo_settings	{"collection":"seo_settings","icon":"folder","note":"Содержит коллекции, связанные с SEO-настройками страниц","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"SEO настройки"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":3,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":3,"group":null}	\N	\N
942	1064	directus_collections	pages	{"collection":"pages","icon":"folder","note":"Содержит коллекции, связанные с контентной частью сайта","display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"ru-RU","translation":"Страницы"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":4,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"sort":4,"group":null}	\N	\N
943	1065	directus_fields	119	{"id":119,"collection":"wholesale","field":"advant","special":["m2m"],"interface":"list-m2m","options":{"enableSelect":false},"display":"related-values","display_options":{"template":"{{wholesale_advant_id.image}}{{wholesale_advant_id.content}}"},"readonly":false,"hidden":false,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":"list","validation":null,"validation_message":null}	{"collection":"wholesale","field":"advant","display":"related-values","display_options":{"template":"{{wholesale_advant_id.image}}{{wholesale_advant_id.content}}"}}	\N	\N
944	1066	directus_collections	wholesale_advant	{"collection":"wholesale_advant","icon":null,"note":null,"display_template":"{{image}}{{content}}","hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"wholesale","collapse":"open","preview_url":null,"versioning":false}	{"display_template":"{{image}}{{content}}"}	\N	\N
945	1067	directus_fields	119	{"id":119,"collection":"wholesale","field":"advant","special":["m2m"],"interface":"list-m2m","options":{"enableSelect":false},"display":"related-values","display_options":{"template":"{{wholesale_advant_id.image}}{{wholesale_advant_id.content}}"},"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Блок"}],"note":null,"conditions":null,"required":false,"group":"list","validation":null,"validation_message":null}	{"collection":"wholesale","field":"advant","translations":[{"language":"ru-RU","translation":"Блок"}]}	\N	\N
946	1068	directus_collections	wholesale_advant	{"collection":"wholesale_advant","icon":null,"note":null,"display_template":"{{image}}{{content}}","hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"wholesale","collapse":"closed","preview_url":null,"versioning":false}	{"collapse":"closed"}	\N	\N
947	1069	directus_collections	wholesale_advant	{"collection":"wholesale_advant","icon":null,"note":null,"display_template":"{{image}}{{content}}","hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"wholesale","collapse":"open","preview_url":null,"versioning":false}	{"collapse":"open"}	\N	\N
948	1070	directus_collections	wholesale_advant	{"collection":"wholesale_advant","icon":null,"note":null,"display_template":"{{image}}{{content}}","hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"wholesale","collapse":"open","preview_url":null,"versioning":false}	{"hidden":false}	\N	\N
952	1078	wholesale_wholesale_advant	3	{"wholesale_advant_id":{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<p>test1</p>"},"wholesale_id":"9be4e10a-bc62-4144-afc5-1adc89ebdcd2"}	{"wholesale_advant_id":{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<p>test1</p>"},"wholesale_id":"9be4e10a-bc62-4144-afc5-1adc89ebdcd2"}	\N	\N
951	1077	wholesale_advant	c57c2627-290f-401e-a6fe-bf745c5cdbea	{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<p>test1</p>"}	{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<p>test1</p>"}	952	\N
954	1084	wholesale_wholesale_advant	4	{"wholesale_advant_id":{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<p>advav</p>"},"wholesale_id":"9be4e10a-bc62-4144-afc5-1adc89ebdcd2"}	{"wholesale_advant_id":{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<p>advav</p>"},"wholesale_id":"9be4e10a-bc62-4144-afc5-1adc89ebdcd2"}	\N	\N
953	1083	wholesale_advant	af006291-e9d7-4fe6-9ebd-371100016034	{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<p>advav</p>"}	{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<p>advav</p>"}	954	\N
956	1089	wholesale_wholesale_advant	5	{"wholesale_advant_id":{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<p>szdb</p>"},"wholesale_id":"9be4e10a-bc62-4144-afc5-1adc89ebdcd2"}	{"wholesale_advant_id":{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<p>szdb</p>"},"wholesale_id":"9be4e10a-bc62-4144-afc5-1adc89ebdcd2"}	\N	\N
955	1088	wholesale_advant	961fcf39-e0da-4092-b4f4-def775b32e8d	{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<p>szdb</p>"}	{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<p>szdb</p>"}	956	\N
958	1096	wholesale_wholesale_advant	6	{"wholesale_advant_id":{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<p>sdzfb</p>"},"wholesale_id":"9be4e10a-bc62-4144-afc5-1adc89ebdcd2"}	{"wholesale_advant_id":{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<p>sdzfb</p>"},"wholesale_id":"9be4e10a-bc62-4144-afc5-1adc89ebdcd2"}	\N	\N
957	1095	wholesale_advant	89c8fc0f-00d3-4129-9a1f-a72d924101bd	{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<p>sdzfb</p>"}	{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<p>sdzfb</p>"}	958	\N
959	1098	wholesale_wholesale_advant	6	{"id":6,"wholesale_id":null,"wholesale_advant_id":"89c8fc0f-00d3-4129-9a1f-a72d924101bd"}	{"wholesale_id":null}	\N	\N
960	1100	directus_fields	119	{"id":119,"collection":"wholesale","field":"advant","special":["m2m"],"interface":"list-m2m","options":{},"display":"related-values","display_options":{"template":"{{wholesale_advant_id.image}}{{wholesale_advant_id.content}}"},"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Блок"}],"note":null,"conditions":null,"required":false,"group":"list","validation":null,"validation_message":null}	{"collection":"wholesale","field":"advant","options":{}}	\N	\N
961	1101	directus_fields	119	{"id":119,"collection":"wholesale","field":"advant","special":["m2m"],"interface":"list-m2m","options":{"enableSelect":false},"display":"related-values","display_options":{"template":"{{wholesale_advant_id.image}}{{wholesale_advant_id.content}}"},"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Блок"}],"note":null,"conditions":null,"required":false,"group":"list","validation":null,"validation_message":null}	{"collection":"wholesale","field":"advant","options":{"enableSelect":false}}	\N	\N
979	1122	directus_fields	124	{"id":124,"collection":"wholesale","field":"faq_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока"}],"note":null,"conditions":null,"required":false,"group":"faq","validation":null,"validation_message":null}	{"collection":"wholesale","field":"faq_title","sort":1,"group":"faq"}	\N	\N
981	1124	directus_fields	125	{"sort":5,"interface":"input-rich-text-html","special":null,"translations":[{"language":"ru-RU","translation":"Описание блока"}],"options":{"toolbar":["bold","italic","underline","strikethrough","h3","h4","h5","h6","numlist","bullist","removeformat","customLink","customImage","hr","fullscreen"]},"display":"formatted-value","collection":"wholesale","field":"faq_description"}	{"sort":5,"interface":"input-rich-text-html","special":null,"translations":[{"language":"ru-RU","translation":"Описание блока"}],"options":{"toolbar":["bold","italic","underline","strikethrough","h3","h4","h5","h6","numlist","bullist","removeformat","customLink","customImage","hr","fullscreen"]},"display":"formatted-value","collection":"wholesale","field":"faq_description"}	\N	\N
982	1125	directus_fields	18	{"id":18,"collection":"wholesale","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"id","sort":1,"group":null}	\N	\N
983	1126	directus_fields	105	{"id":105,"collection":"wholesale","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"hero","sort":2,"group":null}	\N	\N
984	1127	directus_fields	118	{"id":118,"collection":"wholesale","field":"list","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"list"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Список преимуществ"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"list","sort":3,"group":null}	\N	\N
985	1128	directus_fields	123	{"id":123,"collection":"wholesale","field":"faq","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"question_mark"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Раздел FAQ"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"faq","sort":4,"group":null}	\N	\N
963	1103	wholesale_wholesale_advant	7	{"wholesale_advant_id":{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<h2>Для флористов, маркетинговых и свадебных агентств</h2>\\n<p>Покупая цветы оптом у нас, вы получаете множество преимуществ:</p>\\n<ul>\\n<li>Накопление бонусов: За каждую покупку на сумму от 5000 рублей вы получаете бонусы, которые можно использовать для получения скидок.</li>\\n<li>Эксклюзивные скидки: Чем больше вы покупаете, тем выше ваша скидка в следующем месяце.</li>\\n<li>Качество от производителя: Все цветы поступают с нашей фермы, что гарантирует свежесть и высокое качество.</li>\\n</ul>"},"wholesale_id":"9be4e10a-bc62-4144-afc5-1adc89ebdcd2"}	{"wholesale_advant_id":{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<h2>Для флористов, маркетинговых и свадебных агентств</h2>\\n<p>Покупая цветы оптом у нас, вы получаете множество преимуществ:</p>\\n<ul>\\n<li>Накопление бонусов: За каждую покупку на сумму от 5000 рублей вы получаете бонусы, которые можно использовать для получения скидок.</li>\\n<li>Эксклюзивные скидки: Чем больше вы покупаете, тем выше ваша скидка в следующем месяце.</li>\\n<li>Качество от производителя: Все цветы поступают с нашей фермы, что гарантирует свежесть и высокое качество.</li>\\n</ul>"},"wholesale_id":"9be4e10a-bc62-4144-afc5-1adc89ebdcd2"}	\N	\N
962	1102	wholesale_advant	a96d6a1d-9b15-43ee-8755-d242c92bcc03	{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<h2>Для флористов, маркетинговых и свадебных агентств</h2>\\n<p>Покупая цветы оптом у нас, вы получаете множество преимуществ:</p>\\n<ul>\\n<li>Накопление бонусов: За каждую покупку на сумму от 5000 рублей вы получаете бонусы, которые можно использовать для получения скидок.</li>\\n<li>Эксклюзивные скидки: Чем больше вы покупаете, тем выше ваша скидка в следующем месяце.</li>\\n<li>Качество от производителя: Все цветы поступают с нашей фермы, что гарантирует свежесть и высокое качество.</li>\\n</ul>"}	{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<h2>Для флористов, маркетинговых и свадебных агентств</h2>\\n<p>Покупая цветы оптом у нас, вы получаете множество преимуществ:</p>\\n<ul>\\n<li>Накопление бонусов: За каждую покупку на сумму от 5000 рублей вы получаете бонусы, которые можно использовать для получения скидок.</li>\\n<li>Эксклюзивные скидки: Чем больше вы покупаете, тем выше ваша скидка в следующем месяце.</li>\\n<li>Качество от производителя: Все цветы поступают с нашей фермы, что гарантирует свежесть и высокое качество.</li>\\n</ul>"}	963	\N
965	1105	wholesale_wholesale_advant	8	{"wholesale_advant_id":{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<h2>Для флористов, маркетинговых и свадебных агентств</h2>\\n<p>Покупая цветы оптом у нас, вы получаете множество преимуществ:</p>\\n<ul>\\n<li>Накопление бонусов: За каждую покупку на сумму от 5000 рублей вы получаете бонусы, которые можно использовать для получения скидок.</li>\\n<li>Эксклюзивные скидки: Чем больше вы покупаете, тем выше ваша скидка в следующем месяце.</li>\\n<li>Качество от производителя: Все цветы поступают с нашей фермы, что гарантирует свежесть и высокое качество.</li>\\n</ul>"},"wholesale_id":"9be4e10a-bc62-4144-afc5-1adc89ebdcd2"}	{"wholesale_advant_id":{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<h2>Для флористов, маркетинговых и свадебных агентств</h2>\\n<p>Покупая цветы оптом у нас, вы получаете множество преимуществ:</p>\\n<ul>\\n<li>Накопление бонусов: За каждую покупку на сумму от 5000 рублей вы получаете бонусы, которые можно использовать для получения скидок.</li>\\n<li>Эксклюзивные скидки: Чем больше вы покупаете, тем выше ваша скидка в следующем месяце.</li>\\n<li>Качество от производителя: Все цветы поступают с нашей фермы, что гарантирует свежесть и высокое качество.</li>\\n</ul>"},"wholesale_id":"9be4e10a-bc62-4144-afc5-1adc89ebdcd2"}	\N	\N
980	1123	directus_fields	123	{"id":123,"collection":"wholesale","field":"faq","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"question_mark"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Раздел FAQ"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"faq","sort":4,"group":null}	\N	\N
986	1129	directus_fields	124	{"id":124,"collection":"wholesale","field":"faq_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока"}],"note":null,"conditions":null,"required":false,"group":"faq","validation":null,"validation_message":null}	{"collection":"wholesale","field":"faq_title","sort":1,"group":"faq"}	\N	\N
1006	1150	directus_fields	129	{"id":129,"collection":"wholesale","field":"banner_image","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Фоновое изображение"}],"note":null,"conditions":null,"required":false,"group":"banner","validation":null,"validation_message":null}	{"collection":"wholesale","field":"banner_image","sort":1,"group":"banner"}	\N	\N
1008	1152	directus_fields	130	{"sort":6,"interface":"input","special":null,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Заголовок баннера"}],"display":"raw","collection":"wholesale","field":"banner_title"}	{"sort":6,"interface":"input","special":null,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Заголовок баннера"}],"display":"raw","collection":"wholesale","field":"banner_title"}	\N	\N
964	1104	wholesale_advant	78b365d9-ec54-4337-af8b-c62ad45e9d92	{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<h2>Для флористов, маркетинговых и свадебных агентств</h2>\\n<p>Покупая цветы оптом у нас, вы получаете множество преимуществ:</p>\\n<ul>\\n<li>Накопление бонусов: За каждую покупку на сумму от 5000 рублей вы получаете бонусы, которые можно использовать для получения скидок.</li>\\n<li>Эксклюзивные скидки: Чем больше вы покупаете, тем выше ваша скидка в следующем месяце.</li>\\n<li>Качество от производителя: Все цветы поступают с нашей фермы, что гарантирует свежесть и высокое качество.</li>\\n</ul>"}	{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<h2>Для флористов, маркетинговых и свадебных агентств</h2>\\n<p>Покупая цветы оптом у нас, вы получаете множество преимуществ:</p>\\n<ul>\\n<li>Накопление бонусов: За каждую покупку на сумму от 5000 рублей вы получаете бонусы, которые можно использовать для получения скидок.</li>\\n<li>Эксклюзивные скидки: Чем больше вы покупаете, тем выше ваша скидка в следующем месяце.</li>\\n<li>Качество от производителя: Все цветы поступают с нашей фермы, что гарантирует свежесть и высокое качество.</li>\\n</ul>"}	965	\N
967	1107	wholesale_wholesale_advant	9	{"wholesale_advant_id":{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<h2>Для флористов, маркетинговых и свадебных агентств</h2>\\n<p>Покупая цветы оптом у нас, вы получаете множество преимуществ:</p>\\n<ul>\\n<li>Накопление бонусов: За каждую покупку на сумму от 5000 рублей вы получаете бонусы, которые можно использовать для получения скидок.</li>\\n<li>Эксклюзивные скидки: Чем больше вы покупаете, тем выше ваша скидка в следующем месяце.</li>\\n<li>Качество от производителя: Все цветы поступают с нашей фермы, что гарантирует свежесть и высокое качество.</li>\\n</ul>"},"wholesale_id":"9be4e10a-bc62-4144-afc5-1adc89ebdcd2"}	{"wholesale_advant_id":{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<h2>Для флористов, маркетинговых и свадебных агентств</h2>\\n<p>Покупая цветы оптом у нас, вы получаете множество преимуществ:</p>\\n<ul>\\n<li>Накопление бонусов: За каждую покупку на сумму от 5000 рублей вы получаете бонусы, которые можно использовать для получения скидок.</li>\\n<li>Эксклюзивные скидки: Чем больше вы покупаете, тем выше ваша скидка в следующем месяце.</li>\\n<li>Качество от производителя: Все цветы поступают с нашей фермы, что гарантирует свежесть и высокое качество.</li>\\n</ul>"},"wholesale_id":"9be4e10a-bc62-4144-afc5-1adc89ebdcd2"}	\N	\N
966	1106	wholesale_advant	350f1de0-a24f-491b-9d6c-b1f8e12dc93f	{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<h2>Для флористов, маркетинговых и свадебных агентств</h2>\\n<p>Покупая цветы оптом у нас, вы получаете множество преимуществ:</p>\\n<ul>\\n<li>Накопление бонусов: За каждую покупку на сумму от 5000 рублей вы получаете бонусы, которые можно использовать для получения скидок.</li>\\n<li>Эксклюзивные скидки: Чем больше вы покупаете, тем выше ваша скидка в следующем месяце.</li>\\n<li>Качество от производителя: Все цветы поступают с нашей фермы, что гарантирует свежесть и высокое качество.</li>\\n</ul>"}	{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<h2>Для флористов, маркетинговых и свадебных агентств</h2>\\n<p>Покупая цветы оптом у нас, вы получаете множество преимуществ:</p>\\n<ul>\\n<li>Накопление бонусов: За каждую покупку на сумму от 5000 рублей вы получаете бонусы, которые можно использовать для получения скидок.</li>\\n<li>Эксклюзивные скидки: Чем больше вы покупаете, тем выше ваша скидка в следующем месяце.</li>\\n<li>Качество от производителя: Все цветы поступают с нашей фермы, что гарантирует свежесть и высокое качество.</li>\\n</ul>"}	967	\N
1009	1153	directus_fields	18	{"id":18,"collection":"wholesale","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"id","sort":1,"group":null}	\N	\N
1010	1154	directus_fields	105	{"id":105,"collection":"wholesale","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"hero","sort":2,"group":null}	\N	\N
1011	1155	directus_fields	118	{"id":118,"collection":"wholesale","field":"list","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"list"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Список преимуществ"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"list","sort":3,"group":null}	\N	\N
1012	1156	directus_fields	123	{"id":123,"collection":"wholesale","field":"faq","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"question_mark"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Раздел FAQ"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"faq","sort":4,"group":null}	\N	\N
969	1109	wholesale_wholesale_advant	10	{"wholesale_advant_id":{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<h2>Для флористов, маркетинговых и свадебных агентств</h2>\\n<p>Покупая цветы оптом у нас, вы получаете множество преимуществ:</p>\\n<ul>\\n<li>Накопление бонусов: За каждую покупку на сумму от 5000 рублей вы получаете бонусы, которые можно использовать для получения скидок.</li>\\n<li>Эксклюзивные скидки: Чем больше вы покупаете, тем выше ваша скидка в следующем месяце.</li>\\n<li>Качество от производителя: Все цветы поступают с нашей фермы, что гарантирует свежесть и высокое качество.</li>\\n</ul>"},"wholesale_id":"9be4e10a-bc62-4144-afc5-1adc89ebdcd2"}	{"wholesale_advant_id":{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<h2>Для флористов, маркетинговых и свадебных агентств</h2>\\n<p>Покупая цветы оптом у нас, вы получаете множество преимуществ:</p>\\n<ul>\\n<li>Накопление бонусов: За каждую покупку на сумму от 5000 рублей вы получаете бонусы, которые можно использовать для получения скидок.</li>\\n<li>Эксклюзивные скидки: Чем больше вы покупаете, тем выше ваша скидка в следующем месяце.</li>\\n<li>Качество от производителя: Все цветы поступают с нашей фермы, что гарантирует свежесть и высокое качество.</li>\\n</ul>"},"wholesale_id":"9be4e10a-bc62-4144-afc5-1adc89ebdcd2"}	\N	\N
968	1108	wholesale_advant	0be59b02-5267-401c-90d9-be80a41f44a6	{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<h2>Для флористов, маркетинговых и свадебных агентств</h2>\\n<p>Покупая цветы оптом у нас, вы получаете множество преимуществ:</p>\\n<ul>\\n<li>Накопление бонусов: За каждую покупку на сумму от 5000 рублей вы получаете бонусы, которые можно использовать для получения скидок.</li>\\n<li>Эксклюзивные скидки: Чем больше вы покупаете, тем выше ваша скидка в следующем месяце.</li>\\n<li>Качество от производителя: Все цветы поступают с нашей фермы, что гарантирует свежесть и высокое качество.</li>\\n</ul>"}	{"image":"c49375f7-06d0-47d3-babd-0515605ec99f","content":"<h2>Для флористов, маркетинговых и свадебных агентств</h2>\\n<p>Покупая цветы оптом у нас, вы получаете множество преимуществ:</p>\\n<ul>\\n<li>Накопление бонусов: За каждую покупку на сумму от 5000 рублей вы получаете бонусы, которые можно использовать для получения скидок.</li>\\n<li>Эксклюзивные скидки: Чем больше вы покупаете, тем выше ваша скидка в следующем месяце.</li>\\n<li>Качество от производителя: Все цветы поступают с нашей фермы, что гарантирует свежесть и высокое качество.</li>\\n</ul>"}	969	\N
970	1111	directus_collections	wholesale_advant	{"collection":"wholesale_advant","icon":null,"note":null,"display_template":"{{image}}{{content}}","hidden":true,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":1,"group":"wholesale","collapse":"open","preview_url":null,"versioning":false}	{"hidden":true}	\N	\N
971	1112	directus_fields	123	{"sort":5,"interface":"group-detail","special":["alias","no-data","group"],"options":{"headerIcon":"question_mark"},"translations":[{"language":"ru-RU","translation":"Раздел FAQ"}],"collection":"wholesale","field":"faq"}	{"sort":5,"interface":"group-detail","special":["alias","no-data","group"],"options":{"headerIcon":"question_mark"},"translations":[{"language":"ru-RU","translation":"Раздел FAQ"}],"collection":"wholesale","field":"faq"}	\N	\N
972	1113	directus_permissions	33	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"wholesale_advant","action":"read"}	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"wholesale_advant","action":"read"}	\N	\N
973	1114	directus_permissions	34	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"wholesale_wholesale_advant","action":"read"}	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"wholesale_wholesale_advant","action":"read"}	\N	\N
974	1116	directus_access	50c87726-ebc9-4502-9708-10e4a787ab29	{"id":"50c87726-ebc9-4502-9708-10e4a787ab29","role":null,"user":"5e7d0719-f6fa-4e9b-a681-d24bc8947984","policy":"7b920119-42aa-47ac-a60c-656664a5150d","sort":1}	{"policy":"7b920119-42aa-47ac-a60c-656664a5150d"}	\N	\N
975	1118	directus_fields	124	{"sort":6,"interface":"input","special":null,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Заголовок блока"}],"display":"raw","collection":"wholesale","field":"faq_title"}	{"sort":6,"interface":"input","special":null,"options":{"iconLeft":"title"},"translations":[{"language":"ru-RU","translation":"Заголовок блока"}],"display":"raw","collection":"wholesale","field":"faq_title"}	\N	\N
976	1119	directus_fields	18	{"id":18,"collection":"wholesale","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"id","sort":1,"group":null}	\N	\N
977	1120	directus_fields	105	{"id":105,"collection":"wholesale","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"hero","sort":2,"group":null}	\N	\N
978	1121	directus_fields	118	{"id":118,"collection":"wholesale","field":"list","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"list"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Список преимуществ"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"list","sort":3,"group":null}	\N	\N
987	1130	directus_fields	125	{"id":125,"collection":"wholesale","field":"faq_description","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","h3","h4","h5","h6","numlist","bullist","removeformat","customLink","customImage","hr","fullscreen"]},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Описание блока"}],"note":null,"conditions":null,"required":false,"group":"faq","validation":null,"validation_message":null}	{"collection":"wholesale","field":"faq_description","sort":2,"group":"faq"}	\N	\N
988	1131	directus_fields	126	{"sort":5,"interface":"list","special":["cast-json"],"translations":[{"language":"ru-RU","translation":"Блоки аккордеона"}],"display":"raw","options":{"fields":[{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"interface":"input","options":{"iconLeft":"title","softLength":null},"display":"formatted-value"}},{"field":"content","name":"content","type":"text","meta":{"field":"content","type":"text","required":true,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h3","h4","h5","h6","alignleft","aligncenter","alignright","numlist","bullist","removeformat","customLink","customImage","hr","fullscreen"]},"display":"formatted-value"}}]},"collection":"wholesale","field":"faq_blocks"}	{"sort":5,"interface":"list","special":["cast-json"],"translations":[{"language":"ru-RU","translation":"Блоки аккордеона"}],"display":"raw","options":{"fields":[{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"interface":"input","options":{"iconLeft":"title","softLength":null},"display":"formatted-value"}},{"field":"content","name":"content","type":"text","meta":{"field":"content","type":"text","required":true,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h3","h4","h5","h6","alignleft","aligncenter","alignright","numlist","bullist","removeformat","customLink","customImage","hr","fullscreen"]},"display":"formatted-value"}}]},"collection":"wholesale","field":"faq_blocks"}	\N	\N
989	1132	directus_fields	18	{"id":18,"collection":"wholesale","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"id","sort":1,"group":null}	\N	\N
990	1133	directus_fields	105	{"id":105,"collection":"wholesale","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"hero","sort":2,"group":null}	\N	\N
991	1134	directus_fields	118	{"id":118,"collection":"wholesale","field":"list","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"list"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Список преимуществ"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"list","sort":3,"group":null}	\N	\N
992	1135	directus_fields	123	{"id":123,"collection":"wholesale","field":"faq","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"question_mark"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Раздел FAQ"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"faq","sort":4,"group":null}	\N	\N
993	1136	directus_fields	124	{"id":124,"collection":"wholesale","field":"faq_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок блока"}],"note":null,"conditions":null,"required":false,"group":"faq","validation":null,"validation_message":null}	{"collection":"wholesale","field":"faq_title","sort":1,"group":"faq"}	\N	\N
994	1137	directus_fields	125	{"id":125,"collection":"wholesale","field":"faq_description","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","h3","h4","h5","h6","numlist","bullist","removeformat","customLink","customImage","hr","fullscreen"]},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Описание блока"}],"note":null,"conditions":null,"required":false,"group":"faq","validation":null,"validation_message":null}	{"collection":"wholesale","field":"faq_description","sort":2,"group":"faq"}	\N	\N
995	1138	directus_fields	126	{"id":126,"collection":"wholesale","field":"faq_blocks","special":["cast-json"],"interface":"list","options":{"fields":[{"field":"title","name":"title","type":"string","meta":{"field":"title","type":"string","required":true,"interface":"input","options":{"iconLeft":"title","softLength":null},"display":"formatted-value"}},{"field":"content","name":"content","type":"text","meta":{"field":"content","type":"text","required":true,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h3","h4","h5","h6","alignleft","aligncenter","alignright","numlist","bullist","removeformat","customLink","customImage","hr","fullscreen"]},"display":"formatted-value"}}]},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Блоки аккордеона"}],"note":null,"conditions":null,"required":false,"group":"faq","validation":null,"validation_message":null}	{"collection":"wholesale","field":"faq_blocks","sort":3,"group":"faq"}	\N	\N
1005	1149	directus_fields	123	{"id":123,"collection":"wholesale","field":"faq","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"question_mark"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Раздел FAQ"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"faq","sort":4,"group":null}	\N	\N
1007	1151	directus_fields	127	{"id":127,"collection":"wholesale","field":"banner","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"image_aspect_ratio"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Баннер"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"banner","sort":5,"group":null}	\N	\N
996	1139	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	{"id":"9be4e10a-bc62-4144-afc5-1adc89ebdcd2","image":"c49375f7-06d0-47d3-babd-0515605ec99f","tag":"Оптовикам","title":"Всегда свежие цветы для бизнеса","description":"Свежие цветы с нашей собственной фермы в Самарской области. Наши официальные оптовики получают доступ к многоуровневой партнёрской программе, скидки на продукцию, подарки и многое другое","faq_title":"Популярные вопросы","faq_description":"<p>Это самые часто задаваемые вопросы и ответы на них. Если вы не нашли ответа на свой вопрос - напишите нам на почту: <a href=\\"mailto:info@intheplace.ru\\" target=\\"_blank\\" rel=\\"noopener\\">info@intheplace.ru</a></p>","faq_blocks":null,"advant":[7,8,9,10]}	{"faq_title":"Популярные вопросы","faq_description":"<p>Это самые часто задаваемые вопросы и ответы на них. Если вы не нашли ответа на свой вопрос - напишите нам на почту: <a href=\\"mailto:info@intheplace.ru\\" target=\\"_blank\\" rel=\\"noopener\\">info@intheplace.ru</a></p>"}	\N	\N
997	1140	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	{"id":"9be4e10a-bc62-4144-afc5-1adc89ebdcd2","image":"c49375f7-06d0-47d3-babd-0515605ec99f","tag":"Оптовикам","title":"Всегда свежие цветы для бизнеса","description":"Свежие цветы с нашей собственной фермы в Самарской области. Наши официальные оптовики получают доступ к многоуровневой партнёрской программе, скидки на продукцию, подарки и многое другое","faq_title":"Популярные вопросы","faq_description":"<p>Это самые часто задаваемые вопросы и ответы на них. Если вы не нашли ответа на свой вопрос - напишите нам на почту: <a href=\\"mailto:info@intheplace.ru\\" target=\\"_blank\\" rel=\\"noopener\\">info@intheplace.ru</a></p>","faq_blocks":[{"title":"Как я могу присоединиться к бонусной программе?","content":"<div>\\n<div>За каждый заказ на сумму не менее 500 рублей вы получаете бонусы. Количество бонусов зависит от суммы заказа, но повторные заказы одного и того же блюда не учитываются</div>\\n</div>"},{"title":"Сколько бонусов я могу накопить за один заказ?","content":"<div>\\n<div>За каждый заказ на сумму не менее 500 рублей вы получаете бонусы. Количество бонусов зависит от суммы заказа, но повторные заказы одного и того же блюда не учитываются</div>\\n</div>"},{"title":"Какие преимущества мне дает бонусная программа?","content":"<div>\\n<div>За каждый заказ на сумму не менее 500 рублей вы получаете бонусы. Количество бонусов зависит от суммы заказа, но повторные заказы одного и того же блюда не учитываются</div>\\n</div>"},{"title":"Какой срок действия скидки?","content":"<div>\\n<div>За каждый заказ на сумму не менее 500 рублей вы получаете бонусы. Количество бонусов зависит от суммы заказа, но повторные заказы одного и того же блюда не учитываются</div>\\n</div>"}],"advant":[7,8,9,10]}	{"faq_blocks":[{"title":"Как я могу присоединиться к бонусной программе?","content":"<div>\\n<div>За каждый заказ на сумму не менее 500 рублей вы получаете бонусы. Количество бонусов зависит от суммы заказа, но повторные заказы одного и того же блюда не учитываются</div>\\n</div>"},{"title":"Сколько бонусов я могу накопить за один заказ?","content":"<div>\\n<div>За каждый заказ на сумму не менее 500 рублей вы получаете бонусы. Количество бонусов зависит от суммы заказа, но повторные заказы одного и того же блюда не учитываются</div>\\n</div>"},{"title":"Какие преимущества мне дает бонусная программа?","content":"<div>\\n<div>За каждый заказ на сумму не менее 500 рублей вы получаете бонусы. Количество бонусов зависит от суммы заказа, но повторные заказы одного и того же блюда не учитываются</div>\\n</div>"},{"title":"Какой срок действия скидки?","content":"<div>\\n<div>За каждый заказ на сумму не менее 500 рублей вы получаете бонусы. Количество бонусов зависит от суммы заказа, но повторные заказы одного и того же блюда не учитываются</div>\\n</div>"}]}	\N	\N
998	1141	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	{"id":"9be4e10a-bc62-4144-afc5-1adc89ebdcd2","image":"c49375f7-06d0-47d3-babd-0515605ec99f","tag":"Оптовикам","title":"Всегда свежие цветы для бизнеса","description":"Свежие цветы с нашей собственной фермы в Самарской области. Наши официальные оптовики получают доступ к многоуровневой партнёрской программе, скидки на продукцию, подарки и многое другое","faq_title":"Популярные вопросы","faq_description":"<p>Это самые часто задаваемые вопросы и ответы на них. Если вы не нашли ответа на свой вопрос - напишите нам на почту: <a href=\\"mailto:info@intheplace.ru\\" target=\\"_blank\\" rel=\\"noopener\\">info@intheplace.ru</a></p>","faq_blocks":[{"title":"Как я могу присоединиться к бонусной программе?","content":"<p>За каждый заказ на сумму не менее 500 рублей вы получаете бонусы. Количество бонусов зависит от суммы заказа, но повторные заказы одного и того же блюда не учитываются</p>"},{"title":"Сколько бонусов я могу накопить за один заказ?","content":"<p>За каждый заказ на сумму не менее 500 рублей вы получаете бонусы. Количество бонусов зависит от суммы заказа, но повторные заказы одного и того же блюда не учитываются</p>"},{"title":"Какие преимущества мне дает бонусная программа?","content":"<p>За каждый заказ на сумму не менее 500 рублей вы получаете бонусы. Количество бонусов зависит от суммы заказа, но повторные заказы одного и того же блюда не учитываются</p>"},{"title":"Какой срок действия скидки?","content":"<p>За каждый заказ на сумму не менее 500 рублей вы получаете бонусы. Количество бонусов зависит от суммы заказа, но повторные заказы одного и того же блюда не учитываются</p>"}],"advant":[7,8,9,10]}	{"faq_blocks":[{"title":"Как я могу присоединиться к бонусной программе?","content":"<p>За каждый заказ на сумму не менее 500 рублей вы получаете бонусы. Количество бонусов зависит от суммы заказа, но повторные заказы одного и того же блюда не учитываются</p>"},{"title":"Сколько бонусов я могу накопить за один заказ?","content":"<p>За каждый заказ на сумму не менее 500 рублей вы получаете бонусы. Количество бонусов зависит от суммы заказа, но повторные заказы одного и того же блюда не учитываются</p>"},{"title":"Какие преимущества мне дает бонусная программа?","content":"<p>За каждый заказ на сумму не менее 500 рублей вы получаете бонусы. Количество бонусов зависит от суммы заказа, но повторные заказы одного и того же блюда не учитываются</p>"},{"title":"Какой срок действия скидки?","content":"<p>За каждый заказ на сумму не менее 500 рублей вы получаете бонусы. Количество бонусов зависит от суммы заказа, но повторные заказы одного и того же блюда не учитываются</p>"}]}	\N	\N
999	1142	directus_fields	127	{"sort":5,"interface":"group-detail","special":["alias","no-data","group"],"options":{"headerIcon":"image_aspect_ratio"},"translations":[{"language":"ru-RU","translation":"Баннер"}],"collection":"wholesale","field":"banner"}	{"sort":5,"interface":"group-detail","special":["alias","no-data","group"],"options":{"headerIcon":"image_aspect_ratio"},"translations":[{"language":"ru-RU","translation":"Баннер"}],"collection":"wholesale","field":"banner"}	\N	\N
1000	1143	directus_fields	128	{"sort":6,"interface":"file-image","special":["file"],"translations":[{"language":"ru-RU","translation":"Заголовок баннера"}],"display":"image","collection":"wholesale","field":"banner_title"}	{"sort":6,"interface":"file-image","special":["file"],"translations":[{"language":"ru-RU","translation":"Заголовок баннера"}],"display":"image","collection":"wholesale","field":"banner_title"}	\N	\N
1001	1145	directus_fields	129	{"sort":6,"interface":"file-image","special":["file"],"translations":[{"language":"ru-RU","translation":"Фоновое изображение"}],"display":"image","collection":"wholesale","field":"banner_image"}	{"sort":6,"interface":"file-image","special":["file"],"translations":[{"language":"ru-RU","translation":"Фоновое изображение"}],"display":"image","collection":"wholesale","field":"banner_image"}	\N	\N
1002	1146	directus_fields	18	{"id":18,"collection":"wholesale","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"id","sort":1,"group":null}	\N	\N
1003	1147	directus_fields	105	{"id":105,"collection":"wholesale","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"hero","sort":2,"group":null}	\N	\N
1004	1148	directus_fields	118	{"id":118,"collection":"wholesale","field":"list","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"list"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Список преимуществ"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"list","sort":3,"group":null}	\N	\N
1013	1157	directus_fields	129	{"id":129,"collection":"wholesale","field":"banner_image","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Фоновое изображение"}],"note":null,"conditions":null,"required":false,"group":"banner","validation":null,"validation_message":null}	{"collection":"wholesale","field":"banner_image","sort":1,"group":"banner"}	\N	\N
1015	1159	directus_fields	130	{"id":130,"collection":"wholesale","field":"banner_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок баннера"}],"note":null,"conditions":null,"required":false,"group":"banner","validation":null,"validation_message":null}	{"collection":"wholesale","field":"banner_title","sort":2,"group":"banner"}	\N	\N
1014	1158	directus_fields	127	{"id":127,"collection":"wholesale","field":"banner","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"image_aspect_ratio"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Баннер"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"banner","sort":5,"group":null}	\N	\N
1016	1160	directus_fields	131	{"sort":6,"special":null,"interface":"input-rich-text-html","translations":[{"language":"ru-RU","translation":"Текстовое содержимое"}],"options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h3","h4","h5","h6","numlist","bullist","customLink","hr","fullscreen"]},"display":"formatted-value","collection":"wholesale","field":"banner_content"}	{"sort":6,"special":null,"interface":"input-rich-text-html","translations":[{"language":"ru-RU","translation":"Текстовое содержимое"}],"options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h3","h4","h5","h6","numlist","bullist","customLink","hr","fullscreen"]},"display":"formatted-value","collection":"wholesale","field":"banner_content"}	\N	\N
1017	1161	directus_fields	18	{"id":18,"collection":"wholesale","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"id","sort":1,"group":null}	\N	\N
1018	1162	directus_fields	105	{"id":105,"collection":"wholesale","field":"hero","special":["alias","no-data","group"],"interface":"group-detail","options":{},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Хироскрин"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"hero","sort":2,"group":null}	\N	\N
1019	1163	directus_fields	118	{"id":118,"collection":"wholesale","field":"list","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"list"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Список преимуществ"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"list","sort":3,"group":null}	\N	\N
1020	1164	directus_fields	123	{"id":123,"collection":"wholesale","field":"faq","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"question_mark"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":[{"language":"ru-RU","translation":"Раздел FAQ"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"faq","sort":4,"group":null}	\N	\N
1021	1165	directus_fields	129	{"id":129,"collection":"wholesale","field":"banner_image","special":["file"],"interface":"file-image","options":null,"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":[{"language":"ru-RU","translation":"Фоновое изображение"}],"note":null,"conditions":null,"required":false,"group":"banner","validation":null,"validation_message":null}	{"collection":"wholesale","field":"banner_image","sort":1,"group":"banner"}	\N	\N
1022	1166	directus_fields	127	{"id":127,"collection":"wholesale","field":"banner","special":["alias","no-data","group"],"interface":"group-detail","options":{"headerIcon":"image_aspect_ratio"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":[{"language":"ru-RU","translation":"Баннер"}],"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"wholesale","field":"banner","sort":5,"group":null}	\N	\N
1023	1167	directus_fields	130	{"id":130,"collection":"wholesale","field":"banner_title","special":null,"interface":"input","options":{"iconLeft":"title"},"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":[{"language":"ru-RU","translation":"Заголовок баннера"}],"note":null,"conditions":null,"required":false,"group":"banner","validation":null,"validation_message":null}	{"collection":"wholesale","field":"banner_title","sort":2,"group":"banner"}	\N	\N
1024	1168	directus_fields	131	{"id":131,"collection":"wholesale","field":"banner_content","special":null,"interface":"input-rich-text-html","options":{"toolbar":["bold","italic","underline","strikethrough","subscript","superscript","h3","h4","h5","h6","numlist","bullist","customLink","hr","fullscreen"]},"display":"formatted-value","display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":[{"language":"ru-RU","translation":"Текстовое содержимое"}],"note":null,"conditions":null,"required":false,"group":"banner","validation":null,"validation_message":null}	{"collection":"wholesale","field":"banner_content","sort":3,"group":"banner"}	\N	\N
1025	1169	directus_files	09be7688-d281-480b-9a0d-f7966781057a	{"title":"Flowers","filename_download":"flowers.gif","type":"image/gif","storage":"local"}	{"title":"Flowers","filename_download":"flowers.gif","type":"image/gif","storage":"local"}	\N	\N
1026	1170	wholesale	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	{"id":"9be4e10a-bc62-4144-afc5-1adc89ebdcd2","image":"c49375f7-06d0-47d3-babd-0515605ec99f","tag":"Оптовикам","title":"Всегда свежие цветы для бизнеса","description":"Свежие цветы с нашей собственной фермы в Самарской области. Наши официальные оптовики получают доступ к многоуровневой партнёрской программе, скидки на продукцию, подарки и многое другое","faq_title":"Популярные вопросы","faq_description":"<p>Это самые часто задаваемые вопросы и ответы на них. Если вы не нашли ответа на свой вопрос - напишите нам на почту: <a href=\\"mailto:info@intheplace.ru\\" target=\\"_blank\\" rel=\\"noopener\\">info@intheplace.ru</a></p>","faq_blocks":[{"title":"Как я могу присоединиться к бонусной программе?","content":"<p>За каждый заказ на сумму не менее 500 рублей вы получаете бонусы. Количество бонусов зависит от суммы заказа, но повторные заказы одного и того же блюда не учитываются</p>"},{"title":"Сколько бонусов я могу накопить за один заказ?","content":"<p>За каждый заказ на сумму не менее 500 рублей вы получаете бонусы. Количество бонусов зависит от суммы заказа, но повторные заказы одного и того же блюда не учитываются</p>"},{"title":"Какие преимущества мне дает бонусная программа?","content":"<p>За каждый заказ на сумму не менее 500 рублей вы получаете бонусы. Количество бонусов зависит от суммы заказа, но повторные заказы одного и того же блюда не учитываются</p>"},{"title":"Какой срок действия скидки?","content":"<p>За каждый заказ на сумму не менее 500 рублей вы получаете бонусы. Количество бонусов зависит от суммы заказа, но повторные заказы одного и того же блюда не учитываются</p>"}],"banner_image":"09be7688-d281-480b-9a0d-f7966781057a","banner_title":"Начните работать с нами!","banner_content":"<p>Наши официальные оптовики получают неоспоримые преимущества партнёрства: доступ к многоуровневой партнёрской программе, скидки на продукцию, подарки и многое другое</p>","advant":[7,8,9,10]}	{"banner_image":"09be7688-d281-480b-9a0d-f7966781057a","banner_title":"Начните работать с нами!","banner_content":"<p>Наши официальные оптовики получают неоспоримые преимущества партнёрства: доступ к многоуровневой партнёрской программе, скидки на продукцию, подарки и многое другое</p>"}	\N	\N
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
hV0JjTLrUi0VtjRTU2IMw0md3zWtkKKIQiY4eUiNgwa12lkXmgnnfcI3_T4O-Nn2	d28ea43e-0087-4264-aad7-f52329173439	2025-10-29 12:42:10.969+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	\N	http://localhost:8055	u-kCOOMxYFA2HyQfJABDBYMQ6I2ciGZmnCbe5swIMv1faIzcZ7gH1WL_ABIlYrre
u-kCOOMxYFA2HyQfJABDBYMQ6I2ciGZmnCbe5swIMv1faIzcZ7gH1WL_ABIlYrre	d28ea43e-0087-4264-aad7-f52329173439	2025-10-30 12:42:00.968+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 OPR/122.0.0.0 (Edition std-2)	\N	http://localhost:8055	\N
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
d28ea43e-0087-4264-aad7-f52329173439	Admin	User	melnikov.works166@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$kjp3TNg9+bo3CPu1QsccKA$JVJuzUAKSKma20RrPV2rHT684ExVJoEmLv7ISi0ZgFs	\N	\N	\N	\N	\N	\N	FVEQKZCLNZDSCSCX	active	b7c96db7-0bcc-4ff4-8722-a320af6909dd	\N	2025-10-29 12:42:00.976+00	/content/products	default	\N	\N	t	\N	\N	\N	\N	\N	auto
5e7d0719-f6fa-4e9b-a681-d24bc8947984	frontend	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	active	\N	JBHIGfwD5GSGJng17iTDvIOV86zpLKLC	\N	\N	default	\N	\N	t	\N	\N	\N	\N	\N	auto
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
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.products (id, date_created, date_updated, available, sort, title, description, size, price, discount, seo_title, seo_description, seo_keywords) FROM stdin;
\.


--
-- Data for Name: products_categories; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.products_categories (id, products_id, categories_id) FROM stdin;
\.


--
-- Data for Name: products_files; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.products_files (id, products_id, directus_files_id) FROM stdin;
\.


--
-- Data for Name: products_reason; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.products_reason (id, products_id, reason_id) FROM stdin;
\.


--
-- Data for Name: products_structure; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.products_structure (id, products_id, structure_id) FROM stdin;
\.


--
-- Data for Name: products_styles; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.products_styles (id, products_id, styles_id) FROM stdin;
1	\N	\N
2	\N	\N
\.


--
-- Data for Name: reason; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.reason (id, name) FROM stdin;
e28a40e5-9360-41b1-85ff-60766ea4a980	Для мамы
a923bcc4-931a-4709-bade-317c342fedf1	Для любимой
bc74959a-ef74-4834-866f-c62b9e6fd322	Для бабушки
097fb6db-20ea-47d8-a585-342b1bfd11eb	Для учителя
1cfd6194-2a22-4624-9113-920dde9b8cbb	Для коллеги
49c8687b-daf7-432a-ba7b-ed8328f3844f	День рождения
6371556d-6178-4fd7-891d-259db73c76bc	На свадьбу
b9350ae7-2ec4-429a-95d8-0178f036fc53	На юбилей
26a1af3b-7771-435d-a34c-f8dcd3606257	Выписка из роддома
b859a8d7-dffb-4f76-bd96-ee254285ecce	На выпускной
\.


--
-- Data for Name: structure; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.structure (id, name, sort) FROM stdin;
23e7926b-f2a1-4068-908c-6bb690233bc8	Альстромерия	\N
516f6fd3-32fa-45e5-bb80-0aaefe47cb3f	Амариллис	\N
9a7268c1-6b81-4c93-9beb-2af9e8ee1148	Амми	\N
6c0d5a40-2f0a-43a8-9e37-f67c547b0c10	Анемон	\N
bf7a62bb-143d-45b2-9b66-6a819f552439	Антирринум	\N
d3c2e4e1-0ac1-4f31-88ca-7854ac907cd9	Антуриум	\N
caab1f2d-2b8c-4433-83da-0bb00e5dbad4	Аспарагус	\N
ef0c0577-64cf-422b-be6d-c609d5864a5e	Аспидистра	\N
7a983be4-4016-4d99-8943-8e308f75ee9a	Астильба	\N
73d6b923-98d6-4438-a9d4-9281d3870534	Астра	\N
1e621a84-e48c-45a3-916b-0737cda0095d	Ахилея	\N
807524d5-6d38-4d71-b54d-e78848a1a3b3	Берграс	\N
6c806a81-0850-416a-8bbc-03b3f5c81773	Брассика	\N
58ab621c-5a51-4ddb-b2e9-95d0b5ec884c	Бруния	\N
14c95af4-698a-43c0-995a-9103eb34f406	Бавардия	\N
48d9020f-3f1c-4537-b8fa-ce7c9d8b8a4f	Буплерум	\N
89e9466c-e2b4-4110-ab4c-7566086a7769	Орхидея Ванда	\N
9506efda-91ac-4a62-a882-b71ee65f3e44	Верба	\N
92a43dc2-c2f5-454a-9439-60e4c0592f88	Вероника	\N
36b76a3f-b020-4410-8f05-dbb0878fe98d	Орхидея Цимбидиум	\N
40aa380b-4cb5-4c03-aad4-d9f26ccf6e8c	Вибурнум	\N
973917e8-a8d3-427d-a1a5-bd03d7d23dda	Гвоздика	\N
6edf1b21-221b-4326-97ff-0a83ebb5c515	Гвоздика кустовая	\N
1c1b6933-84db-4547-9154-b3df828ee978	Гелиантус	\N
72c19c46-5eba-4c2c-bd06-5b3e0afa059b	Георгины	\N
74267c8e-6ddd-429a-bc74-c113517c73ff	Гербера	\N
ca7af4ff-3ba5-404d-aab5-3fe132776edc	Гермини	\N
d1d6be9d-ee52-471d-b599-30c7d83490cb	Гиацинт	\N
fcd43968-5e80-4c3e-83df-7572f5abc6ac	Гиперикум	\N
bebc96d9-1e70-4f51-abc4-a3898595f7d6	Гипсофила	\N
1bf665f4-4a56-412d-a7e9-2fabc037b3ea	Гортензия	\N
2f0308a5-49f9-4bba-bb00-c0768cb131e2	Декор	\N
798d8553-02f6-4b1a-b1ef-b0b040049afc	Дельфиниум	\N
5a5f6a68-21db-4206-b28d-1e5b306a8e04	Гениста	\N
513d8e30-8a1c-457d-a9ac-dc80c0060d5d	Папоротник	\N
2e7828b8-606a-4ba1-95ab-7318df95ebc3	Илекс	\N
b369ba1d-ca4f-489a-ade9-17f88029d71e	Ирис	\N
af6537ef-e504-4f18-8b70-59669339c5d6	Калла	\N
af13f74f-e163-4d06-a031-e64d8abfd766	Клематис	\N
1c47e146-d72e-4034-8aa9-11faabcba8e7	Краспедия	\N
5849a7b0-af52-42e6-b4a4-61e818497a87	Куэркус	\N
dfdefbbe-cd79-40f6-9096-076c050f7a19	Леукадендрон	\N
cb040715-c359-48c8-bb07-83f20a8f26ef	Лилия	\N
b7d2e8bc-3ed8-4ee8-bf87-a12f28de63fd	Лимониум	\N
40df7fb3-d5bf-40fe-935c-a4487bb675be	Листья малины	\N
a7ab3255-eb33-463f-aaa2-adb8c37b3356	Маттиола	\N
99d724cd-dd9c-4b39-80c4-3e08585086f4	Танацетум	\N
c821b4e3-af39-4fc5-9739-f3a3c5847ef7	Мимоза	\N
625b0b22-02b5-4356-9165-1fa5cc611179	Нарцисс	\N
8ba2d15b-1fdf-4101-8213-c021025349e3	Нобилис	\N
a36a3250-3b78-45f0-a232-c295959ce15d	Нутан	\N
9c4cd5ce-f2d5-42a2-a0b5-9fa35abdbd04	Озотамнус	\N
fe1d63b9-d0d1-4d72-b74d-faa3d0886cea	Оксипеталум	\N
f5daed79-87af-4d4e-8cb5-5ef17dc1c204	Орнитогалум	\N
f119a603-67c6-4478-8c67-9101bab7cda9	Пион	\N
50b586b8-025a-44ec-a397-ce1e46373686	Писташ	\N
22c486a9-ecf5-4432-837e-cff833b00590	Питтоспорум	\N
4101b4ca-dab3-4809-913b-56ba9d6d70b7	Протея	\N
\.


--
-- Data for Name: styles; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.styles (id, name) FROM stdin;
\.


--
-- Data for Name: wholesale; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.wholesale (id, image, tag, title, description, faq_title, faq_description, faq_blocks, banner_image, banner_title, banner_content) FROM stdin;
9be4e10a-bc62-4144-afc5-1adc89ebdcd2	c49375f7-06d0-47d3-babd-0515605ec99f	Оптовикам	Всегда свежие цветы для бизнеса	Свежие цветы с нашей собственной фермы в Самарской области. Наши официальные оптовики получают доступ к многоуровневой партнёрской программе, скидки на продукцию, подарки и многое другое	Популярные вопросы	<p>Это самые часто задаваемые вопросы и ответы на них. Если вы не нашли ответа на свой вопрос - напишите нам на почту: <a href="mailto:info@intheplace.ru" target="_blank" rel="noopener">info@intheplace.ru</a></p>	[{"title":"Как я могу присоединиться к бонусной программе?","content":"<p>За каждый заказ на сумму не менее 500 рублей вы получаете бонусы. Количество бонусов зависит от суммы заказа, но повторные заказы одного и того же блюда не учитываются</p>"},{"title":"Сколько бонусов я могу накопить за один заказ?","content":"<p>За каждый заказ на сумму не менее 500 рублей вы получаете бонусы. Количество бонусов зависит от суммы заказа, но повторные заказы одного и того же блюда не учитываются</p>"},{"title":"Какие преимущества мне дает бонусная программа?","content":"<p>За каждый заказ на сумму не менее 500 рублей вы получаете бонусы. Количество бонусов зависит от суммы заказа, но повторные заказы одного и того же блюда не учитываются</p>"},{"title":"Какой срок действия скидки?","content":"<p>За каждый заказ на сумму не менее 500 рублей вы получаете бонусы. Количество бонусов зависит от суммы заказа, но повторные заказы одного и того же блюда не учитываются</p>"}]	09be7688-d281-480b-9a0d-f7966781057a	Начните работать с нами!	<p>Наши официальные оптовики получают неоспоримые преимущества партнёрства: доступ к многоуровневой партнёрской программе, скидки на продукцию, подарки и многое другое</p>
\.


--
-- Data for Name: wholesale_advant; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.wholesale_advant (id, image, content) FROM stdin;
89c8fc0f-00d3-4129-9a1f-a72d924101bd	c49375f7-06d0-47d3-babd-0515605ec99f	<p>sdzfb</p>
a96d6a1d-9b15-43ee-8755-d242c92bcc03	c49375f7-06d0-47d3-babd-0515605ec99f	<h2>Для флористов, маркетинговых и свадебных агентств</h2>\n<p>Покупая цветы оптом у нас, вы получаете множество преимуществ:</p>\n<ul>\n<li>Накопление бонусов: За каждую покупку на сумму от 5000 рублей вы получаете бонусы, которые можно использовать для получения скидок.</li>\n<li>Эксклюзивные скидки: Чем больше вы покупаете, тем выше ваша скидка в следующем месяце.</li>\n<li>Качество от производителя: Все цветы поступают с нашей фермы, что гарантирует свежесть и высокое качество.</li>\n</ul>
78b365d9-ec54-4337-af8b-c62ad45e9d92	c49375f7-06d0-47d3-babd-0515605ec99f	<h2>Для флористов, маркетинговых и свадебных агентств</h2>\n<p>Покупая цветы оптом у нас, вы получаете множество преимуществ:</p>\n<ul>\n<li>Накопление бонусов: За каждую покупку на сумму от 5000 рублей вы получаете бонусы, которые можно использовать для получения скидок.</li>\n<li>Эксклюзивные скидки: Чем больше вы покупаете, тем выше ваша скидка в следующем месяце.</li>\n<li>Качество от производителя: Все цветы поступают с нашей фермы, что гарантирует свежесть и высокое качество.</li>\n</ul>
350f1de0-a24f-491b-9d6c-b1f8e12dc93f	c49375f7-06d0-47d3-babd-0515605ec99f	<h2>Для флористов, маркетинговых и свадебных агентств</h2>\n<p>Покупая цветы оптом у нас, вы получаете множество преимуществ:</p>\n<ul>\n<li>Накопление бонусов: За каждую покупку на сумму от 5000 рублей вы получаете бонусы, которые можно использовать для получения скидок.</li>\n<li>Эксклюзивные скидки: Чем больше вы покупаете, тем выше ваша скидка в следующем месяце.</li>\n<li>Качество от производителя: Все цветы поступают с нашей фермы, что гарантирует свежесть и высокое качество.</li>\n</ul>
0be59b02-5267-401c-90d9-be80a41f44a6	c49375f7-06d0-47d3-babd-0515605ec99f	<h2>Для флористов, маркетинговых и свадебных агентств</h2>\n<p>Покупая цветы оптом у нас, вы получаете множество преимуществ:</p>\n<ul>\n<li>Накопление бонусов: За каждую покупку на сумму от 5000 рублей вы получаете бонусы, которые можно использовать для получения скидок.</li>\n<li>Эксклюзивные скидки: Чем больше вы покупаете, тем выше ваша скидка в следующем месяце.</li>\n<li>Качество от производителя: Все цветы поступают с нашей фермы, что гарантирует свежесть и высокое качество.</li>\n</ul>
\.


--
-- Data for Name: wholesale_wholesale_advant; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.wholesale_wholesale_advant (id, wholesale_id, wholesale_advant_id) FROM stdin;
1	\N	\N
2	\N	\N
6	\N	89c8fc0f-00d3-4129-9a1f-a72d924101bd
7	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	a96d6a1d-9b15-43ee-8755-d242c92bcc03
8	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	78b365d9-ec54-4337-af8b-c62ad45e9d92
9	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	350f1de0-a24f-491b-9d6c-b1f8e12dc93f
10	9be4e10a-bc62-4144-afc5-1adc89ebdcd2	0be59b02-5267-401c-90d9-be80a41f44a6
\.


--
-- Name: directus_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_activity_id_seq', 1170, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 131, true);


--
-- Name: directus_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_notifications_id_seq', 1, false);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 34, true);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 5, true);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 30, true);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 1026, true);


--
-- Name: directus_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_settings_id_seq', 1, true);


--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_webhooks_id_seq', 1, false);


--
-- Name: products_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.products_categories_id_seq', 1, false);


--
-- Name: products_files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.products_files_id_seq', 1, false);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.products_id_seq', 7, true);


--
-- Name: products_reason_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.products_reason_id_seq', 1, false);


--
-- Name: products_structure_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.products_structure_id_seq', 1, false);


--
-- Name: products_styles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.products_styles_id_seq', 2, true);


--
-- Name: wholesale_wholesale_advant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.wholesale_wholesale_advant_id_seq', 10, true);


--
-- Name: categories categories_name_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_unique UNIQUE (name);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


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
-- Name: products_categories products_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.products_categories
    ADD CONSTRAINT products_categories_pkey PRIMARY KEY (id);


--
-- Name: products_files products_files_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.products_files
    ADD CONSTRAINT products_files_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: products_reason products_reason_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.products_reason
    ADD CONSTRAINT products_reason_pkey PRIMARY KEY (id);


--
-- Name: products_structure products_structure_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.products_structure
    ADD CONSTRAINT products_structure_pkey PRIMARY KEY (id);


--
-- Name: products_styles products_styles_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.products_styles
    ADD CONSTRAINT products_styles_pkey PRIMARY KEY (id);


--
-- Name: reason reason_name_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.reason
    ADD CONSTRAINT reason_name_unique UNIQUE (name);


--
-- Name: reason reason_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.reason
    ADD CONSTRAINT reason_pkey PRIMARY KEY (id);


--
-- Name: structure structure_name_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.structure
    ADD CONSTRAINT structure_name_unique UNIQUE (name);


--
-- Name: structure structure_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.structure
    ADD CONSTRAINT structure_pkey PRIMARY KEY (id);


--
-- Name: styles styles_name_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.styles
    ADD CONSTRAINT styles_name_unique UNIQUE (name);


--
-- Name: styles styles_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.styles
    ADD CONSTRAINT styles_pkey PRIMARY KEY (id);


--
-- Name: wholesale_advant wholesale_advant_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.wholesale_advant
    ADD CONSTRAINT wholesale_advant_pkey PRIMARY KEY (id);


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
-- Name: products_categories products_categories_categories_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.products_categories
    ADD CONSTRAINT products_categories_categories_id_foreign FOREIGN KEY (categories_id) REFERENCES public.categories(id) ON DELETE SET NULL;


--
-- Name: products_categories products_categories_products_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.products_categories
    ADD CONSTRAINT products_categories_products_id_foreign FOREIGN KEY (products_id) REFERENCES public.products(id) ON DELETE SET NULL;


--
-- Name: products_files products_files_directus_files_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.products_files
    ADD CONSTRAINT products_files_directus_files_id_foreign FOREIGN KEY (directus_files_id) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: products_files products_files_products_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.products_files
    ADD CONSTRAINT products_files_products_id_foreign FOREIGN KEY (products_id) REFERENCES public.products(id) ON DELETE SET NULL;


--
-- Name: products_reason products_reason_products_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.products_reason
    ADD CONSTRAINT products_reason_products_id_foreign FOREIGN KEY (products_id) REFERENCES public.products(id) ON DELETE SET NULL;


--
-- Name: products_reason products_reason_reason_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.products_reason
    ADD CONSTRAINT products_reason_reason_id_foreign FOREIGN KEY (reason_id) REFERENCES public.reason(id) ON DELETE SET NULL;


--
-- Name: products_structure products_structure_products_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.products_structure
    ADD CONSTRAINT products_structure_products_id_foreign FOREIGN KEY (products_id) REFERENCES public.products(id) ON DELETE SET NULL;


--
-- Name: products_structure products_structure_structure_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.products_structure
    ADD CONSTRAINT products_structure_structure_id_foreign FOREIGN KEY (structure_id) REFERENCES public.structure(id) ON DELETE SET NULL;


--
-- Name: products_styles products_styles_products_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.products_styles
    ADD CONSTRAINT products_styles_products_id_foreign FOREIGN KEY (products_id) REFERENCES public.products(id) ON DELETE SET NULL;


--
-- Name: products_styles products_styles_styles_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.products_styles
    ADD CONSTRAINT products_styles_styles_id_foreign FOREIGN KEY (styles_id) REFERENCES public.styles(id) ON DELETE SET NULL;


--
-- Name: wholesale_advant wholesale_advant_image_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.wholesale_advant
    ADD CONSTRAINT wholesale_advant_image_foreign FOREIGN KEY (image) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: wholesale wholesale_banner_image_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.wholesale
    ADD CONSTRAINT wholesale_banner_image_foreign FOREIGN KEY (banner_image) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: wholesale wholesale_image_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.wholesale
    ADD CONSTRAINT wholesale_image_foreign FOREIGN KEY (image) REFERENCES public.directus_files(id) ON DELETE SET NULL;


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

\unrestrict 2ATln3pCghj4c6AoahbQV753D1KYnwCOLa45W5zM0ReE8bBJUlceXoeHpgTDCOS

