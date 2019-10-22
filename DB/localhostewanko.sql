--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.7
-- Dumped by pg_dump version 9.5.7

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
    product_branches text
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
201700838	202cb962ac59075b964b07152d234b70	1
\.


--
-- Data for Name: added_user_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY added_user_data (pk, user_id, first_name, middle_name, last_name, user_type, date_created, archived, stall_code, sales_dept) FROM stdin;
1	201700838	Patrick	Matetu	Chavez	1	2017-11-02 11:07:20.68508+08	f	A10239019	01
\.


--
-- Name: added_user_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('added_user_data_pk_seq', 1, true);


--
-- Data for Name: branch_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY branch_data (pk, branch_name, address, contact_person, contact_number, date_created, archived) FROM stdin;
1	Invento	Guadalupe, Makati	Patrick	0929003290932	2017-11-09 09:35:32.454111+08	f
\.


--
-- Name: branch_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('branch_data_pk_seq', 2, true);


--
-- Data for Name: cancelled_transact_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY cancelled_transact_data (pk, product_name, product_quantity, product_supplier_price, product_retail_price, product_transaction_number, vat_percentage, net_amount, vat, discount, change, cash, tempo_total, void_count, total, gc_amount, gc_name, gc_code, cashier_user_id, date_created, archived, product_pk) FROM stdin;
5	test2	1	1	1.00	2452185287	12	0.89	0.11	0	0.00	1.00	1.00	0	1.00	0	none	none	2014000100	2017-11-06 11:23:20.280632+08	f	6
\.


--
-- Name: cancelled_transact_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('cancelled_transact_data_pk_seq', 5, true);


--
-- Data for Name: customer_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY customer_data (pk, first_name, middle_name, last_name, email, contact_number, date_created, archived) FROM stdin;
1	Patrick	Matetu	Chavez	pchavez.chrs@gmail.com	0912039310	2017-11-07 15:24:57.826077+08	f
\.


--
-- Name: customer_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('customer_data_pk_seq', 3, true);


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
1	Product Edit	 R-Wayne Lipardo edited jasonPAQ	2014000100	2017-11-24 09:58:57.360857+08	f
2	Product Edit	 R-Wayne Lipardo edited Product 1	2014000100	2017-11-24 13:45:23.4196+08	f
3	Product Edit	 R-Wayne Lipardo edited jasonPAQ	2014000100	2017-11-24 13:45:50.183363+08	f
\.


--
-- Name: history_log_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('history_log_data_pk_seq', 3, true);


--
-- Data for Name: product_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY product_data (pk, product_name, product_bar_code, product_stocks, product_srp, product_price, product_supplier, date_created, archived, product_receipt_name, product_status, product_or_number, product_or_stocks, product_product_code, product_rules, product_kind, request_order_status, product_expiration, product_branches, product_image) FROM stdin;
13	jasonPAQ	09213190	100	1	1	Patrick	2017-11-17 09:22:45.809269+08	f	1	(NEW)	1	100	1	No Rule	Food	\N	Nov 24, 2017	\N	ASSETS/pictures/20171124/ba8d4FTPAMQvLdxUKBmeX0jfmlhFhqn6GlZBqqOo0dZC6KUHJ4.jpg
2	Test	1	9999	1	1	Patrick	2017-11-02 12:01:34.799998+08	f	1	(OLD)	1	1	1	No Rule	Food	\N	Nov 2, 2017	\N	\N
3	test2	1	9999	1	1	1	2017-11-02 13:08:13.293213+08	f	1	(OLD)	1	1	1	No Rule	Food	\N	Nov 2, 2017	\N	\N
4	test2	1	9999	1	1	1	2017-11-02 13:30:55.503795+08	f	1	(OLD)	1	1	1	No Rule	Food	\N	Nov 2, 2017	\N	\N
5	test2	1	9999	1	1	1	2017-11-02 13:31:05.363344+08	f	1	(OLD)	1	1	1	No Rule	Food	\N	Nov 2, 2017	\N	\N
6	test2	1	9997	1	1	Patrick	2017-11-02 13:31:10.114742+08	f	1	(OLD)	1	1	NO DATA	No Rule	Food	\N	Nov 2, 2017	\N	\N
7	1	1	9999	1	1	Patrick	2017-11-09 10:57:21.762848+08	f	1	(OLD)	1	1	1	No Rule	Food	true	Nov 9, 2017	Invento	ASSETS/uploads/picture/20171117/1CJadkHbs8XeJCdRPOHvjRTyIuC2hHCYJJxms4Ca0Z29ZTRphY.png
10	1	1	1	1	1	1	2017-11-16 14:44:56.881642+08	f	1	(OLD)	1	1	1	No Rule	Food	\N	Nov 16, 2017	Invento	ASSETS/uploads/picture/20171117/EYUZBdxPQA1dpoeuiiaPQAMEGdbsiY1kvL7wmu92vzTYdvI9Ti.png
11	1	1	1	1	1	Patrick	2017-11-17 09:16:25.772688+08	f	1	(NEW)	1	1	1	No Rule	Food	\N	Nov 16, 2017	\N	ASSETS/uploads/picture/20171117/Oh344XUhPfD8H3gx0zgvPbg3bnSOBeNQCFI4caZq3coBULwK8S.png
12	jasonPAQ	09213190	100	1	1	1	2017-11-17 09:22:13.716995+08	f	1	(OLD)	1	100	1	No Rule	Food	\N	Nov 17, 2017	Invento	ASSETS/uploads/picture/20171117/mGym0jRXtGZFWiX4sWnthfBWdlBlOPB0VxcKWsfFy3IIbfDI0q.jpg
\.


--
-- Name: product_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('product_data_pk_seq', 14, true);


--
-- Data for Name: refund_item_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY refund_item_data (pk, product_name, product_srp, product_bar_code, product_stocks, product_price, product_expiration, product_supplier, product_receipt_name, product_or_number, product_or_stocks, product_product_code, product_rules, product_kind, date_created, archived) FROM stdin;
1	test2	1	1	10000	1	Nov 2, 2017	Patrick	1	1	10000	NO DATA	No Rule	Food	2017-11-02 15:16:53.848675+08	f
2	test2	1	1	10000	1	Nov 2, 2017	Patrick	1	1	10000	NO DATA	No Rule	Food	2017-11-02 16:40:52.582893+08	f
3	test2	1	1	9999	1	Nov 2, 2017	Patrick	1	1	9999	NO DATA	No Rule	Food	2017-11-06 11:27:45.173371+08	f
\.


--
-- Name: refund_item_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('refund_item_data_pk_seq', 3, true);


--
-- Data for Name: request_order_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY request_order_data (pk, product_finalnumber, product_quantity, product_date_needed, product_market_price, product_pk, status, date_created, archived, product_name, request_order_status, remarks, requested_by_pk) FROM stdin;
1	5FQZ1-X2IRK	1	Nov 10, 2017 12:00:00 AM	1	7	Approved	2017-11-10 15:17:45.796775+08	t	1	null	Approved	3
2	C2W7F-6QPR7	1	Nov 10, 2017 12:00:00 AM	1	7	Approved	2017-11-10 15:18:44.951241+08	t	1	null	Approved	3
\.


--
-- Name: request_order_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('request_order_data_pk_seq', 2, true);


--
-- Data for Name: rules_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY rules_data (pk, rule_name, date_created, archived) FROM stdin;
2	No Rule	2017-11-02 11:59:17.645492+08	f
\.


--
-- Name: rules_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('rules_data_pk_seq', 2, true);


--
-- Data for Name: supplier_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY supplier_data (pk, supplier_name, supplier_address, supplier_contact_number, supplier_contact_person, supplier_code_name, date_created, archived) FROM stdin;
1	Patrick	Patrick	0000000	Patrick	Patrick	2017-11-02 11:57:27.006234+08	f
\.


--
-- Name: supplier_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('supplier_data_pk_seq', 1, true);


--
-- Data for Name: tender_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY tender_data (pk, product_name, product_quantity, product_supplier_price, product_retail_price, product_transaction_number, vat_percentage, net_amount, vat, discount, change, cash, tempo_total, void_count, total, gc_amount, gc_name, gc_code, cashier_user_id, date_created, archived, product_pk, cancelled_amount, product_branches) FROM stdin;
5	test2	1	1	1.00	0965691213	12	0.89	0.11	0	4.00	5.00	1.00	0	1.00	0	none	none	2014000100	2017-11-03 11:04:28.927065+08	f	6	\N	\N
6	test2	1	1	1.00	2452185287	12	0.89	0.11	0	0.00	1.00	1.00	0	1.00	0	none	none	2014000100	2017-11-06 11:23:20.280632+08	f	6	0.11	\N
7	test2	9	1	1.00	6265084978	12	8.04	0.96	0	1.00	10.00	9.00	0	9.00	0	none	none	2014000100	2017-11-06 11:26:07.398377+08	f	6	\N	\N
8	test2	-1	1	1.00	5030862268	12	-0.89	-0.11	0	11.00	10.00	-1.00	0	-1.00	0	none	none	2014000100	2017-11-06 17:19:56.720762+08	f	6	\N	\N
9	test2	2	1	1.00	4444465549	12	1.79	0.21	0	10000000000000000000.00	10000000000000000000.00	2.00	0	2.00	0	none	none	2014000100	2017-11-08 11:05:12.768087+08	f	6	\N	\N
10	test2	1	1	1.00	1722575108	12	0.89	0.11	0	3.00	4.00	1.00	0	1.00	0	none	none	2014000100	2017-11-08 11:05:33.036403+08	f	6	\N	\N
11	1	1	1	1.00	4784666839	12	0.89	0.11	0	0.00	1.00	1.00	0	1.00	0	none	none	2014000100	2017-11-13 13:42:09.091977+08	f	7	\N	
12	1	1	1	1.00	3786189475	12	0.89	0.11	0	1.00	2.00	1.00	0	1.00	0	none	none	2014000100	2017-11-13 13:44:36.367926+08	f	7	\N	Invento
\.


--
-- Name: tender_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('tender_data_pk_seq', 12, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY users (pk, user_id, first_name, middle_name, last_name, user_type, date_created, archived, superior_pin, email, stall_code, sales_dept) FROM stdin;
1	201400028	Patrick	Matetu	Chavez	1	2017-11-02 10:50:34.866187+08	f	92d85403814002271a64e291dd433483	\N	A0f90033	02
2	201400072	Ken	Villanueva	Tapdasan	2	2017-11-02 10:50:34.880426+08	f	92d85403814002271a64e291dd433483	\N	A0f90033	02
3	2014000100	R-Wayne	Feliciano	Lipardo	1	2017-11-02 10:50:35.652581+08	f	92d85403814002271a64e291dd433483	\N	A0f90033	02
4	201700838	Patrick	Matetu	Chavez	1	2017-11-02 11:07:20.68508+08	f	92d85403814002271a64e291dd433483	pchavez.chrs@gmail.com	A0f90033	02
\.


--
-- Name: users_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('users_pk_seq', 4, true);


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

