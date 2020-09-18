#!usr/bin/python
# coding: utf-8
import psycopg2
import boto3
import sys
import os
import variables as var
import sqlalchemy as alc


hst = os.environ.get('VAR_HOST')
db  = os.environ.get('VAR_DATABASE')
usr = os.environ.get('VAR_USER')
psw = os.environ.get('VAR_PASSWORD')

class connect_database():
	def __init__(self):
		self.postgres = psycopg2.connect("dbname='%s' user='%s' host='%s' password='%s'" % (db, usr, hst, psw))
		self.oracle = None
		self.ms_sql = None

def connect_db():
    return connect_database()

def connect_s3():
    # -- alterar para session
	# s3_client = boto3.client('s3', aws_access_key_id = var.access_key, aws_secret_access_key = var.secret_access_key)
	session = boto3.Session(aws_access_key_id = var.access_key, aws_secret_access_key = var.secret_access_key)
	s3_client = session.resource('S3')
	return s3_client
