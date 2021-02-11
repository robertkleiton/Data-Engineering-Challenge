#!usr/bin/python
# -*- encoding: utf-8-*-

import os
import sys
import variables as var
import log
import process_csv_file as r_csv
import process_json_file as r_json


file_container = os.listdir('./raw_files')


def check_files(list_from, list_in):
    try:
        log.logger.info('Beging to files verification to processing...')
        set_1 = set(list_from)
        set_2 = set(list_in)
        to_process = list(set_1.intersection(set_2))
        miss_file = list(set_1.difference(set_2))
        improper_file = list(set_2.difference(set_1))
        print('files to process {}'.format(to_process))
        log.logger.info('files to process {}'.format(to_process))
        print('miss files {}'.format(miss_file))
        log.logger.info('miss files {}'.format(miss_file))
        print('improper files {}'.format(improper_file))
        log.logger.info('improper files {}'.format(improper_file))
        return to_process
    except Exception as erro:
        print(erro)
        log.logger.error(erro)
        sys.exit()                



def read_dataset(bucket, prefix, files_dist = file_container):
    list_files = check_files(var.raw_files_to_process, files_dist)
    for file_ in list_files:
        if file_.endswith('.jsonl'):
            print('file to proccess jsonl')
            log.logger.info('file to proccess jsonl')
            r_json.read_jsonl(file_[:-6], bucket, prefix)
        elif file_.endswith('.csv'):
            print('file to proccess csv')
            log.logger.info('file to proccess csv')
            r_csv.read_csv(file_[:-4], bucket, prefix)

