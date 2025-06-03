--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-06-02 21:52:08

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

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 4977 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 233 (class 1255 OID 90434)
-- Name: check_sanction_amount(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.check_sanction_amount() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.amount < 0 THEN
        RAISE EXCEPTION 'El monto de la sanción no puede ser negativo';
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.check_sanction_amount() OWNER TO postgres;

--
-- TOC entry 232 (class 1255 OID 90432)
-- Name: set_created_at_book_authors(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.set_created_at_book_authors() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.created_at IS NULL THEN
        NEW.created_at := CURRENT_TIMESTAMP;
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.set_created_at_book_authors() OWNER TO postgres;

--
-- TOC entry 234 (class 1255 OID 90436)
-- Name: set_loan_date_if_null(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.set_loan_date_if_null() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.loan_date IS NULL THEN
        NEW.loan_date := CURRENT_TIMESTAMP;
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.set_loan_date_if_null() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 90345)
-- Name: authors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authors (
    id integer NOT NULL,
    first_name character varying(255),
    last_name character varying(255)
);


ALTER TABLE public.authors OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 90344)
-- Name: authors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.authors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.authors_id_seq OWNER TO postgres;

--
-- TOC entry 4978 (class 0 OID 0)
-- Dependencies: 219
-- Name: authors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.authors_id_seq OWNED BY public.authors.id;


--
-- TOC entry 227 (class 1259 OID 90383)
-- Name: book_authors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book_authors (
    book_id integer NOT NULL,
    author_id integer NOT NULL,
    created_at timestamp without time zone
);


ALTER TABLE public.book_authors OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 90354)
-- Name: books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.books (
    id integer NOT NULL,
    title character varying(255),
    publication_year integer,
    isbn character varying(20),
    publisher_id integer NOT NULL
);


ALTER TABLE public.books OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 90353)
-- Name: books_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.books_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.books_id_seq OWNER TO postgres;

--
-- TOC entry 4979 (class 0 OID 0)
-- Dependencies: 221
-- Name: books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.books_id_seq OWNED BY public.books.id;


--
-- TOC entry 226 (class 1259 OID 90375)
-- Name: employees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employees (
    id integer NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    "position" character varying(255),
    email character varying(255)
);


ALTER TABLE public.employees OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 90374)
-- Name: employees_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.employees_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employees_id_seq OWNER TO postgres;

--
-- TOC entry 4980 (class 0 OID 0)
-- Dependencies: 225
-- Name: employees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employees_id_seq OWNED BY public.employees.id;


--
-- TOC entry 229 (class 1259 OID 90399)
-- Name: loans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.loans (
    id integer NOT NULL,
    loan_date timestamp without time zone,
    return_date timestamp without time zone,
    book_id integer NOT NULL,
    student_id integer NOT NULL,
    employee_id integer NOT NULL
);


ALTER TABLE public.loans OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 90398)
-- Name: loans_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.loans_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.loans_id_seq OWNER TO postgres;

--
-- TOC entry 4981 (class 0 OID 0)
-- Dependencies: 228
-- Name: loans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.loans_id_seq OWNED BY public.loans.id;


--
-- TOC entry 218 (class 1259 OID 90336)
-- Name: publishers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.publishers (
    id integer NOT NULL,
    name character varying(255),
    address character varying(255),
    phone character varying(50)
);


ALTER TABLE public.publishers OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 90335)
-- Name: publishers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.publishers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.publishers_id_seq OWNER TO postgres;

--
-- TOC entry 4982 (class 0 OID 0)
-- Dependencies: 217
-- Name: publishers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.publishers_id_seq OWNED BY public.publishers.id;


--
-- TOC entry 231 (class 1259 OID 90421)
-- Name: sanctions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sanctions (
    id integer NOT NULL,
    reason character varying(255),
    amount numeric(10,2),
    date timestamp without time zone,
    loan_id integer NOT NULL
);


ALTER TABLE public.sanctions OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 90420)
-- Name: sanctions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sanctions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sanctions_id_seq OWNER TO postgres;

--
-- TOC entry 4983 (class 0 OID 0)
-- Dependencies: 230
-- Name: sanctions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sanctions_id_seq OWNED BY public.sanctions.id;


--
-- TOC entry 224 (class 1259 OID 90366)
-- Name: students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.students (
    id integer NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    major character varying(255),
    email character varying(255)
);


ALTER TABLE public.students OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 90365)
-- Name: students_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.students_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.students_id_seq OWNER TO postgres;

--
-- TOC entry 4984 (class 0 OID 0)
-- Dependencies: 223
-- Name: students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.students_id_seq OWNED BY public.students.id;


--
-- TOC entry 4780 (class 2604 OID 90348)
-- Name: authors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authors ALTER COLUMN id SET DEFAULT nextval('public.authors_id_seq'::regclass);


--
-- TOC entry 4781 (class 2604 OID 90357)
-- Name: books id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books ALTER COLUMN id SET DEFAULT nextval('public.books_id_seq'::regclass);


--
-- TOC entry 4783 (class 2604 OID 90378)
-- Name: employees id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees ALTER COLUMN id SET DEFAULT nextval('public.employees_id_seq'::regclass);


--
-- TOC entry 4784 (class 2604 OID 90402)
-- Name: loans id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loans ALTER COLUMN id SET DEFAULT nextval('public.loans_id_seq'::regclass);


--
-- TOC entry 4779 (class 2604 OID 90339)
-- Name: publishers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publishers ALTER COLUMN id SET DEFAULT nextval('public.publishers_id_seq'::regclass);


--
-- TOC entry 4785 (class 2604 OID 90424)
-- Name: sanctions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sanctions ALTER COLUMN id SET DEFAULT nextval('public.sanctions_id_seq'::regclass);


--
-- TOC entry 4782 (class 2604 OID 90369)
-- Name: students id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students ALTER COLUMN id SET DEFAULT nextval('public.students_id_seq'::regclass);


--
-- TOC entry 4960 (class 0 OID 90345)
-- Dependencies: 220
-- Data for Name: authors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authors (id, first_name, last_name) FROM stdin;
1	Gabriel	García Márquez
2	Isabel	Allende
3	Jorge Luis	Borges
4	Mario	Vargas Llosa
5	Laura	Esquivel
6	Julio	Cortázar
7	Carlos	Fuentes
8	Elena	Poniatowska
9	Juan	Rulfo
10	Rosa	Montero
\.


--
-- TOC entry 4967 (class 0 OID 90383)
-- Dependencies: 227
-- Data for Name: book_authors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.book_authors (book_id, author_id, created_at) FROM stdin;
1	1	2025-06-02 21:31:25.858743
2	2	2025-06-02 21:31:25.858743
3	3	2025-06-02 21:31:25.858743
4	6	2025-06-02 21:31:25.858743
5	9	2025-06-02 21:31:25.858743
6	5	2025-06-02 21:31:25.858743
7	4	2025-06-02 21:31:25.858743
8	7	2025-06-02 21:31:25.858743
9	7	2025-06-02 21:31:25.858743
10	4	2025-06-02 21:31:25.858743
\.


--
-- TOC entry 4962 (class 0 OID 90354)
-- Dependencies: 222
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.books (id, title, publication_year, isbn, publisher_id) FROM stdin;
1	Cien años de soledad	1967	978-3-16-148410-0	1
2	La casa de los espíritus	1982	978-0-14-024501-5	2
3	Ficciones	1944	978-0-14-118384-8	2
4	Rayuela	1963	978-84-376-0494-7	3
5	Pedro Páramo	1955	978-84-376-0493-0	4
6	Como agua para chocolate	1989	978-84-376-0484-8	5
7	Pantaleón y las visitadoras	1973	978-84-663-1828-5	1
8	Terra Nostra	1975	978-84-376-0467-1	6
9	La muerte de Artemio Cruz	1962	978-84-206-5590-9	7
10	La fiesta del chivo	2000	978-84-233-3652-9	8
\.


--
-- TOC entry 4966 (class 0 OID 90375)
-- Dependencies: 226
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employees (id, first_name, last_name, "position", email) FROM stdin;
1	Carlos	Ramírez	Bibliotecario	carlos.ramirez@example.com
2	Laura	Torres	Asistente	laura.torres@example.com
3	Juan	Herrera	Auxiliar	juan.herrera@example.com
4	Patricia	Díaz	Técnico	patricia.diaz@example.com
5	Miguel	Luna	Coordinador	miguel.luna@example.com
6	Verónica	Bravo	Auxiliar	vero.bravo@example.com
7	Eduardo	Santos	Recepcionista	eduardo.santos@example.com
8	Claudia	Núñez	Asistente	claudia.n@example.com
9	Raúl	Ríos	Encargado de sala	raul.rios@example.com
10	Natalia	Vega	Administrador	natalia.vega@example.com
\.


--
-- TOC entry 4969 (class 0 OID 90399)
-- Dependencies: 229
-- Data for Name: loans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.loans (id, loan_date, return_date, book_id, student_id, employee_id) FROM stdin;
1	2025-06-02 21:32:08.620107	2025-06-12 21:32:08.620107	1	1	1
2	2025-06-02 21:32:08.620107	2025-06-09 21:32:08.620107	2	2	2
3	2025-06-02 21:32:08.620107	2025-06-17 21:32:08.620107	3	3	3
4	2025-06-02 21:32:08.620107	2025-06-07 21:32:08.620107	4	4	4
5	2025-06-02 21:32:08.620107	2025-06-22 21:32:08.620107	5	5	5
6	2025-06-02 21:32:08.620107	2025-06-10 21:32:08.620107	6	6	6
7	2025-06-02 21:32:08.620107	2025-06-14 21:32:08.620107	6	7	7
8	2025-06-02 21:32:08.620107	2025-06-16 21:32:08.620107	8	8	8
9	2025-06-02 21:32:08.620107	2025-06-08 21:32:08.620107	9	9	9
10	2025-06-02 21:32:08.620107	2025-06-12 21:32:08.620107	10	10	10
\.


--
-- TOC entry 4958 (class 0 OID 90336)
-- Dependencies: 218
-- Data for Name: publishers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.publishers (id, name, address, phone) FROM stdin;
1	Editorial Alfa	Calle 123, Ciudad A	555-1234
2	Ediciones Beta	Av. Siempre Viva 456, Ciudad B	555-5678
3	LibroMundo	Carrera 10, Ciudad C	555-7890
4	Palabra Editores	Calle 45, Ciudad D	555-0001
5	Lectura Viva	Av. del Saber 77, Ciudad E	555-2222
6	Punto y Letra	Callejón 9, Ciudad F	555-3333
7	Texto Abierto	Av. 100, Ciudad G	555-4444
8	Editorial Mundo	Calle 200, Ciudad H	555-5555
9	Pluma y Papel	Boulevard 50, Ciudad I	555-6666
10	Ediciones Universales	Calle Universidad, Ciudad J	555-7777
\.


--
-- TOC entry 4971 (class 0 OID 90421)
-- Dependencies: 231
-- Data for Name: sanctions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sanctions (id, reason, amount, date, loan_id) FROM stdin;
1	Retraso en devolución	5.00	2025-06-02 21:32:20.946602	1
2	Libro dañado	10.00	2025-06-02 21:32:20.946602	2
3	Retraso en devolución	3.50	2025-06-02 21:32:20.946602	3
4	Pérdida de libro	50.00	2025-06-02 21:32:20.946602	4
5	Manejo inadecuado	7.00	2025-06-02 21:32:20.946602	5
6	Retraso	2.50	2025-06-02 21:32:20.946602	6
7	Retraso	4.00	2025-06-02 21:32:20.946602	7
8	Deterioro de portada	6.00	2025-06-02 21:32:20.946602	8
9	Retraso	3.00	2025-06-02 21:32:20.946602	9
10	No devolución	20.00	2025-06-02 21:32:20.946602	10
\.


--
-- TOC entry 4964 (class 0 OID 90366)
-- Dependencies: 224
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.students (id, first_name, last_name, major, email) FROM stdin;
1	Ana	Pérez	Ingeniería Informática	ana.perez@example.com
2	Luis	Gómez	Literatura	luis.gomez@example.com
3	María	Rodríguez	Historia	maria.rod@example.com
4	Carlos	López	Filosofía	carlos.lopez@example.com
5	Laura	Ramírez	Matemáticas	laura.ramirez@example.com
6	José	Martínez	Derecho	jose.mtz@example.com
7	Lucía	Fernández	Medicina	lucia.fernandez@example.com
8	Andrés	Silva	Química	andres.silva@example.com
9	Clara	González	Psicología	clara.g@example.com
10	Diego	Torres	Sociología	diego.torres@example.com
\.


--
-- TOC entry 4985 (class 0 OID 0)
-- Dependencies: 219
-- Name: authors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authors_id_seq', 10, true);


--
-- TOC entry 4986 (class 0 OID 0)
-- Dependencies: 221
-- Name: books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.books_id_seq', 10, true);


--
-- TOC entry 4987 (class 0 OID 0)
-- Dependencies: 225
-- Name: employees_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employees_id_seq', 10, true);


--
-- TOC entry 4988 (class 0 OID 0)
-- Dependencies: 228
-- Name: loans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.loans_id_seq', 10, true);


--
-- TOC entry 4989 (class 0 OID 0)
-- Dependencies: 217
-- Name: publishers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.publishers_id_seq', 10, true);


--
-- TOC entry 4990 (class 0 OID 0)
-- Dependencies: 230
-- Name: sanctions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sanctions_id_seq', 10, true);


--
-- TOC entry 4991 (class 0 OID 0)
-- Dependencies: 223
-- Name: students_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.students_id_seq', 10, true);


--
-- TOC entry 4789 (class 2606 OID 90352)
-- Name: authors authors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authors
    ADD CONSTRAINT authors_pkey PRIMARY KEY (id);


--
-- TOC entry 4797 (class 2606 OID 90387)
-- Name: book_authors book_authors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_authors
    ADD CONSTRAINT book_authors_pkey PRIMARY KEY (book_id, author_id);


--
-- TOC entry 4791 (class 2606 OID 90359)
-- Name: books books_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (id);


--
-- TOC entry 4795 (class 2606 OID 90382)
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);


--
-- TOC entry 4799 (class 2606 OID 90404)
-- Name: loans loans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loans
    ADD CONSTRAINT loans_pkey PRIMARY KEY (id);


--
-- TOC entry 4787 (class 2606 OID 90343)
-- Name: publishers publishers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publishers
    ADD CONSTRAINT publishers_pkey PRIMARY KEY (id);


--
-- TOC entry 4801 (class 2606 OID 90426)
-- Name: sanctions sanctions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sanctions
    ADD CONSTRAINT sanctions_pkey PRIMARY KEY (id);


--
-- TOC entry 4793 (class 2606 OID 90373)
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (id);


--
-- TOC entry 4811 (class 2620 OID 90435)
-- Name: sanctions trg_check_sanction_amount; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_check_sanction_amount BEFORE INSERT OR UPDATE ON public.sanctions FOR EACH ROW EXECUTE FUNCTION public.check_sanction_amount();


--
-- TOC entry 4809 (class 2620 OID 90433)
-- Name: book_authors trg_set_created_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_set_created_at BEFORE INSERT ON public.book_authors FOR EACH ROW EXECUTE FUNCTION public.set_created_at_book_authors();


--
-- TOC entry 4810 (class 2620 OID 90437)
-- Name: loans trg_set_loan_date; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_set_loan_date BEFORE INSERT ON public.loans FOR EACH ROW EXECUTE FUNCTION public.set_loan_date_if_null();


--
-- TOC entry 4803 (class 2606 OID 90393)
-- Name: book_authors fk_author; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_authors
    ADD CONSTRAINT fk_author FOREIGN KEY (author_id) REFERENCES public.authors(id);


--
-- TOC entry 4804 (class 2606 OID 90388)
-- Name: book_authors fk_book; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_authors
    ADD CONSTRAINT fk_book FOREIGN KEY (book_id) REFERENCES public.books(id);


--
-- TOC entry 4802 (class 2606 OID 90360)
-- Name: books fk_books_publishers; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT fk_books_publishers FOREIGN KEY (publisher_id) REFERENCES public.publishers(id);


--
-- TOC entry 4805 (class 2606 OID 90405)
-- Name: loans fk_loan_book; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loans
    ADD CONSTRAINT fk_loan_book FOREIGN KEY (book_id) REFERENCES public.books(id);


--
-- TOC entry 4806 (class 2606 OID 90415)
-- Name: loans fk_loan_employee; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loans
    ADD CONSTRAINT fk_loan_employee FOREIGN KEY (employee_id) REFERENCES public.employees(id);


--
-- TOC entry 4807 (class 2606 OID 90410)
-- Name: loans fk_loan_student; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loans
    ADD CONSTRAINT fk_loan_student FOREIGN KEY (student_id) REFERENCES public.students(id);


--
-- TOC entry 4808 (class 2606 OID 90427)
-- Name: sanctions fk_sanction_loan; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sanctions
    ADD CONSTRAINT fk_sanction_loan FOREIGN KEY (loan_id) REFERENCES public.loans(id);


-- Completed on 2025-06-02 21:52:08

--
-- PostgreSQL database dump complete
--

