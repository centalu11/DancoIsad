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
    sales_dept text,
    branch_assignment text
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
    archived boolean DEFAULT false,
    vat_registered boolean
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
    archived boolean DEFAULT false,
    cadd text,
    company text,
    job_position text,
    tin text,
    percent integer,
    last_day timestamp with time zone DEFAULT now()
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
    product_image text,
    product_size_name text,
    product_size_value integer,
    input_vat double precision,
    output_vat double precision,
    selling_price double precision
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
    cancelled_amount text,
    product_branches text,
    cnumber text
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
    sales_dept text,
    verify_random text,
    permission jsonb,
    branch_assignment text
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
201700153	74d214068a74cb954bff42e5f4a90a57	1
201700922	2bde5d2edf2091021fbca34253a86832	1
201700412	202cb962ac59075b964b07152d234b70	2
\.


--
-- Data for Name: added_user_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY added_user_data (pk, user_id, first_name, middle_name, last_name, user_type, date_created, archived, stall_code, sales_dept, branch_assignment) FROM stdin;
4	201700153	Shereen	N/A	Serdena	1	2017-12-01 14:18:12.913689+08	f	00	00	GUADALUPE
3	201700922	Dennis	N/A	Serdena	1	2017-12-01 14:17:36.364229+08	f	00	00	GUADALUPE
5	201700412	Sample	Sample	Sample	2	2017-12-06 15:28:42.299306+08	f	00	00	GUADALUPE
\.


--
-- Name: added_user_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('added_user_data_pk_seq', 5, true);


--
-- Data for Name: branch_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY branch_data (pk, branch_name, address, contact_person, contact_number, date_created, archived, vat_registered) FROM stdin;
1	GUADALUPE	GUADALUPE MALL	DENNIS SERDENA	09279590839	2017-11-29 09:11:35.847298+08	f	f
2	Starmall	Starmall, Shaw	sample	000000000	2017-12-06 15:36:15.474933+08	f	f
\.


--
-- Name: branch_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('branch_data_pk_seq', 2, true);


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

COPY customer_data (pk, first_name, middle_name, last_name, email, contact_number, date_created, archived, cadd, company, job_position, tin, percent, last_day) FROM stdin;
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
6	Product Edit	 Patrick Chavez edited HMD LETTER W/ DOT DARK	201400028	2017-11-29 13:00:48.796044+08	f
7	Product Edit	 Patrick Chavez edited HMD LETTER W/ STRIPE DARK PINK	201400028	2017-11-29 13:00:54.060378+08	f
8	Product Edit	 Patrick Chavez edited HMD LETTER W/ DOT LIGHT BLUE	201400028	2017-11-29 13:00:59.438426+08	f
9	Product Edit	 Patrick Chavez edited HMD LETTER BLUE W/ BLACK PRINT	201400028	2017-11-29 13:01:10.238713+08	f
10	Product Edit	 Patrick Chavez edited HMD LETTER PINK W/ BLACK PRINT	201400028	2017-11-29 13:01:16.446055+08	f
11	Product Edit	 Patrick Chavez edited HMD LETTER GREEN ASSORTED	201400028	2017-11-29 13:01:21.890838+08	f
12	Product Edit	 Patrick Chavez edited HMD LETTER PANTY FAVOR BALLOONS	201400028	2017-11-29 13:01:28.837927+08	f
13	Product Edit	 Patrick Chavez edited HMD LETTER PINK STRIPE ASSORTED	201400028	2017-11-29 13:01:34.427604+08	f
14	Product Edit	 Patrick Chavez edited HMD LETTER CLOWN W/ DOT GREEN	201400028	2017-11-29 13:01:48.068072+08	f
15	Product Edit	 Patrick Chavez edited HMD LETTER CUT OUT SILVER	201400028	2017-11-29 13:01:54.460207+08	f
16	Product Edit	 Patrick Chavez edited HMD LETTER  CUT OUT GOLD	201400028	2017-11-29 13:02:02.440678+08	f
17	Product Edit	 Patrick Chavez edited FRAME 4R WOOD BLACK	201400028	2017-11-29 13:02:28.87713+08	f
18	Product Edit	 Patrick Chavez edited FRAME 4R WOOD BROWN	201400028	2017-11-29 13:02:46.620674+08	f
19	Product Edit	 Patrick Chavez edited FRAME 4R WOOD BROWN	201400028	2017-11-29 13:02:52.256965+08	f
20	Product Edit	 Patrick Chavez edited FRAME 4R WOOD RED	201400028	2017-11-29 13:02:59.27356+08	f
21	Product Edit	 Patrick Chavez edited FRAME 3R WOOD R.BLUE	201400028	2017-11-29 13:03:05.138355+08	f
22	Product Edit	 Patrick Chavez edited FRAME 3R WOOD L.BLUE	201400028	2017-11-29 13:03:12.866851+08	f
23	Product Edit	 Patrick Chavez edited FRAME 3R WOOD WHITE	201400028	2017-11-29 13:03:17.627276+08	f
24	Product Edit	 Patrick Chavez edited FRAME 3R WOOD RED	201400028	2017-11-29 13:03:21.169775+08	f
25	Product Edit	 Patrick Chavez edited FRAME 3R WOOD PINK	201400028	2017-11-29 13:03:25.086737+08	f
26	Product Edit	 Patrick Chavez edited FRAME 3R WOOD BLACK	201400028	2017-11-29 13:03:28.76685+08	f
27	Product Edit	 Patrick Chavez edited PAPER BAG SMALL	201400028	2017-11-29 13:03:34.669175+08	f
28	Product Edit	 Patrick Chavez edited PAPER BAG MEDIUM	201400028	2017-11-29 13:03:38.539499+08	f
29	Product Edit	 Patrick Chavez edited PAPER BAG LARGE	201400028	2017-11-29 13:03:42.862684+08	f
30	Product Edit	 Patrick Chavez edited I.D LACE ONE DIRECTION	201400028	2017-11-29 13:03:48.461183+08	f
31	Product Edit	 Patrick Chavez edited I.D LACE BTS	201400028	2017-11-29 13:03:52.256305+08	f
32	Product Edit	 Patrick Chavez edited I.D LACE SPONGEBOB	201400028	2017-11-29 13:03:59.324462+08	f
33	Product Edit	 Patrick Chavez edited I.D LACE FROZEN	201400028	2017-11-29 13:04:03.618446+08	f
34	Product Edit	 Patrick Chavez edited I.D LACE ALDUB	201400028	2017-11-29 13:04:08.277176+08	f
35	Product Edit	 Patrick Chavez edited I.D LACE FACEBOOK	201400028	2017-11-29 13:04:12.596545+08	f
36	Product Edit	 Patrick Chavez edited I.D LACE PLAIN	201400028	2017-11-29 13:04:18.578146+08	f
37	Product Edit	 Patrick Chavez edited BTS COIN WALLET GRAY	201400028	2017-11-29 13:04:24.29125+08	f
38	Product Edit	 Patrick Chavez edited BTS COIN WALLET BLACK SMALL	201400028	2017-11-29 13:04:31.319662+08	f
39	Product Edit	 Patrick Chavez edited BTS COIN WALLET BLACK	201400028	2017-11-29 13:04:36.383056+08	f
40	Product Edit	 Patrick Chavez edited HBD LETTER DONUT	201400028	2017-11-29 13:04:40.874057+08	f
41	Product Edit	 Patrick Chavez edited HBD LETTER WHALE	201400028	2017-11-29 13:04:46.239884+08	f
42	Product Edit	 Patrick Chavez edited HBD LETTER CROWN PINK	201400028	2017-11-29 13:04:52.725813+08	f
43	Product Edit	 Patrick Chavez edited HBD LETTER CROWN BLUE	201400028	2017-11-29 13:04:56.807919+08	f
44	Product Edit	 Patrick Chavez edited HBD LETTER FOOT PRINT PINK	201400028	2017-11-29 13:05:01.419676+08	f
45	Product Edit	 Patrick Chavez edited HBD LETTER FOOT PINT BLUE	201400028	2017-11-29 13:05:05.073047+08	f
46	Product Edit	 Patrick Chavez edited HBD LETTER STRIPE BLUE LIGHT	201400028	2017-11-29 13:05:08.518272+08	f
47	Product Edit	 Patrick Chavez edited HBD LETTER R. BLUE	201400028	2017-11-29 13:05:13.239908+08	f
48	Product Edit	 Patrick Chavez edited HBD LETTER STRIPE BLACK	201400028	2017-11-29 13:05:18.39588+08	f
49	Product Edit	 Patrick Chavez edited HBD LETTER STRIPE PINK	201400028	2017-11-29 13:05:22.126825+08	f
50	Product Edit	 Patrick Chavez edited HBD LETTER STRIPE RED	201400028	2017-11-29 13:05:26.486891+08	f
51	Product Edit	 Patrick Chavez edited HBD LETTER YELLOW	201400028	2017-11-29 13:05:30.513445+08	f
52	Product Edit	 Patrick Chavez edited HBD LETTER STRIPE YELLOW	201400028	2017-11-29 13:16:17.539931+08	f
53	Product Edit	 Patrick Chavez edited FRAME 8X10 NORMAL L.BLUE	201400028	2017-11-29 13:21:32.237093+08	f
54	Product Edit	 Patrick Chavez edited HBD LETTER CROWN W/ GLITTERS BLUE	201400028	2017-11-29 14:40:42.494793+08	f
55	Product Edit	 Patrick Chavez edited CALLE TOPPER CHALK MICKEY MOUSE BIG	201400028	2017-11-29 15:58:31.558215+08	f
56	Product Edit	 Patrick Chavez edited CALLE TOPPER CHALK MICKEY MOUSE SMALL	201400028	2017-11-29 15:58:38.781997+08	f
57	Product Edit	 Patrick Chavez edited POWN TAIW CANDLE MEDIUM	201400028	2017-11-29 16:30:39.170556+08	f
58	Product Edit	 Patrick Chavez edited POWN TAIW CANDLE SMALL	201400028	2017-11-29 16:30:46.049159+08	f
59	Product Edit	 R-Wayne Lipardo edited TOOTHPICK POPPER W/ CHARACTER LITTLE PONNY	2014000100	2017-11-30 09:49:09.407889+08	f
60	Product Edit	 R-Wayne Lipardo edited TOOTHPICK POPPER W/ CHARACTER CANS	2014000100	2017-11-30 10:15:32.748499+08	f
61	Product Edit	 R-Wayne Lipardo edited PLASTIC LOOTBAG BIG SPIDERMAN	2014000100	2017-11-30 10:15:46.546913+08	f
62	Product Edit	 R-Wayne Lipardo edited PLASTIC LOOTBAG BIG SUPERMAN	2014000100	2017-11-30 10:15:54.319975+08	f
63	Product Edit	 R-Wayne Lipardo edited PLASTIC LOOTBAG BIG SUPERMAN	2014000100	2017-11-30 10:16:01.405309+08	f
64	Product Edit	 R-Wayne Lipardo edited PLASTIC LOOTBAG BIG SUPERMAN	2014000100	2017-11-30 10:17:53.753935+08	f
65	Product Edit	 R-Wayne Lipardo edited PLASTIC LOOTBAG BIG SUPERMAN	2014000100	2017-11-30 10:18:25.720914+08	f
66	Product Edit	 R-Wayne Lipardo edited PLASTIC LOOTBAG BIG CLASH OF CLANS	2014000100	2017-11-30 10:18:59.351809+08	f
67	Product Edit	 R-Wayne Lipardo edited PLASTIC LOOTBAG BIG CLASH OF CLANS	2014000100	2017-11-30 10:20:29.82623+08	f
68	Product Edit	 R-Wayne Lipardo edited PLASTIC LOOTBAG BIG BEN-10	2014000100	2017-11-30 10:20:36.165265+08	f
69	Product Edit	 R-Wayne Lipardo edited PLASTIC LOOTBAG BIG SUPERMAN	2014000100	2017-11-30 10:21:45.556783+08	f
70	Product Edit	 R-Wayne Lipardo edited PLASTIC LOOTBAG BIG SPIDERMAN	2014000100	2017-11-30 10:21:53.482345+08	f
71	Product Edit	 R-Wayne Lipardo edited TOOTHPICK POPPER W/ CHARACTER CANS	2014000100	2017-11-30 10:21:56.710636+08	f
72	Product Edit	 R-Wayne Lipardo edited TOOTHPICK POPPER W/ CHARACTER CANS	2014000100	2017-11-30 10:22:02.881669+08	f
73	Product Edit	 R-Wayne Lipardo edited KIDDIE MUG TINY ONE SIDE PRINT	2014000100	2017-11-30 10:23:51.151539+08	f
74	Product Edit	 R-Wayne Lipardo edited TOOTHPICK POPPER W/ CHARACTER MINIONS	2014000100	2017-11-30 10:23:56.759293+08	f
75	Product Edit	 R-Wayne Lipardo edited TOOTHPICK POPPER W/ CHARACTER LITTLE PONNY	2014000100	2017-11-30 10:24:04.388167+08	f
76	Product Edit	 R-Wayne Lipardo edited TOOTHPICK POPPER W/ CHARACTER CANS	2014000100	2017-11-30 10:24:10.402238+08	f
77	Product Edit	 R-Wayne Lipardo edited TOOTHPICK POPPER W/ CHARACTER CANS	2014000100	2017-11-30 10:24:28.073636+08	f
78	Product Edit	 R-Wayne Lipardo edited PLASTIC LOOTBAG BIG SPIDERMAN	2014000100	2017-11-30 10:24:34.159166+08	f
79	Product Edit	 R-Wayne Lipardo edited PLASTIC LOOTBAG BIG SUPERMAN	2014000100	2017-11-30 10:24:39.778229+08	f
80	Product Edit	 R-Wayne Lipardo edited PLASTIC LOOTBAG BIG CLASH OF CLANS	2014000100	2017-11-30 10:24:47.682885+08	f
81	Product Edit	 R-Wayne Lipardo edited PLASTIC LOOTBAG BIG BEN-10	2014000100	2017-11-30 10:24:53.242698+08	f
82	Product Edit	 R-Wayne Lipardo edited PLASTIC LOOTBAG BIG AVENGERS	2014000100	2017-11-30 10:24:59.421746+08	f
83	Product Edit	 R-Wayne Lipardo edited PLASTIC LOOTBAG BIG BATMAN	2014000100	2017-11-30 10:25:04.706283+08	f
84	Product Edit	 R-Wayne Lipardo edited PLASTIC LOOTBAG BIG SAFARRI	2014000100	2017-11-30 10:25:13.464272+08	f
85	Product Edit	 R-Wayne Lipardo edited PLASTIC LOOTBAG BIG SPONGEBOB	2014000100	2017-11-30 10:25:19.947999+08	f
86	Product Edit	 R-Wayne Lipardo edited PLASTIC LOOTBAG BIG MINIONS	2014000100	2017-11-30 10:25:26.08831+08	f
87	Product Edit	 R-Wayne Lipardo edited BANDERITAS W/ CHARACTERS ANGRY BIRD	2014000100	2017-11-30 11:00:58.086117+08	f
88	Product Edit	 R-Wayne Lipardo edited PLASTIC LOOTBAG BIG POLKA RED	2014000100	2017-11-30 11:01:15.827976+08	f
89	Product Edit	 R-Wayne Lipardo edited LOOT BAG PAPER SPIDERMAN	2014000100	2017-11-30 11:06:58.564651+08	f
90	Product Edit	 R-Wayne Lipardo edited MYLAR BALLOON CHARACTER BEN 10	2014000100	2017-11-30 11:54:07.967492+08	f
91	Product Edit	 R-Wayne Lipardo edited MYLAR BALLOON CHARACTER MINE CRAFT	2014000100	2017-11-30 11:55:38.519752+08	f
92	Product Edit	 R-Wayne Lipardo edited PHOTOPAPER PRINT A4 SIZE 230 68M	2014000100	2017-11-30 11:56:51.716396+08	f
93	Product Edit	 R-Wayne Lipardo edited MATTE CALLING CARD PAPER 8R SIZE 220 GSM	2014000100	2017-11-30 12:05:03.920899+08	f
94	Product Edit	 R-Wayne Lipardo edited POLKA DOT PARTY HAT RED & WHITE	2014000100	2017-11-30 13:20:45.651828+08	f
95	Product Edit	 R-Wayne Lipardo edited ITS A BOY PINK LETTER	2014000100	2017-11-30 14:25:35.350051+08	f
96	Product Edit	 R-Wayne Lipardo edited CHRISTENING PINK	2014000100	2017-11-30 14:26:58.322249+08	f
97	Product Edit	 R-Wayne Lipardo edited HBD FOIL SET SILVER	2014000100	2017-11-30 14:30:11.051103+08	f
98	Product Edit	 R-Wayne Lipardo edited INVITATION MINIE MOUSE	2014000100	2017-11-30 14:34:17.082267+08	f
99	Product Edit	 R-Wayne Lipardo edited HBD BUNTINGS LIGHT PINK W/ GLITTERS	2014000100	2017-11-30 15:40:46.941279+08	f
100	Product Edit	 R-Wayne Lipardo edited HBD BUNTINGS LIGHT PINK W/ GLITTERS	2014000100	2017-11-30 15:41:21.328901+08	f
101	Product Edit	 R-Wayne Lipardo edited HBD BUNTINGS LIGHT PINK W/ GLITTERS	2014000100	2017-11-30 15:42:53.778196+08	f
102	Product Edit	 R-Wayne Lipardo edited TOOTHPICK W/ LINING SPIDER	2014000100	2017-11-30 17:02:37.821205+08	f
103	Product Edit	 Patrick Chavez edited TOOTHPICK W/ LINING PRINCESS	201400028	2017-12-01 09:37:18.622272+08	f
104	Product Edit	 Patrick Chavez edited TOOTHPICK W/ LINING SPIDER	201400028	2017-12-01 09:37:24.568416+08	f
105	Product Edit	 Patrick Chavez edited TOOTHPICK W/ LINING BEN-10	201400028	2017-12-01 09:37:30.737622+08	f
106	Product Edit	 Patrick Chavez edited TOOTHPICK W/ LINING HAPPY B-DAY W/ DOT PINK/BLUE	201400028	2017-12-01 09:37:36.738542+08	f
107	Product Edit	 Patrick Chavez edited TOOTHPICK W/ LINING FROZEN	201400028	2017-12-01 09:37:46.073264+08	f
108	Product Edit	 Patrick Chavez edited TOOTHPICK TOPPER W/ CHARACTER UMBRELLA	201400028	2017-12-01 09:37:51.580829+08	f
109	Product Edit	 Patrick Chavez edited TOOTHPICK TOPPER W/ CHARACTER PEPPAPIG	201400028	2017-12-01 09:38:47.267578+08	f
110	Product Edit	 Patrick Chavez edited TOOTHPICK TOPPER W/ CHARACTER FROZEN	201400028	2017-12-01 10:15:29.556303+08	f
111	Product Edit	 Patrick Chavez edited TOOTHPICK TOPPER W/ CHARACTER SOFIA	201400028	2017-12-01 10:15:34.31077+08	f
112	Product Edit	 Patrick Chavez edited TOOTHPICK TOPPER W/ CHARACTER HELLO KITTY	201400028	2017-12-01 10:15:39.055327+08	f
113	Product Edit	 Patrick Chavez edited TOOTHPICK TOPPER W/ CHARACTER MINNIE MOUSE	201400028	2017-12-01 10:15:47.779609+08	f
114	Product Edit	 Patrick Chavez edited TOOTHPICK TOPPER W/ CHARACTER MICKEY MOUSE	201400028	2017-12-01 10:15:53.363057+08	f
115	Product Edit	 Patrick Chavez edited TOOTHPICK TOPPER W/ CHARACTER SPIDER	201400028	2017-12-01 10:16:00.074307+08	f
116	Product Edit	 Patrick Chavez edited TOOTHPICK TOPPER W/ CHARACTER CARS	201400028	2017-12-01 10:16:04.62944+08	f
117	Product Edit	 Patrick Chavez edited TOOTHPICK TOPPER W/ CHARACTER LITTLE PONY	201400028	2017-12-01 10:16:08.629469+08	f
118	Product Edit	 Patrick Chavez edited TOOTHPICK TOPPER W/ CHARACTER MINIONS	201400028	2017-12-01 10:16:13.703091+08	f
119	Product Edit	 Patrick Chavez edited HBD BUNTINGS LIGHT PINK W/ GLITTERS	201400028	2017-12-01 10:16:18.275439+08	f
120	Product Edit	 Patrick Chavez edited HBD BUNTINGS RED W/ GLITTERS	201400028	2017-12-01 10:16:24.079522+08	f
121	Product Edit	 Patrick Chavez edited HBD BUNTINGS SILVER W/ GLITTERS	201400028	2017-12-01 10:16:28.873625+08	f
122	Product Edit	 Patrick Chavez edited HBD BUNTINGS BLACK W/ GLITTERS	201400028	2017-12-01 10:16:35.951152+08	f
123	Product Edit	 Patrick Chavez edited HBD BUNTINGS ROYAL BLUE W/ GLITTERS	201400028	2017-12-01 10:16:40.661044+08	f
124	Product Edit	 Patrick Chavez edited HBD LETTER SMALL WHITE W/ GOLD PRINT	201400028	2017-12-01 10:16:44.558926+08	f
125	Product Edit	 Patrick Chavez edited HBD LETTER SMALL BLACK W/ GOLD PRINT	201400028	2017-12-01 10:16:48.292937+08	f
126	Product Edit	 Patrick Chavez edited HBD LETTER SMALL PINK W/ GOLD PRINT	201400028	2017-12-01 10:16:54.010567+08	f
127	Product Edit	 Patrick Chavez edited HBD LETTER SMALL LIGHT BLUE W/ GOLD PRINT	201400028	2017-12-01 10:16:57.495163+08	f
128	Product Edit	 Patrick Chavez edited HBD LETTER BIG ASST W/ GOLD PRINT	201400028	2017-12-01 10:17:03.89364+08	f
129	Product Edit	 Patrick Chavez edited HBD LETTER BIG PINK W/ GOLD PRINT	201400028	2017-12-01 10:17:12.13317+08	f
130	Product Edit	 Patrick Chavez edited HBD LETTER BIG GREEN W/ GOLD PRINT	201400028	2017-12-01 10:17:16.802454+08	f
131	Product Edit	 Patrick Chavez edited HBD LETTER BIG WHITE W/ GOLD PRINT	201400028	2017-12-01 10:17:24.184836+08	f
132	Product Edit	 Patrick Chavez edited HBD BUNTINGS BLACK W/ GLITTERS	201400028	2017-12-01 10:17:34.122119+08	f
133	Product Edit	 Patrick Chavez edited PHOTOPAPER CALLING CARD 230GSM FULL COLOR BACK TO BACK 100S	201400028	2017-12-01 10:17:45.700594+08	f
134	Product Edit	 Patrick Chavez edited PHOTOPAPER CALLING CARD 230GSM FULL COLOR BACK TO BACK 50S	201400028	2017-12-01 10:28:03.623118+08	f
135	Product Edit	 Patrick Chavez edited HBD LETTER BIG BLACK W/ GOLD PRINT	201400028	2017-12-01 10:28:14.333268+08	f
136	Product Edit	 Patrick Chavez edited HBD LETTER BIG LIGHT BLUE W/ GOLD PRINT	201400028	2017-12-01 10:28:22.876908+08	f
137	Product Edit	 Patrick Chavez edited PHOTOPAPER CALLING CARD 230GSM PLAIN PAPER/BACK TO BACK 100S	201400028	2017-12-01 10:28:32.925193+08	f
138	Product Edit	 Patrick Chavez edited PHOTOPAPER CALLING CARD 230GSM PLAIN PAPER/BACK TO BACK 50S	201400028	2017-12-01 10:29:20.149925+08	f
139	Product Edit	 Patrick Chavez edited PARTY CURTAIN SILVER	201400028	2017-12-01 10:29:28.70631+08	f
140	Product Edit	 Patrick Chavez edited PARTY CURTAIN GOLD	201400028	2017-12-01 10:29:34.685366+08	f
141	Product Edit	 Patrick Chavez edited PARTY CURTAIN RED	201400028	2017-12-01 10:29:39.685038+08	f
142	Product Edit	 Patrick Chavez edited PHOTOPAPER CALLING CARD 230GSM FULL COLOR 100S	201400028	2017-12-01 10:29:43.781674+08	f
143	Product Edit	 Patrick Chavez edited PARTY CURTAIN BLUE VIOLET	201400028	2017-12-01 10:30:58.885399+08	f
144	Product Edit	 Patrick Chavez edited PARTY PAPER CUP CLASSIC COLOR AND DESIGN	201400028	2017-12-01 10:31:02.625172+08	f
145	Product Edit	 Patrick Chavez edited PHOTOPAPER CALLING CARD 230GSM FULL COLOR 50S	201400028	2017-12-01 10:31:07.245817+08	f
146	Product Edit	 Patrick Chavez edited PARTY PAPER CUP BAYMAX	201400028	2017-12-01 10:31:11.726704+08	f
147	Product Edit	 Patrick Chavez edited PHOTOPAPER CALLING CARD 230GSM PLAIN COLOR 100S	201400028	2017-12-01 10:31:17.945598+08	f
148	Product Edit	 Patrick Chavez edited PARTY PAPER CUP MICKEY MOUSE	201400028	2017-12-01 10:31:23.224181+08	f
149	Product Edit	 Patrick Chavez edited PHOTOPAPER CALLING CARD 230GSM PLAIN COLOR 50S	201400028	2017-12-01 10:31:27.41696+08	f
150	Product Edit	 Patrick Chavez edited PARTY PAPER CUP SOPHIA THE FIRST	201400028	2017-12-01 10:31:33.465647+08	f
151	Product Edit	 Patrick Chavez edited PARTY PAPER CUP FROZEN	201400028	2017-12-01 10:31:38.223126+08	f
152	Product Edit	 Patrick Chavez edited PARTY PAPER CUP HELLO KITTY BARBIE	201400028	2017-12-01 10:31:42.597152+08	f
153	Product Edit	 Patrick Chavez edited LINING RED	201400028	2017-12-01 10:32:13.587451+08	f
154	Product Edit	 Patrick Chavez edited QUAFF MATTE CALLING CARD PAPER CALLING CARD PRINT FULL COLOR BACK TO BACK 100S	201400028	2017-12-01 10:32:20.123996+08	f
155	Product Edit	 Patrick Chavez edited POLKA DOTS LIGHT PINK	201400028	2017-12-01 10:32:26.855346+08	f
156	Product Edit	 Patrick Chavez edited QUAFF MATTE CALLING CARD PAPER CALLING CARD PRINT FULL COLOR BACK TO BACK 50S	201400028	2017-12-01 10:32:37.765185+08	f
157	Product Edit	 Patrick Chavez edited CUP LIGHT BLUE	201400028	2017-12-01 10:32:44.55232+08	f
158	Product Edit	 Patrick Chavez edited PAPER CUPCAKE VIOLET	201400028	2017-12-01 10:32:53.542834+08	f
159	Product Edit	 Patrick Chavez edited PAPER STRAW RED	201400028	2017-12-01 10:32:59.531372+08	f
160	Product Edit	 Patrick Chavez edited QUAFF MATTE CALLING CARD PAPER CALLING CARD PRINT PLAIN PAPER/BACK TO BACK 100S	201400028	2017-12-01 10:33:05.457464+08	f
161	Product Edit	 Patrick Chavez edited PAPER STRAW BLACK AND POLKA DOTS	201400028	2017-12-01 10:33:14.06715+08	f
162	Product Edit	 Patrick Chavez edited QUAFF MATTE CALLING CARD PAPER CALLING CARD PRINT PLAIN PAPER/BACK TO BACK 50S	201400028	2017-12-01 10:33:19.75255+08	f
163	Product Edit	 Patrick Chavez edited PAPER STRAW FUCHSIA PINK	201400028	2017-12-01 10:33:34.417451+08	f
164	Product Edit	 Patrick Chavez edited PAPER STRAW BLUE	201400028	2017-12-01 10:33:41.507272+08	f
165	Product Edit	 Patrick Chavez edited QUAFF MATTE CALLING CARD PAPER CALLING CARD PRINT FULL COLOR 100S	201400028	2017-12-01 10:33:49.679323+08	f
166	Product Edit	 Patrick Chavez edited QUAFF MATTE CALLING CARD PAPER CALLING CARD PRINT FULL COLOR 50S	201400028	2017-12-01 10:33:56.843506+08	f
167	Product Edit	 Patrick Chavez edited QUAFF MATTE CALLING CARD PAPER CALLING CARD PRINT PLAIN COLOR 100S	201400028	2017-12-01 10:34:03.878668+08	f
168	Product Edit	 Patrick Chavez edited QUAFF MATTE CALLING CARD PAPER CALLING CARD PRINT PLAIN COLOR 50S 220GSM	201400028	2017-12-01 10:34:10.033119+08	f
169	Product Edit	 Patrick Chavez edited POSTER ONE DIRECTION	201400028	2017-12-01 10:34:15.074331+08	f
170	Product Edit	 Patrick Chavez edited PAPER STRAW TIGHT PINK	201400028	2017-12-01 10:34:21.760585+08	f
171	Product Edit	 Patrick Chavez edited POSTER BIG BANG	201400028	2017-12-01 10:34:29.310275+08	f
172	Product Edit	 Patrick Chavez edited POSTER ALDUB	201400028	2017-12-01 10:34:36.577974+08	f
173	Product Edit	 Patrick Chavez edited POSTER BLACK & PINK	201400028	2017-12-01 10:35:32.418281+08	f
174	Product Edit	 Patrick Chavez edited POSTER EXO	201400028	2017-12-01 10:35:41.990393+08	f
175	Product Edit	 Patrick Chavez edited POSTER BTS	201400028	2017-12-01 10:35:49.92669+08	f
176	Product Edit	 Patrick Chavez edited PLASTIC LOOT BAG SMALL ANGRY BIRD	201400028	2017-12-01 10:35:56.617262+08	f
177	Product Edit	 Patrick Chavez edited PLASTIC LOOT BAG SMALL CARS	201400028	2017-12-01 10:36:05.873727+08	f
178	Product Edit	 Patrick Chavez edited PLASTIC LOOT BAG SMALL BATMAN	201400028	2017-12-01 10:36:13.770881+08	f
179	Product Edit	 Patrick Chavez edited PLASTIC LOOT BAG SMALL BEN-10	201400028	2017-12-01 10:36:20.208551+08	f
180	Product Edit	 Patrick Chavez edited PLASTIC LOOT BAG SMALL PEPPAPIG	201400028	2017-12-01 10:36:28.390988+08	f
181	Product Edit	 Patrick Chavez edited PLASTIC LOOT BAG SMALL CAPTAIN AMERICA	201400028	2017-12-01 10:36:35.063591+08	f
182	Product Edit	 Patrick Chavez edited PLASTIC LOOT BAG SMALL SPIDER	201400028	2017-12-01 10:36:41.639875+08	f
183	Product Edit	 Patrick Chavez edited PLASTIC LOOT BAG SMALL MICKEY MOUSE	201400028	2017-12-01 10:38:38.492718+08	f
184	Product Edit	 Patrick Chavez edited PLASTIC LOOT BAG SMALL MINIONS	201400028	2017-12-01 10:38:52.202682+08	f
185	Product Edit	 Patrick Chavez edited PLASTIC LOOT BAG SMALL MINECRAFT	201400028	2017-12-01 10:38:58.040581+08	f
186	Product Edit	 Patrick Chavez edited PLASTIC LOOT BAG SMALL CLASH OF CLANS	201400028	2017-12-01 10:39:05.987493+08	f
187	Product Edit	 Patrick Chavez edited PLASTIC LOOT BAG SMALL SPONGEBOB	201400028	2017-12-01 10:39:14.42338+08	f
188	Product Edit	 Patrick Chavez edited PLASTIC LOOT BAG SMALL WINNIE THE POOH	201400028	2017-12-01 10:39:20.435672+08	f
189	Product Edit	 Patrick Chavez edited INVITATION SOFIA	201400028	2017-12-01 10:39:26.704638+08	f
190	Product Edit	 Patrick Chavez edited INVITATION TINKER BELL	201400028	2017-12-01 10:39:34.199257+08	f
191	Product Edit	 Patrick Chavez edited CURLING RIBBON POMPOMS YELLOW GREEN	201400028	2017-12-01 10:39:41.381574+08	f
192	Product Edit	 Patrick Chavez edited INVITATION BARBIE	201400028	2017-12-01 10:39:48.974012+08	f
193	Product Edit	 Patrick Chavez edited CURLING RIBBON POMPOMS VIOLET & LIGHT VIOLET	201400028	2017-12-01 10:40:13.238417+08	f
194	Product Edit	 Patrick Chavez edited INVITATION HELLO KITTY	201400028	2017-12-01 10:40:19.809348+08	f
195	Product Edit	 Patrick Chavez edited INVITATION FROZEN	201400028	2017-12-01 10:40:27.004294+08	f
196	Product Edit	 Patrick Chavez edited CURLING RIBBON POMPOMS RED & YELLOW	201400028	2017-12-01 10:40:33.831692+08	f
197	Product Edit	 Patrick Chavez edited INVITATION MOANA	201400028	2017-12-01 10:40:42.750867+08	f
198	Product Edit	 Patrick Chavez edited CURLING RIBBON POMPOMS LIGHT BLUE & DARK BLUE	201400028	2017-12-01 10:40:49.19818+08	f
199	Product Edit	 Patrick Chavez edited INVITATION PRINCESS	201400028	2017-12-01 10:40:54.500845+08	f
200	Product Edit	 Patrick Chavez edited CURLING RIBBON POMPOMS LIGHT PINK & FUSCHIA PINK	201400028	2017-12-01 10:41:01.723732+08	f
201	Product Edit	 Patrick Chavez edited INVITATION MINIE MOUSE	201400028	2017-12-01 10:41:08.511476+08	f
202	Product Edit	 Patrick Chavez edited CURLING RIBBON POMPOMS HAPPY BIRTHDAY	201400028	2017-12-01 10:41:16.978804+08	f
203	Product Edit	 Patrick Chavez edited CURLING RIBBON W/ GLITTERS VIOLET	201400028	2017-12-01 10:43:09.147106+08	f
204	Product Edit	 Patrick Chavez edited CURLING RIBBON W/ GLITTERS GREEN	201400028	2017-12-01 10:43:17.891512+08	f
205	Product Edit	 Patrick Chavez edited HBD FOIL SET PINK PLAIN	201400028	2017-12-01 10:43:23.080723+08	f
206	Product Edit	 Patrick Chavez edited CURLING RIBBON W/ GLITTERS BLUE	201400028	2017-12-01 10:43:28.642398+08	f
207	Product Edit	 Patrick Chavez edited HBD FOIL SET PINK W/ STAR DESIGN	201400028	2017-12-01 10:43:32.868159+08	f
208	Product Edit	 Patrick Chavez edited CURLING RIBBON W/ GLITTERS RED	201400028	2017-12-01 10:43:37.283826+08	f
209	Product Edit	 Patrick Chavez edited HBD FOIL SET BLUE W/ STAR DESIGN	201400028	2017-12-01 10:43:46.039952+08	f
210	Product Edit	 Patrick Chavez edited CURLING RIBBON W/ GLITTERS YELLOW GOLD	201400028	2017-12-01 10:43:50.278622+08	f
211	Product Edit	 Patrick Chavez edited HBD FOIL SET GOLD	201400028	2017-12-01 10:43:54.916585+08	f
212	Product Edit	 Patrick Chavez edited PARTY LOOT BAG SMALL PARTY TIME	201400028	2017-12-01 10:43:59.883189+08	f
213	Product Edit	 Patrick Chavez edited HBD FOIL SET SILVER	201400028	2017-12-01 10:44:09.526543+08	f
214	Product Edit	 Patrick Chavez edited PARTY LOOT BAG SMALL DORA	201400028	2017-12-01 10:44:15.095892+08	f
215	Product Edit	 Patrick Chavez edited HBD FOIL SET ASSORTED	201400028	2017-12-01 10:44:19.243661+08	f
216	Product Edit	 Patrick Chavez edited PARTY LOOT BAG SMALL TINKERBELL	201400028	2017-12-01 10:44:23.076142+08	f
217	Product Edit	 Patrick Chavez edited FOIL SET BLUE	201400028	2017-12-01 10:44:26.939259+08	f
218	Product Edit	 Patrick Chavez edited PARTY LOOT BAG SMALL BARBIE	201400028	2017-12-01 10:44:36.113445+08	f
219	Product Edit	 Patrick Chavez edited BABY SHOWER PINK	201400028	2017-12-01 10:44:41.502075+08	f
220	Product Edit	 Patrick Chavez edited PARTY LOOT BAG SMALL HELLO KITTY	201400028	2017-12-01 10:44:46.232279+08	f
221	Product Edit	 Patrick Chavez edited FOIL SET BLUE	201400028	2017-12-01 10:44:53.361228+08	f
222	Product Edit	 Patrick Chavez edited HBD FOIL SET SILVER	201400028	2017-12-01 10:45:22.498697+08	f
223	Product Edit	 Patrick Chavez edited PARTY LOOT BAG SMALL SOFIA	201400028	2017-12-01 10:47:03.699368+08	f
224	Product Edit	 Patrick Chavez edited CHRISTENING PINK	201400028	2017-12-01 10:47:13.319513+08	f
225	Product Edit	 Patrick Chavez edited PARTY LOOT BAG SMALL FROZEN	201400028	2017-12-01 10:47:17.825936+08	f
226	Product Edit	 Patrick Chavez edited PARTY LOOT BAG SMALL MOANA	201400028	2017-12-01 10:47:23.812433+08	f
227	Product Edit	 Patrick Chavez edited ITS A GIRL BLUE LETTER	201400028	2017-12-01 10:47:28.351495+08	f
228	Product Edit	 Patrick Chavez edited ITS A BOY PINK LETTER	201400028	2017-12-01 10:47:32.760482+08	f
229	Product Edit	 Patrick Chavez edited PARTY LOOT BAG SMALL MINNIE MOUSE	201400028	2017-12-01 10:47:39.224345+08	f
230	Product Edit	 Patrick Chavez edited LETTER BLUE	201400028	2017-12-01 10:47:48.027455+08	f
231	Product Edit	 Patrick Chavez edited LETTER BLACK	201400028	2017-12-01 10:47:53.002883+08	f
232	Product Edit	 Patrick Chavez edited PARTY CURTAIN SILVER	201400028	2017-12-01 10:47:58.684852+08	f
233	Product Edit	 Patrick Chavez edited PARTY CURTAIN GOLD	201400028	2017-12-01 10:48:03.77258+08	f
234	Product Edit	 Patrick Chavez edited ANNIVERSARY PINK	201400028	2017-12-01 10:48:13.984524+08	f
235	Product Edit	 Patrick Chavez edited PARTY CURTAIN RED	201400028	2017-12-01 10:48:18.731038+08	f
236	Product Edit	 Patrick Chavez edited BUNTING ASSORTED CLOWN	201400028	2017-12-01 10:48:23.268359+08	f
237	Product Edit	 Patrick Chavez edited PARTY CURTAIN BLUE VIOLET	201400028	2017-12-01 10:48:26.92029+08	f
238	Product Edit	 Patrick Chavez edited PARTY PAPER CUP CLASSIC COLOR & DESIGN	201400028	2017-12-01 10:48:37.679482+08	f
239	Product Edit	 Patrick Chavez edited PARTY PAPER CUP BAYMAX	201400028	2017-12-01 10:48:41.925955+08	f
240	Product Edit	 Patrick Chavez edited PARTY PAPER CUP BAYMAX	201400028	2017-12-01 10:48:46.875984+08	f
241	Product Edit	 Patrick Chavez edited PARTY PAPER CUP MICKEY MOUSE	201400028	2017-12-01 10:48:52.792379+08	f
242	Product Edit	 Patrick Chavez edited PARTY PAPER CUP SOPHIA THE FIRST	201400028	2017-12-01 10:48:56.73538+08	f
243	Product Edit	 Patrick Chavez edited PLASTIC LOOT BAG BIG PARTY TIME RAINBOW	201400028	2017-12-01 10:49:00.700585+08	f
244	Product Edit	 Patrick Chavez edited PARTY PAPER CUP FROZEN	201400028	2017-12-01 10:49:41.859733+08	f
245	Product Edit	 Patrick Chavez edited PLASTIC LOOT BAG BIG HBDAY CAKE	201400028	2017-12-01 10:49:50.106204+08	f
246	Product Edit	 Patrick Chavez edited PARTY PAPER CUP HELLO KITTY BARBIE	201400028	2017-12-01 10:49:56.434721+08	f
247	Product Edit	 Patrick Chavez edited PLASTIC LOOT BAG BIG HBDAY FLOWER	201400028	2017-12-01 10:50:01.563738+08	f
248	Product Edit	 Patrick Chavez edited LINING RED	201400028	2017-12-01 10:50:12.380989+08	f
249	Product Edit	 Patrick Chavez edited PLASTIC LOOT BAG BIG PARTY TIME BALOON	201400028	2017-12-01 10:50:20.174426+08	f
250	Product Edit	 Patrick Chavez edited POLKA DOTS LIGHT PINK	201400028	2017-12-01 10:51:29.815882+08	f
251	Product Edit	 Patrick Chavez edited PLASTIC LOOT BAG BIG SOFIA	201400028	2017-12-01 10:51:35.962211+08	f
252	Product Edit	 Patrick Chavez edited PLASTIC LOOT BAG BIG FROZEN	201400028	2017-12-01 10:51:42.376036+08	f
253	Product Edit	 Patrick Chavez edited CUP LIGHT BLUE	201400028	2017-12-01 10:51:47.06204+08	f
254	Product Edit	 Patrick Chavez edited PLASTIC LOOT BAG BIG LITTLE PONY	201400028	2017-12-01 10:56:08.725805+08	f
255	Product Edit	 Patrick Chavez edited PAPER CUPCAKE VIOLET	201400028	2017-12-01 10:56:17.526179+08	f
256	Product Edit	 Patrick Chavez edited PAPER STRAW RED+	201400028	2017-12-01 10:57:02.440446+08	f
257	Product Edit	 Patrick Chavez edited PAPER STRAW BLACK & POLKA DOTS	201400028	2017-12-01 10:57:06.574007+08	f
258	Product Edit	 Patrick Chavez edited PAPER STRAW FUSCHIA PINK	201400028	2017-12-01 10:57:11.024455+08	f
259	Product Edit	 Patrick Chavez edited PAPER STRAW BLUE	201400028	2017-12-01 10:57:55.520726+08	f
260	Product Edit	 Patrick Chavez edited PAPER STRAW LIGHT PINK	201400028	2017-12-01 10:58:01.691815+08	f
261	Product Edit	 Patrick Chavez edited INVITATION BARNEY	201400028	2017-12-01 10:58:07.088921+08	f
262	Product Edit	 Patrick Chavez edited INVITATION SPONGEBOB	201400028	2017-12-01 10:58:11.121762+08	f
263	Product Edit	 Patrick Chavez edited INVITATION SPIDERMAN	201400028	2017-12-01 10:58:21.096037+08	f
264	Product Edit	 Patrick Chavez edited INVITATION POKEMON	201400028	2017-12-01 10:58:34.723676+08	f
265	Product Edit	 Patrick Chavez edited PLASTIC LOOT BAG BIG MOANA	201400028	2017-12-01 10:58:39.440264+08	f
266	Product Edit	 Patrick Chavez edited INVITATION PEPPAPIG	201400028	2017-12-01 10:58:43.634763+08	f
267	Product Edit	 Patrick Chavez edited PLASTIC LOOT BAG BIG TINKERBELL	201400028	2017-12-01 10:58:48.09032+08	f
268	Product Edit	 Patrick Chavez edited INVITATION CLASH OF CLANS	201400028	2017-12-01 10:58:54.546861+08	f
269	Product Edit	 Patrick Chavez edited PLASTIC LOOT BAG BIG BARBIE	201400028	2017-12-01 10:59:00.0632+08	f
270	Product Edit	 Patrick Chavez edited INVITATION CARS	201400028	2017-12-01 10:59:05.558191+08	f
271	Product Edit	 Patrick Chavez edited PLASTIC LOOT BAG BIG STRAWBERRY SHORT CAKE	201400028	2017-12-01 11:00:10.595272+08	f
272	Product Edit	 Patrick Chavez edited INVITATION MINIONS	201400028	2017-12-01 11:00:14.852528+08	f
273	Product Edit	 Patrick Chavez edited PLASTIC LOOT BAG BIG PRINCESS	201400028	2017-12-01 11:00:20.089321+08	f
274	Product Edit	 Patrick Chavez edited INVITATION SUPERMAN	201400028	2017-12-01 11:00:30.935192+08	f
275	Product Edit	 Patrick Chavez edited ID LACE JUNK KOOL	201400028	2017-12-01 11:00:35.669031+08	f
276	Product Edit	 Patrick Chavez edited INVITATION MICKEY MIOUSE	201400028	2017-12-01 11:00:40.015945+08	f
277	Product Edit	 Patrick Chavez edited BALLER ELICE	201400028	2017-12-01 11:00:45.335456+08	f
278	Product Edit	 Patrick Chavez edited INVITATION TOY STORY	201400028	2017-12-01 11:00:52.786228+08	f
279	Product Edit	 Patrick Chavez edited INVITATION BATMAN	201400028	2017-12-01 11:00:58.399839+08	f
280	Product Edit	 Patrick Chavez edited INVITATION BEN-10	201400028	2017-12-01 11:01:37.94289+08	f
281	Product Edit	 Patrick Chavez edited BTS FAN	201400028	2017-12-01 11:01:41.7577+08	f
282	Product Edit	 Patrick Chavez edited BTS BALLPEN ASSORTED SET	201400028	2017-12-01 11:01:47.322152+08	f
283	Product Edit	 Patrick Chavez edited PLASTIC LOOT BAG BIG MINIE MOUSE	201400028	2017-12-01 11:01:50.999305+08	f
284	Product Edit	 Patrick Chavez edited PLASTIC LOOT BAG BIG DORA	201400028	2017-12-01 11:01:57.351073+08	f
285	Product Edit	 Patrick Chavez edited BTS BALLPEN BLUE	201400028	2017-12-01 11:02:01.15931+08	f
286	Product Edit	 Patrick Chavez edited PLASTIC LOOT BAG BIG HELLO KITTY	201400028	2017-12-01 11:02:05.702198+08	f
287	Product Edit	 Patrick Chavez edited BTS BALLPEN BLACK	201400028	2017-12-01 11:02:53.432736+08	f
288	Product Edit	 Patrick Chavez edited BTS BALLPEN WHITE	201400028	2017-12-01 11:02:59.749893+08	f
289	Product Edit	 Patrick Chavez edited WOODEN CLIP ASSORTED	201400028	2017-12-01 11:03:04.034468+08	f
290	Product Edit	 Patrick Chavez edited BTS BALLPEN PINK	201400028	2017-12-01 11:03:07.814989+08	f
291	Product Edit	 Patrick Chavez edited ID LACE STRING	201400028	2017-12-01 11:03:15.537255+08	f
292	Product Edit	 Patrick Chavez edited WOODEN CLIP BLUE	201400028	2017-12-01 11:03:22.779858+08	f
293	Product Edit	 Patrick Chavez edited WOODEN CLIP PINK	201400028	2017-12-01 11:03:34.945302+08	f
294	Product Edit	 Patrick Chavez edited ID LACE WARRIORS	201400028	2017-12-01 11:03:44.968304+08	f
295	Product Edit	 Patrick Chavez edited ID LACE STAR	201400028	2017-12-01 11:04:05.29437+08	f
296	Product Edit	 Patrick Chavez edited CAKE STAND HELLO KITTY	201400028	2017-12-01 11:04:09.784936+08	f
297	Product Edit	 Patrick Chavez edited ID LACE BANGTANG BOYS	201400028	2017-12-01 11:04:14.852197+08	f
298	Product Edit	 Patrick Chavez edited CAKE STAND SPIDER	201400028	2017-12-01 11:04:23.082504+08	f
299	Product Edit	 Patrick Chavez edited CAKE STAND SOFIA	201400028	2017-12-01 11:04:29.78048+08	f
300	Product Edit	 Patrick Chavez edited CAKE STAND PINK W/ DOT	201400028	2017-12-01 11:05:32.812224+08	f
301	Product Edit	 Patrick Chavez edited CAKE STAND BLUE W/ DOT	201400028	2017-12-01 11:05:39.395199+08	f
302	Product Edit	 Patrick Chavez edited CAKE STAND RED W/ DOT	201400028	2017-12-01 11:06:10.20995+08	f
303	Product Edit	 Patrick Chavez edited ID LACE POKEMON	201400028	2017-12-01 11:06:19.82228+08	f
304	Product Edit	 Patrick Chavez edited CAKE STAND GOLD	201400028	2017-12-01 11:06:32.009777+08	f
305	Product Edit	 Patrick Chavez edited ID LACE PILIPINAS	201400028	2017-12-01 11:06:37.950392+08	f
306	Product Edit	 Patrick Chavez edited CAKE STAND SILVER	201400028	2017-12-01 11:06:46.012568+08	f
307	Product Edit	 Patrick Chavez edited ID LACE TRIBAL	201400028	2017-12-01 11:06:51.575805+08	f
308	Product Edit	 Patrick Chavez edited BALLER RI	201400028	2017-12-01 11:06:56.193467+08	f
309	Product Edit	 Patrick Chavez edited GIFT WRAPPER CHARACTER STAR HBD BLACK	201400028	2017-12-01 11:07:04.815683+08	f
310	Product Edit	 Patrick Chavez edited BALLER DANGEROUS	201400028	2017-12-01 11:07:11.098263+08	f
311	Product Edit	 Patrick Chavez edited GIFT WRAPPER CHARACTER HBD-ASSORTED	201400028	2017-12-01 11:07:16.694422+08	f
312	Product Edit	 Patrick Chavez edited BALLER JUST DO IT	201400028	2017-12-01 11:07:28.082639+08	f
313	Product Edit	 Patrick Chavez edited BALLER NIKE	201400028	2017-12-01 11:07:36.005871+08	f
314	Product Edit	 Patrick Chavez edited GIFT WRAPPER CHARACTER BEAR BLUE & WHITE	201400028	2017-12-01 11:07:43.598262+08	f
315	Product Edit	 Patrick Chavez edited TOOTHPICK W/ LINING PRINCESS	201400028	2017-12-01 11:15:54.715102+08	f
316	Product Edit	 Patrick Chavez edited TOOTHPICK W/ LINING PRINCESS	201400028	2017-12-01 11:16:42.148195+08	f
317	Product Edit	 Patrick Chavez edited BALLER JAMES	201400028	2017-12-01 11:28:49.706885+08	f
318	Product Edit	 Patrick Chavez edited GIFT WRAPPER CHARACTER MICKEY MOUSE	201400028	2017-12-01 11:28:53.967033+08	f
319	Product Edit	 Patrick Chavez edited GIFT WRAPPER CHARACTER BEN 10	201400028	2017-12-01 11:28:58.578597+08	f
320	Product Edit	 Patrick Chavez edited GIFT WRAPPER CHARACTER SOPHIA	201400028	2017-12-01 11:29:02.450569+08	f
321	Product Edit	 Patrick Chavez edited BALLER ATTACK ON TITAN	201400028	2017-12-01 11:29:16.793928+08	f
322	Product Edit	 Patrick Chavez edited GIFT WRAPPER CHARACTER SPIDERMAN	201400028	2017-12-01 11:29:21.590187+08	f
323	Product Edit	 Patrick Chavez edited BALLER HELLO KITTY	201400028	2017-12-01 11:29:26.782561+08	f
324	Product Edit	 Patrick Chavez edited GIFT WRAPPER CHARACTER SPONGEBOB	201400028	2017-12-01 11:29:31.159912+08	f
325	Product Edit	 Patrick Chavez edited GIFT WRAPPER CHARACTER HELLO KITTY	201400028	2017-12-01 11:29:35.346914+08	f
326	Product Edit	 Patrick Chavez edited GIFT WRAPPER CHARACTER FROZEN	201400028	2017-12-01 11:29:41.906425+08	f
327	Product Edit	 Patrick Chavez edited CAKE TOPPER CHARACTER CARS	201400028	2017-12-01 11:29:45.536395+08	f
328	Product Edit	 Patrick Chavez edited BALLER ADIDAS	201400028	2017-12-01 11:29:50.822862+08	f
329	Product Edit	 Patrick Chavez edited CAKE TOPPER CHARACTER MINE CRAFT	201400028	2017-12-01 11:29:55.375911+08	f
330	Product Edit	 Patrick Chavez edited BALLER MAIDEN	201400028	2017-12-01 11:30:14.60332+08	f
331	Product Edit	 Patrick Chavez edited CAKE TOPPER CHARACTER PRINCESS	201400028	2017-12-01 11:30:22.880045+08	f
332	Product Edit	 Patrick Chavez edited CROWN QUEEN SILVER AND SILVER	201400028	2017-12-01 11:30:28.092141+08	f
333	Product Edit	 Patrick Chavez edited CAKE TOPPER CHARACTER FROZEN	201400028	2017-12-01 11:30:31.823416+08	f
334	Product Edit	 Patrick Chavez edited CROWN KING SILVER AND GOLD	201400028	2017-12-01 11:30:37.019091+08	f
335	Product Edit	 Patrick Chavez edited CAKE TOPPER CHARACTER SPIDERMAN	201400028	2017-12-01 11:30:40.912499+08	f
336	Product Edit	 Patrick Chavez edited CAKE TOPPER CHARACTER SOPHIA	201400028	2017-12-01 11:33:45.323693+08	f
337	Product Edit	 Patrick Chavez edited PALAYOK	201400028	2017-12-01 11:33:48.86912+08	f
338	Product Edit	 Patrick Chavez edited PABITIN	201400028	2017-12-01 11:33:53.653099+08	f
339	Product Edit	 Patrick Chavez edited PARTY POPPER X LARGE	201400028	2017-12-01 11:33:57.803159+08	f
340	Product Edit	 Patrick Chavez edited PARTY POPPER LARGE	201400028	2017-12-01 11:34:01.639169+08	f
341	Product Edit	 Patrick Chavez edited PARTY HAT MOANA	201400028	2017-12-01 11:34:10.433551+08	f
342	Product Edit	 Patrick Chavez edited PARTY HAT BASKETBALL	201400028	2017-12-01 11:34:17.199732+08	f
343	Product Edit	 Patrick Chavez edited PARTY POPPER MEDIUM	201400028	2017-12-01 11:34:24.079194+08	f
344	Product Edit	 Patrick Chavez edited PARTY HAT SPIDERMAN	201400028	2017-12-01 11:34:28.473801+08	f
345	Product Edit	 Patrick Chavez edited PARTY POPPER SMALL	201400028	2017-12-01 11:34:35.935109+08	f
346	Product Edit	 Patrick Chavez edited PARTY HAT CARS	201400028	2017-12-01 11:34:49.701781+08	f
347	Product Edit	 Patrick Chavez edited PARTY HAT SUPERMAN	201400028	2017-12-01 11:34:53.505964+08	f
348	Product Edit	 Patrick Chavez edited PARTY HAT TOY STORY	201400028	2017-12-01 11:34:56.948275+08	f
349	Product Edit	 Patrick Chavez edited PARTY HAT TINKERBELL	201400028	2017-12-01 11:35:00.766183+08	f
350	Product Edit	 Patrick Chavez edited PARTY HAT C.O.C	201400028	2017-12-01 11:35:10.139688+08	f
351	Product Edit	 Patrick Chavez edited PARTY HAT POOH	201400028	2017-12-01 11:35:19.298533+08	f
352	Product Edit	 Patrick Chavez edited PARTY HAT POKEMON	201400028	2017-12-01 11:35:23.27969+08	f
353	Product Edit	 Patrick Chavez edited PLAIN ITS A GIRL	201400028	2017-12-01 11:35:27.072127+08	f
354	Product Edit	 Patrick Chavez edited PARTY HAT HELLO KITTY	201400028	2017-12-01 11:35:30.489194+08	f
355	Product Edit	 Patrick Chavez edited PLAIN ITS A BOY	201400028	2017-12-01 11:35:34.439126+08	f
356	Product Edit	 Patrick Chavez edited PARTY HAT BARBIE	201400028	2017-12-01 11:35:44.8319+08	f
357	Product Edit	 Patrick Chavez edited PLAIN YELLOW GOLD	201400028	2017-12-01 11:36:01.488217+08	f
358	Product Edit	 Patrick Chavez edited PARTY HAT PRINCESS	201400028	2017-12-01 11:36:05.976284+08	f
359	Product Edit	 Patrick Chavez edited PLAIN FUCHSIA PINK	201400028	2017-12-01 11:36:10.16941+08	f
360	Product Edit	 Patrick Chavez edited PARTY HAT MINECRAFT	201400028	2017-12-01 11:36:14.60319+08	f
361	Product Edit	 Patrick Chavez edited PLAIN RED	201400028	2017-12-01 11:36:20.416133+08	f
362	Product Edit	 Patrick Chavez edited PARTY HAT PEPPAPIG	201400028	2017-12-01 11:36:27.720373+08	f
363	Product Edit	 Patrick Chavez edited PLAIN LIGHT PINK	201400028	2017-12-01 11:36:32.308784+08	f
364	Product Edit	 Patrick Chavez edited PARTY HAT MICKEY MOUSE	201400028	2017-12-01 11:36:36.52186+08	f
365	Product Edit	 Patrick Chavez edited PLAIN YELLOW	201400028	2017-12-01 11:36:41.322373+08	f
366	Product Edit	 Patrick Chavez edited PARTY HAT MINNIE MOUSE	201400028	2017-12-01 11:36:57.725012+08	f
367	Product Edit	 Patrick Chavez edited PLAIN WHITE	201400028	2017-12-01 11:37:01.582857+08	f
368	Product Edit	 Patrick Chavez edited PARTY HAT SOPHIA	201400028	2017-12-01 11:37:05.33036+08	f
369	Product Edit	 Patrick Chavez edited PARTY HAT FROZEN	201400028	2017-12-01 11:37:09.776277+08	f
370	Product Edit	 Patrick Chavez edited CURLING RIBBON	201400028	2017-12-01 11:37:25.134359+08	f
371	Product Edit	 Patrick Chavez edited CEL HAT PINK HBD	201400028	2017-12-01 11:37:30.353767+08	f
372	Product Edit	 Patrick Chavez edited CEL HAT PINK PRINCESS	201400028	2017-12-01 11:37:34.710786+08	f
373	Product Edit	 Patrick Chavez edited CEL HAT PINK PRINCESS	201400028	2017-12-01 11:37:43.61016+08	f
374	Product Edit	 Patrick Chavez edited CEL HAT PINK W/ DOT	201400028	2017-12-01 11:37:49.074702+08	f
375	Product Edit	 Patrick Chavez edited CEL HAT VIOLET W/ STAR	201400028	2017-12-01 11:37:55.155902+08	f
376	Product Edit	 Patrick Chavez edited CEL HAT STRIPE W/ RED BALLS	201400028	2017-12-01 11:38:08.363681+08	f
377	Product Edit	 Patrick Chavez edited CEL HAT BLUE W/ STAR	201400028	2017-12-01 11:38:13.824489+08	f
378	Product Edit	 Patrick Chavez edited HBD BANNER SOFIA	201400028	2017-12-01 11:38:19.325336+08	f
379	Product Edit	 Patrick Chavez edited POLKA DOT PARTY HAT PINK & WHITE	201400028	2017-12-01 11:38:24.956064+08	f
380	Product Edit	 Patrick Chavez edited HBD BANNER MINIE MOUSE	201400028	2017-12-01 11:38:30.881911+08	f
381	Product Edit	 Patrick Chavez edited HBD BANNER TINKER BELL	201400028	2017-12-01 11:38:35.491544+08	f
382	Product Edit	 Patrick Chavez edited POLKA DOT PARTY HAT BLUE & WHITE	201400028	2017-12-01 11:38:39.017246+08	f
383	Product Edit	 Patrick Chavez edited HBD BANNER BARBIE	201400028	2017-12-01 11:38:43.753024+08	f
384	Product Edit	 Patrick Chavez edited HBD BANNER HAPPY B DAY	201400028	2017-12-01 11:38:49.103742+08	f
385	Product Edit	 Patrick Chavez edited HBD BANNER DORA	201400028	2017-12-01 11:39:14.199015+08	f
386	Product Edit	 Patrick Chavez edited POLKA DOT PARTY HAT RED & WHITE	201400028	2017-12-01 11:39:22.396242+08	f
387	Product Edit	 Patrick Chavez edited HBD BANNER FROZEN	201400028	2017-12-01 11:39:26.654217+08	f
388	Product Edit	 Patrick Chavez edited HBD BANNER HELLO KITTY	201400028	2017-12-01 11:39:30.45605+08	f
389	Product Edit	 Patrick Chavez edited PARTY HAT POWER RANGERS	201400028	2017-12-01 11:39:36.532461+08	f
390	Product Edit	 Patrick Chavez edited HBD BANNER PRINCESS	201400028	2017-12-01 11:39:41.877133+08	f
391	Product Edit	 Patrick Chavez edited PARTY HAT BEN-10	201400028	2017-12-01 11:39:46.382592+08	f
392	Product Edit	 Patrick Chavez edited PARTY HAT  BATMAN	201400028	2017-12-01 11:39:49.712369+08	f
393	Product Edit	 Patrick Chavez edited PARTY HAT MINIONS	201400028	2017-12-01 11:39:54.743864+08	f
394	Product Edit	 Patrick Chavez edited KIDDIE MUG KIDDIE MUG TWO SIDES PRINT	201400028	2017-12-01 11:40:01.5698+08	f
395	Product Edit	 Patrick Chavez edited KIDDIE MUG KIDDIE MUG ONE SIDE PRINT	201400028	2017-12-01 11:40:05.123582+08	f
396	Product Edit	 Patrick Chavez edited GOLD MUG GOLD MUG TWO SIDES PRINT	201400028	2017-12-01 11:40:16.462236+08	f
397	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER PAW PATROL	201400028	2017-12-01 11:40:21.195196+08	f
398	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER PIKACHU	201400028	2017-12-01 11:41:16.126318+08	f
399	Product Edit	 Patrick Chavez edited GOLD MUG GOLD MUG ONE SIDE PRINT	201400028	2017-12-01 11:41:26.087772+08	f
400	Product Edit	 Patrick Chavez edited GOLD MUG GOLD MUG ONLY	201400028	2017-12-01 11:41:37.653884+08	f
401	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER BUTTERFLY	201400028	2017-12-01 11:41:45.148846+08	f
402	Product Edit	 Patrick Chavez edited SILVER MUG SILVER MUG TWO SIDES PRINT	201400028	2017-12-01 11:41:53.137357+08	f
403	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER UNICORN (BLUE)	201400028	2017-12-01 11:41:58.655155+08	f
404	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER AIRPLANE	201400028	2017-12-01 11:44:16.252132+08	f
405	Product Edit	 Patrick Chavez edited SILVER MUG SILVER MUG ONE SIDE PRINT	201400028	2017-12-01 11:44:21.73178+08	f
406	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER PONY	201400028	2017-12-01 11:45:54.513243+08	f
407	Product Edit	 Patrick Chavez edited SILVER MUG SILVER MUG ONLY	201400028	2017-12-01 11:45:59.439769+08	f
408	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER COW	201400028	2017-12-01 11:46:03.585002+08	f
409	Product Edit	 Patrick Chavez edited MAGIC MUG BLUE MAGIC MUG TWO SIDES PRINT	201400028	2017-12-01 11:46:07.536324+08	f
410	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER TIGER	201400028	2017-12-01 11:46:12.611794+08	f
411	Product Edit	 Patrick Chavez edited MAGIC MUG BLUE MAGIC MUG ONE SIDE PRINT	201400028	2017-12-01 11:46:18.519534+08	f
412	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER ZEBRA	201400028	2017-12-01 11:46:22.626703+08	f
413	Product Edit	 Patrick Chavez edited MAGIC MUG BLACK MAGIC MUG TWO SIDES PRINT	201400028	2017-12-01 11:46:29.029504+08	f
414	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER GIRAFFE	201400028	2017-12-01 11:46:32.862915+08	f
415	Product Edit	 Patrick Chavez edited MAGIC MUG BLACK MAGIC MUG ONE SIDE PRINT	201400028	2017-12-01 11:46:38.222495+08	f
416	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER ROASTER	201400028	2017-12-01 11:46:48.647251+08	f
417	Product Edit	 Patrick Chavez edited MAGIC MUG RED MAGIC MUG TWO SIDES PRINT	201400028	2017-12-01 11:46:53.344143+08	f
418	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER EAGLE	201400028	2017-12-01 11:46:58.213399+08	f
419	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER UNICORN (WHITE)	201400028	2017-12-01 11:47:02.632641+08	f
420	Product Edit	 Patrick Chavez edited MAGIC MUG RED MAGIC MUG ONE SIDE PRINT	201400028	2017-12-01 11:48:13.074337+08	f
421	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER SOPHIA	201400028	2017-12-01 11:48:22.493697+08	f
422	Product Edit	 Patrick Chavez edited MAGIC MUG MAGIC MUG ONLY	201400028	2017-12-01 11:48:27.357861+08	f
423	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER HELLO KITTY (BIG)	201400028	2017-12-01 11:48:30.999802+08	f
424	Product Edit	 Patrick Chavez edited WHITE MUG WHITE MUGA	201400028	2017-12-01 11:48:36.392799+08	f
425	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER HELLO KITTY (SMALL)	201400028	2017-12-01 11:48:40.786843+08	f
426	Product Edit	 Patrick Chavez edited WHITE MUG WHITE MUG ONE SIDE PRINT	201400028	2017-12-01 11:48:48.760985+08	f
427	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER TANGLED	201400028	2017-12-01 11:48:52.436338+08	f
428	Product Edit	 Patrick Chavez edited WHITE MUG WHITE MUG ONLY	201400028	2017-12-01 11:48:55.951594+08	f
429	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER TROLLZ	201400028	2017-12-01 11:49:00.414747+08	f
430	Product Edit	 Patrick Chavez edited MATTE CALLING CARD PAPER WALLET SIZE 220 GSM	201400028	2017-12-01 11:49:05.952238+08	f
431	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER FROZEN	201400028	2017-12-01 11:49:10.737317+08	f
432	Product Edit	 Patrick Chavez edited MATTE CALLING CARD PAPER 3R SIZE 220 GSM	201400028	2017-12-01 11:49:19.618489+08	f
433	Product Edit	 Patrick Chavez edited MATTE CALLING CARD PAPER 4R SIZE 220 GSM	201400028	2017-12-01 11:49:23.3313+08	f
434	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER 1ST BDAY GIRL	201400028	2017-12-01 11:49:27.625054+08	f
435	Product Edit	 Patrick Chavez edited MATTE CALLING CARD PAPER 5R SIZE 220 GSM	201400028	2017-12-01 11:49:32.115101+08	f
436	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER 1ST BDAY BOY (BLUE)	201400028	2017-12-01 11:49:40.204277+08	f
437	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER MINIONS ASS	201400028	2017-12-01 11:49:50.088758+08	f
438	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER BASKETBALL	201400028	2017-12-01 11:49:54.579778+08	f
439	Product Edit	 Patrick Chavez edited MATTE CALLING CARD PAPER 8R SIZE 220 GSM	201400028	2017-12-01 11:49:58.296936+08	f
440	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER INSIDE & OUT	201400028	2017-12-01 11:50:04.388502+08	f
441	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER BUZZ LIGHTNING	201400028	2017-12-01 11:50:08.493068+08	f
442	Product Edit	 Patrick Chavez edited MATTE CALLING CARD PAPER A4 220 68M	201400028	2017-12-01 11:50:13.735458+08	f
443	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER POKEMON	201400028	2017-12-01 11:50:18.697308+08	f
444	Product Edit	 Patrick Chavez edited PHOTOPAPER PRINT 24X36	201400028	2017-12-01 11:50:24.154442+08	f
445	Product Edit	 Patrick Chavez edited PHOTOPAPER PRINT 20X30	201400028	2017-12-01 11:50:27.630554+08	f
446	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER BAYMAX (WHITE)	201400028	2017-12-01 11:50:38.322465+08	f
447	Product Edit	 Patrick Chavez edited PHOTOPAPER PRINT 16X20	201400028	2017-12-01 11:50:42.941181+08	f
448	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER BATMAN	201400028	2017-12-01 11:50:46.77835+08	f
449	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER MINNIE MOUSE	201400028	2017-12-01 11:50:50.368549+08	f
450	Product Edit	 Patrick Chavez edited PHOTOPAPER PRINT CUTIE SIZE	201400028	2017-12-01 11:50:55.355848+08	f
451	Product Edit	 Patrick Chavez edited PHOTOPAPER PRINT A3	201400028	2017-12-01 11:51:00.538456+08	f
452	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER MICKEY MOUSE	201400028	2017-12-01 11:51:05.349631+08	f
453	Product Edit	 Patrick Chavez edited PHOTOPAPER PRINT WALLET SIZE	201400028	2017-12-01 11:51:12.204933+08	f
454	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER BAYMAX (RED)	201400028	2017-12-01 11:51:19.572016+08	f
455	Product Edit	 Patrick Chavez edited PHOTOPAPER PRINT 3R	201400028	2017-12-01 11:51:23.425577+08	f
456	Product Edit	 Patrick Chavez edited TOOTHPICK W/ LINING PRINCESS	201400028	2017-12-01 11:51:48.026806+08	f
457	Product Edit	 Patrick Chavez edited TOOTHPICK W/ LINING PRINCESS	201400028	2017-12-01 11:55:50.967437+08	f
458	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER OLAF	201400028	2017-12-01 12:01:32.913267+08	f
459	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER CARS	201400028	2017-12-01 12:01:47.836014+08	f
460	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER SPIDERMAN	201400028	2017-12-01 12:02:00.381268+08	f
461	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER AVENGER	201400028	2017-12-01 12:02:13.555762+08	f
462	Product Edit	 Patrick Chavez edited MYLAR BALLOON CHARACTER MINE CRAFT	201400028	2017-12-01 12:02:23.070209+08	f
463	Product Edit	 Patrick Chavez edited PHOTOPAPER A4 SIZE 230 68M PER PACK 20 SHEETS	201400028	2017-12-01 12:03:01.244616+08	f
464	Product Edit	 Patrick Chavez edited PHOTOPAPER PRINT A4 SIZE 230 68M	201400028	2017-12-01 12:03:32.156424+08	f
465	Product Edit	 Patrick Chavez edited PHOTOPAPER PRINT 5R	201400028	2017-12-01 12:03:47.273796+08	f
466	Product Edit	 Patrick Chavez edited PHOTOPAPER PRINT 4R	201400028	2017-12-01 12:03:55.40754+08	f
467	Product Edit	 Patrick Chavez edited HBD BUNTINGS GOLD W/ GLITTERS	201400028	2017-12-01 12:04:08.702402+08	f
468	Product Edit	 Patrick Chavez edited TOOTHPICK W/ LINING PRINCESS	201400028	2017-12-01 12:04:35.527508+08	f
469	Product Edit	 R-Wayne Lipardo edited TOOTHPICK W/ LINING PRINCESS	2014000100	2017-12-02 11:00:36.652567+08	f
470	Product Edit	 R-Wayne Lipardo edited TOOTHPICK W/ LINING PRINCESS	2014000100	2017-12-02 11:11:17.662524+08	f
471	Product Edit	 R-Wayne Lipardo edited TOOTHPICK W/ LINING PRINCESS	2014000100	2017-12-02 13:28:12.316457+08	f
472	Product Edit	 R-Wayne Lipardo edited TOOTHPICK W/ LINING PRINCESS	2014000100	2017-12-02 13:28:32.223342+08	f
473	Product Edit	 R-Wayne Lipardo edited TOOTHPICK W/ LINING PRINCESS	2014000100	2017-12-02 13:29:48.492472+08	f
474	Product Edit	 Shereen Serdena edited TOOTHPICK W/ LINING PRINCESS	201700153	2017-12-05 22:35:46.927187+08	f
475	Product Edit	 Shereen Serdena edited TOOTHPICK W/ LINING PRINCESS	201700153	2017-12-05 22:38:25.187964+08	f
476	Tender	 Shereen Serdena tendered an item	201700153	2017-12-05 22:38:44.712854+08	f
477	Product Edit	 Shereen Serdena edited TOOTHPICK W/ LINING PRINCESS	201700153	2017-12-06 14:30:08.674908+08	f
478	Tender	 R-Wayne Lipardo tendered an item	2014000100	2017-12-06 15:51:50.805667+08	f
479	Product Edit	 R-Wayne Lipardo edited Sample	2014000100	2017-12-06 16:04:57.654873+08	f
\.


--
-- Name: history_log_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('history_log_data_pk_seq', 479, true);


--
-- Data for Name: product_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY product_data (pk, product_name, product_bar_code, product_stocks, product_srp, product_price, product_supplier, date_created, archived, product_receipt_name, product_status, product_or_number, product_or_stocks, product_product_code, product_rules, product_kind, request_order_status, product_expiration, product_branches, product_image, product_size_name, product_size_value, input_vat, output_vat, selling_price) FROM stdin;
715	TOOTHPICK W/ LINING PRINCESS	00733	0	0	0	N/A	2017-11-30 17:02:54.467916+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
716	Sample	000000	10	00	00	N/A	2017-12-06 15:37:08.526356+08	f	00	(NEW)	00	00	00	No Rule	Nonfood	\N	Dec 6, 2017	Starmall	undefined	\N	\N	0	0	0
309	BALLOON HEART FUCHSIA PINK	00431	0	0	0	N/A	2017-11-30 11:26:30.126198+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
310	BALLOON HEART I LOVE YOU	00432	0	0	0	N/A	2017-11-30 11:27:06.085653+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
324	MYLAR 1 ONE BLUE	00439	0	0	0	N/A	2017-11-30 11:34:27.938687+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
311	BALLOON I DO MINT GREEN	00433	0	0	0	N/A	2017-11-30 11:27:46.894982+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
272	BANDERITAS W/ CHARACTERS FROZEN	00268	0	0	0	N/A	2017-11-30 11:03:50.137017+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
273	BANDERITAS W/ CHARACTERS SOFIA	00269	0	0	0	N/A	2017-11-30 11:05:09.442649+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
274	RAGING FLAG RED AND WHITE	00284	0	0	0	N/A	2017-11-30 11:05:15.794124+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
275	BANDERITAS W/ CHARACTERS PRINCESS	00270	0	0	0	N/A	2017-11-30 11:05:44.644716+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
276	BIG DOT BLACK AND WHITE	00285	0	0	0	N/A	2017-11-30 11:06:13.231838+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
278	BIG DOT RED AND WHITE	00286	0	0	0	N/A	2017-11-30 11:06:54.710911+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
379	MYLAR BALLOON CHARACTER BUZZ LIGHTNING	00330	0	0	0	N/A	2017-11-30 12:02:35.36725+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
398	MYLAR BALLOON CHARACTER HELLO KITTY (BIG)	00354	0	0	0	N/A	2017-11-30 13:05:32.686799+08	f	0	(OLD)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
360	MYLAR BALLOON CHARACTER AVENGER	00320	0	0	0	N/A	2017-11-30 11:56:49.337551+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
338	ALCOHOL BOTH WINE	00410	0	0	0	N/A	2017-11-30 11:40:37.74073+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
277	LOOT BAG PAPER SPIDERMAN	00271	0	0	0	N/A	2017-11-30 11:06:29.630033+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
581	PARTY PAPER CUP CLASSIC COLOR & DESIGN	00556	0	0	0	N/A	2017-11-30 14:21:47.454167+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
312	SMILEY FOIL BALLOON RED	00418	0	0	0	N/A	2017-11-30 11:28:23.203346+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
279	SMALL DOT RED AND WHITE	00287	0	0	0	N/A	2017-11-30 11:07:27.837883+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
280	LOOT BAG PAPER CARS	00272	0	0	0	N/A	2017-11-30 11:08:52.845202+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
281	LOOT BAG PAPER HELLO KITTY	00273	0	0	0	N/A	2017-11-30 11:09:40.819361+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
282	LOOT BAG PAPER SOFIA	00274	0	0	0	N/A	2017-11-30 11:12:07.108437+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
283	SMALL DOT BLACK AND WHITE	00289	0	0	0	N/A	2017-11-30 11:12:09.97188+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
284	LOOT BAG PAPER PRINCESS	00275	0	0	0	N/A	2017-11-30 11:12:44.726581+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
285	SMALL DOT PINK AND WHITE	00290	0	0	0	N/A	2017-11-30 11:12:53.374373+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
286	LOOT BAG PAPER MINNIE MOUSE	00276	0	0	0	N/A	2017-11-30 11:13:25.151354+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
287	SMALL DOT VIOLET AND WHITE	00291	0	0	0	N/A	2017-11-30 11:13:32.481049+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
288	LOOT BAG PAPER MICKEY MOUSE	00277	0	0	0	N/A	2017-11-30 11:13:59.594789+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
289	LOOT BAG PAPER PEPPAPIG	00278	0	0	0	N/A	2017-11-30 11:14:33.337928+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
326	FLOWER W/ GOLD CENTER RED	00426	0	0	0	N/A	2017-11-30 11:35:48.625836+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
340	LOOTBAG PAPER PINK W/ DOT	00303	0	0	0	N/A	2017-11-30 11:42:34.153962+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
290	LOOT BAG PAPER FROZEN	00279	0	0	0	N/A	2017-11-30 11:15:08.660521+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
291	W/ CHARACTERS MINIONS	00293	0	0	0	N/A	2017-11-30 11:15:43.245588+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
292	W/ CHARACTERS BEN 10	00294	0	0	0	N/A	2017-11-30 11:16:26.087703+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
293	W/ CHARACTERS SPONGEBOB	00295	0	0	0	N/A	2017-11-30 11:17:22.466089+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
294	W/ CHARACTERS BARBIE	00296	0	0	0	N/A	2017-11-30 11:17:58.115637+08	f	0	(NEW)	0	0	NODATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
295	LOOT BAG PAPER POKEMON	00280	0	0	0	N/A	2017-11-30 11:18:15.072222+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
296	W/ CHARACTERS SUPERMAN	00297	0	0	0	N/A	2017-11-30 11:18:30.839725+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
297	W/ CHARACTERS MINIE MOUSE	00298	0	0	0	N/A	2017-11-30 11:19:23.007892+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
298	W/ CHARACTERS MICKEY MOUSE	00299	0	0	0	N/A	2017-11-30 11:20:02.512204+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
299	MYLAR FLOWER RED	00411	0	0	0	N/A	2017-11-30 11:20:09.263986+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
300	MYLAR FLOWER BLUE	00412	0	0	0	N/A	2017-11-30 11:20:38.896769+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
301	W/ CHARACTERS BATMAN	00300	0	0	0	N/A	2017-11-30 11:20:49.36024+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
302	W/ CHARACTERS CARS	00301	0	0	0	N/A	2017-11-30 11:21:31.36734+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
303	MYLAR FLOWER FUSCHIA PINK	00413	0	0	0	N/A	2017-11-30 11:21:32.355469+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
304	CHRISTMAS FOIL RED	00414	0	0	0	N/A	2017-11-30 11:22:31.811368+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
314	SMILEY FOIL BALLOON PINK	00419	0	0	0	N/A	2017-11-30 11:28:55.608171+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
305	HEART FOIL HEART RED	00429	0	0	0	N/A	2017-11-30 11:23:38.528207+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
306	BALLOON ROUND GREEN	00415	0	0	0	N/A	2017-11-30 11:24:54.486326+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
307	BALLOON HEART WHITE	00430	0	0	0	N/A	2017-11-30 11:25:13.830207+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
308	BALLOON ROUND RED	00416	0	0	0	N/A	2017-11-30 11:25:34.443011+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
322	BALLOON FOIL TWO SILVER	00437	0	0	0	N/A	2017-11-30 11:33:06.82026+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
328	FLOWER W/ GOLD CENTER PINK	00427	0	0	0	N/A	2017-11-30 11:36:35.97601+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
342	LOOTBAG PAPER BLUE W/ DOT	00305	0	0	0	N/A	2017-11-30 11:44:02.004991+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
356	MYLAR BALLOON CHARACTER BEN 10	00318	0	0	0	N/A	2017-11-30 11:51:27.774739+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
708	TOOTHPICK TOPPER W/ CHARACTER FROZEN	00726	0	0	0	N/A	2017-11-30 16:57:45.413534+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
685	PHOTOPAPER CALLING CARD 230GSM FULL COLOR BACK TO BACK 100S	00511	0	0	0	N/A	2017-11-30 15:13:27.3402+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
673	PHOTOPAPER CALLING CARD 230GSM FULL COLOR 50S	00506	0	0	0	N/A	2017-11-30 15:07:15.387461+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
661	CUP LIGHT BLUE	00605	0	0	0	N/A	2017-11-30 15:03:20.110454+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
649	POSTER ONE DIRECTION	00495	0	0	0	N/A	2017-11-30 14:52:57.579374+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
636	PLASTIC LOOT BAG SMALL SPIDER	00483	0	0	0	N/A	2017-11-30 14:46:48.075522+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
315	SMILEY FOIL BALLOON BLUE	00420	0	0	0	N/A	2017-11-30 11:29:21.32807+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
336	MYLAR FOIL W/ WINE	00409	0	0	0	N/A	2017-11-30 11:39:46.552404+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
350	DUNOT LOOT BAG SUPERMAN	00314	0	0	0	N/A	2017-11-30 11:48:45.192074+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
501	GIFT WRAPPER CHARACTER SOPHIA	00400	0	0	0	N/A	2017-11-30 13:48:54.02273+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
487	CROWN KING SILVER AND GOLD	00666	0	0	0	N/A	2017-11-30 13:43:21.040356+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
473	PARTY HAT TOY STORY	00382	0	0	0	N/A	2017-11-30 13:36:34.810805+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
459	PARTY HAT PEPPAPIG	00373	0	0	0	N/A	2017-11-30 13:32:02.496933+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
445	CEL HAT STRIPE W/ RED BALLS	00345	0	0	0	N/A	2017-11-30 13:26:23.112521+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
431	HBD BANNER PRINCESS	00668	0	0	0	N/A	2017-11-30 13:18:57.849104+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
417	MYLAR BALLOON CHARACTER AIRPLANE	00364	0	0	0	N/A	2017-11-30 13:13:04.843445+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
399	MAGIC MUG MAGIC MUG ONLY	00690	0	0	0	N/A	2017-11-30 13:06:01.58205+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
361	MYLAR BALLOON CHARACTER SPIDERMAN	00321	0	0	0	N/A	2017-11-30 11:57:42.150698+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
352	PHOTOPAPER A4 SIZE 230 68M PER PACK 20 SHEETS	00705	0	0	0	N/A	2017-11-30 11:49:44.374967+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
325	ROUND BALLOON ONE PINK	00440	0	0	0	N/A	2017-11-30 11:35:29.051246+08	f	0	(OLD)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
705	TOOTHPICK TOPPER W/ CHARACTER MINNIE MOUSE	00383	0	0	0	N/A	2017-11-30 16:55:57.16295+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
694	HBD BUNTINGS ROYAL BLUE W/ GLITTERS	00628	0	0	0	N/A	2017-11-30 15:21:06.674251+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
317	GUITAR FOIL BALLOON RED	00422	0	0	0	N/A	2017-11-30 11:30:50.13195+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
318	MYLAR 1 ONE SILVER	00435	0	0	0	N/A	2017-11-30 11:30:51.639328+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
332	ROUND BALLOON LEAF PINK	00444	0	0	0	N/A	2017-11-30 11:38:21.692316+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
319	GUITAR FOIL BALLOON BLUE	00423	0	0	0	N/A	2017-11-30 11:31:21.758431+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
320	GUITAR FOIL BALLOON PINK & BLACK	00424	0	0	0	N/A	2017-11-30 11:32:00.607562+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
236	HBD BANNER BEN 10	00235	0	0	0	N/A	2017-11-29 17:18:06.081688+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
670	PARTY PAPER CUP MICKEY MOUSE	00611	0	0	0	N/A	2017-11-30 15:06:36.498539+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
658	QUAFF MATTE CALLING CARD PAPER CALLING CARD PRINT PLAIN PAPER/BACK TO BACK 100S	00501	0	0	0	N/A	2017-11-30 15:02:19.105934+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
646	POSTER ALDUB	00493	0	0	0	N/A	2017-11-30 14:52:01.750651+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
633	PLASTIC LOOT BAG SMALL MINECRAFT	00480	0	0	0	N/A	2017-11-30 14:45:12.58798+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
620	CURLING RIBBON POMPOMS LIGHT BLUE & DARK BLUE	00528	0	0	0	N/A	2017-11-30 14:34:50.430773+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
607	HBD FOIL SET GOLD	00473	0	0	0	N/A	2017-11-30 14:30:30.003047+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
594	PARTY LOOT BAG SMALL FROZEN	00514	0	0	0	N/A	2017-11-30 14:26:44.344193+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
549	INVITATION CARS	00567	0	0	0	N/A	2017-11-30 14:06:55.991164+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
536	PLASTIC LOOT BAG BIG MINIE MOUSE	00442	0	0	0	N/A	2017-11-30 14:00:43.558249+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
523	CAKE STAND HELLO KITTY	00581	0	0	0	N/A	2017-11-30 13:56:24.438173+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
710	TOOTHPICK TOPPER W/ CHARACTER UMBRELLA	00728	0	0	0	N/A	2017-11-30 16:58:41.828974+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
699	HBD BUNTINGS LIGHT PINK W/ GLITTERS	00633	1	100	112	N/A	2017-11-30 15:23:06.715836+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
688	HBD LETTER BIG GREEN W/ GOLD PRINT	00622	0	0	0	N/A	2017-11-30 15:16:00.442619+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
676	PHOTOPAPER CALLING CARD 230GSM FULL COLOR 100S	00507	0	0	0	N/A	2017-11-30 15:07:58.844879+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
664	QUAFF MATTE CALLING CARD PAPER CALLING CARD PRINT FULL COLOR BACK TO BACK 100S	00503	0	0	0	N/A	2017-11-30 15:03:49.854178+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
652	QUAFF MATTE CALLING CARD PAPER CALLING CARD PRINT FULL COLOR 50S	00498	0	0	0	N/A	2017-11-30 14:58:46.897484+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
640	PLASTIC LOOT BAG SMALL BATMAN	00487	0	0	0	N/A	2017-11-30 14:48:57.299851+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
334	ROUND BALLOON LEAF GOLD	00445	0	0	0	N/A	2017-11-30 11:38:52.142847+08	f	0	(OLD)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
711	TOOTHPICK W/ LINING FROZEN	00729	0	0	0	N/A	2017-11-30 17:00:05.091934+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
700	TOOTHPICK TOPPER W/ CHARACTER MINIONS	00408	0	0	0	N/A	2017-11-30 16:53:11.767572+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
689	HBD LETTER BIG ASST W/ GOLD PRINT	00623	0	0	0	N/A	2017-11-30 15:16:51.973183+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
686	HBD LETTER BIG WHITE W/ GOLD PRINT	00620	0	0	0	N/A	2017-11-30 15:13:52.223667+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
677	PARTY CURTAIN RED	00615	0	0	0	N/A	2017-11-30 15:08:15.975552+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
665	LINING RED	00607	0	0	0	N/A	2017-11-30 15:04:06.817414+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
653	QUAFF MATTE CALLING CARD PAPER CALLING CARD PRINT FULL COLOR 100S	00499	0	0	0	N/A	2017-11-30 14:59:37.53246+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
323	BALLOON FOIL TWO GOLD	00438	0	0	0	N/A	2017-11-30 11:33:48.171542+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
416	SILVER MUG SILVER MUG ONE SIDE PRINT	00698	0	0	0	N/A	2017-11-30 13:13:04.361222+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
351	DUNOT LOOT BAG SPIDERMAN	00315	0	0	0	N/A	2017-11-30 11:49:18.261553+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
239	KIDDIE MUG TINY ONE SIDE PRINT	00239	0	0	0	N/A	2017-11-29 17:38:59.894935+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
240	TOOTHPICK POPPER W/ CHARACTER MINIONS	00240	0	0	0	N/A	2017-11-30 09:47:49.946525+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
255	PLASTIC LOOTBAG BIG MICKEY MOUSE	00254	0	0	0	N/A	2017-11-30 10:29:49.428577+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
258	PLASTIC LOOTBAG BIG POLKA GREEN	00257	0	0	0	N/A	2017-11-30 10:32:37.365618+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
259	PLASTIC LOOTBAG BIG POLKA BLUE	00258	0	0	0	N/A	2017-11-30 10:33:20.444216+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
260	PLASTIC LOOTBAG BIG POLKA YELLOW	00259	0	0	0	N/A	2017-11-30 10:34:27.077395+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
261	PLASTIC LOOTBAG STRIPE WHITE/BLK	00260	0	0	0	N/A	2017-11-30 10:35:20.836017+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
262	PLASTIC LOOTBAG BIG BLACK	00261	0	0	0	N/A	2017-11-30 10:36:07.569758+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
263	BANDERITAS W/ CHARACTERS SPIDERMAN	00262	0	0	0	N/A	2017-11-30 10:37:40.119886+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
264	BANDERITAS W/ CHARACTERS PEPPAPIG	00263	0	0	0	N/A	2017-11-30 10:38:22.407186+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
265	BANDERITAS W/ CHARACTERS HELLO KITTY	00264	0	0	0	N/A	2017-11-30 10:40:03.99147+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
267	BANDIRITAS ASSORTED	00281	0	0	0	N/A	2017-11-30 11:00:32.823065+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
266	BANDERITAS W/ CHARACTERS ANGRY BIRD	00265	0	0	0	undefined	2017-11-30 10:58:55.675287+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
712	TOOTHPICK W/ LINING HAPPY B-DAY W/ DOT PINK/BLUE	00730	0	0	0	N/A	2017-11-30 17:00:48.847521+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
701	TOOTHPICK TOPPER W/ CHARACTER LITTLE PONY	00288	0	0	0	N/A	2017-11-30 16:53:45.592717+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
690	HBD LETTER SMALL LIGHT BLUE W/ GOLD PRINT	00624	0	0	0	N/A	2017-11-30 15:18:14.20397+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
678	PARTY CURTAIN GOLD	00616	0	0	0	N/A	2017-11-30 15:08:38.475088+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
666	PARTY PAPER CUP HELLO KITTY BARBIE	00608	0	0	0	N/A	2017-11-30 15:05:08.440617+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
654	PAPER STRAW BLUE	00600	0	0	0	N/A	2017-11-30 15:00:54.670149+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
512	ID LACE TRIBAL	00644	0	0	0	N/A	2017-11-30 13:52:21.99397+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
257	PLASTIC LOOTBAG BIG POLKA RED	00256	0	0	0	N/A	2017-11-30 10:31:56.579875+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
268	BANDERITAS PINK	00282	0	0	0	N/A	2017-11-30 11:01:21.59764+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
269	BANDERITAS W/ CHARACTERS 1ST A GIRL	00266	0	0	0	N/A	2017-11-30 11:02:19.965549+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
241	TOOTHPICK POPPER W/ CHARACTER LITTLE PONNY	00241	0	0	0	N/A	2017-11-30 09:48:58.421609+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
270	BANDERITAS W/ CHARACTERS GRADUATION DESIGN	00267	0	0	0	N/A	2017-11-30 11:03:04.218632+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
242	TOOTHPICK POPPER W/ CHARACTER CANS	00242	0	0	0	N/A	2017-11-30 09:53:03.637348+08	f	0	(OLD)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
243	PLASTIC LOOTBAG BIG SPIDERMAN	00243	0	0	0	N/A	2017-11-30 10:11:11.893233+08	f	0	(OLD)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
244	PLASTIC LOOTBAG BIG SUPERMAN	00244	0	0	0	N/A	2017-11-30 10:12:05.81445+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
246	PLASTIC LOOTBAG BIG CLASH OF CLANS	00245	0	0	0	N/A	2017-11-30 10:15:59.086246+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
498	BALLER HELLO KITTY	00636	0	0	0	N/A	2017-11-30 13:48:19.681764+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
713	TOOTHPICK W/ LINING BEN-10	00731	0	0	0	N/A	2017-11-30 17:01:19.606406+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
702	TOOTHPICK TOPPER W/ CHARACTER CARS	00417	0	0	0	N/A	2017-11-30 16:54:10.222723+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
691	HBD LETTER SMALL PINK W/ GOLD PRINT	00625	0	0	0	N/A	2017-11-30 15:18:45.237362+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
679	PARTY CURTAIN SILVER	00617	0	0	0	N/A	2017-11-30 15:09:04.403214+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
667	PARTY PAPER CUP FROZEN	00609	0	0	0	N/A	2017-11-30 15:05:37.488268+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
655	PAPER STRAW FUCHSIA PINK	00601	0	0	0	N/A	2017-11-30 15:01:36.748922+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
643	POSTER BTS	00490	0	0	0	N/A	2017-11-30 14:50:37.329102+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
247	PLASTIC LOOTBAG BIG BEN-10	00246	0	0	0	N/A	2017-11-30 10:19:56.410403+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
248	PLASTIC LOOTBAG BIG AVENGERS	00247	0	0	0	N/A	2017-11-30 10:21:59.341486+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
249	PLASTIC LOOTBAG BIG BATMAN	00248	0	0	0	N/A	2017-11-30 10:22:59.938487+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
250	PLASTIC LOOTBAG BIG SAFARRI	00249	0	0	0	N/A	2017-11-30 10:23:51.749218+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
251	PLASTIC LOOTBAG BIG SPONGEBOB	00250	0	0	0	N/A	2017-11-30 10:24:38.359703+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
252	PLASTIC LOOTBAG BIG MINIONS	00251	0	0	0	N/A	2017-11-30 10:25:19.905731+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
253	PLASTIC LOOTBAG BIG TOY STORY	00252	0	0	0	N/A	2017-11-30 10:27:06.087979+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
254	PLASTIC LOOTBAG BIG POKEMON	00253	0	0	0	N/A	2017-11-30 10:28:40.030746+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
540	INVITATION BATMAN	00562	0	0	0	N/A	2017-11-30 14:03:49.276166+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
527	WOODEN CLIP BLUE	00583	0	0	0	N/A	2017-11-30 13:57:31.795073+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
714	TOOTHPICK W/ LINING SPIDER	00732	0	0	0	N/A	2017-11-30 17:02:11.855702+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
703	TOOTHPICK TOPPER W/ CHARACTER SPIDER	00425	0	0	0	N/A	2017-11-30 16:54:40.625351+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
692	HBD LETTER SMALL BLACK W/ GOLD PRINT	00626	0	0	0	N/A	2017-11-30 15:19:14.325641+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
680	PHOTOPAPER CALLING CARD 230GSM PLAIN PAPER/BACK TO BACK 50S	00508	0	0	0	N/A	2017-11-30 15:10:12.943516+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
668	PARTY PAPER CUP SOPHIA THE FIRST	00610	0	0	0	N/A	2017-11-30 15:06:05.640219+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
656	QUAFF MATTE CALLING CARD PAPER CALLING CARD PRINT PLAIN PAPER/BACK TO BACK 50S	00500	0	0	0	N/A	2017-11-30 15:01:56.257479+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
644	POSTER EXO	00491	0	0	0	N/A	2017-11-30 14:51:04.431293+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
271	RAGING FLAG BLACK AND WHITE	00283	0	0	0	N/A	2017-11-30 11:03:16.011322+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
428	PARTY HAT MINIONS	00336	0	0	0	N/A	2017-11-30 13:16:41.017359+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
415	MYLAR BALLOON CHARACTER PONY	00363	0	0	0	N/A	2017-11-30 13:12:26.880709+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
413	MYLAR BALLOON CHARACTER COW	00362	0	0	0	N/A	2017-11-30 13:11:49.327005+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
395	WHITE MUG WHITE MUG ONE SIDE PRINT	00688	0	0	0	N/A	2017-11-30 13:04:32.497361+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
380	MATTE CALLING CARD PAPER A4 220 68M	00719	0	0	0	N/A	2017-11-30 12:03:13.621928+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
376	PHOTOPAPER PRINT 20X30	00717	0	0	0	N/A	2017-11-30 12:01:56.761937+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
618	CURLING RIBBON POMPOMS LIGHT PINK & FUSCHIA PINK	00527	0	0	0	N/A	2017-11-30 14:34:17.800956+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
605	HBD FOIL SET SILVER	00472	0	0	0	N/A	2017-11-30 14:29:54.380717+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
592	ITS A GIRL BLUE LETTER	00464	0	0	0	N/A	2017-11-30 14:26:18.250634+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
579	PARTY PAPER CUP BAYMAX	00555	0	0	0	N/A	2017-11-30 14:21:11.605386+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
566	CUP LIGHT BLUE	00548	0	0	0	N/A	2017-11-30 14:16:38.9101+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
553	INVITATION PEPPAPIG	00569	0	0	0	N/A	2017-11-30 14:08:01.717685+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
499	GIFT WRAPPER CHARACTER SPIDERMAN	00399	0	0	0	N/A	2017-11-30 13:48:27.053039+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
485	CAKE TOPPER CHARACTER SOPHIA	00389	0	0	0	N/A	2017-11-30 13:41:45.753243+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
471	PARTY HAT C.O.C	00380	0	0	0	N/A	2017-11-30 13:35:32.92897+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
457	PARTY HAT MICKEY MOUSE	00372	0	0	0	N/A	2017-11-30 13:31:35.45944+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
443	HBD BANNER SOFIA	00676	0	0	0	N/A	2017-11-30 13:23:18.377157+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
429	PARTY HAT  BATMAN	00337	0	0	0	N/A	2017-11-30 13:17:14.558467+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
414	SILVER MUG SILVER MUG ONLY	00697	0	0	0	N/A	2017-11-30 13:12:01.8518+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
407	MYLAR BALLOON CHARACTER GIRAFFE	00359	0	0	0	N/A	2017-11-30 13:08:36.176561+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
568	PLASTIC LOOT BAG BIG SOFIA	00450	0	0	0	N/A	2017-11-30 14:17:14.584416+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
555	INVITATION POKEMON	00570	0	0	0	N/A	2017-11-30 14:08:35.219837+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
542	BALLER ELICE	00638	0	0	0	N/A	2017-11-30 14:04:33.447404+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
529	WOODEN CLIP ASSORTED	00584	0	0	0	N/A	2017-11-30 13:57:53.699099+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
516	ID LACE POKEMON	00646	0	0	0	N/A	2017-11-30 13:53:10.343654+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
502	GIFT WRAPPER CHARACTER BEN 10	00401	0	0	0	N/A	2017-11-30 13:49:20.053547+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
488	CAKE TOPPER CHARACTER FROZEN	00391	0	0	0	N/A	2017-11-30 13:43:55.350307+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
474	PARTY HAT SUPERMAN	00384	0	0	0	N/A	2017-11-30 13:37:40.358126+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
460	PLAIN RED	00682	0	0	0	N/A	2017-11-30 13:32:14.34934+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
446	CEL HAT VIOLET W/ STAR	00346	0	0	0	N/A	2017-11-30 13:26:54.585068+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
432	PARTY HAT POWER RANGERS	00340	0	0	0	N/A	2017-11-30 13:19:25.780273+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
418	MYLAR BALLOON CHARACTER UNICORN (BLUE)	00365	0	0	0	N/A	2017-11-30 13:13:36.237578+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
400	MYLAR BALLOON CHARACTER SOPHIA	00354	0	0	0	N/A	2017-11-30 13:06:06.303692+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
381	MYLAR BALLOON CHARACTER INSIDE & OUT	00331	0	0	0	N/A	2017-11-30 12:03:16.350913+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
359	PHOTOPAPER PRINT A4 SIZE 230 68M	00708	0	0	0	N/A	2017-11-30 11:55:34.539315+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
362	PHOTOPAPER PRINT 5R	00710	0	0	0	N/A	2017-11-30 11:58:06.127078+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
147	FRAME W/ LINING 12 X 16 NORMAL R.BLUE	00145	0	0	0	N/A	2017-11-29 15:34:54.640009+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
419	SILVER MUG SILVER MUG TWO SIDES PRINT	00699	0	0	0	N/A	2017-11-30 13:13:40.043539+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
706	TOOTHPICK TOPPER W/ CHARACTER HELLO KITTY	00393	0	0	0	N/A	2017-11-30 16:56:28.284161+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
595	CHRISTENING PINK	00466	0	0	0	N/A	2017-11-30 14:26:44.98266+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
695	HBD BUNTINGS BLACK W/ GLITTERS	00629	0	0	0	N/A	2017-11-30 15:21:30.327975+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
683	PHOTOPAPER CALLING CARD 230GSM FULL COLOR BACK TO BACK 50S	00510	0	0	0	N/A	2017-11-30 15:13:00.656289+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
671	PHOTOPAPER CALLING CARD 230GSM PLAIN COLOR 100S	00505	0	0	0	N/A	2017-11-30 15:06:43.712416+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
659	PAPER STRAW RED	00603	0	0	0	N/A	2017-11-30 15:02:23.559561+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
647	POSTER BIG BANG	00494	0	0	0	N/A	2017-11-30 14:52:24.55587+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
634	PLASTIC LOOT BAG SMALL MINIONS	00481	0	0	0	N/A	2017-11-30 14:45:48.707275+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
621	INVITATION MOANA	00593	0	0	0	N/A	2017-11-30 14:35:06.825345+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
608	CURLING RIBBON W/ GLITTERS YELLOW GOLD	00521	0	0	0	N/A	2017-11-30 14:30:48.190164+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
582	PARTY CURTAIN BLUE VIOLET	00557	0	0	0	N/A	2017-11-30 14:22:27.701653+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
569	POLKA DOTS LIGHT PINK	00549	0	0	0	N/A	2017-11-30 14:17:19.624828+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
556	INVITATION SPIDERMAN	00571	0	0	0	N/A	2017-11-30 14:09:03.882706+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
543	INVITATION MICKEY MIOUSE	00564	0	0	0	N/A	2017-11-30 14:04:51.571317+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
530	BTS BALLPEN PINK	00585	0	0	0	N/A	2017-11-30 13:58:35.619182+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
517	CAKE STAND RED W/ DOT	00576	0	0	0	N/A	2017-11-30 13:53:39.44404+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
503	GIFT WRAPPER CHARACTER MICKEY MOUSE	00402	0	0	0	N/A	2017-11-30 13:49:44.20058+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
489	CROWN QUEEN SILVER AND SILVER	00667	0	0	0	N/A	2017-11-30 13:44:06.887517+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
475	PARTY HAT CARS	00385	0	0	0	N/A	2017-11-30 13:38:07.019354+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
461	PARTY HAT MINECRAFT	00374	0	0	0	N/A	2017-11-30 13:32:33.261494+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
447	CEL HAT PINK W/ DOT	00347	0	0	0	N/A	2017-11-30 13:27:41.249189+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
433	HBD BANNER HELLO KITTY	00669	0	0	0	N/A	2017-11-30 13:19:39.475809+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
401	MAGIC MUG RED MAGIC MUG ONE SIDE PRINT	00691	0	0	0	N/A	2017-11-30 13:06:40.016647+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
382	MATTE CALLING CARD PAPER 8R SIZE 220 GSM	00720	0	0	0	N/A	2017-11-30 12:03:43.299215+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
363	MYLAR BALLOON CHARACTER CARS	00322	0	0	0	N/A	2017-11-30 11:58:19.460597+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
557	INVITATION SPONGEBOB	00572	0	0	0	N/A	2017-11-30 14:09:33.369143+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
341	LOOTBAG PAPER RED W/ DOT	00304	0	0	0	N/A	2017-11-30 11:43:30.2468+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
355	MYLAR BALLOON CHARACTER BAYMAX	00317	0	0	0	N/A	2017-11-30 11:50:54.890965+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
194	WOODEN CLIP T SHIRT ASSORTED	00193	0	0	0	N/A	2017-11-29 16:35:47.649784+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
327	ROUND BALLOON TWO PINK	00441	0	0	0	N/A	2017-11-30 11:36:05.873445+08	f	0	(OLD)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
707	TOOTHPICK TOPPER W/ CHARACTER SOFIA	00725	0	0	0	N/A	2017-11-30 16:57:01.696801+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
696	HBD BUNTINGS SILVER W/ GLITTERS	00630	0	0	0	N/A	2017-11-30 15:21:53.207057+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
684	HBD LETTER BIG BLACK W/ GOLD PRINT	00619	0	0	0	N/A	2017-11-30 15:13:01.455688+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
672	PARTY PAPER CUP BAYMAX	00612	0	0	0	N/A	2017-11-30 15:06:58.193079+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
660	PAPER CUPCAKE VIOLET	00604	0	0	0	N/A	2017-11-30 15:02:50.370816+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
648	PAPER STRAW TIGHT PINK	00599	0	0	0	N/A	2017-11-30 14:52:49.983885+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
635	PLASTIC LOOT BAG SMALL MICKEY MOUSE	00482	0	0	0	N/A	2017-11-30 14:46:18.934793+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
622	CURLING RIBBON POMPOMS RED & YELLOW	00529	0	0	0	N/A	2017-11-30 14:35:23.279303+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
609	HBD FOIL SET BLUE W/ STAR DESIGN	00474	0	0	0	N/A	2017-11-30 14:31:01.926706+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
596	PARTY LOOT BAG SMALL SOFIA	00515	0	0	0	N/A	2017-11-30 14:27:12.773936+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
583	BUNTING ASSORTED CLOWN	00459	0	0	0	N/A	2017-11-30 14:22:31.334535+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
570	PLASTIC LOOT BAG BIG PARTY TIME BALOON	00451	0	0	0	N/A	2017-11-30 14:17:43.928406+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
544	ID LACE JUNK KOOL	00647	0	0	0	N/A	2017-11-30 14:05:27.956425+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
531	BTS BALLPEN WHITE	00586	0	0	0	N/A	2017-11-30 13:59:00.569309+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
518	CAKE STAND BLUE W/ DOT	00577	0	0	0	N/A	2017-11-30 13:54:10.052852+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
504	BALLER JAMES	00639	0	0	0	N/A	2017-11-30 13:50:03.455645+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
490	CAKE TOPPER CHARACTER PRINCESS	00392	0	0	0	N/A	2017-11-30 13:44:23.702647+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
476	PARTY POPPER SMALL	00660	0	0	0	N/A	2017-11-30 13:38:35.74312+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
462	PLAIN FUCHSIA PINK	00683	0	0	0	N/A	2017-11-30 13:32:44.528873+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
448	CEL HAT PINK PRINCESS	00348	0	0	0	N/A	2017-11-30 13:28:48.417191+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
434	HBD BANNER FROZEN	00670	0	0	0	N/A	2017-11-30 13:20:11.825747+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
420	MYLAR BALLOON CHARACTER BUTTERFLY	00366	0	0	0	N/A	2017-11-30 13:14:02.725277+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
402	MYLAR BALLOON CHARACTER UNICORN (WHITE)	00356	0	0	0	N/A	2017-11-30 13:06:42.709888+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
383	MYLAR BALLOON CHARACTER BASKETBALL	00332	0	0	0	N/A	2017-11-30 12:03:49.100537+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
364	PHOTOPAPER PRINT 4R	00711	0	0	0	N/A	2017-11-30 11:58:38.890439+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
597	FOIL SET BLUE	00467	0	0	0	N/A	2017-11-30 14:27:18.585865+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
584	PARTY CURTAIN RED	00558	0	0	0	N/A	2017-11-30 14:22:51.555254+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
571	LINING RED	00550	0	0	0	N/A	2017-11-30 14:17:48.524148+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
558	INVITATION BARNEY	00573	0	0	0	N/A	2017-11-30 14:10:22.881961+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
545	INVITATION SUPERMAN	00565	0	0	0	N/A	2017-11-30 14:05:41.844859+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
532	BTS BALLPEN BLACK	00587	0	0	0	N/A	2017-11-30 13:59:31.885656+08	f	00	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
519	CAKE STAND PINK W/ DOT	00578	0	0	0	N/A	2017-11-30 13:54:41.519642+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
505	GIFT WRAPPER CHARACTER BEAR BLUE & WHITE	00403	0	0	0	N/A	2017-11-30 13:50:14.180327+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
339	LOOTBAG PAPER TINKERBELL	00302	0	0	0	N/A	2017-11-30 11:41:44.331405+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
353	DUNOT LOOT BAG CARS	00316	0	0	0	N/A	2017-11-30 11:49:52.936869+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
491	BALLER MAIDEN	00634	0	0	0	N/A	2017-11-30 13:45:00.076611+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
477	PARTY HAT SPIDERMAN	00386	0	0	0	N/A	2017-11-30 13:38:40.826408+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
463	PARTY HAT PRINCESS	00375	0	0	0	N/A	2017-11-30 13:32:56.848051+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
449	CEL HAT PINK PRINCESS	00348	0	0	0	N/A	2017-11-30 13:28:48.485511+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
435	POLKA DOT PARTY HAT RED & WHITE	00341	0	0	0	N/A	2017-11-30 13:20:18.689871+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	undefined	undefined	\N	\N	0	0	0
421	GOLD MUG GOLD MUG ONLY	00700	0	0	0	N/A	2017-11-30 13:14:14.329518+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
403	MYLAR BALLOON CHARACTER EAGLE	00357	0	0	0	N/A	2017-11-30 13:07:14.409745+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
384	MYLAR BALLOON CHARACTER MINIONS ASS	00333	0	0	0	N/A	2017-11-30 12:04:20.98524+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
365	MYLAR BALLOON CHARACTER OLAF	00323	0	0	0	N/A	2017-11-30 11:58:47.439631+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
697	HBD BUNTINGS GOLD W/ GLITTERS	00631	0	0	0	N/A	2017-11-30 15:22:20.043086+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
343	LOOTBAG PAPER GREEN W/ DOT	00306	0	0	0	N/A	2017-11-30 11:44:40.651305+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
357	PHOTOPAPER 3R SIZE 230 68M PER PACK 20 SHEETS	00707	0	0	0	N/A	2017-11-30 11:52:33.213801+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
3	HMD LETTER W/ DOT LIGHT BLUE	00002	0	0	0	N/A	2017-11-29 11:31:18.504854+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
4	HMD LETTER BLUE W/ BLACK PRINT	00004	0	0	0	N/A	2017-11-29 11:31:47.185414+08	f	0	(NEW)	0	0	NO DATA	No Rule	Food	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
354	PHOTOPAPER 4R SIZE 230 68M PER PACK 20 SHEETS	00706	0	0	0	N/A	2017-11-30 11:50:23.616554+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
5	HMD LETTER PINK W/ BLACK PRINT	00003	0	0	0	N/A	2017-11-29 11:40:28.830596+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
1	HMD LETTER W/ DOT DARK	00000	0	0	0	N/A	2017-11-29 11:28:17.534757+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
2	HMD LETTER W/ STRIPE DARK PINK	00001	0	0	0	N/A	2017-11-29 11:30:09.805869+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
6	HMD LETTER GREEN ASSORTED	00005	0	0	0	N/A	2017-11-29 11:41:51.715831+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
8	HMD LETTER PANTY FAVOR BALLOONS	00007	0	0	0	N/A	2017-11-29 11:45:08.558617+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
7	HMD LETTER PINK STRIPE ASSORTED	00006	0	0	0	N/A	2017-11-29 11:43:27.317103+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
9	HMD LETTER CLOWN W/ DOT GREEN	00008	0	0	0	N/A	2017-11-29 11:45:29.456976+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
10	HMD LETTER CUT OUT SILVER	00009	0	0	0	N/A	2017-11-29 11:45:49.995417+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
11	HMD LETTER  CUT OUT GOLD	00010	0	0	0	N/A	2017-11-29 11:48:43.351462+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
12	FRAME 4R WOOD BLACK	00011	0	0	0	N/A	2017-11-29 11:49:42.025422+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
13	FRAME 4R WOOD BROWN	00012	0	0	0	N/A	2017-11-29 11:50:08.540184+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
14	FRAME 4R WOOD BROWN	00013	0	0	0	N/A	2017-11-29 11:51:00.921062+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
15	FRAME 4R WOOD RED	00014	0	0	0	N/A	2017-11-29 11:51:15.014636+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
16	FRAME 3R WOOD R.BLUE	00015	0	0	0	N/A	2017-11-29 11:51:37.608167+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
313	BALLOON I DO PINK	00434	0	0	0	N/A	2017-11-30 11:28:26.863906+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
17	FRAME 3R WOOD L.BLUE	00016	0	0	0	N/A	2017-11-29 11:53:39.70004+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
18	FRAME 3R WOOD WHITE	00017	0	0	0	N/A	2017-11-29 11:54:07.878261+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
329	ROUND BALLOON ONE PINK	00442	0	0	0	N/A	2017-11-30 11:36:40.504427+08	f	0	(OLD)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
331	ROUND BALLOON LEAF SILVER	00443	0	0	0	N/A	2017-11-30 11:37:43.836989+08	f	0	(OLD)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
674	PARTY PAPER CUP CLASSIC COLOR AND DESIGN	00613	0	0	0	N/A	2017-11-30 15:07:23.436046+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
662	QUAFF MATTE CALLING CARD PAPER CALLING CARD PRINT FULL COLOR BACK TO BACK 50S	00502	0	0	0	N/A	2017-11-30 15:03:25.638895+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
650	QUAFF MATTE CALLING CARD PAPER CALLING CARD PRINT PLAIN COLOR 50S 220GSM	00496	0	0	0	N/A	2017-11-30 14:57:08.017969+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
637	PLASTIC LOOT BAG SMALL PEPPAPIG	00484	0	0	0	N/A	2017-11-30 14:47:14.541807+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
624	INVITATION HELLO KITTY	00595	0	0	0	N/A	2017-11-30 14:35:54.438143+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
611	HBD FOIL SET PINK W/ STAR DESIGN	00475	0	0	0	N/A	2017-11-30 14:31:30.588339+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
598	PARTY LOOT BAG SMALL HELLO KITTY	00516	0	0	0	N/A	2017-11-30 14:27:44.560869+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
585	ANNIVERSARY PINK	00460	0	0	0	N/A	2017-11-30 14:23:17.789522+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
623	INVITATION FROZEN	00594	0	0	0	N/A	2017-11-30 14:35:28.216366+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
610	CURLING RIBBON W/ GLITTERS RED	00522	0	0	0	N/A	2017-11-30 14:31:10.797763+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
572	PLASTIC LOOT BAG BIG HBDAY FLOWER	00452	0	0	0	N/A	2017-11-30 14:18:14.458972+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
559	PAPER STRAW LIGHT PINK	00532	0	0	0	N/A	2017-11-30 14:11:39.260657+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
546	PLASTIC LOOT BAG BIG PRINCESS	00443	0	0	0	N/A	2017-11-30 14:05:58.893077+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
533	PLASTIC LOOT BAG BIG HELLO KITTY	00440	0	0	0	N/A	2017-11-30 13:59:40.438421+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
520	CAKE STAND SOFIA	00579	0	0	0	N/A	2017-11-30 13:55:13.060477+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
506	BALLER NIKE	00640	0	0	0	N/A	2017-11-30 13:50:22.214131+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
492	CAKE TOPPER CHARACTER MINE CRAFT	00394	0	0	0	N/A	2017-11-30 13:45:08.430906+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
478	PARTY POPPER MEDIUM	00661	0	0	0	N/A	2017-11-30 13:39:08.498702+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
464	PLAIN YELLOW GOLD	00684	0	0	0	N/A	2017-11-30 13:33:12.474052+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
450	CEL HAT PINK HBD	00349	0	0	0	N/A	2017-11-30 13:29:14.633902+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
436	HBD BANNER DORA	00671	0	0	0	N/A	2017-11-30 13:20:43.027496+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
422	MYLAR BALLOON CHARACTER PIKACHU	00367	0	0	0	N/A	2017-11-30 13:14:40.911571+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
404	MAGIC MUG RED MAGIC MUG TWO SIDES PRINT	00692	0	0	0	N/A	2017-11-30 13:07:36.811011+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
385	MYLAR BALLOON CHARACTER 1ST BDAY BOY (BLUE)	00334	0	0	0	N/A	2017-11-30 12:05:03.801242+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
366	PHOTOPAPER PRINT 3R	00712	0	0	0	N/A	2017-11-30 11:59:07.369005+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
316	SMILEY FOIL BALLOON GOLD	00421	0	0	0	N/A	2017-11-30 11:30:03.322664+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
330	FLOWER W/ GOLD CENTER BLUE & RED	00428	0	0	0	N/A	2017-11-30 11:37:04.015039+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
344	LOOTBAG PAPER GREEN STRIPE	00307	0	0	0	N/A	2017-11-30 11:45:21.878079+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
709	TOOTHPICK TOPPER W/ CHARACTER PEPPAPIG	00727	0	0	0	N/A	2017-11-30 16:58:15.590598+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
698	HBD BUNTINGS RED W/ GLITTERS	00632	0	0	0	N/A	2017-11-30 15:22:41.552136+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
687	HBD LETTER BIG PINK W/ GOLD PRINT	00621	0	0	0	N/A	2017-11-30 15:15:35.382836+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
675	PARTY CURTAIN BLUE VIOLET	00614	0	0	0	N/A	2017-11-30 15:07:52.624255+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
663	POLKA DOTS LIGHT PINK	00606	0	0	0	N/A	2017-11-30 15:03:44.771435+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
651	QUAFF MATTE CALLING CARD PAPER CALLING CARD PRINT PLAIN COLOR 100S	00497	0	0	0	N/A	2017-11-30 14:57:53.539715+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
638	PLASTIC LOOT BAG SMALL CAPTAIN AMERICA	00485	0	0	0	N/A	2017-11-30 14:47:50.79366+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
625	CURLING RIBBON POMPOMS VIOLET & LIGHT VIOLET	00530	0	0	0	N/A	2017-11-30 14:35:57.239235+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
612	CURLING RIBBON W/ GLITTERS BLUE	00523	0	0	0	N/A	2017-11-30 14:31:35.283686+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
599	BABY SHOWER PINK	00468	0	0	0	N/A	2017-11-30 14:27:54.183768+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
586	PARTY CURTAIN GOLD	00559	0	0	0	N/A	2017-11-30 14:23:18.702792+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
573	PARTY PAPER CUP HELLO KITTY BARBIE	00551	0	0	0	N/A	2017-11-30 14:18:54.444443+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
560	PAPER STRAW BLUE	00533	0	0	0	N/A	2017-11-30 14:12:50.369919+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
547	INVITATION MINIONS	00566	0	0	0	N/A	2017-11-30 14:06:27.803441+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
534	BTS BALLPEN BLUE	00588	0	0	0	N/A	2017-11-30 14:00:02.736526+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
521	CAKE STAND SPIDER	00580	0	0	0	N/A	2017-11-30 13:55:44.414845+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
507	GIFT WRAPPER CHARACTER HBD-ASSORTED	00404	0	0	0	N/A	2017-11-30 13:50:48.737261+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
493	BALLER ADIDAS	00635	0	0	0	N/A	2017-11-30 13:45:24.374821+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
479	PARTY HAT BASKETBALL	00387	0	0	0	N/A	2017-11-30 13:39:08.83013+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
465	PARTY HAT BARBIE	00376	0	0	0	N/A	2017-11-30 13:33:26.943655+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
451	CURLING RIBBON	00678	0	0	0	N/A	2017-11-30 13:30:18.455247+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
437	HBD BANNER HAPPY B DAY	00672	0	0	0	N/A	2017-11-30 13:21:10.983995+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
423	GOLD MUG GOLD MUG ONE SIDE PRINT	00701	0	0	0	N/A	2017-11-30 13:14:41.826998+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
405	MYLAR BALLOON CHARACTER ROASTER	00358	0	0	0	N/A	2017-11-30 13:07:46.033838+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
386	MATTE CALLING CARD PAPER 5R SIZE 220 GSM	00721	0	0	0	N/A	2017-11-30 12:05:32.220296+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
367	MYLAR BALLOON CHARACTER BAYMAX (RED)	00324	0	0	0	N/A	2017-11-30 11:59:19.31542+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
358	MYLAR BALLOON CHARACTER MINE CRAFT	00319	0	0	0	N/A	2017-11-30 11:52:59.701077+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
406	MAGIC MUG BLACK MAGIC MUG ONE SIDE PRINT	00693	0	0	0	N/A	2017-11-30 13:08:10.07112+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
345	LOOTBAG PAPER RED STRIPE	00308	0	0	0	N/A	2017-11-30 11:45:52.891747+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
38	HBD LETTER CROWN BLUE	00037	0	0	0	N/A	2017-11-29 12:17:09.010235+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
39	HBD LETTER FOOT PRINT PINK	00038	0	0	0	N/A	2017-11-29 12:19:52.98505+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
40	HBD LETTER FOOT PINT BLUE	00039	0	0	0	N/A	2017-11-29 12:26:50.582638+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
682	HBD LETTER BIG LIGHT BLUE W/ GOLD PRINT	00618	0	0	0	N/A	2017-11-30 15:12:26.209291+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
41	HBD LETTER STRIPE BLUE LIGHT	00040	0	0	0	N/A	2017-11-29 12:32:32.798442+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
42	HBD LETTER R. BLUE	00041	0	0	0	N/A	2017-11-29 12:32:54.797939+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
44	HBD LETTER STRIPE BLACK	00043	0	0	0	N/A	2017-11-29 12:56:47.967561+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
43	HBD LETTER STRIPE PINK	00042	0	0	0	N/A	2017-11-29 12:38:54.163164+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
45	HBD LETTER STRIPE RED	00044	0	0	0	N/A	2017-11-29 12:58:01.193006+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
47	HBD LETTER STRIPE GREEN	00046	0	0	0	N/A	2017-11-29 13:17:20.113178+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
46	HBD LETTER STRIPE YELLOW	00045	0	0	0	N/A	2017-11-29 13:00:16.874417+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
48	HBD LETTER W/ DOT PINK	00047	0	0	0	N/A	2017-11-29 13:17:44.262069+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
49	HBD LETTER W/ DOT BLACK	00048	0	0	0	N/A	2017-11-29 13:18:34.296081+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
50	HBD LETTER W/ DOT YELLOW	00049	0	0	0	N/A	2017-11-29 13:19:02.375975+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
51	HBD LETTER W/ DOT GREEN	00050	0	0	0	N/A	2017-11-29 13:19:21.795563+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
52	HBD LETTER W/ DOT RED	00051	0	0	0	N/A	2017-11-29 13:19:44.418209+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
53	HBD LETTER W/ DOT M. BLUE	00052	0	0	0	N/A	2017-11-29 13:20:19.171826+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
54	FRAME 8X10 NORMAL L.BLUE	00053	0	0	0	N/A	2017-11-29 13:21:21.319838+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
55	FRAME 8X10 NORMAL R.BLUE	00054	0	0	0	N/A	2017-11-29 13:22:24.064847+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
56	FRAME 8X10 NORMAL BROWN	00055	0	0	0	N/A	2017-11-29 13:22:45.387243+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
57	FRAME 8X10 NORMAL RED	00056	0	0	0	N/A	2017-11-29 13:23:05.934866+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
58	FRAME 8X10 NORMAL PINK	00057	0	0	0	N/A	2017-11-29 13:24:28.197774+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
59	FRAME 8X10 NORMAL VIOLET	00058	0	0	0	N/A	2017-11-29 13:24:56.384913+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
60	5R RED	00059	0	0	0	N/A	2017-11-29 13:25:37.444917+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
61	5R R.BLUE	00060	0	0	0	N/A	2017-11-29 13:25:52.127014+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
62	5R PINK	00061	0	0	0	N/A	2017-11-29 13:26:12.087225+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
63	5R BLACK	00062	0	0	0	N/A	2017-11-29 13:26:28.916209+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
64	4R BLACK	00063	0	0	0	N/A	2017-11-29 13:27:25.177661+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
65	4R WHITE	00064	0	0	0	N/A	2017-11-29 13:27:41.055601+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
66	4R BROWN	00065	0	0	0	N/A	2017-11-29 13:28:00.245071+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
67	4R RED	00066	0	0	0	N/A	2017-11-29 13:28:18.758812+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
68	4R L.BLUE	00067	0	0	0	N/A	2017-11-29 13:29:01.615965+08	f	0	(NEW)	0	0	0	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
69	HBD LETTER CARS	00068	0	0	0	N/A	2017-11-29 13:31:23.600845+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
70	HBD LETTER MINIONS	00069	0	0	0	N/A	2017-11-29 13:31:42.75974+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
71	HBD LETTER SPIDER	00070	0	0	0	N/A	2017-11-29 13:32:02.79385+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
73	HBD LETTER FLAG	00071	0	0	0	N/A	2017-11-29 13:32:40.566429+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
72	HBD LETTER AVENGERS	00071	0	0	0	N/A	2017-11-29 13:32:22.815453+08	f	0	(OLD)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
74	HBD LETTER NECK TIE	00072	0	0	0	N/A	2017-11-29 13:33:13.098013+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
75	HBD LETTER GIRAFFE	00073	0	0	0	N/A	2017-11-29 13:33:41.995359+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
76	HBD LETTER BANDIRITAS W/ DOT	00074	0	0	0	N/A	2017-11-29 13:34:09.350699+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
77	HBD LETTER BANDIRITAS W/ STRIPE	00075	0	0	0	N/A	2017-11-29 13:35:09.597985+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
78	HBD LETTER MICKEY MOUSE HEAD	00076	0	0	0	N/A	2017-11-29 13:38:09.300097+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
79	HBD LETTER SPIDER STAR	00077	0	0	0	N/A	2017-11-29 13:38:27.659065+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
80	HBD LETTER PAW RATWOL STAR	00078	0	0	0	N/A	2017-11-29 13:38:48.416401+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
81	HBD LETTER CARS STAR	00079	0	0	0	N/A	2017-11-29 13:39:07.370337+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
387	MYLAR BALLOON CHARACTER 1ST BDAY GIRL	00335	0	0	0	N/A	2017-11-30 12:05:41.90298+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
368	PHOTOPAPER PRINT WALLET SIZE	00713	0	0	0	N/A	2017-11-30 11:59:32.294044+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
346	DUNOT LOOT BAG SPONGEBOB	00310	0	0	0	N/A	2017-11-30 11:46:39.571302+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
82	HBD LETTER SOFIA STAR	00080	0	0	0	N/A	2017-11-29 13:39:33.061597+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
83	HBD LETTER MINIE MOUSE STAR	00081	0	0	0	N/A	2017-11-29 13:39:51.370215+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
84	HBD LETTER FROZEN STAR	00082	0	0	0	N/A	2017-11-29 13:40:05.330245+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
85	HBD LETTER PEPPA PIG STAR	00083	0	0	0	N/A	2017-11-29 13:40:23.001491+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
86	HBD LETTER HELLO KITTEY STAR	00084	0	0	0	N/A	2017-11-29 13:40:42.08796+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
87	BTS BOOKMARK RAP MONSTER	00085	0	0	0	N/A	2017-11-29 13:42:40.327573+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
88	BTS BOOKMARK KIM TAE HYUNG	00086	0	0	0	N/A	2017-11-29 13:43:03.976848+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
89	BTS BOOKMARK PARK JI MIN	00087	0	0	0	N/A	2017-11-29 13:43:27.260114+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
90	BTS BOOKMARK JUNG KOOK	00088	0	0	0	N/A	2017-11-29 13:44:16.666759+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
91	BTS BOOKMARK J-HOPE	00089	0	0	0	N/A	2017-11-29 13:44:32.122819+08	f	0	(NEW)	0	0	0	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
92	POST CARD BTS	00090	0	0	0	N/A	2017-11-29 13:44:54.6954+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
93	POST CARD GIRLS GENERATION	00091	0	0	0	N/A	2017-11-29 13:45:11.343894+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
94	POST CARD EXO	00092	0	0	0	N/A	2017-11-29 13:45:26.460743+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
95	CLAPPER CLAPPER	00093	0	0	0	N/A	2017-11-29 13:45:45.534484+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
96	CLAPPER CLAPPER BALLOON	00094	0	0	0	N/A	2017-11-29 13:46:02.340122+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
97	PAPER PLATE HELLO KITTY	00095	0	0	0	N/A	2017-11-29 13:47:30.064385+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
98	PAPER PLATE FROZEN	00096	0	0	0	N/A	2017-11-29 13:47:45.567735+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
99	PAPER PLATE BARBIE	00097	0	0	0	N/A	2017-11-29 13:47:58.200541+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
100	PAPER PLATE SOPHIA THE FIRST	00098	0	0	0	N/A	2017-11-29 13:48:28.585584+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
101	PAPER PLATE MICKEY MOUSE	00099	0	0	0	N/A	2017-11-29 13:48:44.296423+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
102	PAPER PLATE BAYMAX	00100	0	0	0	N/A	2017-11-29 13:49:00.988623+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
103	PAPER PLATE BARNEY	00101	0	0	0	N/A	2017-11-29 13:49:30.707317+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
104	PAPER PLATE CLASSIC COLOR AND DESIGN	00102	0	0	0	N/A	2017-11-29 13:49:52.395724+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
105	HBD LETTER BALERINA CROWN	00103	0	0	0	N/A	2017-11-29 14:17:38.698256+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
106	HBD LETTER SOFIA SQUARE	00104	0	0	0	N/A	2017-11-29 14:24:29.155705+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
107	HBD LETTER FROZEN	00105	0	0	0	N/A	2017-11-29 14:25:20.188036+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
108	HBD LETTER PRINCESS	00106	0	0	0	N/A	2017-11-29 14:29:56.788667+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
109	HBD LETTER MOANA	00107	0	0	0	N/A	2017-11-29 14:38:42.566575+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
110	HBD LETTER CROWN W/ GLITTERS PINK	00108	0	0	0	N/A	2017-11-29 14:39:26.324662+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
112	HBD LETTER HELLO KITTY BIG	00110	0	0	0	N/A	2017-11-29 14:40:30.323588+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
111	HBD LETTER CROWN W/ GLITTERS BLUE	00109	0	0	0	N/A	2017-11-29 14:39:44.342627+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
113	HBD LETTER MINIE MOUSE	00111	0	0	0	N/A	2017-11-29 14:42:53.334867+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
114	HBD LETTER BALERINA	00112	0	0	0	N/A	2017-11-29 14:45:15.421403+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
115	HBD LETTER HELLO KITTY CIRCLE	00113	0	0	0	N/A	2017-11-29 14:52:17.237402+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
116	HBD LETTER CLOWN	00114	0	0	0	N/A	2017-11-29 14:54:18.247111+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
117	HBD LETTER T SHIRT PINK	00115	0	0	0	N/A	2017-11-29 14:54:57.105056+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
118	HBD LETTER T SHIRT BLUE	00116	0	0	0	N/A	2017-11-29 14:55:19.274276+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
119	HBD LETTER PEPPA PIG	00117	0	0	0	N/A	2017-11-29 15:04:53.867655+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
120	HBD LETTER PEPPAPIG SQUARE	00118	0	0	0	N/A	2017-11-29 15:05:11.26168+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
121	HBD LETTER MICKEY MOUSE STAR	00119	0	0	0	N/A	2017-11-29 15:05:32.46278+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
122	HBD LETTER MICKEY MOUSE SQUARE	00120	0	0	0	N/A	2017-11-29 15:05:50.484444+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
123	HBD LETTER T SHIRT W/ BALL	00121	0	0	0	N/A	2017-11-29 15:07:09.462312+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
124	HBD CANDLE W/ GLITTERS PINK	00122	0	0	0	N/A	2017-11-29 15:14:36.294355+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
369	MYLAR BALLOON CHARACTER MICKEY MOUSE	00325	0	0	0	N/A	2017-11-30 11:59:53.486472+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
333	MYLAR FOIL RING (WHITE)	00407	0	0	0	N/A	2017-11-30 11:38:40.977617+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
347	DUNOT LOOT BAG HELLO KITTY	00311	0	0	0	N/A	2017-11-30 11:47:12.15205+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
125	HBD CANDLE W/ GLITTERS BLUE	00123	0	0	0	N/A	2017-11-29 15:15:32.105345+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
126	HBD CANDLE W/ GLITTERS GOLD	00124	0	0	0	N/A	2017-11-29 15:15:57.683964+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
127	HBD CANDLE W/ GLITTERS RED	00125	0	0	0	N/A	2017-11-29 15:16:20.520449+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
128	HBD CANDLE W/ GLITTERS SILVER	00126	0	0	0	N/A	2017-11-29 15:16:49.334855+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
129	HBD W/ CHARACTER HELLO KITTY	00127	0	0	0	N/A	2017-11-29 15:17:13.33993+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
130	HBD W/ CHARACTER FROZEN	00128	0	0	0	N/A	2017-11-29 15:17:30.474544+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
131	HBD W/ CHARACTER SOFIA	00129	0	0	0	N/A	2017-11-29 15:19:18.44682+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
132	HBD W/ CHARACTER CARS	00130	0	0	0	N/A	2017-11-29 15:19:52.63788+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
133	HBD W/ CHARACTER SPIDER	00131	0	0	0	N/A	2017-11-29 15:20:09.300701+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
134	HBD W/ CHARACTER BEN 10	00132	0	0	0	N/A	2017-11-29 15:20:25.091775+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
135	RE LIGHTNING ASSORTED	00133	0	0	0	N/A	2017-11-29 15:21:34.314813+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
136	COLORED CANDLE ASSORTED	00134	0	0	0	N/A	2017-11-29 15:22:22.170858+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
137	MUSICAL CANDLE ASSORTED	00135	0	0	0	N/A	2017-11-29 15:22:39.156367+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
138	PARTY CANDLE STICK	00136	0	0	0	N/A	2017-11-29 15:25:54.739783+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
139	SET CANDLE PINK	00137	0	0	0	N/A	2017-11-29 15:26:10.341257+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
140	SET CANDLE BLUE	00138	0	0	0	N/A	2017-11-29 15:26:28.305834+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
141	FRAME W/ LINING 12 X 16 PINK	00139	0	0	0	N/A	2017-11-29 15:31:39.498403+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
142	FRAME W/ LINING 12 X 16 RED	00140	0	0	0	N/A	2017-11-29 15:32:00.053928+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
143	FRAME W/ LINING 12 X 16 BLACK	00141	0	0	0	N/A	2017-11-29 15:32:16.091203+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
144	FRAME W/ LINING 12 X 16 R.BLUE	00142	0	0	0	N/A	2017-11-29 15:33:24.335195+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
145	FRAME W/ LINING 12 X 16 BROWN	00143	0	0	0	N/A	2017-11-29 15:33:41.142839+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
146	FRAME W/ LINING 12 X 16 NORMAL PINK	00144	0	0	0	N/A	2017-11-29 15:34:01.064656+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
148	FRAME W/ LINING 12 X 16 NORMAL L.BLUE	00146	0	0	0	N/A	2017-11-29 15:35:10.880966+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
149	FRAME W/ LINING 12 X 16 NORMAL RED	00147	0	0	0	N/A	2017-11-29 15:35:27.084613+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
150	FRAME W/ LINING 8 X 10 W/ LINING BLACK	00148	0	0	0	N/A	2017-11-29 15:36:27.398549+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
151	FRAME W/ LINING 8 X 10 W/ LINING BROWN WOOD W/ DESIGN	00149	0	0	0	N/A	2017-11-29 15:38:59.768443+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
152	FRAME W/ LINING 8 X 10 RED	00150	0	0	0	N/A	2017-11-29 15:40:29.4527+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
153	FRAME W/ LINING 8 X 10 BROWN	00151	0	0	0	N/A	2017-11-29 15:40:53.328969+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
154	FRAME W/ LINING 8 X 10 R.BLUE	00152	0	0	0	N/A	2017-11-29 15:41:17.240887+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
155	FRAME W/ LINING 8 X 10 L.BLUE	00153	0	0	0	N/A	2017-11-29 15:41:32.082442+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
156	CANDLE W/ CHARACTER BUTTERFLY	00154	0	0	0	N/A	2017-11-29 15:42:40.989646+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
157	CANDLE W/ CHARACTER MINIONS	00155	0	0	0	N/A	2017-11-29 15:44:33.078854+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
158	CANDLE W/ CHARACTER MINIE MOUSE	00156	0	0	0	N/A	2017-11-29 15:46:02.578649+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
159	CANDLE W/ CHARACTER MICKEY MOUSE	00157	0	0	0	N/A	2017-11-29 15:46:22.206229+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
162	CANDLE W/ CHARACTER HELLO KITTY	00160	0	0	0	N/A	2017-11-29 15:48:06.233944+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
163	CANDLE W/ CHARACTER FROZEN	00161	0	0	0	N/A	2017-11-29 15:48:21.735116+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
164	CANDLE W/ CHARACTER SPIDER	00162	0	0	0	N/A	2017-11-29 15:48:42.857047+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
165	CANDLE W/ CHARACTER SPONGEBOB	00163	0	0	0	N/A	2017-11-29 15:49:01.139337+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
166	CANDLE W/ CHARACTER CARS	00164	0	0	0	N/A	2017-11-29 15:49:25.719973+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
167	HBD CANDLE PINK (GIRL)	00165	0	0	0	N/A	2017-11-29 15:51:36.464557+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
168	HBD CANDLE BLUE (BOY)	00166	0	0	0	N/A	2017-11-29 15:52:32.795189+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
169	HBD CANDLE BALLOON DESIGN	00167	0	0	0	N/A	2017-11-29 15:53:41.996868+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
370	PHOTOPAPER PRINT CUTIE SIZE	00714	0	0	0	N/A	2017-11-30 12:00:03.805239+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
408	MAGIC MUG BLACK MAGIC MUG TWO SIDES PRINT	00694	0	0	0	N/A	2017-11-30 13:09:55.528714+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
348	DUNOT LOOT BAG BARBIE	00312	0	0	0	N/A	2017-11-30 11:47:40.181802+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
170	HBD CANDLE PINK	00168	0	0	0	N/A	2017-11-29 15:54:41.500505+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
171	HBD CANDLE BLUE	00169	0	0	0	N/A	2017-11-29 15:55:12.415552+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
172	HBD CANDLE PLAIN	00170	0	0	0	N/A	2017-11-29 15:55:25.883486+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
173	HBD CANDLE ASSORTED	00171	0	0	0	N/A	2017-11-29 15:55:53.542576+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
174	HBD CANDLE SET BLUE AND PINK	00172	0	0	0	N/A	2017-11-29 15:56:12.51029+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
175	CALLE TOPPER CHALK SPONGEBOB	00173	0	0	0	N/A	2017-11-29 15:57:04.958738+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
176	CALLE TOPPER CHALK MICKEY MOUSE BIG	00174	0	0	0	N/A	2017-11-29 15:57:53.177375+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
177	CALLE TOPPER CHALK MICKEY MOUSE SMALL	00175	0	0	0	N/A	2017-11-29 15:58:10.620279+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
178	CALLE TOPPER CHALK BASKETBALL	00176	0	0	0	N/A	2017-11-29 15:58:57.162908+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
179	CALLE TOPPER CHALK POKEMON	00178	0	0	0	N/A	2017-11-29 15:59:15.827044+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
180	CALLE TOPPER CHALK BEN 10	00179	0	0	0	N/A	2017-11-29 15:59:32.18014+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
181	CALLE TOPPER CHALK SUPERMAN	00180	0	0	0	N/A	2017-11-29 16:00:00.827497+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
182	CALLE TOPPER CHALK CAPTAIN AMERICA	00181	0	0	0	N/A	2017-11-29 16:00:16.740437+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
183	CALLE TOPPER CHALK C.O.C	00182	0	0	0	N/A	2017-11-29 16:00:43.417708+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
184	CALLE TOPPER CHALK IRON MAN	00183	0	0	0	N/A	2017-11-29 16:01:01.000912+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
185	CALLE TOPPER CHALK SPIDERMAN	00184	0	0	0	N/A	2017-11-29 16:01:27.074292+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
186	CALLE TOPPER CHALK BATMAN	00185	0	0	0	N/A	2017-11-29 16:04:31.515382+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
187	CALLE TOPPER CHALK TRANSFORMER	00186	0	0	0	N/A	2017-11-29 16:04:45.696305+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
188	CALLE TOPPER CHALK THOR	00187	0	0	0	N/A	2017-11-29 16:05:00.150658+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
189	CALLE TOPPER CHALK HORSE	00188	0	0	0	N/A	2017-11-29 16:05:51.038403+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
192	POWN TAIW CANDLE LARGE	00191	0	0	0	N/A	2017-11-29 16:30:32.007058+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
191	POWN TAIW CANDLE MEDIUM	00190	0	0	0	N/A	2017-11-29 16:30:04.152679+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
190	POWN TAIW CANDLE SMALL	00189	0	0	0	N/A	2017-11-29 16:29:37.271608+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
193	WOODEN CLIP NUMBER ASSORTED	00192	0	0	0	N/A	2017-11-29 16:35:08.489344+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
161	CANDLE W/ CHARACTER RAINBOW	00159	0	0	0	N/A	2017-11-29 15:47:00.282202+08	f	0	(OLD)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
195	PUMP BALLOON ASSORTED	00194	0	0	0	N/A	2017-11-29 16:38:58.298238+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
196	STICK LONG	00195	0	0	0	N/A	2017-11-29 16:39:52.257619+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
197	STICK SHORT	00196	0	0	0	N/A	2017-11-29 16:40:08.626736+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
198	STICK RING	00197	0	0	0	N/A	2017-11-29 16:42:54.568602+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
199	MYLAU STICK ASSORTED	00198	0	0	0	N/A	2017-11-29 16:46:09.117774+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
200	CORTAIN SILVER	00199	0	0	0	N/A	2017-11-29 16:46:55.937124+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
201	CORTAIN GOLD	00200	0	0	0	N/A	2017-11-29 16:47:13.83748+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
202	CORTAIN RED	00201	0	0	0	N/A	2017-11-29 16:47:33.16242+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
203	CORTAIN ROYAL BLUE	00202	0	0	0	N/A	2017-11-29 16:47:53.976451+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
204	CORTAIN PINK	00203	0	0	0	N/A	2017-11-29 16:48:14.817067+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
205	FRAME TSHIRT DESIGN ASSORTED	00204	0	0	0	N/A	2017-11-29 16:49:06.421924+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
206	STARBUCKS TUMBLER GREEN	00205	0	0	0	N/A	2017-11-29 16:53:30.841371+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
207	STARBUCKS TUMBLER RED	00206	0	0	0	N/A	2017-11-29 16:53:58.660239+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
208	STARBUCKS TUMBLER BLACK	00207	0	0	0	N/A	2017-11-29 16:54:19.827572+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
209	BIG TUMBLER BLACK	00208	0	0	0	N/A	2017-11-29 16:57:46.77028+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
210	BIG TUMBLER W/ HANDLE BLACK	00209	0	0	0	N/A	2017-11-29 16:58:14.115293+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
211	KEYCHAIN SMALL	00210	0	0	0	N/A	2017-11-29 16:58:57.500581+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
390	MATTE CALLING CARD PAPER WALLET SIZE 220 GSM	00724	0	0	0	N/A	2017-11-30 12:07:11.529099+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
371	PHOTOPAPER PRINT A3	00715	0	0	0	N/A	2017-11-30 12:00:26.568383+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
321	BALLOON FOIL HASHTAG GOLD	00436	0	0	0	N/A	2017-11-30 11:32:27.492842+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
349	DUNOT LOOT BAG FROZEN	00313	0	0	0	N/A	2017-11-30 11:48:20.674379+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
19	FRAME 3R WOOD RED	00018	0	0	0	N/A	2017-11-29 11:54:28.350851+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
20	FRAME 3R WOOD PINK	00019	0	0	0	N/A	2017-11-29 11:54:51.111764+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
21	FRAME 3R WOOD BLACK	00020	0	0	0	N/A	2017-11-29 11:55:05.838122+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
22	PAPER BAG SMALL	00021	0	0	0	N/A	2017-11-29 11:56:29.927139+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
23	PAPER BAG MEDIUM	00022	0	0	0	N/A	2017-11-29 11:56:43.307272+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
24	PAPER BAG LARGE	00023	0	0	0	N/A	2017-11-29 11:57:01.38916+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
25	I.D LACE ONE DIRECTION	00024	0	0	0	N/A	2017-11-29 12:04:51.633975+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
26	I.D LACE BTS	00025	0	0	0	N/A	2017-11-29 12:05:48.968173+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
27	I.D LACE SPONGEBOB	00026	0	0	0	N/A	2017-11-29 12:06:53.11961+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
28	I.D LACE FROZEN	00027	0	0	0	N/A	2017-11-29 12:07:25.554776+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
29	I.D LACE ALDUB	00028	0	0	0	N/A	2017-11-29 12:08:50.448006+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
30	I.D LACE FACEBOOK	00029	0	0	0	N/A	2017-11-29 12:09:05.602387+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
31	I.D LACE PLAIN	00030	0	0	0	N/A	2017-11-29 12:10:04.78845+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
32	BTS COIN WALLET GRAY	00031	0	0	0	N/A	2017-11-29 12:10:56.806606+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
34	BTS COIN WALLET BLACK SMALL	00033	0	0	0	N/A	2017-11-29 12:12:18.065527+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
33	BTS COIN WALLET BLACK	00032	0	0	0	N/A	2017-11-29 12:11:37.133742+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
35	HBD LETTER DONUT	00034	0	0	0	N/A	2017-11-29 12:15:23.249912+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
36	HBD LETTER WHALE	00035	0	0	0	N/A	2017-11-29 12:15:39.446076+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
37	HBD LETTER CROWN PINK	00036	0	0	0	N/A	2017-11-29 12:16:52.308518+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
212	KEYCHAIN BIG	00211	0	0	0	N/A	2017-11-29 16:59:56.402716+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
213	KEYCHAIN OPENER	00212	0	0	0	N/A	2017-11-29 17:00:14.820674+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
214	ROUND MINT TIN CANS EMPTY	00213	0	0	0	N/A	2017-11-29 17:00:53.210322+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
215	ROUND MINT TIN CANS PRINT WITH MINTS	00214	0	0	0	N/A	2017-11-29 17:02:12.850932+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
216	SLIDER RECTANGULAR TIN CANS 10 GRAMS EMPTY	00215	0	0	0	N/A	2017-11-29 17:02:37.290821+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
217	SLIDER RECTANGULAR TIN CANS 10GRAMS WITH PRINT	00216	0	0	0	N/A	2017-11-29 17:03:00.8187+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
335	ROUND BALLOON LEAF BLUE	00446	0	0	0	N/A	2017-11-30 11:39:28.310088+08	f	0	(OLD)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
639	PLASTIC LOOT BAG SMALL BEN-10	00486	0	0	0	N/A	2017-11-30 14:48:29.454589+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
626	INVITATION BARBIE	00596	0	0	0	N/A	2017-11-30 14:36:16.092871+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
613	HBD FOIL SET PINK PLAIN	00476	0	0	0	N/A	2017-11-30 14:32:03.62735+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
600	PARTY LOOT BAG SMALL BARBIE	00517	0	0	0	N/A	2017-11-30 14:28:07.989341+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
587	PARTY CURTAIN SILVER	00560	0	0	0	N/A	2017-11-30 14:23:48.534928+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
561	PAPER STRAW FUSCHIA PINK	00544	0	0	0	N/A	2017-11-30 14:13:41.294233+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
548	PLASTIC LOOT BAG BIG STRAWBERRY SHORT CAKE	000444	0	0	0	N/A	2017-11-30 14:06:42.936079+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
535	PLASTIC LOOT BAG BIG DORA	00441	0	0	0	N/A	2017-11-30 14:00:08.218137+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
522	ID LACE BANGTANG BOYS	00648	0	0	0	N/A	2017-11-30 13:56:02.085128+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
508	BALLER JUST DO IT	00641	0	0	0	N/A	2017-11-30 13:50:49.454214+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
494	CAKE TOPPER CHARACTER CARS	00395	0	0	0	N/A	2017-11-30 13:45:37.58788+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
480	PARTY HAT MOANA	00388	0	0	0	N/A	2017-11-30 13:39:41.852968+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
627	CURLING RIBBON POMPOMS YELLOW GREEN	00531	0	0	0	N/A	2017-11-30 14:36:31.251327+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
614	CURLING RIBBON W/ GLITTERS GREEN	00524	0	0	0	N/A	2017-11-30 14:32:11.63574+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
466	PLAIN ITS A BOY	00685	0	0	0	N/A	2017-11-30 13:33:44.456245+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
452	PARTY HAT FROZEN	00369	0	0	0	N/A	2017-11-30 13:30:19.411828+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
438	HBD BANNER BARBIE	00673	0	0	0	N/A	2017-11-30 13:21:42.288474+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
424	MYLAR BALLOON CHARACTER PAW PATROL	00368	0	0	0	N/A	2017-11-30 13:15:14.158275+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
256	PLASTIC LOOTBAG BIG POLKA  PINK	00255	0	0	0	N/A	2017-11-30 10:30:32.021655+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
409	MYLAR BALLOON CHARACTER ZEBRA	00360	0	0	0	N/A	2017-11-30 13:10:34.255104+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
391	MYLAR BALLOON CHARACTER FROZEN	00350	0	0	0	N/A	2017-11-30 13:02:43.005202+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
372	MYLAR BALLOON CHARACTER MINNIE MOUSE	00326	0	0	0	N/A	2017-11-30 12:00:27.82445+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
601	FOIL SET BLUE	00469	0	0	0	N/A	2017-11-30 14:28:20.614318+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
588	LETTER BLACK	00461	0	0	0	N/A	2017-11-30 14:24:14.175071+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
575	PARTY PAPER CUP FROZEN	00552	0	0	0	N/A	2017-11-30 14:19:27.397656+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
562	PAPER STRAW BLACK & POLKA DOTS	00545	0	0	0	N/A	2017-11-30 14:14:50.090441+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
509	BALLER DANGEROUS	00642	0	0	0	N/A	2017-11-30 13:51:16.935548+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
495	GIFT WRAPPER CHARACTER FROZEN	00396	0	0	0	N/A	2017-11-30 13:46:45.526264+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
481	PARTY POPPER LARGE	00662	0	0	0	N/A	2017-11-30 13:39:44.516022+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
467	PARTY HAT HELLO KITTY	00377	0	0	0	N/A	2017-11-30 13:34:03.517557+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
453	PARTY HAT SOPHIA	00370	0	0	0	N/A	2017-11-30 13:30:45.822974+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
439	POLKA DOT PARTY HAT BLUE & WHITE	00342	0	0	0	N/A	2017-11-30 13:22:05.588815+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
642	PLASTIC LOOT BAG SMALL ANGRY BIRD	00489	0	0	0	N/A	2017-11-30 14:50:01.664315+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
629	INVITATION SOFIA	00598	0	0	0	N/A	2017-11-30 14:36:54.365073+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
425	GOLD MUG GOLD MUG TWO SIDES PRINT	00702	0	0	0	N/A	2017-11-30 13:15:15.55173+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
410	MAGIC MUG BLUE MAGIC MUG ONE SIDE PRINT	00695	0	0	0	N/A	2017-11-30 13:10:44.232932+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
392	MYLAR BALLOON CHARACTER TROLLZ	00351	0	0	0	N/A	2017-11-30 13:03:09.444609+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
373	MYLAR BALLOON CHARACTER BATMAN	00327	0	0	0	N/A	2017-11-30 12:00:54.103328+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
641	PLASTIC LOOT BAG SMALL CARS	00488	0	0	0	N/A	2017-11-30 14:49:26.746736+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
628	INVITATION TINKER BELL	00597	0	0	0	N/A	2017-11-30 14:36:35.935473+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
615	CURLING RIBBON W/ GLITTERS VIOLET	00525	0	0	0	N/A	2017-11-30 14:32:41.012174+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
617	INVITATION MINIE MOUSE	00591	0	0	0	N/A	2017-11-30 14:34:07.955693+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
602	PARTY LOOT BAG SMALL TINKERBELL	00518	0	0	0	N/A	2017-11-30 14:28:40.064187+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
589	LETTER BLUE	00462	0	0	0	N/A	2017-11-30 14:24:44.664454+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
576	PLASTIC LOOT BAG BIG PARTY TIME RAINBOW	00454	0	0	0	N/A	2017-11-30 14:19:48.841466+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
574	PLASTIC LOOT BAG BIG HBDAY CAKE	00453	0	0	0	N/A	2017-11-30 14:19:14.99513+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
563	PAPER STRAW RED+	00546	0	0	0	N/A	2017-11-30 14:15:25.462411+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
631	PLASTIC LOOT BAG SMALL SPONGEBOB	00478	0	0	0	N/A	2017-11-30 14:43:55.347139+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
513	CAKE STAND SILVER	00574	0	0	0	N/A	2017-11-30 13:52:34.542882+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
550	PLASTIC LOOT BAG BIG BARBIE	00445	0	0	0	N/A	2017-11-30 14:07:08.934612+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
537	BTS BALLPEN ASSORTED SET	00589	0	0	0	N/A	2017-11-30 14:00:52.877134+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
524	ID LACE STAR	00649	0	0	0	N/A	2017-11-30 13:56:36.093903+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
510	GIFT WRAPPER CHARACTER STAR HBD BLACK	00405	0	0	0	N/A	2017-11-30 13:51:40.643278+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
374	PHOTOPAPER PRINT 16X20	00716	0	0	0	N/A	2017-11-30 12:01:03.720007+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
496	GIFT WRAPPER CHARACTER HELLO KITTY	00397	0	0	0	N/A	2017-11-30 13:47:16.040921+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
482	PARTY POPPER X LARGE	00663	0	0	0	N/A	2017-11-30 13:40:11.572636+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
468	PLAIN ITS A GIRL	00686	0	0	0	N/A	2017-11-30 13:34:05.96711+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
454	PLAIN WHITE	00679	0	0	0	N/A	2017-11-30 13:30:54.190331+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
440	HBD BANNER TINKER BELL	00674	0	0	0	N/A	2017-11-30 13:22:06.710702+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
426	KIDDIE MUG KIDDIE MUG ONE SIDE PRINT	00703	0	0	0	N/A	2017-11-30 13:15:55.906218+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
411	MYLAR BALLOON CHARACTER TIGER	00361	0	0	0	N/A	2017-11-30 13:11:07.251679+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
393	WHITE MUG WHITE MUG ONLY	00687	0	0	0	N/A	2017-11-30 13:03:59.146687+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
389	MATTE CALLING CARD PAPER 3R SIZE 220 GSM	00723	0	0	0	N/A	2017-11-30 12:06:44.128309+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
616	CURLING RIBBON POMPOMS HAPPY BIRTHDAY	00526	0	0	0	N/A	2017-11-30 14:33:42.549601+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
603	HBD FOIL SET ASSORTED	00471	0	0	0	N/A	2017-11-30 14:28:53.283591+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
590	PARTY LOOT BAG SMALL MINNIE MOUSE	00512	0	0	0	N/A	2017-11-30 14:24:50.09478+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
577	PARTY PAPER CUP SOPHIA THE FIRST	00553	0	0	0	N/A	2017-11-30 14:20:01.617975+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
564	PAPER CUPCAKE VIOLET	00547	0	0	0	N/A	2017-11-30 14:16:07.559024+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
551	INVITATION CLASH OF CLANS	00568	0	0	0	N/A	2017-11-30 14:07:25.9271+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
538	BTS FAN	00590	0	0	0	N/A	2017-11-30 14:02:23.061784+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
525	ID LACE WARRIORS	00650	0	0	0	N/A	2017-11-30 13:56:59.232475+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
515	CAKE STAND GOLD	00575	0	0	0	N/A	2017-11-30 13:52:57.548561+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
511	BALLER RI	00643	0	0	0	N/A	2017-11-30 13:51:48.351355+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
497	GIFT WRAPPER CHARACTER SPONGEBOB	00398	0	0	0	N/A	2017-11-30 13:47:51.546387+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
483	PABITIN	00664	0	0	0	N/A	2017-11-30 13:40:45.128823+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
469	PARTY HAT POKEMON	00378	0	0	0	N/A	2017-11-30 13:34:34.993526+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
455	PARTY HAT MINNIE MOUSE	00371	0	0	0	N/A	2017-11-30 13:31:12.347162+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
441	HBD BANNER MINIE MOUSE	00675	0	0	0	N/A	2017-11-30 13:22:43.816795+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
427	KIDDIE MUG KIDDIE MUG TWO SIDES PRINT	00704	0	0	0	N/A	2017-11-30 13:16:24.402817+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
412	MAGIC MUG BLUE MAGIC MUG TWO SIDES PRINT	00696	0	0	0	N/A	2017-11-30 13:11:27.776149+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
394	MYLAR BALLOON CHARACTER TANGLED	00352	0	0	0	N/A	2017-11-30 13:04:23.569641+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
388	MATTE CALLING CARD PAPER 4R SIZE 220 GSM	00722	0	0	0	N/A	2017-11-30 12:06:02.336503+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
375	MYLAR BALLOON CHARACTER BAYMAX (WHITE)	00328	0	0	0	N/A	2017-11-30 12:01:30.903176+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
630	PLASTIC LOOT BAG SMALL WINNIE THE POOH	00477	0	0	0	N/A	2017-11-30 14:43:28.101395+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
604	PARTY LOOT BAG SMALL DORA	00519	0	0	0	N/A	2017-11-30 14:29:25.513016+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
591	ITS A BOY PINK LETTER	00463	0	0	0	N/A	2017-11-30 14:25:06.349344+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
578	PARTY PAPER CUP MICKEY MOUSE	00554	0	0	0	N/A	2017-11-30 14:20:38.004736+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
565	PLASTIC LOOT BAG BIG LITTLE PONY	00448	0	0	0	N/A	2017-11-30 14:16:22.984723+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
552	PLASTIC LOOT BAG BIG TINKERBELL	00446	0	0	0	N/A	2017-11-30 14:07:40.546472+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
539	INVITATION BEN-10	00561	0	0	0	N/A	2017-11-30 14:03:20.458212+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
526	WOODEN CLIP PINK	00582	0	0	0	N/A	2017-11-30 13:57:02.496811+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
484	PALAYOK	00665	0	0	0	N/A	2017-11-30 13:41:10.909789+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
470	PARTY HAT POOH	00379	0	0	0	N/A	2017-11-30 13:35:04.186165+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
456	PLAIN YELLOW	00680	0	0	0	N/A	2017-11-30 13:31:22.566281+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
442	POLKA DOT PARTY HAT PINK & WHITE	00343	0	0	0	N/A	2017-11-30 13:22:53.233837+08	f	0	(OLD)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
396	MYLAR BALLOON CHARACTER HELLO KITTY (SMALL)	00353	0	0	0	N/A	2017-11-30 13:04:58.256015+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
377	MYLAR BALLOON CHARACTER POKEMON	00329	0	0	0	N/A	2017-11-30 12:01:58.402094+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
337	ROUND BALLOON LEAF RED	00447	0	0	0	N/A	2017-11-30 11:40:11.836973+08	f	0	(OLD)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
704	TOOTHPICK TOPPER W/ CHARACTER MICKEY MOUSE	00309	0	0	0	N/A	2017-11-30 16:55:23.405784+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
218	SLIDER RECTANGULAR TIN CANS 10G W/ PRINT AND MINTS	00217	0	0	0	N/A	2017-11-29 17:03:27.388063+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
219	SLIDER MEDIUM EMPTY	00218	0	0	0	N/A	2017-11-29 17:04:19.280505+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
220	SLIDER MEDIUM WITH PRINT	00219	0	0	0	N/A	2017-11-29 17:04:39.585977+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
221	SLIDER MEDIUM WITH PRINT AND MINTS	00220	0	0	0	N/A	2017-11-29 17:05:03.756597+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
222	SLIDER RECTANGULAR EMPTY	00221	0	0	0	N/A	2017-11-29 17:05:27.13535+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
223	SLIDER RECTANGULAR WITH PRINT	00222	0	0	0	N/A	2017-11-29 17:05:43.78819+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
224	SLIDER RECTANGULAR WITH PRINT AND MINTS	00223	0	0	0	N/A	2017-11-29 17:06:12.464705+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
225	TIN CANS EMPTY	00224	0	0	0	N/A	2017-11-29 17:07:37.474116+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
226	TIN CANS WITH PRINT	00225	0	0	0	N/A	2017-11-29 17:07:58.362086+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
227	TIN CANS WITH PRINT AND MINTS	00226	0	0	0	N/A	2017-11-29 17:09:27.397129+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
228	HBD BANNER CANS	00227	0	0	0	N/A	2017-11-29 17:12:55.238456+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
229	HBD BANNER SPIDERMAN	00228	0	0	0	N/A	2017-11-29 17:13:39.264708+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
230	HBD BANNER SAFARI	00229	0	0	0	N/A	2017-11-29 17:14:03.119707+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
231	HBD BANNER MICKEY MOUSE	00230	0	0	0	N/A	2017-11-29 17:14:30.696857+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
232	HBD BANNER POKEMON	00231	0	0	0	N/A	2017-11-29 17:14:54.176436+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
233	HBD BANNER SUPERMAN	00232	0	0	0	N/A	2017-11-29 17:15:56.267264+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
234	HBD BANNER TOY STORY	00233	0	0	0	N/A	2017-11-29 17:17:26.499329+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
235	HBD BANNER MINIONS	00234	0	0	0	N/A	2017-11-29 17:17:45.302777+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
237	HBD BANNER PEPPA PIG	00236	0	0	0	N/A	2017-11-29 17:18:45.202871+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
238	HBD BANNER SPONGEBOB	00237	0	0	0	N/A	2017-11-29 17:18:59.759467+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
160	CANDLE W/ CHARACTER PEPPA PIG	00158	0	0	0	N/A	2017-11-29 15:46:41.730129+08	f	0	(OLD)	0	0	NO DATA	No Rule	Nonfood	\N	Nov 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
693	HBD LETTER SMALL WHITE W/ GOLD PRINT	00627	0	0	0	N/A	2017-11-30 15:20:16.17127+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
681	PHOTOPAPER CALLING CARD 230GSM PLAIN PAPER/BACK TO BACK 100S	00509	0	0	0	N/A	2017-11-30 15:11:19.736253+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
669	PHOTOPAPER CALLING CARD 230GSM PLAIN COLOR 50S	00504	0	0	0	N/A	2017-11-30 15:06:08.092398+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
657	PAPER STRAW BLACK AND POLKA DOTS	00602	0	0	0	N/A	2017-11-30 15:02:02.408245+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
645	POSTER BLACK & PINK	00492	0	0	0	N/A	2017-11-30 14:51:27.695864+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
632	PLASTIC LOOT BAG SMALL CLASH OF CLANS	00479	0	0	0	N/A	2017-11-30 14:44:36.747053+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
619	INVITATION PRINCESS	00592	0	0	0	N/A	2017-11-30 14:34:38.34558+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
606	PARTY LOOT BAG SMALL PARTY TIME	00520	0	0	0	N/A	2017-11-30 14:30:06.375086+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
593	PARTY LOOT BAG SMALL MOANA	00513	0	0	0	N/A	2017-11-30 14:26:20.763248+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
580	PARTY PAPER CUP BAYMAX	00555	0	0	0	N/A	2017-11-30 14:21:11.639482+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
567	PLASTIC LOOT BAG BIG FROZEN	00449	0	0	0	N/A	2017-11-30 14:16:49.862415+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
554	PLASTIC LOOT BAG BIG MOANA	00447	0	0	0	N/A	2017-11-30 14:08:06.746606+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
541	INVITATION TOY STORY	00563	0	0	0	N/A	2017-11-30 14:04:19.277483+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
528	ID LACE STRING	00651	0	0	0	N/A	2017-11-30 13:57:47.704719+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
514	ID LACE PILIPINAS	00645	0	0	0	N/A	2017-11-30 13:52:44.387193+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
500	BALLER ATTACK ON TITAN	00637	0	0	0	N/A	2017-11-30 13:48:47.660563+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
486	CAKE TOPPER CHARACTER SPIDERMAN	00390	0	0	0	N/A	2017-11-30 13:42:49.739382+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
472	PARTY HAT TINKERBELL	00381	0	0	0	N/A	2017-11-30 13:36:03.916819+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
458	PLAIN LIGHT PINK	00681	0	0	0	N/A	2017-11-30 13:31:48.486445+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
444	CEL HAT BLUE W/ STAR	00343	0	0	0	N/A	2017-11-30 13:25:27.056597+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
430	PARTY HAT BEN-10	00338	0	0	0	N/A	2017-11-30 13:17:58.404737+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
397	WHITE MUG WHITE MUGA	00689	0	0	0	N/A	2017-11-30 13:05:00.135442+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
378	PHOTOPAPER PRINT 24X36	00718	0	0	0	N/A	2017-11-30 12:02:22.827567+08	f	0	(NEW)	0	0	NO DATA	No Rule	Nonfood	\N	Dec 30, 2020	GUADALUPE	undefined	\N	\N	0	0	0
\.


--
-- Name: product_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('product_data_pk_seq', 716, true);


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
2	undefined	2017-11-30 13:37:43.420212+08	f
\.


--
-- Name: rules_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('rules_data_pk_seq', 2, true);


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

COPY tender_data (pk, product_name, product_quantity, product_supplier_price, product_retail_price, product_transaction_number, vat_percentage, net_amount, vat, discount, change, cash, tempo_total, void_count, total, gc_amount, gc_name, gc_code, cashier_user_id, date_created, archived, product_pk, cancelled_amount, product_branches, cnumber) FROM stdin;
2	TOOTHPICK W/ LINING BEN-10	1	0	0.00	0936511028	12	1	0	0	1.00	2.00	1.00	0	1.00	0	none	none	2014000100	2017-12-06 15:51:50.805667+08	f	713	\N	GUADALUPE	
\.


--
-- Name: tender_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('tender_data_pk_seq', 2, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY users (pk, user_id, first_name, middle_name, last_name, user_type, date_created, archived, superior_pin, email, stall_code, sales_dept, verify_random, permission, branch_assignment) FROM stdin;
1	201400028	Patrick	Matetu	Chavez	1	2017-11-08 09:17:46.874583+08	f	82bd3619c452b5c693ce2b26db8e0da7	\N	\N	\N	\N	{"Admin": {"Menu": true, "Modules": {"One": false, "Six": false, "Ten": false, "Two": true, "Five": false, "Four": false, "Nine": false, "Eight": false, "Seven": false, "Three": false, "Eleven": false, "Twelve": false, "Thirteen": false}}, "Cashier": {"Menu": true}, "ProductE": {"Menu": true}, "PriceList": {"Menu": true}}	\N
2	201400072	Ken	Villanueva	Tapdasan	2	2017-11-08 09:17:46.878213+08	f	82bd3619c452b5c693ce2b26db8e0da7	\N	\N	\N	\N	{"Admin": {"Menu": true, "Modules": {"One": false, "Six": false, "Ten": false, "Two": true, "Five": false, "Four": false, "Nine": false, "Eight": false, "Seven": false, "Three": false, "Eleven": false, "Twelve": false, "Thirteen": false}}, "Cashier": {"Menu": true}, "ProductE": {"Menu": true}, "PriceList": {"Menu": true}}	\N
7	201700153	Shereen	N/A	Serdena	1	2017-12-01 14:18:12.913689+08	f	82bd3619c452b5c693ce2b26db8e0da7	shersaints711@gmail.com	00	00	\N	{"Admin": {"Menu": true, "Modules": {"One": true, "Six": true, "Ten": true, "Two": true, "Five": true, "Four": true, "Nine": true, "Eight": true, "Seven": true, "Three": true, "Eleven": true, "Twelve": true, "Fifteen": true, "Fourteen": true, "Thirteen": true}}, "Cashier": {"Menu": true}, "ProductE": {"Menu": true}, "PriceList": {"Menu": true}}	GUADALUPE
3	2014000100	R-Wayne	Feliciano	Lipardo	1	2017-11-08 09:17:47.465389+08	f	82bd3619c452b5c693ce2b26db8e0da7	\N	\N	\N	\N	{"Admin": {"Menu": true, "Modules": {"One": true, "Six": true, "Ten": true, "Two": true, "Five": true, "Four": true, "Nine": true, "Eight": true, "Seven": true, "Three": true, "Eleven": true, "Twelve": true, "Fifteen": true, "Fourteen": true, "Thirteen": true}}, "Cashier": {"Menu": true}, "ProductE": {"Menu": true}, "PriceList": {"Menu": true}}	\N
6	201700922	Dennis	N/A	Serdena	1	2017-12-01 14:17:36.364229+08	f	82bd3619c452b5c693ce2b26db8e0da7	noname@gmail.com	00	00	\N	{"Admin": {"Menu": true, "Modules": {"One": true, "Six": true, "Ten": true, "Two": true, "Five": true, "Four": true, "Nine": true, "Eight": true, "Seven": true, "Three": true, "Eleven": true, "Twelve": true, "Fifteen": true, "Fourteen": true, "Thirteen": true}}, "Cashier": {"Menu": true}, "ProductE": {"Menu": true}, "PriceList": {"Menu": true}}	GUADALUPE
8	201700412	Sample	Sample	Sample	2	2017-12-06 15:28:42.299306+08	f	92d85403814002271a64e291dd433483	sample@gmail.com	00	00	\N	{"Admin": {"Modules": {"One": false}}}	GUADALUPE
\.


--
-- Name: users_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('users_pk_seq', 8, true);


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

