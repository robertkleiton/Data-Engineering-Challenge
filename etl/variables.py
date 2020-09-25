import os

# S3 Bucet Access
bucket = os.environ.get('VAR_BUCKET')
access_key = os.environ.get('VAR_ACCESS_KEY')
secret_access_key = os.environ.get('VAR_SECRET_ACCESS_KEY')


file_input = './raw_file/datasets.tar.gz'
output_file = './output_file'
path_input = 'raw_file/datasets.tar.gz'
path_output = 'distribution_data/{}/year={}/month={}/day={}/{}'
path_output_error = 'distribution_data/fail/{}/year={}/month={}/day={}/{}'


# Raw File to Process
raw_files_to_process = ['world_currencies_conversion_rates.csv', 
                    'dca_dataset_loan_transactions.jsonl',
                    'hdi_human_development_index_hdig_value.jsonl',
                    'dca_dataset_utilization_and_claims.jsonl']

# Datasets to Process

dca_dataset_loan_transactions = 'dca_dataset_loan_transactions.snappy.parquet'
dca_dataset_utilization_and_claims = 'dca_dataset_utilization_and_claims.snappy.parquet'
hdi_human_development_index_hdig_value = 'hdi_human_development_index_hdig_value.snappy.parquet'
world_currencies_conversion_rates = 'world_currencies_conversion_rates.snappy.parquet'

# Query insert STG to AUX
insert_aux_dca_dataset_loan_transactions = './query_sql_aux/dca_dataset_loan_transactions.sql'
insert_aux_dca_dataset_utilization_and_claims = './query_sql_aux/dca_dataset_utilization_and_claims.sql'
insert_aux_hdi_human_development_index_hdig_value = './query_sql_aux/hdi_human_development_index_hdig_value.sql'
insert_aux_world_currencies_conversion_rates = './query_sql_aux/world_currencies_conversion_rates.sql'

# Datasets Insert Into Database

insert_prod_dca_dataset_loan_transactions = './query_sql_prd/dca_dataset_loan_transactions.sql'
insert_prod_dca_dataset_utilization_and_claims = './query_sql_prd/dca_dataset_utilization_and_claims.sql'
insert_prod_hdi_human_development_index_hdig_value = './query_sql_prd/hdi_human_development_index_hdig_value.sql'
insert_prod_world_currencies_conversion_rates = './query_sql_prd/world_currencies_conversion_rates.sql'

