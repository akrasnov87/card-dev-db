CREATE OR REPLACE FUNCTION core.cf_arm_dd_documents_search(_txt text) RETURNS TABLE(id uuid, c_first_name text, c_last_name text, c_middle_name text, d_barthday date, c_address_reg text, c_address_life text, c_notice text, sn_delete boolean, c_tag text)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {uuid} _txt - текст для поиска
*
* @example
* [{ "action": "cf_arm_dd_documents_search", "method": "Select", "data": [{ "params": [_txt] }], "type": "rpc", "tid": 0 }]
*/
BEGIN
	return query 
	select d.id,
	    d.n_number,
	    d.c_first_name,
	    d.c_last_name,
	    d.c_middle_name,
		d.d_barthday,
	    concat(d.c_city_reg, ' ', d.c_street_reg, ' ', d.c_house_reg, ' ', d.c_premise_reg),
	    concat(d.c_city_life, ' ', d.c_street_life, ' ', d.c_house_life, ' ', d.c_premise_life),
	    d.c_notice,
	    d.sn_delete,
		d.c_tag
	from core.dd_documents as d
	where d.c_first_name ilike '%'||_txt||'%' or d.c_last_name ilike '%'||_txt||'%' or d.c_middle_name ilike '%'||_txt||'%'
	or d.c_city_reg ilike '%'||_txt||'%' or d.c_street_reg ilike '%'||_txt||'%' or d.c_house_reg ilike '%'||_txt||'%' or d.c_premise_reg ilike '%'||_txt||'%' 
	or d.c_city_life ilike '%'||_txt||'%' or d.c_street_life ilike '%'||_txt||'%' or d.c_house_life ilike '%'||_txt||'%' or d.c_premise_life ilike '%'||_txt||'%' 
	or d.c_education ilike '%'||_txt||'%' or d.c_work_place ilike '%'||_txt||'%' or d.c_biografy ilike '%'||_txt||'%' or d.с_arrest ilike '%'||_txt||'%'
	or d.c_target ilike '%'||_txt||'%' or d.c_form_event ilike '%'||_txt||'%' or d.c_time_place_before ilike '%'||_txt||'%' or d.c_notify_result ilike '%'||_txt||'%'
	or d.c_time_place_after ilike '%'||_txt||'%' or d.c_show_material ilike '%'||_txt||'%' or d.с_violation ilike '%'||_txt||'%' or d.c_notice ilike '%'||_txt||'%'
	order by d.dx_created desc;
END
$$;

ALTER FUNCTION core.cf_arm_dd_documents_search(_txt text) OWNER TO mobnius;

COMMENT ON FUNCTION core.cf_arm_dd_documents_search(_txt text) IS 'Поиск документа';
