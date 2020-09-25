#!usr/bin/python
# coding: utf-8

import psycopg2.extras as pse
import pandas as pd
import os
import log
import query_insert as qr
import connect as con
import sys

def log_control(execution = 'initial'):
    conn = con.connect_db().postgres
    cursor = conn.cursor()
    try:
        if execution == 'initial':
            sql = pd.read_sql_query('select max(num_exec) as num_exec, ind_status from aux.log_control group by ind_status limit 1', conn)
            if sql['ind_status'][0] == 'success':
                cursor.execute('insert into aux.log_control (num_exec) select max(num_exec)+1 from aux.log_control;')
                conn.commit()
            else:
                print('Last execution in pending yet')
                log.logger.warning('Last execution in pending yet')
        elif execution == 'finish':
            cursor.execute('''update aux.log_control set ind_status = 'success', dat_updated = current_timestamp where ind_status = 'pending';''')
            conn.commit()
    except IOError as erro:
        log.logger.error(erro)
        conn.close()
    conn.close()


log_control('finish')