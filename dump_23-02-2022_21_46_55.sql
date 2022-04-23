--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--

DROP DATABASE seminario;




--
-- Drop roles
--

DROP ROLE postgres;


--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:i7Wkv4T9hxzCladl4equgw==$gk5bMH2I+5rP1yiY1+/PhCrJlhwdYQOMlDJCaanlrW4=:d27idRXkqsxnTDvoFM6vZE2MnOBfd/dnm4ALdMCkMro=';






--
-- Databases
--

--
-- Database "template1" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2 (Debian 14.2-1.pgdg110+1)
-- Dumped by pg_dump version 14.2 (Debian 14.2-1.pgdg110+1)

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

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO postgres;

\connect template1

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
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: postgres
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

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
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: postgres
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2 (Debian 14.2-1.pgdg110+1)
-- Dumped by pg_dump version 14.2 (Debian 14.2-1.pgdg110+1)

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

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

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
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- PostgreSQL database dump complete
--

--
-- Database "seminario" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2 (Debian 14.2-1.pgdg110+1)
-- Dumped by pg_dump version 14.2 (Debian 14.2-1.pgdg110+1)

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
-- Name: seminario; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE seminario WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE seminario OWNER TO postgres;

\connect seminario

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
-- Name: agregar_catalogo_pregunta(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.agregar_catalogo_pregunta(datajson text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
	JSONarray jsonb:=datajson::jsonb;
	total Integer:=0;
	idpregunta Integer:=0;
	idcatalogo Integer:=0;
	Catalogo text:= replace((JSONarray->'nombreCatalogo')::text, '"', '');
BEGIN
	select count(*) into total from catalogo_pregunta cp  where nombrecatalogo =upper(Catalogo);

	IF(total) = 0 THEN
	
		INSERT INTO catalogo_pregunta values (default,upper(Catalogo),default) returning idcatalogopregunta  into idcatalogo;

		for idpregunta in select jsonb_array_elements(JSONarray->'pregunta') loop
	       raise notice '%', idpregunta;
	       insert into catalogo_pregunta_union  values (idcatalogo,idpregunta,default);
    	end loop;
		
		RETURN '{"Mensaje":"Catalogo creado correctamente"}';
	else
	
		RETURN '{"Mensaje":"Este nombre ya fue utilizado"}';
	
	END IF;
	
END;
$$;


ALTER FUNCTION public.agregar_catalogo_pregunta(datajson text) OWNER TO postgres;

--
-- Name: agregar_nuevas_pregunta_catalogo(text, integer, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.agregar_nuevas_pregunta_catalogo(datajson text, tipo integer, statusx boolean) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
	JSONarray jsonb:=datajson::jsonb;
	total Integer:=0;
	idpregunta Integer:=0;
	idcatalogo int:= (JSONarray->'idcatalogo')::int;
begin
	
	select count(*) into total from catalogo_pregunta  where idcatalogopregunta  = idcatalogo;
	
	IF ( tipo = 1 ) THEN
		IF( total = 0 ) THEN
			for idpregunta in select jsonb_array_elements(JSONarray->'pregunta') loop
		       	insert into catalogo_pregunta_union  values (idcatalogo,idpregunta,default);
	    	end loop;
			RETURN '{"Mensaje":"Se agregaron las preguntas correctamente"}';
		ELSE
			RETURN '{"Mensaje":"No existe el catalogo"}';
		END IF;
	ELSIF ( tipo = 2 ) THEN  
		IF( total = 0 ) THEN
			for idpregunta in select jsonb_array_elements(JSONarray->'pregunta') loop
	    	  	update catalogo_pregunta_union set status = statusx where idcatalogopregunta = idpregunta and idcatalogopregunta = idcatalogo;
	    	end loop;
			IF ( statusx ) THEN 
				RETURN '{"Mensaje":"Se activaron las preguntas"}';
			ELSE 
				RETURN '{"Mensaje":"Se desactivaron las preguntas}';
			END IF;
		ELSE
			RETURN '{"Mensaje":"No existe el catalogo"}';
		END IF;
	ELSE 
		RETURN '{"Mensaje":"Sin resultados"}';
	END IF;
END;
$$;


ALTER FUNCTION public.agregar_nuevas_pregunta_catalogo(datajson text, tipo integer, statusx boolean) OWNER TO postgres;

--
-- Name: catalogo_pregunta(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.catalogo_pregunta(OUT respuesta text) RETURNS text
    LANGUAGE plpgsql
    AS $$

declare 
	--VARIABLES AUXILIARES QUE NOS AYUDA A SABER SI EXISTEN REGISTROS DEL CATALOGO.
	contador int:=0; --AYUDA A SABER SI EXISTEN CATALOGOS CREADOS
	id int; -- SU FUNCION ES GUARDAR TEMPORALMENTE EL ID DEL CATALOGO PARA HACER EL RECORRIDO
	datosCatalogo text:=''; --SE GUARDA TEMPORALMENTE EL VALOR DE UN CATALOGO
	sumaryCatalogo text:=''; --ES LA SUMA DE TODOS LOS CATALOGOS Y SE COMPLEMENTA CON LA VARIABLE @datosCatalogo
	aux boolean:=false; --BANDERA PARA QUE LA COMA no VAYA AL INICIO Y PUEDA DARLE EL FORMATO JSON
	COMA CHAR(1):=',';
	idCatalogo text:='';
	nomCatalogo text:='';
begin 
	--VERIFICAMOS ANTES QUE NADA SI EXISTE UN CATALOGO CON EL ID QUE PROPORSIONAMOS
	select count(idcatalogopregunta) into contador  from catalogo_pregunta_union where status = true;
		
	--DE SER MAYOR A 0 SIGNIFCA QUE EXISTEN REGISTROS
	if (contador > 0) then
		respuesta :='';
		--CREAMOS EL OBJETO JSON CON LOS DATOS QUE NECESITAMOS
		FOR id IN select distinct (idcatalogopregunta) FROM catalogo_pregunta_union where status = true order by idcatalogopregunta
			loop
				--
				select idcatalogopregunta into idCatalogo from catalogo_pregunta where idCatalogoPregunta = id;
				select nombrecatalogo into nomCatalogo  from catalogo_pregunta where idCatalogoPregunta = id;

				select (' { "idCatalogo":'|| idCatalogo ||',"nombre" : "' || nomCatalogo || '","preguntas":' || array_to_json(array_agg(('{"idpregunta":'||p.idpregunta||',"pregunta":"'||nuevapregunta||'"}')::JSON))::JSON || '}')::text into datosCatalogo from pregunta p inner join catalogo_pregunta_union cp on (p.idPregunta=cp.idPregunta) where cp.idCatalogoPregunta=id  and p.status  = true;
				IF ( aux )THEN
					sumaryCatalogo :=sumaryCatalogo  || COMA || datosCatalogo;
				else
					sumaryCatalogo :=sumaryCatalogo  || '' || datosCatalogo;
				end if;
				aux := true;
		end loop;
	respuesta := '{"catalogos":[' || sumaryCatalogo || ']}';
	else
		--EN CASO DE NO SER MAYOR A 0 SE REGRESA UN MENSAJE DE CONTROL
		respuesta := 'Sin resultados';
	end if;
end;
$$;


ALTER FUNCTION public.catalogo_pregunta(OUT respuesta text) OWNER TO postgres;

--
-- Name: catalogo_respuesta(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.catalogo_respuesta(OUT respuesta text) RETURNS text
    LANGUAGE plpgsql
    AS $$

declare 
	--VARIABLES AUXILIARES QUE NOS AYUDA A SABER SI EXISTEN REGISTROS DEL CATALOGO.
	contador int:=0; --AYUDA A SABER SI EXISTEN CATALOGOS CREADOS
	id int; -- SU FUNCION ES GUARDAR TEMPORALMENTE EL ID DEL CATALOGO PARA HACER EL RECORRIDO
	datosCatalogo text:=''; --SE GUARDA TEMPORALMENTE EL VALOR DE UN CATALOGO
	sumaryCatalogo text:=''; --ES LA SUMA DE TODOS LOS CATALOGOS Y SE COMPLEMENTA CON LA VARIABLE @datosCatalogo
	aux boolean:=false; --BANDERA PARA QUE LA COMA no VAYA AL INICIO Y PUEDA DARLE EL FORMATO JSON
	COMA CHAR(1):=',';
	idCatalogo text:='';
	nomCatalogo text:='';
	tipoCatalogo text:='';
begin 
	--VERIFICAMOS ANTES QUE NADA SI EXISTE UN CATALOGO CON EL ID QUE PROPORSIONAMOS
	select count(idcatalogorespuesta) into contador  from catalogo_respuesta_union where status = true;
		
	--DE SER MAYOR A 0 SIGNIFCA QUE EXISTEN REGISTROS
	if (contador > 0) then
		respuesta :='';
		--CREAMOS EL OBJETO JSON CON LOS DATOS QUE NECESITAMOS
		FOR id IN select distinct (idcatalogorespuesta) FROM catalogo_respuesta_union where status = true order by idcatalogorespuesta
			loop
				--
				select idcatalogorespuesta into idCatalogo from catalogo_respuesta  where idcatalogorespuesta = id;
				select nombrecatalogo into nomCatalogo  from catalogo_respuesta where idcatalogorespuesta = id;
				select descripciontiporespuesta into tipoCatalogo  from tipo_respuesta where idtiporespuesta =(select idtiporespuesta from catalogo_respuesta where idcatalogorespuesta=id);

				select (' { "idCatalogo":'|| idCatalogo ||',"nombre" : "' || nomCatalogo || ' ","tipoCatalogo":"'|| tipoCatalogo ||'","respuestas":' || array_to_json(array_agg(('{"id":'||r.idrespuesta||',"info":"'||nuevarespuesta||'"}')::JSON))::JSON || '}')::text into datosCatalogo from respuesta r inner join catalogo_respuesta_union cru ON (r.idrespuesta =cru.idrespuesta) where cru.idcatalogorespuesta = id  and r.status  = true;
				IF ( aux )THEN
					sumaryCatalogo :=sumaryCatalogo  || COMA || datosCatalogo;
				else
					sumaryCatalogo :=sumaryCatalogo  || '' || datosCatalogo;
				end if;
				aux := true;
		end loop;
	respuesta := '{"catalogos":[' || sumaryCatalogo || ']}';
	else
		--EN CASO DE NO SER MAYOR A 0 SE REGRESA UN MENSAJE DE CONTROL
		respuesta := 'Sin resultados';
	end if;
end;
$$;


ALTER FUNCTION public.catalogo_respuesta(OUT respuesta text) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: catalogo_pregunta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.catalogo_pregunta (
    idcatalogopregunta integer NOT NULL,
    nombrecatalogo text NOT NULL,
    status boolean DEFAULT true NOT NULL,
    fechacreacion text DEFAULT now() NOT NULL
);


ALTER TABLE public.catalogo_pregunta OWNER TO postgres;

--
-- Name: catalogo_pregunta_idcatalogopregunta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.catalogo_pregunta_idcatalogopregunta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.catalogo_pregunta_idcatalogopregunta_seq OWNER TO postgres;

--
-- Name: catalogo_pregunta_idcatalogopregunta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.catalogo_pregunta_idcatalogopregunta_seq OWNED BY public.catalogo_pregunta.idcatalogopregunta;


--
-- Name: catalogo_pregunta_union; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.catalogo_pregunta_union (
    idcatalogopregunta integer NOT NULL,
    idpregunta integer NOT NULL,
    status boolean DEFAULT true NOT NULL
);


ALTER TABLE public.catalogo_pregunta_union OWNER TO postgres;

--
-- Name: catalogo_respuesta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.catalogo_respuesta (
    idcatalogorespuesta integer NOT NULL,
    nombrecatalogo text NOT NULL,
    status boolean DEFAULT true NOT NULL,
    fechacreacion text DEFAULT now(),
    idtiporespuesta integer
);


ALTER TABLE public.catalogo_respuesta OWNER TO postgres;

--
-- Name: catalogo_respuesta_idcatalogorespuesta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.catalogo_respuesta_idcatalogorespuesta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.catalogo_respuesta_idcatalogorespuesta_seq OWNER TO postgres;

--
-- Name: catalogo_respuesta_idcatalogorespuesta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.catalogo_respuesta_idcatalogorespuesta_seq OWNED BY public.catalogo_respuesta.idcatalogorespuesta;


--
-- Name: catalogo_respuesta_union; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.catalogo_respuesta_union (
    idcatalogorespuesta integer NOT NULL,
    idrespuesta integer NOT NULL,
    status boolean DEFAULT true NOT NULL
);


ALTER TABLE public.catalogo_respuesta_union OWNER TO postgres;

--
-- Name: encuesta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.encuesta (
    idencuesta integer NOT NULL,
    nombreencuesta text NOT NULL,
    descripcionencuesta text NOT NULL,
    fechacreacion text DEFAULT now(),
    fechaexpiracion date NOT NULL
);


ALTER TABLE public.encuesta OWNER TO postgres;

--
-- Name: encuesta_idencuesta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.encuesta_idencuesta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.encuesta_idencuesta_seq OWNER TO postgres;

--
-- Name: encuesta_idencuesta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.encuesta_idencuesta_seq OWNED BY public.encuesta.idencuesta;


--
-- Name: encuesta_union_detalle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.encuesta_union_detalle (
    idencuesta integer NOT NULL,
    idpregunta integer NOT NULL,
    idrespuesta integer NOT NULL
);


ALTER TABLE public.encuesta_union_detalle OWNER TO postgres;

--
-- Name: pregunta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pregunta (
    idpregunta integer NOT NULL,
    nuevapregunta text NOT NULL,
    status boolean DEFAULT true NOT NULL,
    fechacreacion text DEFAULT now() NOT NULL
);


ALTER TABLE public.pregunta OWNER TO postgres;

--
-- Name: pregunta_idpregunta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pregunta_idpregunta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pregunta_idpregunta_seq OWNER TO postgres;

--
-- Name: pregunta_idpregunta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pregunta_idpregunta_seq OWNED BY public.pregunta.idpregunta;


--
-- Name: respuesta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.respuesta (
    idrespuesta integer NOT NULL,
    nuevarespuesta text NOT NULL,
    status boolean DEFAULT true NOT NULL,
    fechacreacion text DEFAULT now() NOT NULL
);


ALTER TABLE public.respuesta OWNER TO postgres;

--
-- Name: respuesta_idrespuesta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.respuesta_idrespuesta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.respuesta_idrespuesta_seq OWNER TO postgres;

--
-- Name: respuesta_idrespuesta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.respuesta_idrespuesta_seq OWNED BY public.respuesta.idrespuesta;


--
-- Name: tipo_respuesta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo_respuesta (
    idtiporespuesta integer NOT NULL,
    descripciontiporespuesta text NOT NULL
);


ALTER TABLE public.tipo_respuesta OWNER TO postgres;

--
-- Name: tipo_respuesta_idtiporespuesta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipo_respuesta_idtiporespuesta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipo_respuesta_idtiporespuesta_seq OWNER TO postgres;

--
-- Name: tipo_respuesta_idtiporespuesta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipo_respuesta_idtiporespuesta_seq OWNED BY public.tipo_respuesta.idtiporespuesta;


--
-- Name: catalogo_pregunta idcatalogopregunta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalogo_pregunta ALTER COLUMN idcatalogopregunta SET DEFAULT nextval('public.catalogo_pregunta_idcatalogopregunta_seq'::regclass);


--
-- Name: catalogo_respuesta idcatalogorespuesta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalogo_respuesta ALTER COLUMN idcatalogorespuesta SET DEFAULT nextval('public.catalogo_respuesta_idcatalogorespuesta_seq'::regclass);


--
-- Name: encuesta idencuesta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.encuesta ALTER COLUMN idencuesta SET DEFAULT nextval('public.encuesta_idencuesta_seq'::regclass);


--
-- Name: pregunta idpregunta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pregunta ALTER COLUMN idpregunta SET DEFAULT nextval('public.pregunta_idpregunta_seq'::regclass);


--
-- Name: respuesta idrespuesta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuesta ALTER COLUMN idrespuesta SET DEFAULT nextval('public.respuesta_idrespuesta_seq'::regclass);


--
-- Name: tipo_respuesta idtiporespuesta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_respuesta ALTER COLUMN idtiporespuesta SET DEFAULT nextval('public.tipo_respuesta_idtiporespuesta_seq'::regclass);


--
-- Data for Name: catalogo_pregunta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.catalogo_pregunta (idcatalogopregunta, nombrecatalogo, status, fechacreacion) FROM stdin;
1	CATALOGO PREGUNTA #1	t	2022-02-11 21:03:53.954668-06
2	CATALOGO PREGUNTA #2	t	2022-02-11 21:03:53.954668-06
3	CATALOGO PREGUNTA #3	t	2022-02-11 21:03:53.954668-06
4	CATALOGO PREGUNTA #4	t	2022-02-11 21:03:53.954668-06
5	CATALOGO PREGUNTA #5	t	2022-02-11 21:03:53.954668-06
6	PRUEBA	t	2022-02-22 02:39:50.574637-06
7	PRUEBA2	t	2022-02-22 02:41:59.704701-06
12	CATALOGO DESDE FUNCION	t	2022-02-22 11:30:18.178041-06
13	CATALOGO DESDE SPRING	t	2022-02-22 12:46:22.229398-06
14	CATALOGO DESDE SPRING X2	t	2022-02-22 12:53:04.025456-06
15	CATALOGO DESDE SPRING X3	t	2022-02-22 12:56:34.801343-06
16	CATALOGO DESDE SPRING X5	t	2022-02-22 13:01:15.215543-06
\.


--
-- Data for Name: catalogo_pregunta_union; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.catalogo_pregunta_union (idcatalogopregunta, idpregunta, status) FROM stdin;
1	1	t
1	2	t
1	3	t
1	4	t
1	5	t
2	6	t
2	7	t
2	1	t
6	1	t
6	2	t
7	1	t
7	2	t
7	3	t
7	4	t
12	1	t
12	2	t
12	3	t
12	4	t
13	2	t
13	3	t
14	2	t
14	3	t
15	2	t
15	3	t
16	2	t
16	3	t
\.


--
-- Data for Name: catalogo_respuesta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.catalogo_respuesta (idcatalogorespuesta, nombrecatalogo, status, fechacreacion, idtiporespuesta) FROM stdin;
1	CATALOGO RESPUESTA #1	t	2022-02-13 20:06:09.430545-06	1
2	CATALOGO RESPUESTA #2	t	2022-02-13 20:06:09.430545-06	1
3	CATALOGO RESPUESTA #3	t	2022-02-13 20:06:09.430545-06	2
4	CATALOGO RESPUESTA #4	t	2022-02-13 20:06:09.430545-06	3
5	CATALOGO RESPUESTA #5	t	2022-02-13 20:06:09.430545-06	4
\.


--
-- Data for Name: catalogo_respuesta_union; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.catalogo_respuesta_union (idcatalogorespuesta, idrespuesta, status) FROM stdin;
1	1	t
2	2	t
3	3	t
3	4	t
4	5	t
4	6	t
4	7	t
5	8	t
5	9	t
5	10	t
\.


--
-- Data for Name: encuesta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.encuesta (idencuesta, nombreencuesta, descripcionencuesta, fechacreacion, fechaexpiracion) FROM stdin;
\.


--
-- Data for Name: encuesta_union_detalle; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.encuesta_union_detalle (idencuesta, idpregunta, idrespuesta) FROM stdin;
\.


--
-- Data for Name: pregunta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pregunta (idpregunta, nuevapregunta, status, fechacreacion) FROM stdin;
2	¿Cuantos años tienes?	t	2022-02-11 21:03:45.993494-06
3	¿Cúal es tu color favorito?	t	2022-02-11 21:03:45.993494-06
4	¿Cúal es tu fruta preferida?	t	2022-02-11 21:03:45.993494-06
5	¿Tienes hijos?	t	2022-02-11 21:03:45.993494-06
6	¿Has viajado al extranjero?	t	2022-02-11 21:03:45.993494-06
7	¿Viste la peli de spiderman?	t	2022-02-11 21:03:45.993494-06
8	¿Sabes programar?	t	2022-02-22 02:22:09.560029-06
1	¿Whats is your name?	t	2022-02-22 02:05:20.424467-06
\.


--
-- Data for Name: respuesta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.respuesta (idrespuesta, nuevarespuesta, status, fechacreacion) FROM stdin;
1	--FECHA--	t	2022-02-13 20:05:56.462504-06
2	--LIBRE--	t	2022-02-13 20:05:56.462504-06
3	SI	t	2022-02-13 20:05:56.462504-06
4	NO	t	2022-02-13 20:05:56.462504-06
5	ROJO	t	2022-02-13 20:05:56.462504-06
6	AZUL	t	2022-02-13 20:05:56.462504-06
7	VERDE	t	2022-02-13 20:05:56.462504-06
8	MANZANA	t	2022-02-13 20:05:56.462504-06
9	BANANA	t	2022-02-13 20:05:56.462504-06
10	UVAS	t	2022-02-13 20:05:56.462504-06
\.


--
-- Data for Name: tipo_respuesta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipo_respuesta (idtiporespuesta, descripciontiporespuesta) FROM stdin;
1	Abierta
2	Multiple
3	Unica
4	Fecha
\.


--
-- Name: catalogo_pregunta_idcatalogopregunta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.catalogo_pregunta_idcatalogopregunta_seq', 16, true);


--
-- Name: catalogo_respuesta_idcatalogorespuesta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.catalogo_respuesta_idcatalogorespuesta_seq', 5, true);


--
-- Name: encuesta_idencuesta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.encuesta_idencuesta_seq', 1, false);


--
-- Name: pregunta_idpregunta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pregunta_idpregunta_seq', 8, true);


--
-- Name: respuesta_idrespuesta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.respuesta_idrespuesta_seq', 10, true);


--
-- Name: tipo_respuesta_idtiporespuesta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipo_respuesta_idtiporespuesta_seq', 1, false);


--
-- Name: catalogo_pregunta catalogo_pregunta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalogo_pregunta
    ADD CONSTRAINT catalogo_pregunta_pkey PRIMARY KEY (idcatalogopregunta);


--
-- Name: catalogo_pregunta_union catalogo_pregunta_union_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalogo_pregunta_union
    ADD CONSTRAINT catalogo_pregunta_union_pkey PRIMARY KEY (idcatalogopregunta, idpregunta);


--
-- Name: catalogo_respuesta catalogo_respuesta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalogo_respuesta
    ADD CONSTRAINT catalogo_respuesta_pkey PRIMARY KEY (idcatalogorespuesta);


--
-- Name: catalogo_respuesta_union catalogo_respuesta_union_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalogo_respuesta_union
    ADD CONSTRAINT catalogo_respuesta_union_pkey PRIMARY KEY (idcatalogorespuesta, idrespuesta);


--
-- Name: encuesta encuesta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.encuesta
    ADD CONSTRAINT encuesta_pkey PRIMARY KEY (idencuesta);


--
-- Name: encuesta_union_detalle encuesta_union_detalle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.encuesta_union_detalle
    ADD CONSTRAINT encuesta_union_detalle_pkey PRIMARY KEY (idencuesta, idpregunta, idrespuesta);


--
-- Name: pregunta pregunta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pregunta
    ADD CONSTRAINT pregunta_pkey PRIMARY KEY (idpregunta);


--
-- Name: respuesta respuesta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuesta
    ADD CONSTRAINT respuesta_pkey PRIMARY KEY (idrespuesta);


--
-- Name: tipo_respuesta tipo_respuesta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_respuesta
    ADD CONSTRAINT tipo_respuesta_pkey PRIMARY KEY (idtiporespuesta);


--
-- Name: catalogo_pregunta_union catalogo_pregunta_union_idcatalogopregunta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalogo_pregunta_union
    ADD CONSTRAINT catalogo_pregunta_union_idcatalogopregunta_fkey FOREIGN KEY (idcatalogopregunta) REFERENCES public.catalogo_pregunta(idcatalogopregunta);


--
-- Name: catalogo_pregunta_union catalogo_pregunta_union_idpregunta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalogo_pregunta_union
    ADD CONSTRAINT catalogo_pregunta_union_idpregunta_fkey FOREIGN KEY (idpregunta) REFERENCES public.pregunta(idpregunta);


--
-- Name: catalogo_respuesta catalogo_respuesta_idtiporespuesta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalogo_respuesta
    ADD CONSTRAINT catalogo_respuesta_idtiporespuesta_fkey FOREIGN KEY (idtiporespuesta) REFERENCES public.tipo_respuesta(idtiporespuesta);


--
-- Name: catalogo_respuesta_union catalogo_respuesta_union_idcatalogorespuesta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalogo_respuesta_union
    ADD CONSTRAINT catalogo_respuesta_union_idcatalogorespuesta_fkey FOREIGN KEY (idcatalogorespuesta) REFERENCES public.catalogo_respuesta(idcatalogorespuesta);


--
-- Name: catalogo_respuesta_union catalogo_respuesta_union_idrespuesta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalogo_respuesta_union
    ADD CONSTRAINT catalogo_respuesta_union_idrespuesta_fkey FOREIGN KEY (idrespuesta) REFERENCES public.respuesta(idrespuesta);


--
-- Name: encuesta_union_detalle encuesta_union_detalle_idencuesta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.encuesta_union_detalle
    ADD CONSTRAINT encuesta_union_detalle_idencuesta_fkey FOREIGN KEY (idencuesta) REFERENCES public.encuesta(idencuesta);


--
-- Name: encuesta_union_detalle encuesta_union_detalle_idpregunta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.encuesta_union_detalle
    ADD CONSTRAINT encuesta_union_detalle_idpregunta_fkey FOREIGN KEY (idpregunta) REFERENCES public.pregunta(idpregunta);


--
-- Name: encuesta_union_detalle encuesta_union_detalle_idrespuesta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.encuesta_union_detalle
    ADD CONSTRAINT encuesta_union_detalle_idrespuesta_fkey FOREIGN KEY (idrespuesta) REFERENCES public.respuesta(idrespuesta);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

