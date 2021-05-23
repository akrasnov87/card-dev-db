CREATE TABLE core.dd_files (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	ba_foto bytea NOT NULL
);

ALTER TABLE core.dd_files OWNER TO mobnius;

COMMENT ON COLUMN core.dd_files.ba_foto IS 'Файл';

--------------------------------------------------------------------------------

ALTER TABLE core.dd_files
	ADD CONSTRAINT dd_files_pkey PRIMARY KEY (id);
