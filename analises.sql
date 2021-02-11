
HDI loan quantity

select
	h.name_country,
	h.desc_indicator,
	count(lt.idt_transaction_report) as qtd_loan
from
	prod.dca_dataset_loan_transactions as lt
inner join prod.hdi_human_development_index_hdig_value as h on
	h.name_country = lt.name_country
where
	extract('year' from lt.date_end) between '1989' and '2013'
group by
	h.name_country,
	h.desc_indicator
order by
	h.name_country

loan without guarantee

select
	distinct lt.*
from
	prod.dca_dataset_loan_transactions as lt
left join prod.dca_dataset_utilization_and_claims as uc 
	on lt.cod_guarantee_number = uc.cod_guarantee_number
where
	uc.cod_guarantee_number is null;


-- guarantee without loan

select
	distinct lt.cod_guarantee_number,
	uc.*
from
	prod.dca_dataset_utilization_and_claims as uc
left join prod.dca_dataset_loan_transactions as lt
	on uc.cod_guarantee_number = lt.cod_guarantee_number


-- Sum every country

select
	h.name_country,
	sum(w.num_value) as num_value
from
	prod.world_currencies_conversion_rates as w
left join prod.hdi_human_development_index_hdig_value as h
	on h.cod_country = w.cod_location
	and h.desc_year = w.desc_year
group by
	h.name_country
order by
	h.name_country