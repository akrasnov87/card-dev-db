CREATE OR REPLACE FUNCTION core.cf_arm_dd_documents_search(_txt text) RETURNS TABLE(id uuid, c_first_name text, c_last_name text, c_middle_name text, d_birthday date, c_address_reg text, c_address_life text, c_notice text, sn_delete boolean, c_tag text)
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
	    max(d.c_first_name),
	    max(d.c_last_name),
	    max(d.c_middle_name),
		max(d.d_birthday),
	    max(concat(d.c_city_reg, ' ', d.c_street_reg, ' ', d.c_house_reg, ' ', d.c_premise_reg)),
	    max(concat(d.c_city_life, ' ', d.c_street_life, ' ', d.c_house_life, ' ', d.c_premise_life)),
	    max(d.c_notice),
	    case when max(case when d.sn_delete then 1 else 0 end) = 1 then true else false end,
		max(d.c_tag)
	from core.dd_documents as d
	inner join core.dd_events as e on d.id = e.f_document
	where d.c_first_name ilike '%'||_txt||'%' or d.c_last_name ilike '%'||_txt||'%' or d.c_middle_name ilike '%'||_txt||'%'
	or d.c_city_reg ilike '%'||_txt||'%' or d.c_street_reg ilike '%'||_txt||'%' or d.c_house_reg ilike '%'||_txt||'%' or d.c_premise_reg ilike '%'||_txt||'%' 
	or d.c_city_life ilike '%'||_txt||'%' or d.c_street_life ilike '%'||_txt||'%' or d.c_house_life ilike '%'||_txt||'%' or d.c_premise_life ilike '%'||_txt||'%' 
	or d.c_education ilike '%'||_txt||'%' or d.c_work_place ilike '%'||_txt||'%' or d.c_biografy ilike '%'||_txt||'%' or d.c_arrest ilike '%'||_txt||'%'
	or e.c_target ilike '%'||_txt||'%' or e.c_time_place_before ilike '%'||_txt||'%' or e.c_notify_result ilike '%'||_txt||'%'
	or e.c_time_place_after ilike '%'||_txt||'%' or e.c_show_material ilike '%'||_txt||'%' or e.c_violation ilike '%'||_txt||'%' or d.c_notice ilike '%'||_txt||'%'
	group by d.id
	order by d.dx_created desc, max(e.dx_created) desc;
END
$$;

ALTER FUNCTION core.cf_arm_dd_documents_search(_txt text) OWNER TO card;

COMMENT ON FUNCTION core.cf_arm_dd_documents_search(_txt text) IS 'Поиск документа';
