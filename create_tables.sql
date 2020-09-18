drop schema if exists public;

create schema stage;
create schema aux;
create schema prod;
grant all on schema stage to postgres with grant option;
grant all on schema aux to postgres with grant option;
grant all on schema prod to postgres with grant option;



-------------------------------------------------------------------------------
-------------------------------CREATE TABLES AUX------------------------------
-------------------------------------------------------------------------------

CREATE TABLE aux.log_control (
	"num_exec" int4 not null,
	"dat_created" timestamp default current_timestamp,
	"dat_updated" timestamp,
	"ind_status"  varchar(20) default 'pending'
) ;
ALTER TABLE aux.log_control ADD CONSTRAINT logcon_pk PRIMARY KEY (num_exec);


COMMENT ON TABLE aux.log_control							IS 'Table of control of the load';
COMMENT ON COLUMN aux.log_control.num_exec					IS 'Number execution';
COMMENT ON COLUMN aux.log_control.dat_created				IS 'Data created register';
COMMENT ON COLUMN aux.log_control.dat_updated				IS 'Data updated register';
COMMENT ON COLUMN aux.log_control.ind_status				IS 'Execution status ("success", "pending")';


CREATE TABLE aux.log_execution (
	"num_exec" int4 not null,
	"nam_table" timestamp,
	"num_count_rows" int4,
	"dat_execution" timestamp default current_timestamp
) ;

ALTER TABLE aux.log_execution ADD CONSTRAINT logexec_pk PRIMARY KEY (num_exec, nam_table);

COMMENT ON TABLE aux.log_execution						IS 'Table log register';
COMMENT ON COLUMN aux.log_execution.num_exec			IS 'Number execution';
COMMENT ON COLUMN aux.log_execution.nam_table			IS 'Name of the table';
COMMENT ON COLUMN aux.log_execution.num_count_rows		IS 'Count rows processed';
COMMENT ON COLUMN aux.log_execution.dat_execution		IS 'Data Execution';

CREATE TABLE aux.dca_dataset_loan_transactions (
	"num_exec" int4 not NULL,
	"amount (usd)" varchar NULL,
	"business sector" varchar NULL,
	"business size" varchar NULL,
	"city/town" varchar NULL,
	"country name" varchar NULL,
	"currency name" varchar NULL,
	"end date" varchar NULL,
	"guarantee number" varchar NULL,
	"is first time borrower?" varchar NULL,
	"is woman owned?" varchar NULL,
	"latitude" varchar NULL,
	"longitude" varchar NULL,
	"region name" varchar NULL,
	"state/province/region code" varchar NULL,
	"state/province/region name" varchar NULL,
	"transaction report id" varchar NULL,
	"dat_import" TIMESTAMP DEFAULT CURRENT_TIMESTAMP  NOT NULL
) ;
ALTER TABLE aux.dca_dataset_loan_transactions ADD CONSTRAINT dca_dataset_loan_transactions_uk UNIQUE ("num_exec", "transaction report id");


CREATE TABLE aux.dca_dataset_utilization_and_claims (
	"num_exec" int4 not NULL,
	"claims" varchar NULL,
	"country" varchar NULL,
	"credit agreement type" varchar NULL,
	"cumulative loans" varchar NULL,
	"cumulative utilization" varchar NULL,
	"cumulative utilization percentage" varchar NULL,
	"effective maximum cumulative disbursements" varchar NULL,
	"final date for placing loans under coverage" varchar NULL,
	"fiscal year" varchar NULL,
	"guarantee end date" varchar NULL,
	"guarantee number" varchar NULL,
	"guarantee percentage" varchar NULL,
	"guarantee start date" varchar NULL,
	"partner name" varchar NULL,
	"primary target sector" varchar NULL,
	"primary target segment" varchar NULL,
	"recoveries" varchar NULL,
	"secondary target sector(s)" varchar NULL,
	"secondary target segment(s)" varchar NULL,
	"status" varchar NULL,
	"dat_import" TIMESTAMP DEFAULT CURRENT_TIMESTAMP  NOT NULL
) ;
ALTER TABLE aux.dca_dataset_utilization_and_claims ADD CONSTRAINT dca_dataset_utilization_and_claims_uk UNIQUE ("num_exec", "credit agreement type", "guarantee number", "guarantee start date", "guarantee end date");


CREATE TABLE aux.hdi_human_development_index_hdig_value (
	"num_exec" int4 not NULL,
	"country" varchar NULL,
	"country_code" varchar NULL,
	"id" varchar NULL,
	"indicator" varchar NULL,
	"indicator_code" varchar NULL,
	"utc_created" varchar NULL,
	"utc_updated" varchar NULL,
	"value" varchar NULL,
	"year" varchar NULL,
	"dat_import" TIMESTAMP DEFAULT CURRENT_TIMESTAMP  NOT NULL
) ;
ALTER TABLE aux.hdi_human_development_index_hdig_value ADD CONSTRAINT hdi_human_development_index_hdig_value_uk UNIQUE ("num_exec", "country_code", "indicator_code", "year");


CREATE TABLE aux.world_currencies_conversion_rates (
	"num_exec" int4 not NULL,
	"location" varchar NULL,
	"indicator" varchar NULL,
	"subject" varchar NULL,
	"measure" varchar NULL,
	"frequency" varchar NULL,
	"time" varchar NULL,
	"value" varchar NULL,
	"flag codes" varchar NULL,
	"dat_import" TIMESTAMP DEFAULT CURRENT_TIMESTAMP  NOT NULL
) ;
ALTER TABLE aux.world_currencies_conversion_rates ADD CONSTRAINT world_currencies_conversion_rates_uk UNIQUE ("num_exec", "location", "indicator", "time");

-------------------------------------------------------------------------------
-------------------------------CREATE TABLES STAGE------------------------------
-------------------------------------------------------------------------------

CREATE TABLE stage.dca_dataset_loan_transactions (
	"num_exec" int4 NOT NULL,
	"amount (usd)" varchar NULL,
	"business sector" varchar NULL,
	"business size" varchar NULL,
	"city/town" varchar NULL,
	"country name" varchar NULL,
	"currency name" varchar NULL,
	"end date" varchar NULL,
	"guarantee number" varchar NULL,
	"is first time borrower?" varchar NULL,
	"is woman owned?" varchar NULL,
	"latitude" varchar NULL,
	"longitude" varchar NULL,
	"region name" varchar NULL,
	"state/province/region code" varchar NULL,
	"state/province/region name" varchar NULL,
	"transaction report id" varchar NULL
);



CREATE TABLE stage.dca_dataset_utilization_and_claims (
	"num_exec" int4 not NULL,
	"claims" varchar NULL,
	"country" varchar NULL,
	"credit agreement type" varchar NULL,
	"cumulative loans" varchar NULL,
	"cumulative utilization" varchar NULL,
	"cumulative utilization percentage" varchar NULL,
	"effective maximum cumulative disbursements" varchar NULL,
	"final date for placing loans under coverage" varchar NULL,
	"fiscal year" varchar NULL,
	"guarantee end date" varchar NULL,
	"guarantee number" varchar NULL,
	"guarantee percentage" varchar NULL,
	"guarantee start date" varchar NULL,
	"partner name" varchar NULL,
	"primary target sector" varchar NULL,
	"primary target segment" varchar NULL,
	"recoveries" varchar NULL,
	"secondary target sector(s)" varchar NULL,
	"secondary target segment(s)" varchar NULL,
	"status" varchar NULL
) ;


CREATE TABLE stage.hdi_human_development_index_hdig_value (
	"num_exec" int4 not NULL,
	"country" varchar NULL,
	"country_code" varchar NULL,
	"id" varchar NULL,
	"indicator" varchar NULL,
	"indicator_code" varchar NULL,
	"utc_created" varchar NULL,
	"utc_updated" varchar NULL,
	"value" varchar NULL,
	"year" varchar NULL
) ;


CREATE TABLE stage.world_currencies_conversion_rates (
	"num_exec" int4 not NULL,
	"location" varchar NULL,
	"indicator" varchar NULL,
	"subject" varchar NULL,
	"measure" varchar NULL,
	"frequency" varchar NULL,
	"time" varchar NULL,
	"value" varchar NULL,
	"flag codes" varchar NULL
) ;



-------------------------------------------------------------------------------
-------------------------------CREATE TABLES PROD------------------------------
-------------------------------------------------------------------------------


CREATE TABLE prod.dca_dataset_loan_transactions (
	"num_exec" int4 not null,
	"cod_key_table" text not null,
	"idt_transaction_report" int8 not null,
	"num_amount_usd" numeric(12,2) null,
	"desc_business_sector" varchar(100) null,
	"desc_business_size" varchar(20) null,
	"name_city_town" varchar(250) null,
	"name_country" varchar(250) null,
	"name_currency" varchar(100) not null,
	"date_end" date not null,
	"cod_guarantee_number" varchar(100) not null,
	"idc_first_time_borrower" boolean null,
	"idc_woman_owned" boolean null,
	"num_latitude" float8 null,
	"num_longitude" float8 null,
	"name_region" varchar(100) null,
	"cod_state_province_region" varchar(10) null,
	"name_state_province_region" varchar(250) null,
	"date_creation" timestamp default current_timestamp  not null,
	"date_update" 	timestamp
) ;

ALTER TABLE prod.dca_dataset_loan_transactions ADD CONSTRAINT dca_dataset_loan_transactions_uk UNIQUE ("cod_key_table");

CREATE TABLE prod.dca_dataset_utilization_and_claims (
	"num_exec" int4 not null,
	"cod_key_table" text not null,
	"desc_credit_agreement_type" varchar(100) not null,	
	"cod_guarantee_number" varchar(100) not null,
	"date_guarantee_start" date not null,
	"date_guarantee_end" date not null,
	"num_claims" numeric(12,2) null,
	"name_country" varchar(100) null,
	"num_cumulative_loans" int8 null,
	"num_cumulative_utilization" numeric(12,2) null,
	"num_cumulative_utilization_percentage" numeric(12,2) null,
	"num_effective_maximum_cumulative_disbursements" numeric(12,2) null,
	"date_final_for_placing_loans_under_coverage" date null,
	"desc_fiscal_year" varchar(4) null,
	"num_guarantee_percentage" numeric(12,2) null,
	"name_partner" varchar(150) null,
	"desc_primary_target_sector" varchar(20) null,
	"desc_primary_target_segment" varchar(20) null,
	"num_recoveries" numeric(12,2) null,
	"desc_secondary_target_sector" varchar(30) null,
	"desc_secondary_target_segment" varchar(30) null,
	"desc_status" varchar(10) null,
	"date_creation" timestamp default current_timestamp  not null,
	"date_update" 	timestamp
) ;

ALTER TABLE prod.dca_dataset_utilization_and_claims ADD CONSTRAINT dca_dataset_utilization_and_claims_uk UNIQUE ("cod_key_table");


CREATE TABLE prod.hdi_human_development_index_hdig_value (
	"num_exec" int4 not null,
	"cod_key_table" text not null,
	"name_country" varchar(100) null,
	"cod_country" varchar(5) not null,
	"desc_indicator" varchar(100) null,
	"cod_indicator" int4 not null,
	"desc_year" int4 not null,
	"num_value" numeric(12,2) null,
	"date_creation" timestamp not null,
	"date_update" 	timestamp
) ;

ALTER TABLE prod.hdi_human_development_index_hdig_value ADD CONSTRAINT hdi_human_development_index_hdig_value_uk UNIQUE ("cod_key_table");


CREATE TABLE prod.world_currencies_conversion_rates (
	"num_exec" int4 not null,
	"cod_key_table" text not null,
	"cod_location" varchar(5) not null,
	"cod_indicator" varchar(5) not null,
	"desc_year" int4 not null,
	"desc_subject" varchar(10) null,
	"desc_measure" varchar(30) null,
	"desc_frequency" varchar(10) null,
	"num_value" numeric(12,2) null,
	"cod_flag" varchar(50) null,
	"date_creation" timestamp default current_timestamp  not null,
	"date_update" 	timestamp
) ;

ALTER TABLE prod.world_currencies_conversion_rates ADD CONSTRAINT world_currencies_conversion_rates_uk UNIQUE ("cod_key_table");