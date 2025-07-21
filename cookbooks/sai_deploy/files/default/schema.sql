--
-- PostgreSQL database dump
--

-- Dumped from database version 16.9 (Ubuntu 16.9-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.9 (Ubuntu 16.9-0ubuntu0.24.04.1)

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: cat_estados; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cat_estados (
    id_estado integer NOT NULL,
    nombre character varying(100) NOT NULL,
    clave character varying(10)
);


--
-- Name: cat_estados_id_estado_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cat_estados_id_estado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cat_estados_id_estado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cat_estados_id_estado_seq OWNED BY public.cat_estados.id_estado;


--
-- Name: cat_type_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cat_type_users (
    id_cat_type_users integer NOT NULL,
    type_user character varying(100) NOT NULL,
    vigente boolean DEFAULT true,
    f_reg timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    default_sub_modules jsonb
);


--
-- Name: cat_type_users_id_cat_type_users_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cat_type_users_id_cat_type_users_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cat_type_users_id_cat_type_users_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cat_type_users_id_cat_type_users_seq OWNED BY public.cat_type_users.id_cat_type_users;


--
-- Name: sub_modulo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sub_modulo (
    id_sub_modulo integer NOT NULL,
    nombre character varying(100) NOT NULL,
    visible boolean DEFAULT true,
    ordenamiento integer,
    vigente boolean DEFAULT true
);


--
-- Name: sub_modulo_id_sub_modulo_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sub_modulo_id_sub_modulo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sub_modulo_id_sub_modulo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sub_modulo_id_sub_modulo_seq OWNED BY public.sub_modulo.id_sub_modulo;


--
-- Name: cat_estados id_estado; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cat_estados ALTER COLUMN id_estado SET DEFAULT nextval('public.cat_estados_id_estado_seq'::regclass);


--
-- Name: cat_type_users id_cat_type_users; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cat_type_users ALTER COLUMN id_cat_type_users SET DEFAULT nextval('public.cat_type_users_id_cat_type_users_seq'::regclass);


--
-- Name: sub_modulo id_sub_modulo; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sub_modulo ALTER COLUMN id_sub_modulo SET DEFAULT nextval('public.sub_modulo_id_sub_modulo_seq'::regclass);


--
-- Name: cat_estados cat_estados_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cat_estados
    ADD CONSTRAINT cat_estados_pkey PRIMARY KEY (id_estado);


--
-- Name: cat_type_users cat_type_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cat_type_users
    ADD CONSTRAINT cat_type_users_pkey PRIMARY KEY (id_cat_type_users);


--
-- Name: sub_modulo sub_modulo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sub_modulo
    ADD CONSTRAINT sub_modulo_pkey PRIMARY KEY (id_sub_modulo);


--
-- PostgreSQL database dump complete
--

