insert into aux.dca_dataset_loan_transactions (
	"num_exec",
	"amount (usd)",
	"business sector",
	"business size",
	"city/town",
	"country name",
	"currency name",
	"end date",
	"guarantee number",
	"is first time borrower?",
	"is woman owned?",
	"latitude",
	"longitude",
	"region name",
	"state/province/region code",
	"state/province/region name",
	"transaction report id"
	)
select
	"num_exec",
	"amount (usd)",
	"business sector",
	"business size",
	"city/town",
	"country name",
	"currency name",
	"end date",
	"guarantee number",
	"is first time borrower?",
	"is woman owned?",
	"latitude",
	"longitude",
	"region name",
	"state/province/region code",
	"state/province/region name",
	"transaction report id"
from (
	select
		stg.*
		,case
			when
				aux."transaction report id" is null and
				aux."num_exec" 				is null
				then 'insert'
			when
				coalesce(stg."amount (usd)", '-1') 					<> coalesce(aux."amount (usd)", '-1') or
				coalesce(stg."business sector", '-1') 				<> coalesce(aux."business sector", '-1') or
				coalesce(stg."business size", '-1') 				<> coalesce(aux."business size", '-1') or
				coalesce(stg."city/town", '-1') 					<> coalesce(aux."city/town", '-1') or
				coalesce(stg."country name", '-1') 					<> coalesce(aux."country name", '-1') or
				coalesce(stg."currency name", '-1') 				<> coalesce(aux."currency name", '-1') or
				coalesce(stg."end date", '-1') 						<> coalesce(aux."end date", '-1') or
				coalesce(stg."guarantee number", '-1') 				<> coalesce(aux."guarantee number", '-1') or
				coalesce(stg."is first time borrower?", '-1') 		<> coalesce(aux."is first time borrower?", '-1') or
				coalesce(stg."is woman owned?", '-1') 				<> coalesce(aux."is woman owned?", '-1') or
				coalesce(stg."latitude", '-1') 						<> coalesce(aux."latitude", '-1') or
				coalesce(stg."longitude", '-1') 					<> coalesce(aux."longitude", '-1') or
				coalesce(stg."region name", '-1') 					<> coalesce(aux."region name", '-1') or
				coalesce(stg."state/province/region code", '-1')	<> coalesce(aux."state/province/region code", '-1') or
				coalesce(stg."state/province/region name", '-1')	<> coalesce(aux."state/province/region name", '-1')
				then 'update'
			else 'none'
		end as operation_type
	from
		stage.dca_dataset_loan_transactions as stg
	left join
		aux.dca_dataset_loan_transactions as aux
	on stg."transaction report id"	= aux."transaction report id"
	and stg."num_exec" 				= aux."num_exec"
	) as sq
where
	operation_type in ('insert', 'update')
