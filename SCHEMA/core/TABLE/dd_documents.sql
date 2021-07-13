CREATE TABLE core.dd_documents (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	c_first_name text,
	c_last_name text,
	c_middle_name text,
	d_birthday date,
	c_city_reg text,
	c_street_reg text,
	c_house_reg text,
	c_premise_reg text,
	c_city_life text,
	c_street_life text,
	c_house_life text,
	c_premise_life text,
	c_education text,
	c_work_place text,
	c_biografy text,
	b_administrative boolean,
	b_criminal boolean,
	c_arrest text,
	f_user integer NOT NULL,
	sn_delete boolean NOT NULL,
	dx_created timestamp with time zone DEFAULT now(),
	c_soc_link text,
	c_tag text,
	c_notice text
);

ALTER TABLE core.dd_documents OWNER TO "card";

COMMENT ON COLUMN core.dd_documents.id IS 'Идентификатор';

COMMENT ON COLUMN core.dd_documents.c_first_name IS 'Фамилия';

COMMENT ON COLUMN core.dd_documents.c_last_name IS 'Имя';

COMMENT ON COLUMN core.dd_documents.c_middle_name IS 'Отчество';

COMMENT ON COLUMN core.dd_documents.d_birthday IS 'Дата рождения';

COMMENT ON COLUMN core.dd_documents.c_city_reg IS 'Город (адрес регистрации)';

COMMENT ON COLUMN core.dd_documents.c_street_reg IS 'Улица (адрес регистрации)';

COMMENT ON COLUMN core.dd_documents.c_house_reg IS 'Дом (адрес регистрации)';

COMMENT ON COLUMN core.dd_documents.c_premise_reg IS 'Квартира (адрес регистрации)';

COMMENT ON COLUMN core.dd_documents.c_city_life IS 'Город (адрес проживания)';

COMMENT ON COLUMN core.dd_documents.c_street_life IS 'Улица (адрес проживания)';

COMMENT ON COLUMN core.dd_documents.c_house_life IS 'Дом (адрес проживания)';

COMMENT ON COLUMN core.dd_documents.c_premise_life IS 'Квартира (адрес проживания)';

COMMENT ON COLUMN core.dd_documents.c_education IS 'Образование';

COMMENT ON COLUMN core.dd_documents.c_work_place IS 'Место работы';

COMMENT ON COLUMN core.dd_documents.c_biografy IS 'Биографическая информация';

COMMENT ON COLUMN core.dd_documents.b_administrative IS 'Административная ответственность';

COMMENT ON COLUMN core.dd_documents.b_criminal IS 'Уголовная ответственность';

COMMENT ON COLUMN core.dd_documents.c_arrest IS 'Задержание';

COMMENT ON COLUMN core.dd_documents.f_user IS 'Пользователь';

COMMENT ON COLUMN core.dd_documents.sn_delete IS 'Признак удаленности';

COMMENT ON COLUMN core.dd_documents.dx_created IS 'Дата создания';

COMMENT ON COLUMN core.dd_documents.c_soc_link IS 'Ссылки на социальные сети';

--------------------------------------------------------------------------------

CREATE TRIGGER dd_documents_1
	BEFORE INSERT OR UPDATE OR DELETE ON core.dd_documents
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_log_action();

--------------------------------------------------------------------------------

ALTER TABLE core.dd_documents
	ADD CONSTRAINT dd_documents_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE core.dd_documents
	ADD CONSTRAINT dd_documnets_f_user_fkey FOREIGN KEY (f_user) REFERENCES core.pd_users(id) NOT VALID;
