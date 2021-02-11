#!usr/bin/python
# -*- encoding: utf-8-*-

import pandas as pd
import os
import pyarrow
import json
import sys
import func_datetime as fdt
import variables as var
import connect as con
import log


def read_jsonl(file, bucket, prefix_output):
    try:
        file_input = f'./raw_files/{file}.jsonl'
        parquet_file_input = '{}/{}.snappy.parquet'.format(var.output_file, file)
        parquet_file_output = '{}.snappy.parquet'.format(file)
        file_error_input = '{}/fail/{}.txt'.format(var.output_file, file)
        file_error_output = 'fail/{}.txt'.format(file)
        path_output = prefix_output.format(file, fdt.datetime_str.year, fdt.datetime_str.month, fdt.datetime_str.day, parquet_file_output)
        path_output_error = prefix_output.format(file, fdt.datetime_str.year, fdt.datetime_str.month, fdt.datetime_str.day, file_error_output)
        print('reading and processing dataset.. {}'.format(file))
        log.logger.info('reading and processing dataset.. {}'.format(file))
        crude_file = open(file_input).read()
        result = {
                "success": [],
                "error": []
                }
        for i in crude_file.splitlines():
            try:
                result['success'].append(json.loads(i))
            except:
                log.logger.warning('Error in json loads {}'.format(i))
                result['error'].append(i)
        df_success = pd.DataFrame(result['success'])
        df_success.columns = map(str.lower, df_success.columns)
        df_error = pd.DataFrame(result['error'])
        try:
            print('saving data into file.. {} : {} rows'.format(file, df_success.shape[0]))
            log.logger.info('saving data into file.. {} : {} rows'.format(file, df_success.shape[0]))
            df_success.to_parquet(parquet_file_input, engine='pyarrow', compression='snappy')
        except Exception as erro:
            print('fail to save data on file')
            log.logger.error('fail to save data on file')
            log.logger.error(erro)
            sys.exit()
        try:
            df_error.to_csv(file_error_input, sep=';', index=False, header=False, doublequote=False, escapechar= '"')
        except:
            pass
        try:
            try:
                print('trying connect to AWS S3...')
                log.logger.info('trying connect to AWS S3...')
                s3_resource = con.connect_s3()
                print('connected to AWS S3...')
                log.logger.info('connected to AWS S3...')
            except Exception as erro:
                print('failed try to connect to AWS S3')
                log.logger.error('failed try to connect to AWS S3')
                log.logger.error(erro)
                sys.exit()
            print('saving dataset to AWS S3...')
            log.logger.info('saving dataset to AWS S3...')
            s3_resource.meta.client.upload_file(Filename = parquet_file_input, Bucket = bucket, Key = path_output)
            try:
                s3_resource.meta.client.upload_file(Filename = file_error_input, Bucket = bucket, Key = path_output_error)
            except:
                pass
        except Exception as erro:
            print('fail to save file to AWS S3')
            log.logger.error('fail to save file to AWS S3')
            log.logger.error(erro)
            sys.exit()
        try:
            print('Cleaning files from path out')
            log.logger.info('Cleaning files from path out')
            os.remove(parquet_file_input)
            os.remove(file_error_input)
        except Exception as erro:
            print(erro) 
            log.logger.error(erro)
    except Exception as erro:
        log.logger.error(erro)
        print('read and proccess dataset success')
        log.logger.info('read and proccess dataset success')
        sys.exit()
