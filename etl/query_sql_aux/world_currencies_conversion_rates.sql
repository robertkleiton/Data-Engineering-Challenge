insert into aux.world_currencies_conversion_rates (
	"num_exec",
	"location",
	"indicator",
	"subject",
	"measure",
	"frequency",
	"time",
	"value",
	"flag codes"
	)
select
	"num_exec",
	"location",
	"indicator",
	"subject",
	"measure",
	"frequency",
	"time",
	"value",
	"flag codes"
from (
	select
		stg.*
		,case
			when
				aux."location" 	is null and
				aux."indicator" is null and
				aux."time" 		is null and
				aux."num_exec"	is null
				then 'insert'
			when
				coalesce(stg."subject", '-1') 		<> coalesce(aux."subject", '-1') or
				coalesce(stg."measure", '-1') 		<> coalesce(aux."measure", '-1') or
				coalesce(stg."frequency", '-1') 	<> coalesce(aux."frequency", '-1') or
				coalesce(stg."value", '-1') 		<> coalesce(aux."value", '-1') or
				coalesce(stg."flag codes", '-1') 	<> coalesce(aux."flag codes", '-1')
				then 'update'
			else 'none'
		end as operation_type
	from
		stage.world_currencies_conversion_rates as stg
	left join
		aux.world_currencies_conversion_rates as aux
	on stg."location"	 	= aux."location"
	and stg."indicator" 	= aux."indicator"
	and stg."time"			= aux."time"
	and stg."num_exec"		= aux."num_exec"
	) as sq
where
	operation_type in ('insert', 'update')
