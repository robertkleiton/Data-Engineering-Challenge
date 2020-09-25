INSERT INTO prod."dca_dataset_loan_transactions"
(
	"num_exec",
	"cod_key_table",
	"idt_transaction_report",
	"num_amount_usd",
	"desc_business_sector",
	"desc_business_size",
	"name_city_town",
	"name_country",
	"name_currency",
	"date_end",
	"cod_guarantee_number",
	"idc_first_time_borrower",
	"idc_woman_owned",
	"num_latitude",
	"num_longitude",
	"name_region",
	"cod_state_province_region",
	"name_state_province_region",
	"date_update"
)
select
	aux."num_exec",
	aux."cod_key_table",
	aux."idt_transaction_report",
	aux."num_amount_usd",
	aux."desc_business_sector",
	aux."desc_business_size",
	aux."name_city_town",
	aux."name_country",
	aux."name_currency",
	aux."date_end",
	aux."cod_guarantee_number",
	aux."idc_first_time_borrower",
	aux."idc_woman_owned",
	aux."num_latitude",
	aux."num_longitude",
	aux."name_region",
	aux."cod_state_province_region",
	aux."name_state_province_region",
	aux."date_update"
from (
	select
		distinct
		"num_exec",
		upper(md5(trim(coalesce("transaction report id", '-1'))))::text as "cod_key_table",
		case when "transaction report id" = '' then null else "transaction report id"::int8 end as "idt_transaction_report",
		case when "amount (usd)" = '' then null else "amount (usd)"::numeric(12,2) end as "num_amount_usd",
		case when "business sector" = '' then null else trim(upper("business sector"))::varchar(100) end as "desc_business_sector",
		case when "business size" = '' then null else "business size"::varchar(20) end as "desc_business_size",
		case when "city/town" = '' then null else trim(upper("city/town"))::varchar(250) end as "name_city_town",
		case when "country name" = '' then null else trim(upper("country name"))::varchar(250) end as "name_country",
		case when "currency name" = '' then null else trim(upper("currency name"))::varchar(100) end as "name_currency",
		case when "end date"= '' then null else to_date("end date", 'mm/dd/yyyy') end as "date_end",
		case when "guarantee number" = '' then null else trim(upper("guarantee number"))::varchar(100) end as "cod_guarantee_number",
		case when "is first time borrower?" = '' then null when "is first time borrower?" = 't' then true else false end as "idc_first_time_borrower",
		case when "is woman owned?" = '' then null when "is woman owned?" = 't' then true else false end as "idc_woman_owned",
		case when "latitude" = '' then null else "latitude"::float8 end as "num_latitude",
		case when "longitude" = '' then null else "longitude"::float8 end as "num_longitude",
		case when "region name" = '' then null else trim(upper("region name"))::varchar(100) end as "name_region",
		case when "state/province/region code" = '' then null else trim(upper("state/province/region code"))::varchar(10) end as "cod_state_province_region",
		case when "state/province/region name" = '' then null else trim(upper("state/province/region name"))::varchar(250) end as "name_state_province_region",
		now() AT TIME ZONE current_setting('TimeZone') as "date_update",
		dense_rank() over (partition by upper(md5(trim(coalesce("transaction report id", '-1'))))::text order by "num_exec" desc) as rank
	from
		aux."dca_dataset_loan_transactions"	
	) as aux
left join prod."dca_dataset_loan_transactions" as prod
on prod."cod_key_table" = aux."cod_key_table"
where aux.rank = 1
and (aux."num_exec" > prod."num_exec" or prod."num_exec" is null)
on conflict on constraint "dca_dataset_loan_transactions_uk"
do update set
	"num_exec" 						= excluded."num_exec",
	"num_amount_usd" 				= excluded."num_amount_usd",
	"desc_business_sector" 			= excluded."desc_business_sector",
	"desc_business_size"			= excluded."desc_business_size",
	"name_city_town"				= excluded."name_city_town",
	"name_country" 					= excluded."name_country",
	"name_currency" 				= excluded."name_currency",
	"date_end" 						= excluded."date_end",
	"cod_guarantee_number"			= excluded."cod_guarantee_number",
	"idc_first_time_borrower" 		= excluded."idc_first_time_borrower",
	"idc_woman_owned" 				= excluded."idc_woman_owned",
	"num_latitude" 					= excluded."num_latitude",
	"num_longitude" 				= excluded."num_longitude",
	"name_region" 					= excluded."name_region",
	"cod_state_province_region"  	= excluded."cod_state_province_region",
	"name_state_province_region" 	= excluded."name_state_province_region",
	"date_update" 					= excluded."date_update";