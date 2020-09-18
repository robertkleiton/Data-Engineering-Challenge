import os
import log
import variables as var
import query_insert as qr
import s3_download_data as sdd
import process_data_up_s3 as pdus
import truncate_tables as tr
import data_insert_log_control as lc
import data_insert_stg as dis
import data_insert_aux as dia
import data_insert_prd as dip

print('ETL starting')
log.logger.info('ETL starting')

# # Files extraction from bucket AWS S3 to proccessing
sdd.s3_download_dataset(var.bucket, var.path_input)

# # Porccessing, handling and uploading of the files format ".parquet" to bucket AWS S3
pdus.read_dataset(var.bucket, var.path_output)

# # Truncate stage tables
tr.truncate()

# # Update log_control table
lc.log_control('initial')


# # Inserting raw data on stage tables
dis.insert_stg(var.dca_dataset_loan_transactions, qr.query_dca_dataset_loan_transactions)

dis.insert_stg(var.dca_dataset_utilization_and_claims, qr.query_dca_dataset_utilization_and_claims)

dis.insert_stg(var.hdi_human_development_index_hdig_value, qr.query_hdi_human_development_index_hdig_value)

dis.insert_stg(var.world_currencies_conversion_rates, qr.query_world_currencies_conversion_rates)

# # Inserting raw data on aux tables
dia.insert_aux(var.insert_aux_dca_dataset_loan_transactions)

dia.insert_aux(var.insert_aux_dca_dataset_utilization_and_claims)

dia.insert_aux(var.insert_aux_hdi_human_development_index_hdig_value)

dia.insert_aux(var.insert_aux_world_currencies_conversion_rates)

# # Inserting or updating data in final tables

dip.insert_prd(var.insert_prod_dca_dataset_loan_transactions)
dip.insert_prd(var.insert_prod_dca_dataset_utilization_and_claims)
dip.insert_prd(var.insert_prod_hdi_human_development_index_hdig_value)
dip.insert_prd(var.insert_prod_world_currencies_conversion_rates)

# # Update log_control table
lc.log_control('finish')
print('ETL execution completed successfully')
log.logger.info('ETL execution completed successfully')