#!usr/bin/python
# coding: utf-8

import os
import log
import connect as con
import sys


def insert_aux(query_update_insert_aux):
	conn = con.connect_db().postgres
	cursor = conn.cursor()
	table_query = query_update_insert_aux[16:-4]
	try:
		print(f'Running query {table_query}')
		log.logger.info(f'Running query {table_query}')
		query = open(query_update_insert_aux, 'r').read()
		cursor.execute(query)
		conn.commit()
		cursor.close()
		print(f'Success to process {table_query}')
		log.logger.info(f'Success to process {table_query}')
	except Exception as erro:
		print(f'Fail to process {table_query}')
		log.logger.error(f'Fail to process {table_query}')
		log.logger.error(erro)
		conn.close()
		sys.exit()
	conn.close()