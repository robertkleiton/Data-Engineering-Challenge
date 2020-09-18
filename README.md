# Data Engineering Challenge

### Objetivo
	Este pequeno projeto tem o objetivo de executar um fluxo de ETL para processamento de dados utilizando o ambiente AWS e Python 3.

### Recursos Tecnológicos
		1. Python 3.X
			- Bibliotecas necessárias para instalar
				- Pandas
				- Boto3
				- Pyarrow
				- Psycopg2
				- Virtualenv
		2. AWS
			- Serviços utilizados:
				- RDS (PostgreSql)
				- EC2 (Linux)
				- S3

### Cenário
	Fonte original dos dados: data.usaid.gov
	Para este processo assumi-se o seguinte cenário.
		Proprietários dos dados de origem disponibilizam os arquivos diariamente para processamento em um bucket do S3.
			Dado que:
			- source_bucket = nome do bucket definido pelo dono da conta.
			- raw_file = pasta criada no bucket.
			- datasets.tar.gz = arquivos origens para processamento, inseridos pelo proprietário.
				<source_bucket>/raw_file/datasets.tar.gz


Sobre os arquivos:

dca_dataset_loan_transactions.jsonl
	#### This dataset is the complete list of all private loans made under USAID's DCA since it was established in 1999. To protect the personal information of borrowers and bank partners, all strategic and personal identifiable information was removed. For explanations and limitations of the dataset, download the attachment in the metadata.
	*[https://www.usaid.gov/developer/dca-loan-transactions](https://www.usaid.gov/developer/dca-loan-transactions)*
 
dca_dataset_utilization_and_claims.jsonl
	#### This dataset is the complete list of all USAID partial credit guarantees since DCA was established in 1999. This USAID dataset shows the partial credit guarantees that USAID has issued since the development credit authority program was founded in 1999. The spreadsheet reflects the full facility size of each guarantee, how much was lent under the guarantee, the status of the guarantee (i.e., active or expired) , how much in claims the bank submitted due to losses it incurred for loans placed under the guarantee, and how many loans were placed under coverage of the guarantee. The data also shows the sector and country for each guarantee.
	*[https://www.usaid.gov/developer/dca-utilizations-and-claims](https://www.usaid.gov/developer/dca-utilizations-and-claims)*
 
hdi_human_development_index_hdig_value.jsonl
	#### HDI from 1980 to 2013.
	*[https://data.humdata.org/dataset/human-development-index-hdi](https://data.humdata.org/dataset/human-development-index-hdi)*

world_currencies_conversion_rates.csv
	#### Dollar based conversion rates for world currencies from 1950 to 2017.
	*[https://data.oecd.org/conversion/exchange-rates.htm](https://data.oecd.org/conversion/exchange-rates.htm)*
	
From the datasets above, the first two represent loans and guarantees USAID has issued since 1999, the third contains HDI indices and the fourth conversion rates across the globe. You must ingest this data into a PostgreSQL "data warehouse" (a Redshift simulation).

### Arquitetura ETL.

![](Fluxograma_ETL.jpg)


................
### Preparação do Ambiente de Simulação.

### Todas as configurações descritas abaixo são necessárias para pleno funcionamento do ETL.
	Ambiente Amazon Web Services (AWS)
		1.	Simple Storage Service (S3)
			1.	Criar/utilizar um bucket.
			2.	Criar o diretório no bucket.
				- <nome_bucket>/files_raw.
			3.	Criar um “access key e secret access key “, com policie de read e write para o bucket que será utilizado.
		2.	Relational Database Service (RDS).
			1.	Criar/utilizar Banco de dados RDS PostgreSql.
	
		
		4.1.	Acessar o banco de dados criado e executar o script “create_tables.sql” em anexo
		5.	Descompactar arquivo “dev.zip” em anexo.
		5.1.	Alteraçoes em arquivos do ETL
		5.1.1.	“connect.py”: alterar as 7 ao 10, com as configurações do AWS RDS criada.
		5.1.2.	“variables.py”: alterar as linhas 4 ao 6, as com o nome do bucket criado e as chaves de acesso criadas.
		6.	Compactar novamente em zip todos os arquivos do etl com o nome de “etl_creditas.zip”

#### Obs:

Ao processar os arquivos imposto no teste, houve um erro que em um valor, o mesmo se referia à um valor de formato "date" que não poderia ser
processado. 

Minha ação quando este cenário ocorre, seria informar à pessoa que disponibiliza os dados para o processamento do meu ETL para que o mesmo,
verificasse este tipo de erro. Assumindo que não poderia "construir dados", sem saber a que se referia.

Com isso coloco em anexo um datasets.tar.gz, simulando que o mesmo resolveu este impasse. Para dar continuidade ao teste, o mesmo deve ser colocado no Bucket criado e no diretório "files_raw" antes de executar o ETL
O valor com erro ao qual me refiro é encontrado no arquivo dca_dataset_utilization_and_claims.jsonl

"Guarantee End Date": "2027/09" (está faltando o "dia")


### Execução do ETL.

O ETL é executado em uma instância AWS EC2 Linux (pode ser a t2.micro).
Todos os scripts são em Python 2.7 e alguns .sql.

### Deploy.

#1.	Criar um diretório /home/ec2-user/etl/etl_creditas/
1.	Clonar pacote https://github.com/robertkleiton/Data-Engineering-Challenge.git

2.	Copiar o arquivo zip etl_creditas.zip em anexo para o servidor EC2, no diretório /home/ec2-user/etl/etl_creditas/.
3.	Extrair o arquivo.
4.	Executar script abaixo para dar permissão de execução ao shell script.
4.1.	chmod +x /home/ec2-user/etl/etl_creditas/cr_etl_controller.sh
5.	Para execução diária agendar no crontab do linux.
5.1.	0 7 * * * /home/ec2-user/etl/etl_creditas/cr_etl_controller.sh
Para execução manual do ETL, executar o comando no terminal Linux
sh /home/ec2-user/etl/etl_creditas/cr_etl_controller.sh




