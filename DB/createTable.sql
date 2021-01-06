-- Table: public.users

-- DROP TABLE public.users;

CREATE TABLE public.users
(
    user_id integer NOT NULL DEFAULT nextval('users_user_id_seq'::regclass),
    firstname character varying(50) COLLATE pg_catalog."default",
    lastname character varying(50) COLLATE pg_catalog."default",
    password character varying(200) COLLATE pg_catalog."default" NOT NULL,
    emailaddress character varying(255) COLLATE pg_catalog."default" NOT NULL,
    isadmin boolean NOT NULL,
    dateadded date DEFAULT CURRENT_DATE,
    CONSTRAINT users_pkey PRIMARY KEY (user_id),
    CONSTRAINT users_email_key UNIQUE (emailaddress)
)

TABLESPACE pg_default;

ALTER TABLE public.users
    OWNER to "postgresAdmin";