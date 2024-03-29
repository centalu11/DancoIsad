--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.19
-- Dumped by pg_dump version 9.5.19

-- Started on 2019-11-05 16:21:44

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 186 (class 1259 OID 16748)
-- Name: customer_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_data (
    pk integer NOT NULL,
    client_name text,
    email text,
    contact_number text,
    date_created timestamp with time zone DEFAULT now(),
    archived boolean DEFAULT false,
    tin text,
    street text,
    city text
);


ALTER TABLE public.customer_data OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 16757)
-- Name: customer_data_pk_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customer_data_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customer_data_pk_seq OWNER TO postgres;

--
-- TOC entry 2225 (class 0 OID 0)
-- Dependencies: 187
-- Name: customer_data_pk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customer_data_pk_seq OWNED BY public.customer_data.pk;


--
-- TOC entry 2101 (class 2604 OID 16931)
-- Name: pk; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_data ALTER COLUMN pk SET DEFAULT nextval('public.customer_data_pk_seq'::regclass);


--
-- TOC entry 2218 (class 0 OID 16748)
-- Dependencies: 186
-- Data for Name: customer_data; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2226 (class 0 OID 0)
-- Dependencies: 187
-- Name: customer_data_pk_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customer_data_pk_seq', 1, false);


--
-- TOC entry 2103 (class 2606 OID 16954)
-- Name: customer_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_data
    ADD CONSTRAINT customer_data_pkey PRIMARY KEY (pk);


-- Completed on 2019-11-05 16:21:44

--
-- PostgreSQL database dump complete
--

