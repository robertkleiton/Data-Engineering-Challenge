# Data Engineering Challenge

### Purpose Porject
This project has goal to run ETL flow to process data using AWS and Python 3

### Resources
1. Python 3.X
	- Library needed to install
		- Pandas
		- Boto3
		- Pyarrow
		- Psycopg2
		- Virtualenv
2. AWS
	- Cloud services used:
		- RDS (PostgreSql)
		- EC2 (Linux)
		- S3

### Scenery
Original source of data: data.usaid.gov

For this project, the scenario follows
	The source data's owner put files on bucket in the AWS S3.
		- source_bucket = The S3 bucket's man defined.
		- raw_file = Path created.
		- datasets.tar.gz = The raw file's.
			<source_bucket>/raw_file/datasets.tar.gz



About the files

#### dca_dataset_loan_transactions.jsonl
This dataset is the complete list of all private loans made under USAID's DCA since it was established in 1999. To protect the personal information of borrowers and bank partners, all strategic and personal identifiable information was removed. For explanations and limitations of the dataset, download the attachment in the metadata.

#### url: *[https://www.usaid.gov/developer/dca-loan-transactions](https://www.usaid.gov/developer/dca-loan-transactions)*
 
#### dca_dataset_utilization_and_claims.jsonl
This dataset is the complete list of all USAID partial credit guarantees since DCA was established in 1999. This USAID dataset shows the partial credit guarantees that USAID has issued since the development credit authority program was founded in 1999. The spreadsheet reflects the full facility size of each guarantee, how much was lent under the guarantee, the status of the guarantee (i.e., active or expired) , how much in claims the bank submitted due to losses it incurred for loans placed under the guarantee, and how many loans were placed under coverage of the guarantee. The data also shows the sector and country for each guarantee.

#### url: *[https://www.usaid.gov/developer/dca-utilizations-and-claims](https://www.usaid.gov/developer/dca-utilizations-and-claims)*
 
#### hdi_human_development_index_hdig_value.jsonl
HDI from 1980 to 2013.

#### url: *[https://data.humdata.org/dataset/human-development-index-hdi](https://data.humdata.org/dataset/human-development-index-hdi)*

#### world_currencies_conversion_rates.csv
Dollar based conversion rates for world currencies from 1950 to 2017.

#### url: *[https://data.oecd.org/conversion/exchange-rates.htm](https://data.oecd.org/conversion/exchange-rates.htm)*
	

### ETL's Architecture.

![](./images/etl_flow.jpg)



### Enviroment to Simulation.

### The all configurations needed ETL to works well

Amazon Web Services (AWS) enviroment.
1. Simple Storage Service (S3)
	- Create/use a bucket.
2. Create the path on the bucket.
	- <bucket_name>/raw_files.
3. Create one "access key and secret access key", with policies to read and to write.

4. Relational Database Service (RDS).
	- Create/use database RDS "PostgreSql".
