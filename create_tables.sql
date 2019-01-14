
CREATE TABLE stage.dca_dataset_loan_transactions (
	"amount_(usd)" varchar NULL,
	business_sector varchar NULL,
	business_size varchar NULL,
	"city/town" varchar NULL,
	country_name varchar NULL,
	currency_name varchar NULL,
	end_date varchar NULL,
	guarantee_number varchar NULL,
	"is_first_time_borrower?" varchar NULL,
	"is_woman_owned?" varchar NULL,
	latitude varchar NULL,
	longitude varchar NULL,
	region_name varchar NULL,
	"state/province/region_code" varchar NULL,
	"state/province/region_name" varchar NULL,
	transaction_report_id varchar NULL
)
WITH (
	OIDS=FALSE
) ;



CREATE TABLE stage.dca_dataset_utilization_and_claims (
	claims varchar NULL,
	country varchar NULL,
	credit_agreement_type varchar NULL,
	cumulative_loans varchar NULL,
	cumulative_utilization varchar NULL,
	cumulative_utilization_percentage varchar NULL,
	effective_maximum_cumulative_disbursements varchar NULL,
	final_date_for_placing_loans_under_coverage varchar NULL,
	final_date_for_placng_loans_under_coverage varchar NULL,
	fiscal_year varchar NULL,
	guarantee_end_date varchar NULL,
	guarantee_number varchar NULL,
	guarantee_percentage varchar NULL,
	guarantee_start_date varchar NULL,
	partner_name varchar NULL,
	primary_target_sector varchar NULL,
	primary_target_segment varchar NULL,
	recoveries varchar NULL,
	"secondary_target_sector(s)" varchar NULL,
	"secondary_target_segment(s)" varchar NULL,
	status varchar NULL
)
WITH (
	OIDS=FALSE
) ;


CREATE TABLE stage.hdi_human_development_index_hdig_value (
	country varchar NULL,
	country_code varchar NULL,
	id varchar NULL,
	"indicator" varchar NULL,
	indicator_code varchar NULL,
	utc_created varchar NULL,
	utc_updated varchar NULL,
	value varchar NULL,
	"year" varchar NULL
)
WITH (
	OIDS=FALSE
) ;


CREATE TABLE stage.world_currencies_conversion_rates (
	location varchar NULL,
	"indicator" varchar NULL,
	suject varchar NULL,
	measure varchar NULL,
	frequency varchar NULL,
	"time" varchar NULL,
	value varchar NULL,
	flag_codes varchar NULL
)
WITH (
	OIDS=FALSE
) ;



CREATE TABLE public.dca_dataset_loan_transactions (
	transaction_report_id int8 NOT NULL,
	"amount_(usd)" numeric NULL,
	business_sector varchar NULL,
	business_size varchar NULL,
	"city/town" varchar NULL,
	country_name varchar NULL,
	currency_name varchar NOT NULL,
	end_date date NOT NULL,
	guarantee_number varchar NOT NULL,
	"is_first_time_borrower?" varchar NULL,
	"is_woman_owned?" varchar NULL,
	latitude float8 NULL,
	longitude float8 NULL,
	region_name varchar NULL,
	"state/province/region_code" varchar NULL,
	"state/province/region_name" varchar NULL,
	last_update timestamp NULL,
	date_creation timestamp NOT NULL,
	CONSTRAINT dca_dataset_loan_transactions_un UNIQUE (transaction_report_id)
)
WITH (
	OIDS=FALSE
) ;



CREATE TABLE public.dca_dataset_utilization_and_claims (
	claims money NULL,
	country varchar NULL,
	credit_agreement_type varchar NOT NULL,
	cumulative_loans numeric NULL,
	cumulative_utilization money NULL,
	cumulative_utilization_percentage varchar NULL,
	effective_maximum_cumulative_disbursements money NULL,
	final_date_for_placing_loans_under_coverage date NULL,
	final_date_for_placng_loans_under_coverage date NULL,
	fiscal_year varchar NULL,
	guarantee_number varchar NOT NULL,
	guarantee_start_date date NOT NULL,
	guarantee_end_date date NOT NULL,
	guarantee_percentage varchar NULL,
	partner_name varchar NULL,
	primary_target_sector varchar NULL,
	primary_target_segment varchar NULL,
	recoveries money NULL,
	"secondary_target_sector(s)" varchar NULL,
	"secondary_target_segment(s)" varchar NULL,
	status varchar NULL,
	last_update timestamp NULL,
	date_creation timestamp NOT NULL,
	CONSTRAINT dca_dataset_utilization_and_claims_un UNIQUE (credit_agreement_type, guarantee_number, guarantee_start_date, guarantee_end_date)
)
WITH (
	OIDS=FALSE
) ;



CREATE TABLE public.hdi_human_development_index_hdig_value (
	country varchar NULL,
	country_code varchar NULL,
	id int4 NULL,
	"indicator" varchar NULL,
	indicator_code int4 NULL,
	utc_created timestamp NULL,
	utc_updated timestamp NULL,
	value numeric NULL,
	"year" varchar NULL,
	last_update timestamp NULL,
	date_creation timestamp NOT NULL,
	CONSTRAINT hdi_human_development_index_hdig_value_un UNIQUE (country_code, indicator_code, year)
)
WITH (
	OIDS=FALSE
) ;



CREATE TABLE public.world_currencies_conversion_rates (
	location varchar NULL,
	"indicator" varchar NULL,
	suject varchar NULL,
	measure varchar NULL,
	frequency varchar NULL,
	"time" varchar NULL,
	value numeric NULL,
	flag_codes varchar NULL,
	last_update timestamp NULL,
	date_creation timestamp NOT NULL,
	CONSTRAINT world_currencies_conversion_rates_un UNIQUE (location, indicator, "time")
)
WITH (
	OIDS=FALSE
) ;