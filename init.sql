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

GRANT ALL ON TABLE public.user TO "studygroup-admin";
GRANT SELECT, INSERT, UPDATE, DELETE ON public.user TO studygroup_rw;



CREATE TABLE public.group
(
  id BIGSERIAL NOT NULL,
  name text NOT NULL,
  owner_id  TEXT NOT NULL,
  created timestamp without time zone DEFAULT now(),
  modified timestamp without time zone DEFAULT now(),
  CONSTRAINT group_id_pkey PRIMARY KEY (id),
  CONSTRAINT fk_group_owner_id FOREIGN KEY (owner_id)
    REFERENCES public."user" (id) MATCH SIMPLE
    ON UPDATE CASCADE ON DELETE CASCADE
)
  WITH (
    OIDS = FALSE
  )
  TABLESPACE pg_default;

GRANT ALL ON TABLE public.group TO "studygroup-admin";
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE public.group TO studygroup_rw;



CREATE TABLE public.user_group
      (
        id BIGSERIAL,
        group_id  bigint NOT NULL,
        member_id TEXT NOT NULL,
        approved  BOOLEAN NOT NULL,
        created timestamp without time zone DEFAULT now(),
        modified timestamp without time zone DEFAULT now(),
        CONSTRAINT user_group_id_pkey PRIMARY KEY (id),
        CONSTRAINT fk_user_group_member_id FOREIGN KEY (member_id)
          REFERENCES public."user" (id) MATCH SIMPLE
          ON UPDATE CASCADE ON DELETE CASCADE
      )
        WITH (
          OIDS = FALSE
        )
        TABLESPACE pg_default;


GRANT ALL ON TABLE public.user_group TO "studygroup-admin";
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE public.user_group TO studygroup_rw;

