CREATE USER studygroup_rw WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION;


CREATE TABLE public.user
(
    id text NOT NULL,
    email text NOT NULL,
    email_verified boolean,
    name text,
    given_name text,
    family_name text,
    picture text,
    created timestamp without time zone DEFAULT now(),
	modified timestamp without time zone DEFAULT now(),
    CONSTRAINT user_id_pkey PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

GRANT SELECT, INSERT, UPDATE, DELETE ON public.user TO studygroup_rw;

