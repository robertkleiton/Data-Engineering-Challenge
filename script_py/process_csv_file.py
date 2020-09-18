import pandas as pd
import os
import pyarrow
import sys
import func_datetime as fdt
import variables as var
import connect as con
import log


def read_csv(file, bucket, prefix_output):
    try:
        new_df = pd.DataFrame()
        file_input = f'./raw_file/{file}.csv'
        parquet_file = '{}/{}.snappy.parquet'.format(var.output_file, file)
        path_output = prefix_output.format(file, fdt.datetime_str.year, fdt.datetime_str.month, fdt.datetime_str.day, file)
        print('reading and processing dataset.. {}'.format(file))
        log.logger.info('reading and processing dataset.. {}'.format(file))
        for df in pd.read_csv(file_input, sep=',', dtype=str, chunksize=1000):
            df.columns = map(str.lower, df.columns)
            new_df = new_df.append(df)
            try:
                print('saving data into file.. {} : {} rows'.format(file, new_df.shape[0]))
                log.logger.info('saving data into file.. {} : {} rows'.format(file, new_df.shape[0]))
                new_df.to_parquet(parquet_file, engine='pyarrow', compression='snappy')
                print('data saved on file')
                log.logger.info('data saved on file')
            except Exception as erro:
                print('fail to save data on file')
                log.logger.error('fail to save data on file')
                log.logger.error(erro)
                sys.exit()
            
        # try:
        #     try:
        #         print('trying connect to AWS S3...')
        #         log.logger.info('trying connect to AWS S3...')
        #         s3_resource = con.connect_s3()
        #         print('connected to AWS S3...')
        #         log.logger.info('connected to AWS S3...')
        #     except Exception as erro:
        #         print('failed try to connect to AWS S3')
        #         log.logger.error('failed try to connect to AWS S3')
        #         log.logger.error(erro)
        #         # sys.exit()
        #     print('saving dataset to AWS S3...')
        #     log.logger.info('saving dataset to AWS S3...')
        #     s3_resource.client.upload_file(Filename = parquet_file, Bucket = bucket, Key = path_output)
        # except Exception as erro:
        #     print('fail to save file to AWS S3')
        #     log.logger.error('fail to save file to AWS S3')
        #     log.logger.error(erro)
        #     # sys.exit()
    except Exception as erro:
        log.logger.error(erro)
        print('read and proccess dataset success')
        log.logger.info('read and proccess dataset success')
        # sys.exit()