CREATE SEQUENCE core.auto_id_cs_event_types
	START WITH 1
	INCREMENT BY 1
	NO MAXVALUE
	NO MINVALUE
	CACHE 1;

ALTER SEQUENCE core.auto_id_cs_event_types OWNER TO "card";
