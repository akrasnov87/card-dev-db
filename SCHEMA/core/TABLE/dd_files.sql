CREATE TABLE core.dd_files (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	ba_foto bytea NOT NULL,
	dx_created timestamp with time zone DEFAULT now(),
	sn_delete boolean DEFAULT false,
	f_document uuid,
	d_date date
);

ALTER TABLE core.dd_files OWNER TO "card";

COMMENT ON COLUMN core.dd_files.ba_foto IS 'Файл';

--------------------------------------------------------------------------------

ALTER TABLE core.dd_files
	ADD CONSTRAINT dd_files_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE core.dd_files
	ADD CONSTRAINT dd_files_f_document_fkey FOREIGN KEY (f_document) REFERENCES core.dd_documents(id) NOT VALID;
