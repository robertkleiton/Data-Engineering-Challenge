import logging
from sys import stdout
import pandas as pd
from datetime import date

current_date = str(date.today())

def config_log():
    logging.basicConfig(
        filename='./logs/log_{}.log' .format(current_date),
        level=logging.INFO,
        format='[%(asctime)s] {%(filename)s:%(lineno)d} %(levelname)s - %(message)s',
        filemode= 'w')
    logger = logging.getLogger()
    return logger

logger = config_log()