--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5 (Debian 17.5-1)
-- Dumped by pg_dump version 17.5 (Debian 17.5-1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: profile; Type: TABLE; Schema: public; Owner: clothing_admin
--

CREATE TABLE public.profile (
    id integer NOT NULL,
    user_id integer NOT NULL,
    phone_number character varying(20),
    avatar_url character varying(255),
    bio text,
    date_of_birth date,
    gender character varying(20),
    address jsonb,
    level integer DEFAULT 1,
    grade character varying(50),
    education character varying(100)[],
    skills character varying(100)[],
    website_url character varying(255),
    social_links jsonb,
    qr_code_data bytea NOT NULL,
    qr_code_content text NOT NULL,
    qr_code_type character varying(10) DEFAULT 'png'::character varying,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT profile_gender_check CHECK (((gender)::text = ANY ((ARRAY['male'::character varying, 'female'::character varying])::text[])))
);


ALTER TABLE public.profile OWNER TO clothing_admin;

--
-- Name: profile_id_seq; Type: SEQUENCE; Schema: public; Owner: clothing_admin
--

CREATE SEQUENCE public.profile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.profile_id_seq OWNER TO clothing_admin;

--
-- Name: profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: clothing_admin
--

ALTER SEQUENCE public.profile_id_seq OWNED BY public.profile.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: clothing_admin
--

CREATE TABLE public.users (
    id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    password_hash character varying(255) NOT NULL,
    role character varying(20) DEFAULT 'member'::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY ((ARRAY['admin'::character varying, 'member'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO clothing_admin;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: clothing_admin
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO clothing_admin;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: clothing_admin
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: profile id; Type: DEFAULT; Schema: public; Owner: clothing_admin
--

ALTER TABLE ONLY public.profile ALTER COLUMN id SET DEFAULT nextval('public.profile_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: clothing_admin
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: profile; Type: TABLE DATA; Schema: public; Owner: clothing_admin
--

COPY public.profile (id, user_id, phone_number, avatar_url, bio, date_of_birth, gender, address, level, grade, education, skills, website_url, social_links, qr_code_data, qr_code_content, qr_code_type, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: clothing_admin
--

COPY public.users (id, first_name, last_name, email, password_hash, role, created_at) FROM stdin;
1	Admin	User	admin@example.com	$2a$12$QdoPUdCdt0lFY.cEEYrRKOtpoe0u52n1tnYWrCIag3YuJPGXvd2mO	admin	2025-06-07 00:02:23.976921-05
2	Admin	User	blackdemo@mail.com	$2a$12$QdoPUdCdt0lFY.cEEYrRKOtpoe0u52n1tnYWrCIag3YuJPGXvd2mO	admin	2025-06-07 00:15:28.99772-05
\.


--
-- Name: profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: clothing_admin
--

SELECT pg_catalog.setval('public.profile_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: clothing_admin
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- Name: profile profile_pkey; Type: CONSTRAINT; Schema: public; Owner: clothing_admin
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_pkey PRIMARY KEY (id);


--
-- Name: profile profile_user_id_key; Type: CONSTRAINT; Schema: public; Owner: clothing_admin
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_user_id_key UNIQUE (user_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: clothing_admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: clothing_admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_profile_user_id; Type: INDEX; Schema: public; Owner: clothing_admin
--

CREATE INDEX idx_profile_user_id ON public.profile USING btree (user_id);


--
-- Name: profile profile_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: clothing_admin
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

