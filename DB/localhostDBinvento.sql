--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.10
-- Dumped by pg_dump version 9.5.10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
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


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE accounts (
    user_id text,
    password text DEFAULT md5('User123456!'::text),
    user_type text
);


ALTER TABLE accounts OWNER TO ktapdasan;

--
-- Name: added_user_data; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE added_user_data (
    pk integer NOT NULL,
    user_id text NOT NULL,
    first_name text NOT NULL,
    middle_name text NOT NULL,
    last_name text NOT NULL,
    user_type text NOT NULL,
    date_created timestamp with time zone DEFAULT now(),
    archived boolean DEFAULT false,
    stall_code text,
    sales_dept text
);


ALTER TABLE added_user_data OWNER TO ktapdasan;

--
-- Name: added_user_data_pk_seq; Type: SEQUENCE; Schema: public; Owner: ktapdasan
--

CREATE SEQUENCE added_user_data_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE added_user_data_pk_seq OWNER TO ktapdasan;

--
-- Name: added_user_data_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ktapdasan
--

ALTER SEQUENCE added_user_data_pk_seq OWNED BY added_user_data.pk;


--
-- Name: branch_data; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE branch_data (
    pk integer NOT NULL,
    branch_name text NOT NULL,
    address text NOT NULL,
    contact_person text NOT NULL,
    contact_number text NOT NULL,
    date_created timestamp with time zone DEFAULT now(),
    archived boolean DEFAULT false
);


ALTER TABLE branch_data OWNER TO ktapdasan;

--
-- Name: branch_data_pk_seq; Type: SEQUENCE; Schema: public; Owner: ktapdasan
--

CREATE SEQUENCE branch_data_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE branch_data_pk_seq OWNER TO ktapdasan;

--
-- Name: branch_data_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ktapdasan
--

ALTER SEQUENCE branch_data_pk_seq OWNED BY branch_data.pk;


--
-- Name: cancelled_transact_data; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE cancelled_transact_data (
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
    product_pk integer
);


ALTER TABLE cancelled_transact_data OWNER TO ktapdasan;

--
-- Name: cancelled_transact_data_pk_seq; Type: SEQUENCE; Schema: public; Owner: ktapdasan
--

CREATE SEQUENCE cancelled_transact_data_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cancelled_transact_data_pk_seq OWNER TO ktapdasan;

--
-- Name: cancelled_transact_data_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ktapdasan
--

ALTER SEQUENCE cancelled_transact_data_pk_seq OWNED BY cancelled_transact_data.pk;


--
-- Name: customer_data; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE customer_data (
    pk integer NOT NULL,
    first_name text NOT NULL,
    middle_name text NOT NULL,
    last_name text NOT NULL,
    email text NOT NULL,
    contact_number text NOT NULL,
    date_created timestamp with time zone DEFAULT now(),
    archived boolean DEFAULT false
);


ALTER TABLE customer_data OWNER TO ktapdasan;

--
-- Name: customer_data_pk_seq; Type: SEQUENCE; Schema: public; Owner: ktapdasan
--

CREATE SEQUENCE customer_data_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE customer_data_pk_seq OWNER TO ktapdasan;

--
-- Name: customer_data_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ktapdasan
--

ALTER SEQUENCE customer_data_pk_seq OWNED BY customer_data.pk;


--
-- Name: gift_certificate_data; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE gift_certificate_data (
    pk integer NOT NULL,
    gc_name text NOT NULL,
    gc_code text NOT NULL,
    gc_amount text NOT NULL,
    cashier_user_id integer NOT NULL,
    date_created timestamp with time zone DEFAULT now(),
    archived boolean DEFAULT false
);


ALTER TABLE gift_certificate_data OWNER TO ktapdasan;

--
-- Name: gift_certificate_data_pk_seq; Type: SEQUENCE; Schema: public; Owner: ktapdasan
--

CREATE SEQUENCE gift_certificate_data_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE gift_certificate_data_pk_seq OWNER TO ktapdasan;

--
-- Name: gift_certificate_data_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ktapdasan
--

ALTER SEQUENCE gift_certificate_data_pk_seq OWNED BY gift_certificate_data.pk;


--
-- Name: history_log_data; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE history_log_data (
    pk integer NOT NULL,
    name text NOT NULL,
    action text NOT NULL,
    cashier_user_id text NOT NULL,
    date_created timestamp with time zone DEFAULT now(),
    archived boolean DEFAULT false
);


ALTER TABLE history_log_data OWNER TO ktapdasan;

--
-- Name: history_log_data_pk_seq; Type: SEQUENCE; Schema: public; Owner: ktapdasan
--

CREATE SEQUENCE history_log_data_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE history_log_data_pk_seq OWNER TO ktapdasan;

--
-- Name: history_log_data_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ktapdasan
--

ALTER SEQUENCE history_log_data_pk_seq OWNED BY history_log_data.pk;


--
-- Name: product_data; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE product_data (
    pk integer NOT NULL,
    product_name text NOT NULL,
    product_bar_code text NOT NULL,
    product_stocks integer NOT NULL,
    product_srp text NOT NULL,
    product_price text NOT NULL,
    product_supplier text NOT NULL,
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
    product_expiration text,
    product_branches text,
    product_image text
);


ALTER TABLE product_data OWNER TO ktapdasan;

--
-- Name: product_data_pk_seq; Type: SEQUENCE; Schema: public; Owner: ktapdasan
--

CREATE SEQUENCE product_data_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE product_data_pk_seq OWNER TO ktapdasan;

--
-- Name: product_data_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ktapdasan
--

ALTER SEQUENCE product_data_pk_seq OWNED BY product_data.pk;


--
-- Name: product_expire_status_confirm; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE product_expire_status_confirm (
    pk integer NOT NULL,
    cashier_user_id text NOT NULL,
    status text NOT NULL,
    date_created timestamp with time zone DEFAULT now(),
    archived boolean DEFAULT false
);


ALTER TABLE product_expire_status_confirm OWNER TO ktapdasan;

--
-- Name: product_expire_status_confirm_pk_seq; Type: SEQUENCE; Schema: public; Owner: ktapdasan
--

CREATE SEQUENCE product_expire_status_confirm_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE product_expire_status_confirm_pk_seq OWNER TO ktapdasan;

--
-- Name: product_expire_status_confirm_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ktapdasan
--

ALTER SEQUENCE product_expire_status_confirm_pk_seq OWNED BY product_expire_status_confirm.pk;


--
-- Name: refund_item_data; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE refund_item_data (
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


ALTER TABLE refund_item_data OWNER TO ktapdasan;

--
-- Name: refund_item_data_pk_seq; Type: SEQUENCE; Schema: public; Owner: ktapdasan
--

CREATE SEQUENCE refund_item_data_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE refund_item_data_pk_seq OWNER TO ktapdasan;

--
-- Name: refund_item_data_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ktapdasan
--

ALTER SEQUENCE refund_item_data_pk_seq OWNED BY refund_item_data.pk;


--
-- Name: request_order_data; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE request_order_data (
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


ALTER TABLE request_order_data OWNER TO ktapdasan;

--
-- Name: request_order_data_pk_seq; Type: SEQUENCE; Schema: public; Owner: ktapdasan
--

CREATE SEQUENCE request_order_data_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE request_order_data_pk_seq OWNER TO ktapdasan;

--
-- Name: request_order_data_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ktapdasan
--

ALTER SEQUENCE request_order_data_pk_seq OWNED BY request_order_data.pk;


--
-- Name: rules_data; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE rules_data (
    pk integer NOT NULL,
    rule_name text NOT NULL,
    date_created timestamp with time zone DEFAULT now(),
    archived boolean DEFAULT false
);


ALTER TABLE rules_data OWNER TO ktapdasan;

--
-- Name: rules_data_pk_seq; Type: SEQUENCE; Schema: public; Owner: ktapdasan
--

CREATE SEQUENCE rules_data_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE rules_data_pk_seq OWNER TO ktapdasan;

--
-- Name: rules_data_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ktapdasan
--

ALTER SEQUENCE rules_data_pk_seq OWNED BY rules_data.pk;


--
-- Name: supplier_data; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE supplier_data (
    pk integer NOT NULL,
    supplier_name text NOT NULL,
    supplier_address text NOT NULL,
    supplier_contact_number text NOT NULL,
    supplier_contact_person text NOT NULL,
    supplier_code_name text NOT NULL,
    date_created timestamp with time zone DEFAULT now(),
    archived boolean DEFAULT false
);


ALTER TABLE supplier_data OWNER TO ktapdasan;

--
-- Name: supplier_data_pk_seq; Type: SEQUENCE; Schema: public; Owner: ktapdasan
--

CREATE SEQUENCE supplier_data_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE supplier_data_pk_seq OWNER TO ktapdasan;

--
-- Name: supplier_data_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ktapdasan
--

ALTER SEQUENCE supplier_data_pk_seq OWNED BY supplier_data.pk;


--
-- Name: tender_data; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE tender_data (
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
    cancelled_amount text
);


ALTER TABLE tender_data OWNER TO ktapdasan;

--
-- Name: tender_data_pk_seq; Type: SEQUENCE; Schema: public; Owner: ktapdasan
--

CREATE SEQUENCE tender_data_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tender_data_pk_seq OWNER TO ktapdasan;

--
-- Name: tender_data_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ktapdasan
--

ALTER SEQUENCE tender_data_pk_seq OWNED BY tender_data.pk;


--
-- Name: users; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE users (
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
    stall_code text,
    sales_dept text
);


ALTER TABLE users OWNER TO ktapdasan;

--
-- Name: users_pk_seq; Type: SEQUENCE; Schema: public; Owner: ktapdasan
--

CREATE SEQUENCE users_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_pk_seq OWNER TO ktapdasan;

--
-- Name: users_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ktapdasan
--

ALTER SEQUENCE users_pk_seq OWNED BY users.pk;


--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY added_user_data ALTER COLUMN pk SET DEFAULT nextval('added_user_data_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY branch_data ALTER COLUMN pk SET DEFAULT nextval('branch_data_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY cancelled_transact_data ALTER COLUMN pk SET DEFAULT nextval('cancelled_transact_data_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY customer_data ALTER COLUMN pk SET DEFAULT nextval('customer_data_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY gift_certificate_data ALTER COLUMN pk SET DEFAULT nextval('gift_certificate_data_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY history_log_data ALTER COLUMN pk SET DEFAULT nextval('history_log_data_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY product_data ALTER COLUMN pk SET DEFAULT nextval('product_data_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY product_expire_status_confirm ALTER COLUMN pk SET DEFAULT nextval('product_expire_status_confirm_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY refund_item_data ALTER COLUMN pk SET DEFAULT nextval('refund_item_data_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY request_order_data ALTER COLUMN pk SET DEFAULT nextval('request_order_data_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY rules_data ALTER COLUMN pk SET DEFAULT nextval('rules_data_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY supplier_data ALTER COLUMN pk SET DEFAULT nextval('supplier_data_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY tender_data ALTER COLUMN pk SET DEFAULT nextval('tender_data_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY users ALTER COLUMN pk SET DEFAULT nextval('users_pk_seq'::regclass);


--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY accounts (user_id, password, user_type) FROM stdin;
201400028	d9df80dcfc3a7096ebebc461398a2427	1
201400072	d9df80dcfc3a7096ebebc461398a2427	2
2014000100	d9df80dcfc3a7096ebebc461398a2427	1
\.


--
-- Data for Name: added_user_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY added_user_data (pk, user_id, first_name, middle_name, last_name, user_type, date_created, archived, stall_code, sales_dept) FROM stdin;
\.


--
-- Name: added_user_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('added_user_data_pk_seq', 1, false);


--
-- Data for Name: branch_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY branch_data (pk, branch_name, address, contact_person, contact_number, date_created, archived) FROM stdin;
1	GUADALUPE	GUADALUPE MALL	DENNIS SERDENA	09279590839	2017-11-29 09:11:35.847298+08	f
\.


--
-- Name: branch_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('branch_data_pk_seq', 1, true);


--
-- Data for Name: cancelled_transact_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY cancelled_transact_data (pk, product_name, product_quantity, product_supplier_price, product_retail_price, product_transaction_number, vat_percentage, net_amount, vat, discount, change, cash, tempo_total, void_count, total, gc_amount, gc_name, gc_code, cashier_user_id, date_created, archived, product_pk) FROM stdin;
\.


--
-- Name: cancelled_transact_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('cancelled_transact_data_pk_seq', 1, false);


--
-- Data for Name: customer_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY customer_data (pk, first_name, middle_name, last_name, email, contact_number, date_created, archived) FROM stdin;
\.


--
-- Name: customer_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('customer_data_pk_seq', 1, false);


--
-- Data for Name: gift_certificate_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY gift_certificate_data (pk, gc_name, gc_code, gc_amount, cashier_user_id, date_created, archived) FROM stdin;
\.


--
-- Name: gift_certificate_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('gift_certificate_data_pk_seq', 1, false);


--
-- Data for Name: history_log_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY history_log_data (pk, name, action, cashier_user_id, date_created, archived) FROM stdin;
1	Supplier Adding	 Patrick Chavez added N/A in supplier section	201400028	2017-11-29 09:10:34.153155+08	f
2	Product Edit	 Patrick Chavez edited HMD LETTER W/ DOT DARK	201400028	2017-11-29 11:30:32.761437+08	f
3	Product Edit	 Patrick Chavez edited HMD LETTER W/ STRIPE DARK PINK	201400028	2017-11-29 11:30:46.238654+08	f
4	Product Edit	 Patrick Chavez edited HMD LETTER W/ DOT LIGHT BLUE	201400028	2017-11-29 11:31:54.118359+08	f
5	Product Edit	 Patrick Chavez edited HMD LETTER BLUE W/ BLACK PRINT	201400028	2017-11-29 11:40:45.972718+08	f
\.


--
-- Name: history_log_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('history_log_data_pk_seq', 5, true);


--
-- Data for Name: product_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY product_data (pk, product_name, product_bar_code, product_stocks, product_srp, product_price, product_supplier, date_created, archived, product_receipt_name, product_status, product_or_number, product_or_stocks, product_product_code, product_rules, product_kind, request_order_status, product_expiration, product_branches, product_image) FROM stdin;
1	HMD LETTER W/ DOT DARK	00000	0	0	0	N/A	2017-11-29 11:28:17.534757+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
42	HBD LETTER R. BLUE	00041	0	0	0	N/A	2017-11-29 12:32:54.797939+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
2	HMD LETTER W/ STRIPE DARK PINK	00001	0	0	0	N/A	2017-11-29 11:30:09.805869+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
3	HMD LETTER W/ DOT LIGHT BLUE	00002	0	0	0	N/A	2017-11-29 11:31:18.504854+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
5	HMD LETTER PINK W/ BLACK PRINT	00003	0	0	0	N/A	2017-11-29 11:40:28.830596+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
4	HMD LETTER BLUE W/ BLACK PRINT	00004	0	0	0	N/A	2017-11-29 11:31:47.185414+08	f	0	(NEW)	0	0	NO DATA	No Rule	Food	\N	Nov 29, 2017	GUADALUPE	undefined
6	HMD LETTER GREEN ASSORTED	00005	0	0	0	N/A	2017-11-29 11:41:51.715831+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
7	HMD LETTER PINK STRIPE ASSORTED	00006	0	0	0	N/A	2017-11-29 11:43:27.317103+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
8	HMD LETTER PANTY FAVOR BALLOONS	00007	0	0	0	N/A	2017-11-29 11:45:08.558617+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
9	HMD LETTER CLOWN W/ DOT GREEN	00008	0	0	0	N/A	2017-11-29 11:45:29.456976+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
10	HMD LETTER CUT OUT SILVER	00009	0	0	0	N/A	2017-11-29 11:45:49.995417+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
11	HMD LETTER  CUT OUT GOLD	00010	0	0	0	N/A	2017-11-29 11:48:43.351462+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
12	FRAME 4R WOOD BLACK	00011	0	0	0	N/A	2017-11-29 11:49:42.025422+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
13	FRAME 4R WOOD BROWN	00012	0	0	0	N/A	2017-11-29 11:50:08.540184+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
14	FRAME 4R WOOD BROWN	00013	0	0	0	N/A	2017-11-29 11:51:00.921062+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
15	FRAME 4R WOOD RED	00014	0	0	0	N/A	2017-11-29 11:51:15.014636+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
16	FRAME 3R WOOD R.BLUE	00015	0	0	0	N/A	2017-11-29 11:51:37.608167+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
17	FRAME 3R WOOD L.BLUE	00016	0	0	0	N/A	2017-11-29 11:53:39.70004+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
18	FRAME 3R WOOD WHITE	00017	0	0	0	N/A	2017-11-29 11:54:07.878261+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
19	FRAME 3R WOOD RED	00018	0	0	0	N/A	2017-11-29 11:54:28.350851+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
20	FRAME 3R WOOD PINK	00019	0	0	0	N/A	2017-11-29 11:54:51.111764+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
21	FRAME 3R WOOD BLACK	00020	0	0	0	N/A	2017-11-29 11:55:05.838122+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
22	PAPER BAG SMALL	00021	0	0	0	N/A	2017-11-29 11:56:29.927139+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
23	PAPER BAG MEDIUM	00022	0	0	0	N/A	2017-11-29 11:56:43.307272+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
24	PAPER BAG LARGE	00023	0	0	0	N/A	2017-11-29 11:57:01.38916+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
25	I.D LACE ONE DIRECTION	00024	0	0	0	N/A	2017-11-29 12:04:51.633975+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
26	I.D LACE BTS	00025	0	0	0	N/A	2017-11-29 12:05:48.968173+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
27	I.D LACE SPONGEBOB	00026	0	0	0	N/A	2017-11-29 12:06:53.11961+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
28	I.D LACE FROZEN	00027	0	0	0	N/A	2017-11-29 12:07:25.554776+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
29	I.D LACE ALDUB	00028	0	0	0	N/A	2017-11-29 12:08:50.448006+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
30	I.D LACE FACEBOOK	00029	0	0	0	N/A	2017-11-29 12:09:05.602387+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
31	I.D LACE PLAIN	00030	0	0	0	N/A	2017-11-29 12:10:04.78845+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
32	BTS COIN WALLET GRAY	00031	0	0	0	N/A	2017-11-29 12:10:56.806606+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
33	BTS COIN WALLET BLACK	00032	0	0	0	N/A	2017-11-29 12:11:37.133742+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
34	BTS COIN WALLET BLACK SMALL	00033	0	0	0	N/A	2017-11-29 12:12:18.065527+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
35	HBD LETTER DONUT	00034	0	0	0	N/A	2017-11-29 12:15:23.249912+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
36	HBD LETTER WHALE	00035	0	0	0	N/A	2017-11-29 12:15:39.446076+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
37	HBD LETTER CROWN PINK	00036	0	0	0	N/A	2017-11-29 12:16:52.308518+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
38	HBD LETTER CROWN BLUE	00037	0	0	0	N/A	2017-11-29 12:17:09.010235+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
39	HBD LETTER FOOT PRINT PINK	00038	0	0	0	N/A	2017-11-29 12:19:52.98505+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
40	HBD LETTER FOOT PINT BLUE	00039	0	0	0	N/A	2017-11-29 12:26:50.582638+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
41	HBD LETTER STRIPE BLUE LIGHT	00040	0	0	0	N/A	2017-11-29 12:32:32.798442+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
43	HBD LETTER STRIPE PINK	00042	0	0	0	N/A	2017-11-29 12:38:54.163164+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
44	HBD LETTER STRIPE BLACK	00043	0	0	0	N/A	2017-11-29 12:56:47.967561+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 29, 2017	GUADALUPE	undefined
\.


--
-- Name: product_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('product_data_pk_seq', 44, true);


--
-- Data for Name: product_expire_status_confirm; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY product_expire_status_confirm (pk, cashier_user_id, status, date_created, archived) FROM stdin;
\.


--
-- Name: product_expire_status_confirm_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('product_expire_status_confirm_pk_seq', 1, false);


--
-- Data for Name: refund_item_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY refund_item_data (pk, product_name, product_srp, product_bar_code, product_stocks, product_price, product_expiration, product_supplier, product_receipt_name, product_or_number, product_or_stocks, product_product_code, product_rules, product_kind, date_created, archived) FROM stdin;
\.


--
-- Name: refund_item_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('refund_item_data_pk_seq', 1, false);


--
-- Data for Name: request_order_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY request_order_data (pk, product_finalnumber, product_quantity, product_date_needed, product_market_price, product_pk, status, date_created, archived, product_name, request_order_status, remarks, requested_by_pk) FROM stdin;
\.


--
-- Name: request_order_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('request_order_data_pk_seq', 1, false);


--
-- Data for Name: rules_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY rules_data (pk, rule_name, date_created, archived) FROM stdin;
1	No Rule	2017-11-29 09:16:38.986382+08	f
\.


--
-- Name: rules_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('rules_data_pk_seq', 1, true);


--
-- Data for Name: supplier_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY supplier_data (pk, supplier_name, supplier_address, supplier_contact_number, supplier_contact_person, supplier_code_name, date_created, archived) FROM stdin;
1	N/A	N/A	0	N/A	N/A	2017-11-29 09:10:34.153155+08	f
\.


--
-- Name: supplier_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('supplier_data_pk_seq', 1, true);


--
-- Data for Name: tender_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY tender_data (pk, product_name, product_quantity, product_supplier_price, product_retail_price, product_transaction_number, vat_percentage, net_amount, vat, discount, change, cash, tempo_total, void_count, total, gc_amount, gc_name, gc_code, cashier_user_id, date_created, archived, product_pk, cancelled_amount) FROM stdin;
\.


--
-- Name: tender_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('tender_data_pk_seq', 1, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY users (pk, user_id, first_name, middle_name, last_name, user_type, date_created, archived, superior_pin, email, stall_code, sales_dept) FROM stdin;
1	201400028	Patrick	Matetu	Chavez	1	2017-11-08 09:17:46.874583+08	f	92d85403814002271a64e291dd433483	\N	\N	\N
2	201400072	Ken	Villanueva	Tapdasan	2	2017-11-08 09:17:46.878213+08	f	92d85403814002271a64e291dd433483	\N	\N	\N
3	2014000100	R-Wayne	Feliciano	Lipardo	1	2017-11-08 09:17:47.465389+08	f	92d85403814002271a64e291dd433483	\N	\N	\N
\.


--
-- Name: users_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('users_pk_seq', 3, true);


--
-- Name: added_user_data_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY added_user_data
    ADD CONSTRAINT added_user_data_pkey PRIMARY KEY (pk);


--
-- Name: branch_data_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY branch_data
    ADD CONSTRAINT branch_data_pkey PRIMARY KEY (pk);


--
-- Name: cancelled_transact_data_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY cancelled_transact_data
    ADD CONSTRAINT cancelled_transact_data_pkey PRIMARY KEY (pk);


--
-- Name: customer_data_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY customer_data
    ADD CONSTRAINT customer_data_pkey PRIMARY KEY (pk);


--
-- Name: gift_certificate_data_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY gift_certificate_data
    ADD CONSTRAINT gift_certificate_data_pkey PRIMARY KEY (pk);


--
-- Name: history_log_data_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY history_log_data
    ADD CONSTRAINT history_log_data_pkey PRIMARY KEY (pk);


--
-- Name: product_data_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY product_data
    ADD CONSTRAINT product_data_pkey PRIMARY KEY (pk);


--
-- Name: product_expire_status_confirm_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY product_expire_status_confirm
    ADD CONSTRAINT product_expire_status_confirm_pkey PRIMARY KEY (pk);


--
-- Name: refund_item_data_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY refund_item_data
    ADD CONSTRAINT refund_item_data_pkey PRIMARY KEY (pk);


--
-- Name: request_order_data_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY request_order_data
    ADD CONSTRAINT request_order_data_pkey PRIMARY KEY (pk);


--
-- Name: rules_data_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY rules_data
    ADD CONSTRAINT rules_data_pkey PRIMARY KEY (pk);


--
-- Name: supplier_data_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY supplier_data
    ADD CONSTRAINT supplier_data_pkey PRIMARY KEY (pk);


--
-- Name: tender_data_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY tender_data
    ADD CONSTRAINT tender_data_pkey PRIMARY KEY (pk);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (pk);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

