#!usr/bin/python
# coding: utf-8

import psycopg2.extras as pse
import pandas as pd
import os
import log
import tempfile
import pyarrow
import query_insert as qr
import connect as con
import sys

def insert_stg(file_input, query_input):
    conn = con.connect_db().postgres
    cursor = conn.cursor()
    try:
        file_path = './output_file/{}'.format(file_input)
        data_parquet = pd.read_parquet(file_path, engine='pyarrow')
        sql = pd.read_sql_query('''select max(num_exec) num_exec from aux.log_control where ind_status  <> 'success';''', conn)
        data_parquet['num_exec'] = sql['num_exec'][0]
        print('inserting file {}'.format(file_input))
        log.logger.info('inserting file {}'.format(file_input))
        query_insert = query_input.format(
                                    columns = (', '.join('"' + item + '"' for item in data_parquet.columns)),
                                    values=', '.join(['%s' for i in range(0, len(data_parquet.columns))]))
        try:
            pse.execute_batch(cursor, query_insert,
            data_parquet.loc[:].values, page_size= 10000)
            conn.commit()
            print('inserted <{}> rows'.format(data_parquet.shape[0]))
            log.logger.info('inserted <{}> rows'.format(data_parquet.shape[0]))
        except Exception as erro:
            log.logger.error(erro)
            log.logger.error(list(data_parquet.values))
            sys.exit()
    except IOError as erro:
        log.logger.error(erro)
        conn.close()
    conn.close()