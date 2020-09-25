insert into prod.dca_dataset_utilization_and_claims (
	"num_exec",
	"cod_key_table",
	"desc_credit_agreement_type",
	"cod_guarantee_number",
	"date_guarantee_start",
	"date_guarantee_end",
	"num_claims",
	"name_country",
	"num_cumulative_loans",
	"num_cumulative_utilization",
	"num_cumulative_utilization_percentage",
	"num_effective_maximum_cumulative_disbursements",
	"date_final_for_placing_loans_under_coverage",
	"desc_fiscal_year",
	"num_guarantee_percentage",
	"name_partner",
	"desc_primary_target_sector",
	"desc_primary_target_segment",
	"num_recoveries",
	"desc_secondary_target_sector",
	"desc_secondary_target_segment",
	"desc_status",
	"date_update"
	)
select
	aux."num_exec",
	aux."cod_key_table",
	aux."desc_credit_agreement_type",
	aux."cod_guarantee_number",
	aux."date_guarantee_start",
	aux."date_guarantee_end",
	aux."num_claims",
	aux."name_country",
	aux."num_cumulative_loans",
	aux."num_cumulative_utilization",
	aux."num_cumulative_utilization_percentage",
	aux."num_effective_maximum_cumulative_disbursements",
	aux."date_final_for_placing_loans_under_coverage",
	aux."desc_fiscal_year",
	aux."num_guarantee_percentage",
	aux."name_partner",
	aux."desc_primary_target_sector",
	aux."desc_primary_target_segment",
	aux."num_recoveries",
	aux."desc_secondary_target_sector",
	aux."desc_secondary_target_segment",
	aux."desc_status",
	aux."date_update"
from (
	select
		distinct
		"num_exec",
		upper(md5(trim(trim(upper(coalesce("credit agreement type", '-1'))) || trim(upper(coalesce("guarantee number", '-1'))) || trim(coalesce("guarantee start date", '-1')) || trim(coalesce("guarantee start date", '-1')))))::text as "cod_key_table",
		case when "credit agreement type" = '' then null else trim(upper("credit agreement type"))::varchar(100) end as "desc_credit_agreement_type",
		case when "guarantee number" = '' then null else trim(upper("guarantee number"))::varchar(100) end as "cod_guarantee_number",
		case when "guarantee start date" = '' then null else  "guarantee start date"::date end as "date_guarantee_start",
		case when "guarantee end date"  = '' then null else "guarantee end date"::date end as "date_guarantee_end",
		case when "claims" = '' then null else replace(replace("claims", '$', ''), ',', '')::numeric(12,2) end as "num_claims",
		case when "country" = '' then null else trim(upper("country"))::varchar(100) end as "name_country",
		case when "cumulative loans" = '' then null else replace("cumulative loans", ',', '')::int8 end "num_cumulative_loans",
		case when "cumulative utilization" = '' then null else replace(replace("cumulative utilization", '$', ''), ',', '')::numeric(12,2) end as "num_cumulative_utilization",
		case when "cumulative utilization percentage" = '' then null else replace("cumulative utilization percentage", '%', '')::numeric(12,2) end as "num_cumulative_utilization_percentage",
		case when "effective maximum cumulative disbursements" = '' then null else replace(replace("effective maximum cumulative disbursements", '$', ''), ',', '')::numeric(12,2) end as "num_effective_maximum_cumulative_disbursements",
		case when "final date for placing loans under coverage" = '' then null else "final date for placing loans under coverage"::date end as "date_final_for_placing_loans_under_coverage",
		case when "fiscal year" = '' then null else "fiscal year"::varchar(4) end as "desc_fiscal_year",
		case when "guarantee percentage" = '' then null else replace("guarantee percentage", '%', '')::numeric(12,2) end as "num_guarantee_percentage",
		case when "partner name" = '' then null else trim(upper("partner name"))::varchar(150) end as "name_partner",
		case when "primary target sector" = '' then null else trim(upper("primary target sector"))::varchar(20) end as "desc_primary_target_sector",
		case when "primary target segment" = '' then null else trim(upper("primary target segment"))::varchar(20) end as "desc_primary_target_segment",
		case when "recoveries" = '' then null else replace(replace("recoveries", '$', ''), ',', '')::numeric(12,2) end "num_recoveries",
		case when "secondary target sector(s)" = '' then null else trim(upper("secondary target sector(s)"))::varchar(30) end as "desc_secondary_target_sector",
		case when "secondary target segment(s)" = '' then null else trim(upper("secondary target segment(s)"))::varchar(30) end as "desc_secondary_target_segment",
		case when "status" = '' then null else trim(upper("status"))::varchar(10) end as "desc_status",
		now() AT TIME ZONE current_setting('TimeZone') as "date_update",
		dense_rank() over (partition by upper(md5(trim(trim(upper(coalesce("credit agreement type", '-1'))) || trim(upper(coalesce("guarantee number", '-1')) || trim(coalesce("guarantee start date", '-1')) || trim(coalesce("guarantee start date", '-1'))))))::text order by "num_exec" desc) as rank
	from aux."dca_dataset_utilization_and_claims"
	) as aux
left join prod."dca_dataset_utilization_and_claims" as prod
	on prod."cod_key_table" = aux."cod_key_table"
where aux.rank = 1
and (aux."num_exec" > prod."num_exec" or prod."num_exec" is null)
on conflict on constraint "dca_dataset_utilization_and_claims_uk"
do update set
	"num_exec" 											= excluded."num_exec",
	"num_claims"										= excluded."num_claims",
	"name_country"										= excluded."name_country",
	"num_cumulative_loans"								= excluded."num_cumulative_loans",
	"num_cumulative_utilization"						= excluded."num_cumulative_utilization",
	"num_cumulative_utilization_percentage"				= excluded."num_cumulative_utilization_percentage",
	"num_effective_maximum_cumulative_disbursements"	= excluded."num_effective_maximum_cumulative_disbursements",
	"date_final_for_placing_loans_under_coverage"		= excluded."date_final_for_placing_loans_under_coverage",
	"desc_fiscal_year"									= excluded."desc_fiscal_year",
	"num_guarantee_percentage"							= excluded."num_guarantee_percentage",
	"name_partner"										= excluded."name_partner",
	"desc_primary_target_sector"						= excluded."desc_primary_target_sector",
	"desc_primary_target_segment"						= excluded."desc_primary_target_segment",
	"num_recoveries"									= excluded."num_recoveries",
	"desc_secondary_target_sector"						= excluded."desc_secondary_target_sector",
	"desc_secondary_target_segment"						= excluded."desc_secondary_target_segment",
	"desc_status"										= excluded."desc_status",
	"date_update"										= excluded."date_update"