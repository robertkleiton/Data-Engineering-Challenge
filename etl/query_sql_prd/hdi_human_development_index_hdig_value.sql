insert into prod.hdi_human_development_index_hdig_value (
	"num_exec",
	"cod_key_table",
	"name_country",
	"cod_country",
	"desc_indicator",
	"cod_indicator",
	"desc_year",
	"num_value",
	"date_creation",
	"date_update"
)
select
	aux."num_exec",
	aux."cod_key_table",
	aux."name_country",
	aux."cod_country",
	aux."desc_indicator",
	aux."cod_indicator",
	aux."desc_year",
	aux."num_value",
	aux."date_creation",
	aux."date_update"
from (
	select
		distinct
		"num_exec",
		upper(md5(trim(trim(upper(coalesce("country_code", '-1'))) || trim(upper(coalesce("indicator_code", '-1'))) || trim(coalesce("year", '-1')))))::text as "cod_key_table",
		case when "country" = '' then null else upper("country") end as "name_country",
		case when "country_code" = '' then null else upper("country_code") end as "cod_country",
		case when "indicator" = '' then null else upper("indicator") end as "desc_indicator",
		case when "indicator_code" = '' then null else "indicator_code"::int4 end as "cod_indicator",
		coalesce(case when "year" = '' then null else "year"::int4 end, 0) as "desc_year",
		case when "value" = '' then null else "value"::numeric(12,2) end as "num_value",
		"utc_created"::timestamp as "date_creation",
		"utc_updated"::timestamp as "date_update",
		dense_rank() over (partition by upper(md5(trim(trim(upper(coalesce("country_code", '-1'))) || trim(upper(coalesce("indicator_code", '-1'))) || trim(coalesce("year", '-1')))))::text order by "num_exec" desc) as rank
	from aux."hdi_human_development_index_hdig_value"
	) as aux
left join prod."hdi_human_development_index_hdig_value" as prod
	on prod."cod_key_table" = aux."cod_key_table"
where aux.rank = 1
and (aux."num_exec" > prod."num_exec" or prod."num_exec" is null)
on conflict on constraint "hdi_human_development_index_hdig_value_uk"
do update set
	"num_exec" 				= excluded."num_exec",
	"cod_key_table"			= excluded."cod_key_table",
	"name_country"			= excluded."name_country",
	"cod_country"			= excluded."cod_country",
	"desc_indicator"		= excluded."desc_indicator",
	"cod_indicator"			= excluded."cod_indicator",
	"desc_year"				= excluded."desc_year",
	"num_value"				= excluded."num_value",
	"date_update"			= excluded."date_update"