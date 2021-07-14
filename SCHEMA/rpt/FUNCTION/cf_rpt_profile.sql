CREATE OR REPLACE FUNCTION rpt.cf_rpt_profile(_f_document uuid) RETURNS TABLE(f_document uuid, c_img_url text, c_first_name text, c_last_name text, c_middle_name text, d_birthday date, n_age integer, c_address_reg text, c_city_reg text, c_street_reg text, c_house_reg text, c_premise_reg text, c_address_life text, c_city_life text, c_street_life text, c_house_life text, c_premise_life text, c_education text, c_work_place text, c_biografy text, b_administrative boolean, b_criminal boolean, c_arrest text, c_soc_link text, c_notice text, dx_created timestamp with time zone, d_date_place date, d_notify date, c_event_type text, c_target text, n_count_before integer, c_time_place_before text, c_notify_result text, c_time_place_after text, n_count_after integer, c_show_material text, c_violation text, c_period text, n_iter integer)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* params _f_document {uuid} - идентификатор документа
*
* @example
* [{ "action": "cf_rpt_profile", "method": "Select", "data": [{ "params": [_f_document] }], "type": "rpc", "tid": 0 }]
*/
BEGIN
	return query select
		d.id,						-- иден. документа
		concat('http://10.128.0.2:3001/release/upload/file?id=', d.id::text) as c_img_url,
		d.c_first_name, 			-- фамилия
		d.c_last_name, 				-- имя
		d.c_middle_name, 			-- отчество
		d.d_birthday, 				-- дата рождения
		(date_part('YEAR', now()) - date_part('YEAR', d.d_birthday))::integer as n_age,					-- возраст
		concat(d.c_city_reg, ', ', d.c_street_reg, ', д. ', d.c_house_reg, ', кв. ', d.c_premise_reg) as c_address_reg,
		d.c_city_reg, 				-- город регистрации
		d.c_street_reg, 			-- улица регистрации
		d.c_house_reg, 				-- дом регистрации
		d.c_premise_reg, 			-- квартира регистрации
		concat(d.c_city_life, ', ', d.c_street_life, ', д. ', d.c_house_life, ', кв. ', d.c_premise_life) as c_address_life,
		d.c_city_life, 				-- город проживания
		d.c_street_life, 			-- улица проживания
		d.c_house_life, 			-- дом проживания
		d.c_premise_life, 			-- квартира проживания
		d.c_education,				-- образование
		d.c_work_place,				-- место работы
		d.c_biografy,				-- биография
		d.b_administrative,			-- административка
		d.b_criminal,				-- уголовная ответственность
		d.c_arrest,					-- задержание
		d.c_soc_link,				-- ссылки на соц. сети
		d.c_notice,					-- примечание
		d.dx_created,				-- дата создания записи
		--==================== события =====================
		e.d_date_place, 			-- дата проведения
		e.d_notify,					-- уведомление
		et.c_name as c_event_type,	-- форма проведения
		e.c_target,					-- цель
		e.n_count_before,			-- Заявленное количество участников
		e.c_time_place_before,		-- Место и время проведения
		e.c_notify_result,			-- Результаты рассмотрения уведомления
		e.c_time_place_after,		-- Место и время проведения
		e.n_count_after,			-- Принятое количество участников
		e.c_show_material, 			-- Средства наглядной агитации
		e.c_violation,				-- Нарушения
		to_char(e.d_date_place, 'MM.YYYY'::text) as c_period,
		1 as n_iter					-- Число
	from core.dd_events as e
	inner join core.cs_event_types as et on e.f_event_type = et.id
	inner join core.dd_documents as d on e.f_document = d.id
	where d.id = _f_document
	order by e.d_date_place;
END
$$;

ALTER FUNCTION rpt.cf_rpt_profile(_f_document uuid) OWNER TO vaccine;

COMMENT ON FUNCTION rpt.cf_rpt_profile(_f_document uuid) IS 'Отчет-профиль';
