insert into aux.dca_dataset_utilization_and_claims(
	"num_exec",
	"claims",
	"country",
	"credit agreement type",
	"cumulative loans",
	"cumulative utilization",
	"cumulative utilization percentage",
	"effective maximum cumulative disbursements",
	"final date for placing loans under coverage",
	"fiscal year",
	"guarantee end date",
	"guarantee number",
	"guarantee percentage",
	"guarantee start date",
	"partner name",
	"primary target sector",
	"primary target segment",
	"recoveries",
	"secondary target sector(s)",
	"secondary target segment(s)",
	"status"
)
select
	"num_exec",
	"claims",
	"country",
	"credit agreement type",
	"cumulative loans",
	"cumulative utilization",
	"cumulative utilization percentage",
	"effective maximum cumulative disbursements",
	"final date for placing loans under coverage",
	"fiscal year",
	"guarantee end date",
	"guarantee number",
	"guarantee percentage",
	"guarantee start date",
	"partner name",
	"primary target sector",
	"primary target segment",
	"recoveries",
	"secondary target sector(s)",
	"secondary target segment(s)",
	"status"
from (
	select
		stg.*
		,case
			when
				aux."credit agreement type" 	is null and
				aux."guarantee number" 			is null and
				aux."guarantee start date" 		is null and
				aux."guarantee end date" 		is null and
				aux."num_exec"					is null
				then 'insert'
			when
				coalesce(stg."country",'-1')                                        <> coalesce(aux."country", '-1') or
				coalesce(stg."cumulative loans",'-1')                               <> coalesce(aux."cumulative loans", '-1') or
				coalesce(stg."cumulative utilization",'-1')                         <> coalesce(aux."cumulative utilization", '-1') or
				coalesce(stg."cumulative utilization percentage",'-1')              <> coalesce(aux."cumulative utilization percentage", '-1') or
				coalesce(stg."effective maximum cumulative disbursements",'-1')     <> coalesce(aux."effective maximum cumulative disbursements", '-1') or
				coalesce(stg."final date for placing loans under coverage",'-1')    <> coalesce(aux."final date for placing loans under coverage", '-1') or
				coalesce(stg."fiscal year",'-1')                                    <> coalesce(aux."fiscal year", '-1') or
				coalesce(stg."guarantee percentage",'-1')                           <> coalesce(aux."guarantee percentage", '-1') or
				coalesce(stg."partner name",'-1')                                   <> coalesce(aux."partner name", '-1') or
				coalesce(stg."primary target sector",'-1')                          <> coalesce(aux."primary target sector", '-1') or
				coalesce(stg."primary target segment",'-1')                         <> coalesce(aux."primary target segment", '-1') or
				coalesce(stg."recoveries",'-1')                                     <> coalesce(aux."recoveries", '-1') or
				coalesce(stg."secondary target sector(s)",'-1')                     <> coalesce(aux."secondary target sector(s)", '-1') or
				coalesce(stg."secondary target segment(s)",'-1')                    <> coalesce(aux."secondary target segment(s)", '-1') or
				coalesce(stg."status",'-1')                                         <> coalesce(aux."status", '-1')
				then 'update'
			else 'none'
		end as operation_type
	from 
		stage.dca_dataset_utilization_and_claims as stg
	left join
		aux.dca_dataset_utilization_and_claims as aux
	on stg."credit agreement type" 		= aux."credit agreement type"
	and stg."guarantee number" 			= aux."guarantee number"
	and stg."guarantee start date" 		= aux."guarantee start date"
	and stg."guarantee end date" 		= aux."guarantee end date"
	and stg."num_exec"					= aux."num_exec"
	) as sq
where
	operation_type in ('insert', 'update')

