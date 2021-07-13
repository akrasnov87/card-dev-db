CREATE TABLE core.dd_events (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	f_document uuid NOT NULL,
	d_date_place date,
	d_notify date,
	f_event_type integer,
	c_target text,
	n_count_before integer,
	c_time_place_before text,
	c_notify_result text,
	c_time_place_after text,
	n_count_after integer,
	c_show_material text,
	c_violation text,
	f_user integer NOT NULL,
	sn_delete boolean DEFAULT false,
	dx_created timestamp with time zone DEFAULT now()
);

ALTER TABLE core.dd_events OWNER TO card;

COMMENT ON COLUMN core.dd_events.id IS 'Идентификатор';

COMMENT ON COLUMN core.dd_events.f_document IS 'Документ';

COMMENT ON COLUMN core.dd_events.d_date_place IS 'Дата проведения';

COMMENT ON COLUMN core.dd_events.d_notify IS 'Уведомления';

COMMENT ON COLUMN core.dd_events.f_event_type IS 'Форма проведения';

COMMENT ON COLUMN core.dd_events.c_target IS 'Цель';

COMMENT ON COLUMN core.dd_events.n_count_before IS 'Заявленное количество участников';

COMMENT ON COLUMN core.dd_events.c_time_place_before IS 'Место и время проведения';

COMMENT ON COLUMN core.dd_events.c_notify_result IS 'Результаты рассмотрения уведомления';

COMMENT ON COLUMN core.dd_events.c_time_place_after IS 'Место и время проведения';

COMMENT ON COLUMN core.dd_events.n_count_after IS 'Принятое количество участников';

COMMENT ON COLUMN core.dd_events.c_show_material IS 'Средства наглядной агитации';

COMMENT ON COLUMN core.dd_events.c_violation IS 'Нарушения';

COMMENT ON COLUMN core.dd_events.f_user IS 'Пользователь';

COMMENT ON COLUMN core.dd_events.sn_delete IS 'Признак удаленности';

COMMENT ON COLUMN core.dd_events.dx_created IS 'Дата создания';

--------------------------------------------------------------------------------

CREATE TRIGGER dd_events_1
	BEFORE INSERT OR UPDATE OR DELETE ON core.dd_events
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_log_action();

--------------------------------------------------------------------------------

ALTER TABLE core.dd_events
	ADD CONSTRAINT dd_events_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE core.dd_events
	ADD CONSTRAINT dd_events_f_event_type FOREIGN KEY (f_event_type) REFERENCES core.cs_event_types(id);

--------------------------------------------------------------------------------

ALTER TABLE core.dd_events
	ADD CONSTRAINT dd_events_f_document FOREIGN KEY (f_document) REFERENCES core.dd_documents(id);

--------------------------------------------------------------------------------

ALTER TABLE core.dd_events
	ADD CONSTRAINT dd_events_f_user_fkey FOREIGN KEY (f_user) REFERENCES core.pd_users(id);
