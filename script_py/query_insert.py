# query_dca_dataset_loan_transactions = """INSERT INTO stage.dca_dataset_loan_transactions ("amount_(usd)", "business_sector", "business_size", "city/town", "country_name", "currency_name", "end_date", guarantee_number, "is_first_time_borrower?", "is_woman_owned?", "latitude", "longitude", "region_name", "state/province/region_code", "state/province/region_name", "transaction_report_id")VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);"""
query_dca_dataset_loan_transactions = """INSERT INTO stage.dca_dataset_loan_transactions({columns})values({values})"""

# query_dca_dataset_utilization_and_claims = """INSERT INTO stage.dca_dataset_utilization_and_claims("claims", "country", "credit_agreement_type", "cumulative_loans", "cumulative_utilization", "cumulative_utilization_percentage", "effective_maximum_cumulative_disbursements", "final_date_for_placing_loans_under_coverage", "final_date_for_placng_loans_under_coverage", "fiscal_year", "guarantee_end_date", "guarantee_number", "guarantee_percentage", "guarantee_start_date", "partner_name", "primary_target_sector", "primary_target_segment", "recoveries", "secondary_target_sector(s)", "secondary_target_segment(s)", "status")VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);"""
query_dca_dataset_utilization_and_claims = """INSERT INTO stage.dca_dataset_utilization_and_claims({columns})values({values})"""


# query_hdi_human_development_index_hdig_value = """INSERT INTO stage.hdi_human_development_index_hdig_value("num_exec", "country", "country_code", "id", "indicator", "indicator_code", "utc_created", "utc_updated", "value", "year")VALUES(11, %s, %s, %s, %s, %s, %s, %s, %s, %s);"""
query_hdi_human_development_index_hdig_value = """INSERT INTO stage.hdi_human_development_index_hdig_value({columns})values({values})"""



# query_world_currencies_conversion_rates = """INSERT INTO stage.world_currencies_conversion_rates("location", "indicator", "suject", "measure", "frequency", "time", "value", "flag_codes")VALUES(%s, %s, %s, %s, %s, %s, %s, %s);"""
query_world_currencies_conversion_rates = """INSERT INTO stage.world_currencies_conversion_rates({columns})values({values})"""
