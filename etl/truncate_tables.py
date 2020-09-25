import os
import connect as con
import variables as var
import log

def truncate():
    tables_truncate_list = [var.dca_dataset_loan_transactions[:-15], var.dca_dataset_utilization_and_claims[:-15],
                            var.hdi_human_development_index_hdig_value[:-15], var.world_currencies_conversion_rates[:-15]]
    try:                        
        log.logger.info('begin truncating tables...')
        print('begin truncating tables...')
        conn = con.connect_db().postgres
        cursor = conn.cursor()
        for table in tables_truncate_list:
            cursor.execute('truncate table stage.{}'.format(table))
            log.logger.info('truncate table stage.{}'.format(table))
            print('truncate table stage.{}'.format(table))
        conn.commit()
        conn.close()
        print('tables truncated...')
        log.logger.info('tables truncated...')
    except Exception as erro:
        print('fail to truncate table...')
        log.logger.error('fail to truncate table...')
        log.logger.error(erro)
        conn.close()
