CREATE SEQUENCE core.auto_id_pd_users
	START WITH 1
	INCREMENT BY 1
	NO MAXVALUE
	NO MINVALUE
	CACHE 1;

ALTER SEQUENCE core.auto_id_pd_users OWNER TO mobnius;