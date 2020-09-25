#!usr/bin/python
# coding: utf-8

import pandas as pd
import os
import connect as con
import log
import variables as var
import sys


def insert_prd(query_update_insert_prod):
    conn = con.connect_db().postgres
    cursor = conn.cursor()
    table_query = query_update_insert_prod[16:-4]
    try:
        print(f'Running query {table_query}')
        log.logger.info(f'Running query {table_query}')
        query = open(query_update_insert_prod, 'r').read()
        cursor.execute(query)
        conn.commit()
        print(f'Success to process {table_query}')
        log.logger.info(f'Success to process {table_query}')
    except Exception as erro:
        print(f'Fail to process {table_query}')
        log.logger.error(f'Fail to process {table_query}')
        log.logger.error(erro)
        conn.close()
        sys.exit()
    conn.close()
        
