SET TIMEZONE TO 'UTC';

SET check_function_bodies = false;

START TRANSACTION;

SET search_path = pg_catalog;

REVOKE ALL ON SCHEMA public FROM "card-node";
REVOKE ALL ON SCHEMA public FROM PUBLIC;

REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO "card";
GRANT ALL ON SCHEMA public TO PUBLIC;

ALTER SEQUENCE core.auto_id_cd_settings OWNER TO card;

ALTER SEQUENCE core.auto_id_cs_event_types OWNER TO card;

ALTER SEQUENCE core.auto_id_cs_setting_types OWNER TO card;

ALTER SEQUENCE core.auto_id_pd_accesses OWNER TO card;

ALTER SEQUENCE core.auto_id_pd_roles OWNER TO card;

ALTER SEQUENCE core.auto_id_pd_userinroles OWNER TO card;

ALTER SEQUENCE core.auto_id_pd_users OWNER TO card;

--ALTER SEQUENCE core.sd_table_change_id_seq OWNER TO card;

--ALTER SEQUENCE core.sd_table_change_ref_id_seq OWNER TO card;

ALTER TABLE core.cd_action_log OWNER TO card;

ALTER TABLE core.cd_action_log_user OWNER TO card;

ALTER TABLE core.cd_settings OWNER TO card;

ALTER TABLE core.cd_sys_log OWNER TO card;

ALTER TABLE core.cs_setting_types OWNER TO card;

ALTER TABLE core.dd_documents OWNER TO card;

ALTER TABLE core.dd_files OWNER TO card;

ALTER TABLE core.pd_accesses OWNER TO card;
REVOKE SELECT ON TABLE core.pd_accesses FROM "card-node" CASCADE;
REVOKE ALL ON TABLE core.pd_accesses FROM PUBLIC;
REVOKE ALL ON TABLE core.pd_accesses FROM card;
GRANT ALL ON TABLE core.pd_accesses TO card;

REVOKE ALL ON TABLE core.pd_accesses FROM "card";
GRANT SELECT ON TABLE core.pd_accesses TO "card" WITH GRANT OPTION;

ALTER TABLE core.pd_roles OWNER TO card;

ALTER TABLE core.pd_userinroles OWNER TO card;

ALTER TABLE core.pd_users OWNER TO card;

ALTER TABLE core.sd_table_change OWNER TO card;

ALTER TABLE core.sd_table_change_ref OWNER TO card;

ALTER FUNCTION core.cf_arm_dd_documents_history(_id uuid) OWNER TO card;

ALTER FUNCTION core.cf_arm_dd_documents_search(_txt text) OWNER TO card;

ALTER FUNCTION core.cf_arm_dd_events_history(_id uuid) OWNER TO card;

ALTER FUNCTION core.cf_mui_sd_table_change(_fn_user integer, _c_version text) OWNER TO card;

ALTER FUNCTION core.cft_log_action() OWNER TO card;

ALTER FUNCTION core.cft_table_state_change_version() OWNER TO card;

ALTER FUNCTION core.pf_accesses(n_user_id integer) OWNER TO card;

ALTER FUNCTION core.pf_update_user_roles(_user_id integer, _claims json) OWNER TO card;

ALTER FUNCTION core.sf_accesses(c_role_name text, n_currentuser integer, c_claims text, n_user_id integer) OWNER TO card;

ALTER FUNCTION core.sf_build_version(status integer) OWNER TO card;

ALTER FUNCTION core.sf_create_user(_login text, _password text, _claims text, _f_subdivision integer) OWNER TO card;

ALTER FUNCTION core.sf_del_user(_id integer) OWNER TO card;

ALTER FUNCTION core.sf_get_version() OWNER TO card;

ALTER VIEW core.pv_users OWNER TO card;

ALTER VIEW core.sv_objects OWNER TO card;

ALTER VIEW core.sv_users OWNER TO card;

COMMIT TRANSACTION;