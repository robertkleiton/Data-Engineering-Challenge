import boto3
import os
import tarfile
import log
import sys
import variables as var
import connect as con


def s3_download_dataset(file_input, bucket, path_input):
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

    try:
        print('extracting datasets from S3...')
        log.logger.info('extracting datasets from S3...')
        s3_resource.meta.client.download_file(Filename = file_input, Bucket = bucket, Key = path_input)
    except Exception as erro:
        print('fail to download files from AWS S3...')
        log.logger.error('fail to download files from AWS S3...')
        log.logger.error(erro)
        sys.exit()
    
    tar = tarfile.open(file_input)
    tar.extractall('./raw_files')
    tar.close()
    os.remove(tar.name)