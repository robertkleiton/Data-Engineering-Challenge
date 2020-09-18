insert into prod.world_currencies_conversion_rates (
	"num_exec",
	"cod_key_table",
	"cod_location",
	"cod_indicator",
	"desc_year",
	"desc_subject",
	"desc_measure",
	"desc_frequency",
	"num_value",
	"cod_flag",
	"date_update"
)
select
	aux."num_exec",
	aux."cod_key_table",
	aux."cod_location",
	aux."cod_indicator",
	aux."desc_year",
	aux."desc_subject",
	aux."desc_measure",
	aux."desc_frequency",
	aux."num_value",
	aux."cod_flag",
	aux."date_update"
from (
	select
		distinct
		"num_exec",
		upper(md5(trim(trim(upper("location")) || trim(upper("indicator")) || trim("time"))))::text as "cod_key_table",
		case when "location" = '' then null else upper("location") end as "cod_location",
		case when "indicator" = '' then null else upper("indicator") end as "cod_indicator",
		case when "time" = '' then null else "time"::int4 end as "desc_year",
		case when "subject" = '' then null else upper("subject") end as "desc_subject",
		case when "measure" = '' then null else upper("measure") end as "desc_measure",
		case when "frequency" = '' then null else upper("frequency") end as "desc_frequency",
		case when "value" = '' then null else "value"::numeric(12,2) end as "num_value",
		case when "flag codes" = '' then null else upper("flag codes") end as "cod_flag",
		now() AT TIME ZONE current_setting('TimeZone') as "date_update",
		dense_rank() over (partition by upper(md5(trim(trim(upper("location")) || trim(upper("indicator")) || trim("time"))))::text order by "num_exec" desc) as rank
	from aux."world_currencies_conversion_rates"
	) as aux
left join prod."world_currencies_conversion_rates" as prod
	on prod."cod_key_table" = aux."cod_key_table"
where aux.rank = 1
and (aux."num_exec" > prod."num_exec" or prod."num_exec" is null)
on conflict on constraint "world_currencies_conversion_rates_uk"
do update set
	"num_exec" 				= excluded."num_exec",
	"cod_key_table"			= excluded."cod_key_table",
	"cod_location"			= excluded."cod_location",
	"cod_indicator"			= excluded."cod_indicator",
	"desc_year"				= excluded."desc_year",
	"desc_subject"			= excluded."desc_subject",
	"desc_measure"			= excluded."desc_measure",
	"desc_frequency"		= excluded."desc_frequency",
	"num_value"				= excluded."num_value",
	"cod_flag"				= excluded."cod_flag",
	"date_update"			= excluded."date_update"