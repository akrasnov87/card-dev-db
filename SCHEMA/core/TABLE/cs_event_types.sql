CREATE TABLE core.cs_event_types (
	id integer DEFAULT nextval('core.auto_id_cs_event_types'::regclass) NOT NULL,
	c_name text NOT NULL,
	n_order integer DEFAULT 0,
	b_default boolean DEFAULT false NOT NULL,
	b_disabled boolean DEFAULT false NOT NULL
);

ALTER TABLE core.cs_event_types OWNER TO card;

COMMENT ON TABLE core.cs_event_types IS 'Тип настройки';

COMMENT ON COLUMN core.cs_event_types.id IS 'Идентификатор';

COMMENT ON COLUMN core.cs_event_types.c_name IS 'Наименование';

COMMENT ON COLUMN core.cs_event_types.n_order IS 'Сортировка';

COMMENT ON COLUMN core.cs_event_types.b_default IS 'По умолчанию';

COMMENT ON COLUMN core.cs_event_types.b_disabled IS 'Отключено';

--------------------------------------------------------------------------------

CREATE TRIGGER cs_event_types_1
	BEFORE INSERT OR UPDATE OR DELETE ON core.cs_event_types
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_log_action();

--------------------------------------------------------------------------------

ALTER TABLE core.cs_event_types
	ADD CONSTRAINT cs_event_types_pkey PRIMARY KEY (id);
