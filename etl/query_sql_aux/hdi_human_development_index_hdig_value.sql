insert into aux.hdi_human_development_index_hdig_value (
	"num_exec",
	"country",
	"country_code",
	"id",
	"indicator",
	"indicator_code",
	"utc_created",
	"utc_updated",
	"value",
	"year"
	)
select 
	"num_exec",
	"country",
	"country_code",
	"id",
	"indicator",
	"indicator_code",
	"utc_created",
	"utc_updated",
	"value",
	"year"
from (
	select
		stg.*
		, case
			when 
				aux."country_code" 		is null and
				aux."indicator_code" 	is null and
				aux."year" 				is null and
				aux."num_exec"			is null
				then 'insert'
			when
				coalesce(stg."country", '-1') 			<> coalesce(aux."country", '-1') or
				coalesce(stg."country_code", '-1') 		<> coalesce(aux."country_code", '-1') or
				coalesce(stg."id", '-1') 				<> coalesce(aux."id", '-1') or
				coalesce(stg."value", '-1') 			<> coalesce(aux."value", '-1') or
				coalesce(stg."indicator_code", '-1') 	<> coalesce(aux."indicator_code", '-1')
				then 'update'
			else 'none'
		end as operation_type
	from
		stage.hdi_human_development_index_hdig_value as stg
	left join
		aux.hdi_human_development_index_hdig_value as aux
	on stg."country_code" 		= aux."country_code"
	and stg."indicator_code" 	= aux."indicator_code"
	and stg."year" 				= aux."year"
	and stg."num_exec"			= aux."num_exec"
	) as sq
where
	operation_type in ('insert', 'update')

