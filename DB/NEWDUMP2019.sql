--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.14
-- Dumped by pg_dump version 9.5.14

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE public.accounts (
    user_id text,
    password text DEFAULT md5('user123456'::text),
    user_type text
);


ALTER TABLE public.accounts OWNER TO ktapdasan;

--
-- Name: added_user_data; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE public.added_user_data (
    pk integer NOT NULL,
    user_id text NOT NULL,
    first_name text NOT NULL,
    middle_name text NOT NULL,
    last_name text NOT NULL,
    user_type text NOT NULL,
    date_created timestamp with time zone DEFAULT now(),
    archived boolean DEFAULT false,
    branch_assignment text
);


ALTER TABLE public.added_user_data OWNER TO ktapdasan;

--
-- Name: added_user_data_pk_seq; Type: SEQUENCE; Schema: public; Owner: ktapdasan
--

CREATE SEQUENCE public.added_user_data_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.added_user_data_pk_seq OWNER TO ktapdasan;

--
-- Name: added_user_data_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ktapdasan
--

ALTER SEQUENCE public.added_user_data_pk_seq OWNED BY public.added_user_data.pk;


--
-- Name: branch_data; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE public.branch_data (
    pk integer NOT NULL,
    branch_name text NOT NULL,
    address text NOT NULL,
    contact_person text NOT NULL,
    contact_number text NOT NULL,
    date_created timestamp with time zone DEFAULT now(),
    archived boolean DEFAULT false,
    vat_registered boolean
);


ALTER TABLE public.branch_data OWNER TO ktapdasan;

--
-- Name: branch_data_pk_seq; Type: SEQUENCE; Schema: public; Owner: ktapdasan
--

CREATE SEQUENCE public.branch_data_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.branch_data_pk_seq OWNER TO ktapdasan;

--
-- Name: branch_data_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ktapdasan
--

ALTER SEQUENCE public.branch_data_pk_seq OWNED BY public.branch_data.pk;


--
-- Name: customer_data; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE public.customer_data (
    pk integer NOT NULL,
    first_name text NOT NULL,
    middle_name text NOT NULL,
    last_name text NOT NULL,
    email text NOT NULL,
    contact_number text NOT NULL,
    date_created timestamp with time zone DEFAULT now(),
    archived boolean DEFAULT false,
    tin text,
    cadd text,
    company text,
    job_position text,
    percent integer,
    last_day timestamp with time zone DEFAULT now()
);


ALTER TABLE public.customer_data OWNER TO ktapdasan;

--
-- Name: customer_data_pk_seq; Type: SEQUENCE; Schema: public; Owner: ktapdasan
--

CREATE SEQUENCE public.customer_data_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customer_data_pk_seq OWNER TO ktapdasan;

--
-- Name: customer_data_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ktapdasan
--

ALTER SEQUENCE public.customer_data_pk_seq OWNED BY public.customer_data.pk;


--
-- Name: data_collected; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE public.data_collected (
    pk integer NOT NULL,
    barcode text NOT NULL,
    quantity text NOT NULL,
    date_created timestamp with time zone DEFAULT now(),
    archived boolean DEFAULT false
);


ALTER TABLE public.data_collected OWNER TO ktapdasan;

--
-- Name: data_collected_pk_seq; Type: SEQUENCE; Schema: public; Owner: ktapdasan
--

CREATE SEQUENCE public.data_collected_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data_collected_pk_seq OWNER TO ktapdasan;

--
-- Name: data_collected_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ktapdasan
--

ALTER SEQUENCE public.data_collected_pk_seq OWNED BY public.data_collected.pk;


--
-- Name: discounted_aomos_staff_data; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE public.discounted_aomos_staff_data (
    pk integer NOT NULL,
    customer_name text NOT NULL,
    transaction_number text NOT NULL,
    cashier_user_id text NOT NULL,
    date_created timestamp with time zone DEFAULT now(),
    archived boolean DEFAULT false
);


ALTER TABLE public.discounted_aomos_staff_data OWNER TO ktapdasan;

--
-- Name: discounted_aomos_staff_data_pk_seq; Type: SEQUENCE; Schema: public; Owner: ktapdasan
--

CREATE SEQUENCE public.discounted_aomos_staff_data_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.discounted_aomos_staff_data_pk_seq OWNER TO ktapdasan;

--
-- Name: discounted_aomos_staff_data_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ktapdasan
--

ALTER SEQUENCE public.discounted_aomos_staff_data_pk_seq OWNED BY public.discounted_aomos_staff_data.pk;


--
-- Name: down_payment_data; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE public.down_payment_data (
    pk integer NOT NULL,
    product_name text NOT NULL,
    customer_name text NOT NULL,
    product_quantity integer NOT NULL,
    product_supplier_price text NOT NULL,
    product_retail_price text NOT NULL,
    product_transaction_number text NOT NULL,
    vat_percentage text NOT NULL,
    net_amount text NOT NULL,
    vat text NOT NULL,
    discount text NOT NULL,
    type text NOT NULL,
    down_payment_amount text NOT NULL,
    change text NOT NULL,
    cash text NOT NULL,
    tempo_total text NOT NULL,
    void_count text NOT NULL,
    total text NOT NULL,
    gc_amount text NOT NULL,
    gc_name text NOT NULL,
    gc_code text NOT NULL,
    cashier_user_id text NOT NULL,
    date_created timestamp with time zone DEFAULT now(),
    archived boolean DEFAULT false,
    product_pk integer,
    cancelled_amount text,
    product_branches text,
    cnumber text,
    item_size_name text,
    item_has_size text,
    balance text
);


ALTER TABLE public.down_payment_data OWNER TO ktapdasan;

--
-- Name: down_payment_data_pk_seq; Type: SEQUENCE; Schema: public; Owner: ktapdasan
--

CREATE SEQUENCE public.down_payment_data_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.down_payment_data_pk_seq OWNER TO ktapdasan;

--
-- Name: down_payment_data_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ktapdasan
--

ALTER SEQUENCE public.down_payment_data_pk_seq OWNED BY public.down_payment_data.pk;


--
-- Name: gift_certificate_data; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE public.gift_certificate_data (
    pk integer NOT NULL,
    gc_name text NOT NULL,
    gc_code text NOT NULL,
    gc_amount text NOT NULL,
    cashier_user_id integer NOT NULL,
    date_created timestamp with time zone DEFAULT now(),
    archived boolean DEFAULT false
);


ALTER TABLE public.gift_certificate_data OWNER TO ktapdasan;

--
-- Name: gift_certificate_data_pk_seq; Type: SEQUENCE; Schema: public; Owner: ktapdasan
--

CREATE SEQUENCE public.gift_certificate_data_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gift_certificate_data_pk_seq OWNER TO ktapdasan;

--
-- Name: gift_certificate_data_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ktapdasan
--

ALTER SEQUENCE public.gift_certificate_data_pk_seq OWNED BY public.gift_certificate_data.pk;


--
-- Name: history_log_data; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE public.history_log_data (
    pk integer NOT NULL,
    name text NOT NULL,
    action text NOT NULL,
    cashier_user_id text NOT NULL,
    date_created timestamp with time zone DEFAULT now(),
    archived boolean DEFAULT false
);


ALTER TABLE public.history_log_data OWNER TO ktapdasan;

--
-- Name: history_log_data_pk_seq; Type: SEQUENCE; Schema: public; Owner: ktapdasan
--

CREATE SEQUENCE public.history_log_data_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.history_log_data_pk_seq OWNER TO ktapdasan;

--
-- Name: history_log_data_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ktapdasan
--

ALTER SEQUENCE public.history_log_data_pk_seq OWNED BY public.history_log_data.pk;


--
-- Name: news_feed; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE public.news_feed (
    pk integer NOT NULL,
    user_id text,
    description text,
    name text,
    link text,
    type text,
    date_created timestamp with time zone DEFAULT now(),
    archived boolean DEFAULT false
);


ALTER TABLE public.news_feed OWNER TO ktapdasan;

--
-- Name: news_feed_pk_seq; Type: SEQUENCE; Schema: public; Owner: ktapdasan
--

CREATE SEQUENCE public.news_feed_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.news_feed_pk_seq OWNER TO ktapdasan;

--
-- Name: news_feed_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ktapdasan
--

ALTER SEQUENCE public.news_feed_pk_seq OWNED BY public.news_feed.pk;


--
-- Name: payment_data; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE public.payment_data (
    pk integer NOT NULL,
    productname text NOT NULL,
    productamount text NOT NULL,
    date_created timestamp with time zone DEFAULT now(),
    archived boolean DEFAULT false
);


ALTER TABLE public.payment_data OWNER TO ktapdasan;

--
-- Name: payment_data_pk_seq; Type: SEQUENCE; Schema: public; Owner: ktapdasan
--

CREATE SEQUENCE public.payment_data_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payment_data_pk_seq OWNER TO ktapdasan;

--
-- Name: payment_data_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ktapdasan
--

ALTER SEQUENCE public.payment_data_pk_seq OWNED BY public.payment_data.pk;


--
-- Name: product_data; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE public.product_data (
    pk integer NOT NULL,
    product_name text NOT NULL,
    product_bar_code text NOT NULL,
    product_stocks integer NOT NULL,
    product_srp text NOT NULL,
    product_price text NOT NULL,
    product_supplier text NOT NULL,
    product_expiration timestamp with time zone,
    date_created timestamp with time zone DEFAULT now(),
    archived boolean DEFAULT false,
    product_receipt_name text,
    product_status text,
    product_or_number text,
    product_or_stocks text,
    product_product_code text,
    product_rules text,
    product_kind text,
    request_order_status text,
    product_branches text,
    product_image text,
    input_vat double precision,
    output_vat double precision,
    selling_price double precision,
    product_size_name text,
    product_size_value integer
);


ALTER TABLE public.product_data OWNER TO ktapdasan;

--
-- Name: product_data_pk_seq; Type: SEQUENCE; Schema: public; Owner: ktapdasan
--

CREATE SEQUENCE public.product_data_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_data_pk_seq OWNER TO ktapdasan;

--
-- Name: product_data_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ktapdasan
--

ALTER SEQUENCE public.product_data_pk_seq OWNED BY public.product_data.pk;


--
-- Name: product_expire_status_confirm; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE public.product_expire_status_confirm (
    pk integer NOT NULL,
    cashier_user_id text NOT NULL,
    status text NOT NULL,
    date_created timestamp with time zone DEFAULT now(),
    archived boolean DEFAULT false
);


ALTER TABLE public.product_expire_status_confirm OWNER TO ktapdasan;

--
-- Name: product_expire_status_confirm_pk_seq; Type: SEQUENCE; Schema: public; Owner: ktapdasan
--

CREATE SEQUENCE public.product_expire_status_confirm_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_expire_status_confirm_pk_seq OWNER TO ktapdasan;

--
-- Name: product_expire_status_confirm_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ktapdasan
--

ALTER SEQUENCE public.product_expire_status_confirm_pk_seq OWNED BY public.product_expire_status_confirm.pk;


--
-- Name: refund_item_data; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE public.refund_item_data (
    pk integer NOT NULL,
    product_name text NOT NULL,
    product_srp text NOT NULL,
    product_bar_code text NOT NULL,
    product_stocks integer NOT NULL,
    product_price text NOT NULL,
    product_expiration text NOT NULL,
    product_supplier text NOT NULL,
    product_receipt_name text NOT NULL,
    product_or_number text NOT NULL,
    product_or_stocks text NOT NULL,
    product_product_code text NOT NULL,
    product_rules text NOT NULL,
    product_kind text NOT NULL,
    date_created timestamp with time zone DEFAULT now(),
    archived boolean DEFAULT false
);


ALTER TABLE public.refund_item_data OWNER TO ktapdasan;

--
-- Name: refund_item_data_pk_seq; Type: SEQUENCE; Schema: public; Owner: ktapdasan
--

CREATE SEQUENCE public.refund_item_data_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.refund_item_data_pk_seq OWNER TO ktapdasan;

--
-- Name: refund_item_data_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ktapdasan
--

ALTER SEQUENCE public.refund_item_data_pk_seq OWNED BY public.refund_item_data.pk;


--
-- Name: request_order_data; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE public.request_order_data (
    pk integer NOT NULL,
    product_finalnumber text NOT NULL,
    product_quantity text NOT NULL,
    product_date_needed text NOT NULL,
    product_market_price text NOT NULL,
    product_pk text,
    status text DEFAULT 'Pending'::text,
    date_created timestamp with time zone DEFAULT now(),
    archived boolean DEFAULT false,
    product_name text,
    request_order_status text,
    remarks text,
    requested_by_pk integer
);


ALTER TABLE public.request_order_data OWNER TO ktapdasan;

--
-- Name: request_order_data_pk_seq; Type: SEQUENCE; Schema: public; Owner: ktapdasan
--

CREATE SEQUENCE public.request_order_data_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.request_order_data_pk_seq OWNER TO ktapdasan;

--
-- Name: request_order_data_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ktapdasan
--

ALTER SEQUENCE public.request_order_data_pk_seq OWNED BY public.request_order_data.pk;


--
-- Name: rules_data; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE public.rules_data (
    pk integer NOT NULL,
    rule_name text NOT NULL,
    date_created timestamp with time zone DEFAULT now(),
    archived boolean DEFAULT false
);


ALTER TABLE public.rules_data OWNER TO ktapdasan;

--
-- Name: rules_data_pk_seq; Type: SEQUENCE; Schema: public; Owner: ktapdasan
--

CREATE SEQUENCE public.rules_data_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rules_data_pk_seq OWNER TO ktapdasan;

--
-- Name: rules_data_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ktapdasan
--

ALTER SEQUENCE public.rules_data_pk_seq OWNED BY public.rules_data.pk;


--
-- Name: supplier_data; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE public.supplier_data (
    pk integer NOT NULL,
    supplier_name text NOT NULL,
    supplier_address text NOT NULL,
    supplier_contact_number text NOT NULL,
    supplier_contact_person text NOT NULL,
    supplier_code_name text NOT NULL,
    date_created timestamp with time zone DEFAULT now(),
    archived boolean DEFAULT false
);


ALTER TABLE public.supplier_data OWNER TO ktapdasan;

--
-- Name: supplier_data_pk_seq; Type: SEQUENCE; Schema: public; Owner: ktapdasan
--

CREATE SEQUENCE public.supplier_data_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.supplier_data_pk_seq OWNER TO ktapdasan;

--
-- Name: supplier_data_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ktapdasan
--

ALTER SEQUENCE public.supplier_data_pk_seq OWNED BY public.supplier_data.pk;


--
-- Name: tender_data; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE public.tender_data (
    pk integer NOT NULL,
    product_name text NOT NULL,
    product_quantity integer NOT NULL,
    product_supplier_price text NOT NULL,
    product_retail_price text NOT NULL,
    product_transaction_number text NOT NULL,
    vat_percentage text NOT NULL,
    net_amount text NOT NULL,
    vat text NOT NULL,
    discount text NOT NULL,
    change text NOT NULL,
    cash text NOT NULL,
    tempo_total text NOT NULL,
    void_count text NOT NULL,
    total text NOT NULL,
    gc_amount text NOT NULL,
    gc_name text NOT NULL,
    gc_code text NOT NULL,
    cashier_user_id text NOT NULL,
    date_created timestamp with time zone DEFAULT now(),
    archived boolean DEFAULT false,
    product_pk integer,
    item_size_name text,
    item_has_size text
);


ALTER TABLE public.tender_data OWNER TO ktapdasan;

--
-- Name: tender_data_pk_seq; Type: SEQUENCE; Schema: public; Owner: ktapdasan
--

CREATE SEQUENCE public.tender_data_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tender_data_pk_seq OWNER TO ktapdasan;

--
-- Name: tender_data_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ktapdasan
--

ALTER SEQUENCE public.tender_data_pk_seq OWNED BY public.tender_data.pk;


--
-- Name: users; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE public.users (
    pk integer NOT NULL,
    user_id text NOT NULL,
    first_name text NOT NULL,
    middle_name text NOT NULL,
    last_name text NOT NULL,
    user_type text NOT NULL,
    date_created timestamp with time zone DEFAULT now(),
    archived boolean DEFAULT false,
    superior_pin text DEFAULT md5('SirWayne'::text),
    email text,
    permission jsonb,
    branch_assignment text
);


ALTER TABLE public.users OWNER TO ktapdasan;

--
-- Name: users_pk_seq; Type: SEQUENCE; Schema: public; Owner: ktapdasan
--

CREATE SEQUENCE public.users_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_pk_seq OWNER TO ktapdasan;

--
-- Name: users_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ktapdasan
--

ALTER SEQUENCE public.users_pk_seq OWNED BY public.users.pk;


--
-- Name: voucher_data; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE public.voucher_data (
    pk integer NOT NULL,
    customer_name text,
    voucher_number text,
    date_created timestamp with time zone DEFAULT now(),
    archived boolean DEFAULT false
);


ALTER TABLE public.voucher_data OWNER TO ktapdasan;

--
-- Name: voucher_data_pk_seq; Type: SEQUENCE; Schema: public; Owner: ktapdasan
--

CREATE SEQUENCE public.voucher_data_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.voucher_data_pk_seq OWNER TO ktapdasan;

--
-- Name: voucher_data_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ktapdasan
--

ALTER SEQUENCE public.voucher_data_pk_seq OWNED BY public.voucher_data.pk;


--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.added_user_data ALTER COLUMN pk SET DEFAULT nextval('public.added_user_data_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.branch_data ALTER COLUMN pk SET DEFAULT nextval('public.branch_data_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.customer_data ALTER COLUMN pk SET DEFAULT nextval('public.customer_data_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.data_collected ALTER COLUMN pk SET DEFAULT nextval('public.data_collected_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.discounted_aomos_staff_data ALTER COLUMN pk SET DEFAULT nextval('public.discounted_aomos_staff_data_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.down_payment_data ALTER COLUMN pk SET DEFAULT nextval('public.down_payment_data_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.gift_certificate_data ALTER COLUMN pk SET DEFAULT nextval('public.gift_certificate_data_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.history_log_data ALTER COLUMN pk SET DEFAULT nextval('public.history_log_data_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.news_feed ALTER COLUMN pk SET DEFAULT nextval('public.news_feed_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.payment_data ALTER COLUMN pk SET DEFAULT nextval('public.payment_data_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.product_data ALTER COLUMN pk SET DEFAULT nextval('public.product_data_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.product_expire_status_confirm ALTER COLUMN pk SET DEFAULT nextval('public.product_expire_status_confirm_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.refund_item_data ALTER COLUMN pk SET DEFAULT nextval('public.refund_item_data_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.request_order_data ALTER COLUMN pk SET DEFAULT nextval('public.request_order_data_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.rules_data ALTER COLUMN pk SET DEFAULT nextval('public.rules_data_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.supplier_data ALTER COLUMN pk SET DEFAULT nextval('public.supplier_data_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.tender_data ALTER COLUMN pk SET DEFAULT nextval('public.tender_data_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.users ALTER COLUMN pk SET DEFAULT nextval('public.users_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.voucher_data ALTER COLUMN pk SET DEFAULT nextval('public.voucher_data_pk_seq'::regclass);


--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY public.accounts (user_id, password, user_type) FROM stdin;
201400028	4da49c16db42ca04538d629ef0533fe8	1
201400072	4da49c16db42ca04538d629ef0533fe8	2
2014000100	4da49c16db42ca04538d629ef0533fe8	1
201700789	202cb962ac59075b964b07152d234b70	1
\.


--
-- Data for Name: added_user_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY public.added_user_data (pk, user_id, first_name, middle_name, last_name, user_type, date_created, archived, branch_assignment) FROM stdin;
1	201700789	Jeff	Jeff	Jeff	1	2019-02-26 01:11:42.694461+08	f	\N
\.


--
-- Name: added_user_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('public.added_user_data_pk_seq', 1, true);


--
-- Data for Name: branch_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY public.branch_data (pk, branch_name, address, contact_person, contact_number, date_created, archived, vat_registered) FROM stdin;
1	Test	test	Test	0000000	2019-02-26 00:41:01.472789+08	f	t
\.


--
-- Name: branch_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('public.branch_data_pk_seq', 1, true);


--
-- Data for Name: customer_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY public.customer_data (pk, first_name, middle_name, last_name, email, contact_number, date_created, archived, tin, cadd, company, job_position, percent, last_day) FROM stdin;
\.


--
-- Name: customer_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('public.customer_data_pk_seq', 1, false);


--
-- Data for Name: data_collected; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY public.data_collected (pk, barcode, quantity, date_created, archived) FROM stdin;
\.


--
-- Name: data_collected_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('public.data_collected_pk_seq', 1, false);


--
-- Data for Name: discounted_aomos_staff_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY public.discounted_aomos_staff_data (pk, customer_name, transaction_number, cashier_user_id, date_created, archived) FROM stdin;
\.


--
-- Name: discounted_aomos_staff_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('public.discounted_aomos_staff_data_pk_seq', 1, false);


--
-- Data for Name: down_payment_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY public.down_payment_data (pk, product_name, customer_name, product_quantity, product_supplier_price, product_retail_price, product_transaction_number, vat_percentage, net_amount, vat, discount, type, down_payment_amount, change, cash, tempo_total, void_count, total, gc_amount, gc_name, gc_code, cashier_user_id, date_created, archived, product_pk, cancelled_amount, product_branches, cnumber, item_size_name, item_has_size, balance) FROM stdin;
\.


--
-- Name: down_payment_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('public.down_payment_data_pk_seq', 1, false);


--
-- Data for Name: gift_certificate_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY public.gift_certificate_data (pk, gc_name, gc_code, gc_amount, cashier_user_id, date_created, archived) FROM stdin;
\.


--
-- Name: gift_certificate_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('public.gift_certificate_data_pk_seq', 1, false);


--
-- Data for Name: history_log_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY public.history_log_data (pk, name, action, cashier_user_id, date_created, archived) FROM stdin;
1	Supplier Adding	 R-Wayne Lipardo added Test in supplier section	2014000100	2019-02-26 00:40:49.629735+08	f
2	Tender	 R-Wayne Lipardo tendered an item	2014000100	2019-02-26 01:15:17.662353+08	f
3	Tender	 R-Wayne Lipardo tendered an item	2014000100	2019-02-26 01:17:25.759855+08	f
4	Product Edit	 R-Wayne Lipardo edited Lewis and Pearl	2014000100	2019-02-26 01:22:16.867796+08	f
5	Product Order	 R-Wayne Lipardo requested for an order of Lewis and Pearl	2014000100	2019-02-26 01:22:57.616313+08	f
6	Product Edit	 R-Wayne Lipardo edited Lewis and Pearl	2014000100	2019-02-26 01:40:38.331035+08	f
7	Tender	 R-Wayne Lipardo tendered an item	2014000100	2019-02-26 01:40:55.792687+08	f
8	Product Edit	 R-Wayne Lipardo edited Lewis and Pearl	2014000100	2019-02-26 01:42:13.90961+08	f
\.


--
-- Name: history_log_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('public.history_log_data_pk_seq', 8, true);


--
-- Data for Name: news_feed; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY public.news_feed (pk, user_id, description, name, link, type, date_created, archived) FROM stdin;
\.


--
-- Name: news_feed_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('public.news_feed_pk_seq', 1, false);


--
-- Data for Name: payment_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY public.payment_data (pk, productname, productamount, date_created, archived) FROM stdin;
\.


--
-- Name: payment_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('public.payment_data_pk_seq', 1, false);


--
-- Data for Name: product_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY public.product_data (pk, product_name, product_bar_code, product_stocks, product_srp, product_price, product_supplier, product_expiration, date_created, archived, product_receipt_name, product_status, product_or_number, product_or_stocks, product_product_code, product_rules, product_kind, request_order_status, product_branches, product_image, input_vat, output_vat, selling_price, product_size_name, product_size_value) FROM stdin;
2	Lewis and Pearl	4800047862557	1	10	15	test	2019-02-25 00:00:00+08	2019-02-26 01:14:52.302145+08	f	Lewis	(NEW)	00000	12	N/A	Test	Nonfood	true	Test	undefined	1.19999999999999996	0	15	\N	\N
\.


--
-- Name: product_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('public.product_data_pk_seq', 2, true);


--
-- Data for Name: product_expire_status_confirm; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY public.product_expire_status_confirm (pk, cashier_user_id, status, date_created, archived) FROM stdin;
\.


--
-- Name: product_expire_status_confirm_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('public.product_expire_status_confirm_pk_seq', 1, false);


--
-- Data for Name: refund_item_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY public.refund_item_data (pk, product_name, product_srp, product_bar_code, product_stocks, product_price, product_expiration, product_supplier, product_receipt_name, product_or_number, product_or_stocks, product_product_code, product_rules, product_kind, date_created, archived) FROM stdin;
\.


--
-- Name: refund_item_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('public.refund_item_data_pk_seq', 1, false);


--
-- Data for Name: request_order_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY public.request_order_data (pk, product_finalnumber, product_quantity, product_date_needed, product_market_price, product_pk, status, date_created, archived, product_name, request_order_status, remarks, requested_by_pk) FROM stdin;
1	TVNRJ-5973E	5	Feb 28, 2019 12:00:00 AM	10	2	Approved	2019-02-26 01:22:57.616313+08	f	Lewis and Pearl	false	\N	3
\.


--
-- Name: request_order_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('public.request_order_data_pk_seq', 1, true);


--
-- Data for Name: rules_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY public.rules_data (pk, rule_name, date_created, archived) FROM stdin;
1	Test	2019-02-26 00:41:35.287585+08	f
\.


--
-- Name: rules_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('public.rules_data_pk_seq', 1, true);


--
-- Data for Name: supplier_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY public.supplier_data (pk, supplier_name, supplier_address, supplier_contact_number, supplier_contact_person, supplier_code_name, date_created, archived) FROM stdin;
1	Test	test	000000	test	test	2019-02-26 00:40:49.629735+08	f
\.


--
-- Name: supplier_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('public.supplier_data_pk_seq', 1, true);


--
-- Data for Name: tender_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY public.tender_data (pk, product_name, product_quantity, product_supplier_price, product_retail_price, product_transaction_number, vat_percentage, net_amount, vat, discount, change, cash, tempo_total, void_count, total, gc_amount, gc_name, gc_code, cashier_user_id, date_created, archived, product_pk, item_size_name, item_has_size) FROM stdin;
1	Lewis and Pearl	1	10	15.00	2145652942	12	15.00	1.80	0	3.20	20.00	16.8	0	16.80	0	none	none	2014000100	2019-02-26 01:15:17.662353+08	f	2	\N	\N
2	Lewis and Pearl	1	10	15.00	0497474649	12	15.00	1.80	0	1.20	18.00	16.8	0	16.80	0	none	none	2014000100	2019-02-26 01:17:25.759855+08	f	2	\N	\N
3	Lewis and Pearl	2	10	15.00	8970994961	12	13.39	1.61	0	5.00	20.00	15	0	15.00	0	none	none	2014000100	2019-02-26 01:40:55.792687+08	f	2	\N	\N
\.


--
-- Name: tender_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('public.tender_data_pk_seq', 3, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY public.users (pk, user_id, first_name, middle_name, last_name, user_type, date_created, archived, superior_pin, email, permission, branch_assignment) FROM stdin;
1	201400028	Patrick	Matetu	Chavez	1	2019-02-26 00:39:14.062348+08	f	202cb962ac59075b964b07152d234b70	\N	{"Admin": {"Menu": true, "Modules": {"One": true, "Six": true, "Ten": true, "Two": true, "Five": true, "Four": true, "Nine": true, "Eight": true, "Seven": true, "Three": true, "Eleven": true, "Twelve": true, "Twenty": true, "Fifteen": true, "Sixteen": true, "Eighteen": true, "Fourteen": true, "Nineteen": true, "Thirteen": true, "Seventeen": true, "Twentyone": true, "Twentytwo": true}}, "Cashier": {"Menu": true}, "ProductE": {"Menu": true}, "PriceList": {"Menu": true}}	\N
2	201400072	Ken	Villanueva	Tapdasan	2	2019-02-26 00:39:14.083114+08	f	202cb962ac59075b964b07152d234b70	\N	{"Admin": {"Menu": true, "Modules": {"One": true, "Six": true, "Ten": true, "Two": true, "Five": true, "Four": true, "Nine": true, "Eight": true, "Seven": true, "Three": true, "Eleven": true, "Twelve": true, "Twenty": true, "Fifteen": true, "Sixteen": true, "Eighteen": true, "Fourteen": true, "Nineteen": true, "Thirteen": true, "Seventeen": true, "Twentyone": true, "Twentytwo": true}}, "Cashier": {"Menu": true}, "ProductE": {"Menu": true}, "PriceList": {"Menu": true}}	\N
3	2014000100	R-Wayne	Feliciano	Lipardo	1	2019-02-26 00:39:14.685497+08	f	202cb962ac59075b964b07152d234b70	\N	{"Admin": {"Menu": true, "Modules": {"One": true, "Six": true, "Ten": true, "Two": true, "Five": true, "Four": true, "Nine": true, "Eight": true, "Seven": true, "Three": true, "Eleven": true, "Twelve": true, "Twenty": true, "Fifteen": true, "Sixteen": true, "Eighteen": true, "Fourteen": true, "Nineteen": true, "Thirteen": true, "Seventeen": true, "Twentyone": true, "Twentytwo": true}}, "Cashier": {"Menu": true}, "ProductE": {"Menu": true}, "PriceList": {"Menu": true}}	\N
4	201700789	Jeff	Jeff	Jeff	1	2019-02-26 01:11:42.694461+08	f	92d85403814002271a64e291dd433483	Jeff@gmail.com	{"Admin": {"Menu": true, "Modules": {"One": false, "Two": true}}, "Cashier": {"Menu": true}}	\N
\.


--
-- Name: users_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('public.users_pk_seq', 4, true);


--
-- Data for Name: voucher_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY public.voucher_data (pk, customer_name, voucher_number, date_created, archived) FROM stdin;
\.


--
-- Name: voucher_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('public.voucher_data_pk_seq', 1, false);


--
-- Name: added_user_data_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.added_user_data
    ADD CONSTRAINT added_user_data_pkey PRIMARY KEY (pk);


--
-- Name: branch_data_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.branch_data
    ADD CONSTRAINT branch_data_pkey PRIMARY KEY (pk);


--
-- Name: customer_data_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.customer_data
    ADD CONSTRAINT customer_data_pkey PRIMARY KEY (pk);


--
-- Name: data_collected_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.data_collected
    ADD CONSTRAINT data_collected_pkey PRIMARY KEY (pk);


--
-- Name: discounted_aomos_staff_data_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.discounted_aomos_staff_data
    ADD CONSTRAINT discounted_aomos_staff_data_pkey PRIMARY KEY (pk);


--
-- Name: down_payment_data_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.down_payment_data
    ADD CONSTRAINT down_payment_data_pkey PRIMARY KEY (pk);


--
-- Name: gift_certificate_data_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.gift_certificate_data
    ADD CONSTRAINT gift_certificate_data_pkey PRIMARY KEY (pk);


--
-- Name: history_log_data_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.history_log_data
    ADD CONSTRAINT history_log_data_pkey PRIMARY KEY (pk);


--
-- Name: news_feed_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.news_feed
    ADD CONSTRAINT news_feed_pkey PRIMARY KEY (pk);


--
-- Name: payment_data_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.payment_data
    ADD CONSTRAINT payment_data_pkey PRIMARY KEY (pk);


--
-- Name: product_data_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.product_data
    ADD CONSTRAINT product_data_pkey PRIMARY KEY (pk);


--
-- Name: product_expire_status_confirm_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.product_expire_status_confirm
    ADD CONSTRAINT product_expire_status_confirm_pkey PRIMARY KEY (pk);


--
-- Name: refund_item_data_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.refund_item_data
    ADD CONSTRAINT refund_item_data_pkey PRIMARY KEY (pk);


--
-- Name: request_order_data_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.request_order_data
    ADD CONSTRAINT request_order_data_pkey PRIMARY KEY (pk);


--
-- Name: rules_data_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.rules_data
    ADD CONSTRAINT rules_data_pkey PRIMARY KEY (pk);


--
-- Name: supplier_data_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.supplier_data
    ADD CONSTRAINT supplier_data_pkey PRIMARY KEY (pk);


--
-- Name: tender_data_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.tender_data
    ADD CONSTRAINT tender_data_pkey PRIMARY KEY (pk);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (pk);


--
-- Name: voucher_data_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY public.voucher_data
    ADD CONSTRAINT voucher_data_pkey PRIMARY KEY (pk);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

