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
    archived boolean DEFAULT false
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
    product_expiration timestamp with time zone,
    product_product_expiration timestamp without time zone,
    product_or_stocks text,
    product_product_code text,
    product_kind text,
    product_rules text,
    request_order_status text
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
-- Name: request_order_data; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE request_order_data (
    pk integer NOT NULL,
    product_finalnumber text NOT NULL,
    product_quantity text NOT NULL,
    product_date_needed text NOT NULL,
    product_market_price text NOT NULL,
    product_pk integer,
    status text DEFAULT 'Pending'::text,
    date_created timestamp with time zone DEFAULT now(),
    archived boolean DEFAULT false,
    product_name text,
    request_order_status text,
    id integer,
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
-- Name: superior_pin; Type: TABLE; Schema: public; Owner: ktapdasan
--

CREATE TABLE superior_pin (
    password text DEFAULT md5('SirWayne'::text)
);


ALTER TABLE superior_pin OWNER TO ktapdasan;

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
    product_receipt_name text
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
    email text
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

ALTER TABLE ONLY gift_certificate_data ALTER COLUMN pk SET DEFAULT nextval('gift_certificate_data_pk_seq'::regclass);


--
-- Name: pk; Type: DEFAULT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY product_data ALTER COLUMN pk SET DEFAULT nextval('product_data_pk_seq'::regclass);


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
201400072	d9df80dcfc3a7096ebebc461398a2427	2
2014000100	d9df80dcfc3a7096ebebc461398a2427	1
201400028	d9df80dcfc3a7096ebebc461398a2427	1
201700314	202cb962ac59075b964b07152d234b70	2
201700237	202cb962ac59075b964b07152d234b70	1
\.


--
-- Data for Name: added_user_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY added_user_data (pk, user_id, first_name, middle_name, last_name, user_type, date_created, archived) FROM stdin;
4	201700314	1231	312	312	2	2017-10-17 11:09:44.087122+08	f
1	201700237	Patrick	Matetu	Chavez	1	2017-09-14 15:15:32.199108+08	f
\.


--
-- Name: added_user_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('added_user_data_pk_seq', 4, true);


--
-- Data for Name: gift_certificate_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY gift_certificate_data (pk, gc_name, gc_code, gc_amount, cashier_user_id, date_created, archived) FROM stdin;
1	SODEXO	12310239130190	100	2014000100	2017-09-07 09:00:29.955303+08	f
2	SODEXO	102391030193	100	2014000100	2017-09-07 09:05:49.806891+08	f
3	SODEXO	10923909120	100	2014000100	2017-09-07 09:09:04.749835+08	f
4	sdofadf	103129320	100	2014000100	2017-09-07 09:10:10.22584+08	f
5	dfakjsf	13930190	200	2014000100	2017-09-07 09:11:01.403052+08	f
6	asdf	131023901391	100	2014000100	2017-09-07 09:13:10.557558+08	f
7	adsfa1	123130	10239120312	2014000100	2017-09-07 09:14:06.932885+08	f
8	asdfkjasfj	1000	100	2014000100	2017-09-07 09:15:06.062904+08	f
9	weiajfsj	029190	0101019	2014000100	2017-09-07 09:15:59.988236+08	f
10	dfjasjfkas	1-2301-3010	2190	2014000100	2017-09-07 09:16:36.414813+08	f
11	lajsfksjfak	100	100	2014000100	2017-09-07 09:17:30.98772+08	f
12	afadf	123123	100	2014000100	2017-09-07 09:19:52.731897+08	f
13	SODEXO	123812391239	100	2014000100	2017-09-07 09:23:04.283346+08	f
14	asjfks	09323	19010	2014000100	2017-09-07 09:23:47.125822+08	f
15	djfasdfkjs	100010319	100	2014000100	2017-09-07 09:24:26.82822+08	f
16	undefined	undefined	undefined	2014000100	2017-09-18 09:06:37.970293+08	f
17	adfads	213123123123213	1233	2014000100	2017-09-18 09:13:41.555266+08	f
18	SODEXO	12324124123124	1000	2014000100	2017-09-22 14:32:10.744394+08	f
19	afasfsf	afafsdfaffsadfads	100	2014000100	2017-09-28 09:17:21.827226+08	f
20	sadfas	adfafasas	100	2014000100	2017-09-28 09:22:15.32149+08	f
21	SODEXO	091203910209	100	2014000100	2017-09-28 09:23:00.098871+08	f
22	SODEXO	0909123010	100	2014000100	2017-09-28 10:17:27.238656+08	f
23	SODEXO	103923	100	2014000100	2017-09-28 10:24:58.533745+08	f
24	SODEXO	0909009	100	2014000100	2017-09-28 10:27:45.628181+08	f
25	SODEXO	1023930	100	2014000100	2017-09-28 10:29:58.633641+08	f
26	SODEXO	09092309029	100	2014000100	2017-09-28 10:31:11.545471+08	f
27	SODEXO	092032	100	2014000100	2017-09-28 10:32:26.437047+08	f
28	SODEXO	09123912	100	2014000100	2017-09-28 10:33:40.93501+08	f
29	SODEXO	02931239	100	2014000100	2017-09-28 10:35:20.958722+08	f
30	SODEXO	092030901039	1000	2014000100	2017-10-03 15:32:04.092614+08	f
31	SODEXO	0919034920229	1000	2014000100	2017-10-05 09:16:49.348195+08	f
32	SODEXO	1231246	1000	2014000100	2017-10-05 09:47:48.104819+08	f
33	SODEXO	1234445	1000	2014000100	2017-10-05 09:54:29.588759+08	f
34	SODEXO	123456	100	2014000100	2017-10-05 10:47:48.079192+08	f
35	fasd	adfs	1000	2014000100	2017-10-05 14:58:13.279968+08	f
36	1231	31231	312321	2014000100	2017-10-05 14:59:38.100026+08	f
\.


--
-- Name: gift_certificate_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('gift_certificate_data_pk_seq', 36, true);


--
-- Data for Name: product_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY product_data (pk, product_name, product_bar_code, product_stocks, product_srp, product_price, product_supplier, date_created, archived, product_receipt_name, product_status, product_or_number, product_expiration, product_product_expiration, product_or_stocks, product_product_code, product_kind, product_rules, request_order_status) FROM stdin;
69	Smart Prepaid 40	123123	0	123	1	Wayne Corp.	2017-10-13 11:18:23.815116+08	f	12312	(NEW)	1231	2017-10-13 00:00:00+08	\N	500	Smart Prepaid	Nonfood	Shared Stocks	true
64	test2	00	199	123	123	Wayne Corp.	2017-10-11 17:03:50.499853+08	f	1231	(NEW)	00000	2017-10-10 00:00:00+08	\N	\N	No Code	Food	Testing	\N
65	Globe Prepaid 30	0000	5	123	33	Wayne Corp.	2017-10-12 08:59:33.386005+08	f	1322	(NEW)	1111	2017-10-13 00:00:00+08	\N	\N	Globe Prepaid	Nonfood	Shared Stocks	\N
67	Globe Prepaid 20	12312312	0	123	1	Wayne Corp.	2017-10-12 13:42:26.202368+08	f	123	(NEW)	123	2017-10-13 00:00:00+08	\N	123	Globe Prepaid	Nonfood	Shared Stocks	true
68	GARDENIA CREAM ROLL COOKIES AND CREAM 50G	123	-1	200	1	Wayne Corp.	2017-10-13 11:17:54.570356+08	f	1231	(NEW)	12312	2017-10-13 00:00:00+08	\N	500	Smart Prepaid	Nonfood	Shared Stocks	true
63	Test	0	9	12	12	Wayne Corp.	2017-10-11 17:02:35.3905+08	f	12	(NEW)	123	2017-10-13 00:00:00+08	\N	\N	null	null	null	\N
\.


--
-- Name: product_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('product_data_pk_seq', 72, true);


--
-- Data for Name: request_order_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY request_order_data (pk, product_finalnumber, product_quantity, product_date_needed, product_market_price, product_pk, status, date_created, archived, product_name, request_order_status, id, remarks, requested_by_pk) FROM stdin;
22	1S6JY-7JQGV	4.00	Oct 17, 2017 12:00:00 AM	4.00	69	Approved	2017-10-17 16:42:46.843458+08	t	Smart Prepaid 40	null	\N	Approved	\N
25	AI5UF-FXARU	4.00	Oct 17, 2017 12:00:00 AM	4.00	68	Disapproved	2017-10-17 16:50:56.105615+08	t	Smart Prepaid 30	null	\N	hehehe	2
\.


--
-- Name: request_order_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('request_order_data_pk_seq', 35, true);


--
-- Data for Name: rules_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY rules_data (pk, rule_name, date_created, archived) FROM stdin;
2	Shared Stocks	2017-10-09 13:44:41.62119+08	f
3	Testing	2017-10-12 13:59:48.040495+08	f
\.


--
-- Name: rules_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('rules_data_pk_seq', 3, true);


--
-- Data for Name: superior_pin; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY superior_pin (password) FROM stdin;
\.


--
-- Data for Name: supplier_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY supplier_data (pk, supplier_name, supplier_address, supplier_contact_number, supplier_contact_person, supplier_code_name, date_created, archived) FROM stdin;
2	Chavez-Lapid Corp.	Quezon City	143143	Patty	CLC	2017-08-18 13:52:20.295192+08	f
3	Wayne Corp.	Boni Mandaluyong	99000909	R-Wayne Lipardo	Wayne Corp.	2017-08-22 13:19:39.765518+08	f
1	An Office Management Outsourcing Services	BONI	9000000	SIR WAYNE	AOMOS	2017-08-18 13:35:48.783795+08	f
\.


--
-- Name: supplier_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('supplier_data_pk_seq', 6, true);


--
-- Data for Name: tender_data; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY tender_data (pk, product_name, product_quantity, product_supplier_price, product_retail_price, product_transaction_number, vat_percentage, net_amount, vat, discount, change, cash, tempo_total, void_count, total, gc_amount, gc_name, gc_code, cashier_user_id, date_created, archived, product_pk, product_receipt_name) FROM stdin;
152	11232112312	3	5.00	10.00	00BH58SVQG	12	26.79	3.21	0	10.00	40.00	30.00	0	30.00	0	none	none	2014000100	2017-10-06 16:01:14.845885+08	f	53	\N
153	Argentina Corned Beef (455g)	3	25.45	30.00	D5C35SE58P	12	80.36	9.64	0	10.00	100.00	90.00	0	90.00	0	none	none	2014000100	2017-10-06 16:01:39.663548+08	f	33	\N
154	28.00	3	12312	28.00	FPWX7OOZ7O	12	75.00	9.00	0	6.00	90.00	84.00	0	84.00	0	none	none	2014000100	2017-10-06 16:03:15.226859+08	f	54	\N
155	28.00	3	12312	28.00	WB5KEM0S28	12	75.00	9.00	0	6.00	90.00	84.00	0	84.00	0	none	none	2014000100	2017-10-06 16:05:21.866239+08	f	54	\N
156	28.00	3	12312	28.00	HCS96N3LFK	12	75.00	9.00	0	6.00	90.00	84.00	0	84.00	0	none	none	2014000100	2017-10-06 16:06:25.13666+08	f	54	\N
157	28.00	3	12312	28.00	0UPXBZCV0M	12	75.00	9.00	0	6.00	90.00	84.00	0	84.00	0	none	none	2014000100	2017-10-06 16:10:26.733782+08	f	54	\N
158	28.00	3	12312	28.00	5DX8OTWBR0	12	75.00	9.00	0	6.00	90.00	84.00	0	84.00	0	none	none	2014000100	2017-10-06 16:13:50.292689+08	f	54	\N
159	28.00	3	12312	28.00	IQXIANA4YU	12	75.00	9.00	0	6.00	90.00	84.00	0	84.00	0	none	none	2014000100	2017-10-06 16:14:52.500125+08	f	54	\N
160	28.00	3	12312	28.00	98DPSN363I	12	75.00	9.00	0	6.00	90.00	84.00	0	84.00	0	none	none	2014000100	2017-10-06 16:37:09.128059+08	f	54	\N
161	1233	3	12312	1231.00	2LZRYLDIXH	12	3297.32	395.68	0	307.00	4000.00	3693.00	0	3693.00	0	none	none	2014000100	2017-10-06 17:03:05.236946+08	f	55	\N
162	1233	3	12312	1231.00	KYEBL5PAZ9	12	3297.32	395.68	0	307.00	4000.00	3693.00	0	3693.00	0	none	none	2014000100	2017-10-09 07:42:30.738983+08	f	55	\N
163	1233	2	12312	1231.00	9O1A1HL8JG	12	2198.21	263.79	0	538.00	3000.00	2462.00	1	2462.00	0	none	none	2014000100	2017-10-09 15:06:06.621808+08	f	55	\N
164	1233	1	12312	1231.00	LLOKN6RUJQ	12	1099.11	131.89	0	69.00	1300.00	1231.00	0	1231.00	0	none	none	2014000100	2017-10-09 15:10:15.500538+08	f	55	pasok
165	1233	1	12312	1231.00	NDC6QB8CO0	12	1099.11	131.89	0	1.00	1232.00	1231.00	1	1231.00	0	none	none	2014000100	2017-10-10 12:30:42.146624+08	f	55	\N
166	test	1	undefined	2.00	OUHEEG83F1	12	1.79	0.21	0	1.00	3.00	2.00	0	2.00	0	none	none	2014000100	2017-10-10 12:32:58.222987+08	f	56	\N
167	1233	1	12312	1231.00	VCEYU22VGR	12	1099.11	131.89	0	1.00	1232.00	1231.00	0	1231.00	0	none	none	2014000100	2017-10-10 13:53:13.000407+08	f	55	\N
168	28.00	1	12312	28.00	1JKNQREUHZ	12	25.00	3.00	0	2.00	30.00	28.00	0	28.00	0	none	none	2014000100	2017-10-11 10:10:47.854546+08	f	54	\N
169	test2	1	123	123.00	7304379132	12	109.82	13.18	0	1.00	124.00	123.00	0	123.00	0	none	none	2014000100	2017-10-12 11:04:43.617235+08	f	64	\N
170	test3	2	123	123.00	3434080558	12	219.64	26.36	0	4.00	250.00	246.00	0	246.00	0	none	none	2014000100	2017-10-12 13:10:19.09961+08	f	65	\N
171	test2	1	123	123.00	8451522582	12	109.82	13.18	0	-123.00	0.00	123.00	0	123.00	0	none	none	2014000100	2017-10-12 13:10:51.8198+08	f	64	\N
172	test4	2	123	123.00	1350409183	12	219.64	26.36	0	4.00	250.00	246.00	0	246.00	0	none	none	2014000100	2017-10-13 09:08:07.250587+08	f	67	\N
173	test4	5	123	123.00	9609018474	12	549.11	65.89	0	85.00	700.00	615.00	0	615.00	0	none	none	2014000100	2017-10-13 09:14:57.785159+08	f	67	\N
174	test4	1	123	123.00	9151434312	12	109.82	13.18	0	1.00	124.00	123.00	0	123.00	0	none	none	2014000100	2017-10-13 09:21:40.706295+08	f	67	\N
175	test4	1	123	123.00	2681676959	12	109.82	13.18	0	1.00	124.00	123.00	0	123.00	0	none	none	2014000100	2017-10-13 09:35:13.214642+08	f	67	\N
176	test4	5	123	123.00	0045722729	12	549.11	65.89	0	85.00	700.00	615.00	0	615.00	0	none	none	2014000100	2017-10-13 09:35:40.383734+08	f	67	\N
177	test2	1	123	123.00	4414254959	12	109.82	13.18	0	1.00	124.00	123.00	0	123.00	0	none	none	2014000100	2017-10-13 09:39:39.437999+08	f	64	\N
178	test2	1	123	123.00	6840460695	12	109.82	13.18	0	1.00	124.00	123.00	1	123.00	0	none	none	2014000100	2017-10-13 09:40:10.544452+08	f	64	\N
179	test4	1	123	123.00	1721773064	12	109.82	13.18	0	1.00	124.00	123.00	0	123.00	0	none	none	2014000100	2017-10-13 09:56:40.152093+08	f	67	\N
180	Globe Prepaid 20	20	123	1.00	8709975803	12	17.86	2.14	0	10.00	30.00	20.00	0	20.00	0	none	none	2014000100	2017-10-13 10:06:07.574311+08	f	67	\N
181	Globe Prepaid 30	30	123	33.00	3050110355	12	883.93	106.07	0	10.00	1000.00	990.00	0	990.00	0	none	none	2014000100	2017-10-13 10:06:50.089148+08	f	65	\N
182	Smart Prepaid 40	40	123	1.00	3280077091	12	35.71	4.29	0	0.00	40.00	40.00	0	40.00	0	none	none	2014000100	2017-10-13 11:18:54.606708+08	f	69	\N
183	Smart Prepaid 40	40	123	1.00	0207970341	12	35.71	4.29	0	0.00	40.00	40.00	0	40.00	0	none	none	2014000100	2017-10-13 11:19:18.91378+08	f	69	\N
184	Smart Prepaid 40	49	123	1.00	9948420758	12	43.75	5.25	0	1.00	50.00	49.00	0	49.00	0	none	none	2014000100	2017-10-13 11:45:08.693299+08	f	69	\N
185	Globe Prepaid 20	12	123	1.00	5538489981	12	364.29	43.71	0	2.00	410.00	12.00	0	408.00	0	none	none	2014000100	2017-10-13 12:58:33.269843+08	f	67	\N
186	Globe Prepaid 30	12	123	33.00	5538489981	12	364.29	43.71	0	2.00	410.00	396.00	0	408.00	0	none	none	2014000100	2017-10-13 12:58:33.269843+08	f	65	\N
187	Globe Prepaid 20	1	123	1.00	5276773359	12	354.46	42.54	0	3.00	400.00	1.00	0	397.00	0	none	none	2014000100	2017-10-13 12:59:52.169323+08	f	67	\N
188	Globe Prepaid 30	12	123	33.00	5276773359	12	354.46	42.54	0	3.00	400.00	396.00	0	397.00	0	none	none	2014000100	2017-10-13 12:59:52.169323+08	f	65	\N
189	Smart Prepaid 40	1	123	1.00	8953413531	12	2.68	0.32	0	1.00	4.00	1.00	0	3.00	0	none	none	2014000100	2017-10-13 13:26:21.31744+08	f	69	\N
190	Smart Prepaid 30	2	123	1.00	8953413531	12	2.68	0.32	0	1.00	4.00	2.00	0	3.00	0	none	none	2014000100	2017-10-13 13:26:21.31744+08	f	68	\N
191	Smart Prepaid 40	1	123	1.00	4133911380	12	2.68	0.32	0	1.00	4.00	1.00	0	3.00	0	none	none	2014000100	2017-10-13 13:28:27.894884+08	f	69	\N
192	Smart Prepaid 30	2	123	1.00	4133911380	12	2.68	0.32	0	1.00	4.00	2.00	0	3.00	0	none	none	2014000100	2017-10-13 13:28:27.894884+08	f	68	\N
193	Smart Prepaid 40	1	123	1.00	2632284325	12	2.68	0.32	0	1.00	4.00	1.00	0	3.00	0	none	none	2014000100	2017-10-13 13:31:09.711275+08	f	69	\N
194	Smart Prepaid 30	2	123	1.00	2632284325	12	2.68	0.32	0	1.00	4.00	2.00	0	3.00	0	none	none	2014000100	2017-10-13 13:31:09.711275+08	f	68	\N
195	Smart Prepaid 40	4	123	1.00	1712325753	12	6.25	0.75	0	1.00	8.00	4.00	0	7.00	0	none	none	2014000100	2017-10-13 13:32:17.268738+08	f	69	\N
196	Smart Prepaid 30	3	123	1.00	1712325753	12	6.25	0.75	0	1.00	8.00	3.00	0	7.00	0	none	none	2014000100	2017-10-13 13:32:17.268738+08	f	68	\N
197	Smart Prepaid 40	4	123	1.00	2202446529	12	6.25	0.75	0	1.00	8.00	4.00	0	7.00	0	none	none	2014000100	2017-10-13 13:32:59.044385+08	f	69	\N
198	Smart Prepaid 30	3	123	1.00	2202446529	12	6.25	0.75	0	1.00	8.00	3.00	0	7.00	0	none	none	2014000100	2017-10-13 13:32:59.044385+08	f	68	\N
199	Smart Prepaid 40	1	123	1.00	9861869245	12	3.57	0.43	0	1.00	5.00	1.00	0	4.00	0	none	none	2014000100	2017-10-13 13:35:45.637297+08	f	69	\N
200	Smart Prepaid 30	3	123	1.00	9861869245	12	3.57	0.43	0	1.00	5.00	3.00	0	4.00	0	none	none	2014000100	2017-10-13 13:35:45.637297+08	f	68	\N
201	Smart Prepaid 40	1	123	1.00	6688168606	12	3.57	0.43	0	1.00	5.00	1.00	0	4.00	0	none	none	2014000100	2017-10-13 13:38:02.351853+08	f	69	\N
202	Smart Prepaid 30	3	123	1.00	6688168606	12	3.57	0.43	0	1.00	5.00	3.00	0	4.00	0	none	none	2014000100	2017-10-13 13:38:02.351853+08	f	68	\N
203	Smart Prepaid 40	1	123	1.00	0499462311	12	3.57	0.43	0	1.00	5.00	1.00	0	4.00	0	none	none	2014000100	2017-10-13 13:39:31.125387+08	f	69	\N
204	Smart Prepaid 30	3	123	1.00	0499462311	12	3.57	0.43	0	1.00	5.00	3.00	0	4.00	0	none	none	2014000100	2017-10-13 13:39:31.125387+08	f	68	\N
205	Smart Prepaid 40	1	123	1.00	6350795230	12	3.57	0.43	0	1.00	5.00	1.00	0	4.00	0	none	none	2014000100	2017-10-13 13:40:37.617585+08	f	69	\N
206	Smart Prepaid 30	3	123	1.00	6350795230	12	3.57	0.43	0	1.00	5.00	3.00	0	4.00	0	none	none	2014000100	2017-10-13 13:40:37.617585+08	f	68	\N
207	Smart Prepaid 40	1	123	1.00	9301721205	12	3.57	0.43	0	1.00	5.00	1.00	0	4.00	0	none	none	2014000100	2017-10-13 13:41:40.600194+08	f	69	\N
208	Smart Prepaid 30	3	123	1.00	9301721205	12	3.57	0.43	0	1.00	5.00	3.00	0	4.00	0	none	none	2014000100	2017-10-13 13:41:40.600194+08	f	68	\N
209	Smart Prepaid 40	1	123	1.00	4931132307	12	3.57	0.43	0	1.00	5.00	1.00	0	4.00	0	none	none	2014000100	2017-10-13 13:44:23.529333+08	f	69	\N
210	Smart Prepaid 30	3	123	1.00	4931132307	12	3.57	0.43	0	1.00	5.00	3.00	0	4.00	0	none	none	2014000100	2017-10-13 13:44:23.529333+08	f	68	\N
211	test2	2	123	123.00	0455223403	12	221.43	26.57	0	2.00	250.00	246.00	0	248.00	0	none	none	2014000100	2017-10-13 13:55:18.436267+08	f	64	\N
212	Smart Prepaid 30	1	200	1.00	0455223403	12	221.43	26.57	0	2.00	250.00	1.00	0	248.00	0	none	none	2014000100	2017-10-13 13:55:18.436267+08	f	68	\N
213	Smart Prepaid 40	1	123	1.00	0455223403	12	221.43	26.57	0	2.00	250.00	1.00	0	248.00	0	none	none	2014000100	2017-10-13 13:55:18.436267+08	f	69	\N
214	test2	1	123	123.00	8059611100	12	115.18	13.82	0	1.00	130.00	123.00	0	129.00	0	none	none	2014000100	2017-10-13 13:57:13.009512+08	f	64	\N
215	Smart Prepaid 40	3	123	1.00	8059611100	12	115.18	13.82	0	1.00	130.00	3.00	0	129.00	0	none	none	2014000100	2017-10-13 13:57:13.009512+08	f	69	\N
216	Smart Prepaid 30	3	200	1.00	8059611100	12	115.18	13.82	0	1.00	130.00	3.00	0	129.00	0	none	none	2014000100	2017-10-13 13:57:13.009512+08	f	68	\N
217	test2	1	123	123.00	9533003576	12	114.29	13.71	0	2.00	130.00	123.00	0	128.00	0	none	none	2014000100	2017-10-13 14:00:42.137542+08	f	64	\N
218	Smart Prepaid 40	2	123	1.00	9533003576	12	114.29	13.71	0	2.00	130.00	2.00	0	128.00	0	none	none	2014000100	2017-10-13 14:00:42.137542+08	f	69	\N
219	Smart Prepaid 30	3	200	1.00	9533003576	12	114.29	13.71	0	2.00	130.00	3.00	0	128.00	0	none	none	2014000100	2017-10-13 14:00:42.137542+08	f	68	\N
220	test2	1	123	123.00	3039228057	12	114.29	13.71	0	2.00	130.00	123.00	0	128.00	0	none	none	2014000100	2017-10-13 14:24:05.776279+08	f	64	\N
221	Smart Prepaid 40	2	123	1.00	3039228057	12	114.29	13.71	0	2.00	130.00	2.00	0	128.00	0	none	none	2014000100	2017-10-13 14:24:05.776279+08	f	69	\N
222	Smart Prepaid 30	3	200	1.00	3039228057	12	114.29	13.71	0	2.00	130.00	3.00	0	128.00	0	none	none	2014000100	2017-10-13 14:24:05.776279+08	f	68	\N
223	test2	1	123	123.00	4148226079	12	116.07	13.93	0	10.00	140.00	123.00	0	130.00	0	none	none	2014000100	2017-10-13 14:29:57.756239+08	f	64	\N
224	Smart Prepaid 40	3	123	1.00	4148226079	12	116.07	13.93	0	10.00	140.00	3.00	0	130.00	0	none	none	2014000100	2017-10-13 14:29:57.756239+08	f	69	\N
225	Smart Prepaid 30	4	200	1.00	4148226079	12	116.07	13.93	0	10.00	140.00	4.00	0	130.00	0	none	none	2014000100	2017-10-13 14:29:57.756239+08	f	68	\N
226	Smart Prepaid 40	1	123	1.00	3571829461	12	112.50	13.50	0	4.00	130.00	1.00	0	126.00	0	none	none	2014000100	2017-10-13 16:20:24.192453+08	f	69	\N
227	Smart Prepaid 30	1	200	1.00	3571829461	12	112.50	13.50	0	4.00	130.00	1.00	0	126.00	0	none	none	2014000100	2017-10-13 16:20:24.192453+08	f	68	\N
228	Globe Prepaid 20	1	123	1.00	3571829461	12	112.50	13.50	0	4.00	130.00	1.00	0	126.00	0	none	none	2014000100	2017-10-13 16:20:24.192453+08	f	67	\N
229	test2	1	123	123.00	3571829461	12	112.50	13.50	0	4.00	130.00	123.00	0	126.00	0	none	none	2014000100	2017-10-13 16:20:24.192453+08	f	64	\N
230	Smart Prepaid 40	1	123	1.00	8546081118	12	123.21	14.79	0	2.00	140.00	1.00	0	138.00	0	none	none	2014000100	2017-10-13 16:21:40.506235+08	f	69	\N
231	Smart Prepaid 30	1	200	1.00	8546081118	12	123.21	14.79	0	2.00	140.00	1.00	0	138.00	0	none	none	2014000100	2017-10-13 16:21:40.506235+08	f	68	\N
232	Globe Prepaid 20	1	123	1.00	8546081118	12	123.21	14.79	0	2.00	140.00	1.00	0	138.00	0	none	none	2014000100	2017-10-13 16:21:40.506235+08	f	67	\N
233	test2	1	123	123.00	8546081118	12	123.21	14.79	0	2.00	140.00	123.00	0	138.00	0	none	none	2014000100	2017-10-13 16:21:40.506235+08	f	64	\N
234	Test	1	12	12.00	8546081118	12	123.21	14.79	0	2.00	140.00	12.00	0	138.00	0	none	none	2014000100	2017-10-13 16:21:40.506235+08	f	63	\N
235	Smart Prepaid 40	5	123	1.00	1867000136	12	4.46	0.54	0	5.00	10.00	5.00	0	5.00	0	none	none	2014000100	2017-10-16 08:35:57.894192+08	f	69	\N
236	Smart Prepaid 40	1	123	1.00	8285746224	12	0.89	0.11	0	0.00	1.00	1.00	0	1.00	0	none	none	2014000100	2017-10-16 08:36:12.306592+08	f	69	\N
237	Smart Prepaid 40	3	123	1.00	5921691019	12	2.68	0.32	0	1.00	4.00	3.00	0	3.00	0	none	none	2014000100	2017-10-16 08:41:37.225513+08	f	69	\N
238	Smart Prepaid 40	5	123	1.00	6492666760	12	4.46	0.54	0	0.00	5.00	5.00	0	5.00	0	none	none	2014000100	2017-10-16 08:42:44.068255+08	f	69	\N
239	Smart Prepaid 40	5	123	1.00	2607466633	12	4.46	0.54	0	0.00	5.00	5.00	0	5.00	0	none	none	2014000100	2017-10-16 08:45:22.308546+08	f	69	\N
240	Smart Prepaid 40	20	123	1.00	7599928983	12	566.96	68.04	0	5.00	640.00	20.00	0	635.00	0	none	none	2014000100	2017-10-16 11:52:53.308736+08	f	69	\N
241	test2	5	123	123.00	7599928983	12	566.96	68.04	0	5.00	640.00	615.00	0	635.00	0	none	none	2014000100	2017-10-16 11:52:53.308736+08	f	64	\N
242	Smart Prepaid 40	40	123	1.00	5294535395	12	71.43	8.57	0	0.00	80.00	40.00	0	80.00	0	none	none	2014000100	2017-10-16 11:53:41.328732+08	f	69	\N
243	Smart Prepaid 30	40	200	1.00	5294535395	12	71.43	8.57	0	0.00	80.00	40.00	0	80.00	0	none	none	2014000100	2017-10-16 11:53:41.328732+08	f	68	\N
244	Smart Prepaid 40	20	123	1.00	1466943561	12	457.14	54.86	0	188.00	700.00	20.00	0	512.00	0	none	none	2014000100	2017-10-16 14:24:12.644081+08	f	69	\N
245	test2	4	123	123.00	1466943561	12	457.14	54.86	0	188.00	700.00	492.00	0	512.00	0	none	none	2014000100	2017-10-16 14:24:12.644081+08	f	64	\N
246	Smart Prepaid 40	40	123	1.00	3944830547	12	53.57	6.43	0	10.00	70.00	40.00	0	60.00	0	none	none	2014000100	2017-10-16 14:24:49.523677+08	f	69	\N
247	Globe Prepaid 20	20	123	1.00	3944830547	12	53.57	6.43	0	10.00	70.00	20.00	0	60.00	0	none	none	2014000100	2017-10-16 14:24:49.523677+08	f	67	\N
248	test2	2	123	123.00	5967620037	12	219.64	26.36	0	4.00	250.00	246.00	0	246.00	0	none	none	2014000100	2017-10-17 11:05:45.142278+08	f	64	\N
249	1231	10	32131	32131.00	5679844690	12	286883.93	34426.07	0	78690.00	400000.00	321310.00	0	321310.00	0	none	none	2014000100	2017-10-17 12:01:51.247802+08	f	72	\N
250	Smart Prepaid 40	40	123	1.00	4549704202	12	58291.07	6994.93	0	4714.00	70000.00	40.00	0	65286.00	0	none	none	2014000100	2017-10-17 12:03:04.238528+08	f	69	\N
251	test2	8	123	123.00	4549704202	12	58291.07	6994.93	0	4714.00	70000.00	984.00	0	65286.00	0	none	none	2014000100	2017-10-17 12:03:04.238528+08	f	64	\N
252	1231	2	32131	32131.00	4549704202	12	58291.07	6994.93	0	4714.00	70000.00	64262.00	0	65286.00	0	none	none	2014000100	2017-10-17 12:03:04.238528+08	f	72	\N
253	1231	1	32131	32131.00	8413777408	12	28688.39	3442.61	0	7869.00	40000.00	32131.00	0	32131.00	0	none	none	2014000100	2017-10-17 13:15:56.101408+08	f	72	\N
254	1231	100	32131	32131.00	3972415413	12	2868839.29	344260.71	0	999996786900.00	1000000000000.00	3213100.00	0	3213100.00	0	none	none	2014000100	2017-10-17 14:50:22.073148+08	f	72	\N
255	Test	10	12	12.00	3733428984	12	107.14	12.86	0	10.00	130.00	120.00	0	120.00	0	none	none	2014000100	2017-10-17 15:33:33.329493+08	f	63	\N
256	GARDENIA CREAM ROLL COOKIES AND CREAM 50G	1	200	1.00	3240872489	12	0.89	0.11	0	0.00	1.00	1.00	0	1.00	0	none	none	2014000100	2017-10-18 09:57:10.169802+08	f	68	\N
\.


--
-- Name: tender_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('tender_data_pk_seq', 256, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: ktapdasan
--

COPY users (pk, user_id, first_name, middle_name, last_name, user_type, date_created, archived, superior_pin, email) FROM stdin;
1	201400072	Ken	Villanueva	Tapdasan	2	2017-09-14 15:14:47.672456+08	f	92d85403814002271a64e291dd433483	pchavez.chrs@gmail.com
2	2014000100	R-Wayne	Feliciano	Lipardo	1	2017-09-14 15:14:48.039932+08	f	92d85403814002271a64e291dd433483	pchavez.chrs@gmail.com
6	201400028	Patrick	Matetu	Chavez	1	2017-10-02 08:41:22.275469+08	f	92d85403814002271a64e291dd433483	pchavez.chrs@gmail.com
7	201700314	1231	312	312	2	2017-10-17 11:09:44.087122+08	f	92d85403814002271a64e291dd433483	pchavez.chrs@gmail.com
3	201700237	Patrick	Matetu	Chavez	1	2017-09-14 15:15:32.199108+08	f	92d85403814002271a64e291dd433483	pchavez.chrs@gmail.com
\.


--
-- Name: users_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: ktapdasan
--

SELECT pg_catalog.setval('users_pk_seq', 7, true);


--
-- Name: added_user_data_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY added_user_data
    ADD CONSTRAINT added_user_data_pkey PRIMARY KEY (pk);


--
-- Name: gift_certificate_data_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY gift_certificate_data
    ADD CONSTRAINT gift_certificate_data_pkey PRIMARY KEY (pk);


--
-- Name: product_data_pkey; Type: CONSTRAINT; Schema: public; Owner: ktapdasan
--

ALTER TABLE ONLY product_data
    ADD CONSTRAINT product_data_pkey PRIMARY KEY (pk);


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

