#!/usr/bin/env python

import pymysql
import pandas as pd


# MySQL connection settings
HOST = ''
USER = ''
PASS = ''
TABLE = 'percentDry_05d_1981_2010_stn'

# Connect to MySQL
connection = pymysql.connect(
    host=HOST,
    user=USER,
    password=PASS,
    db='cpc_reference',
    cursorclass=pymysql.cursors.DictCursor
)

# Get AK stations
try:
    with connection.cursor() as cursor:
        sql = f"SELECT id FROM stn_with_ak WHERE state='AK'"
        # Execute SQL statement
        cursor.execute(sql)
        # Retrieve results
        ak_ids = cursor.fetchall()
finally:
    connection.close()

ak_ids = [x['id'] for x in ak_ids]

# Connect to MySQL
connection = pymysql.connect(
    host=HOST,
    user=USER,
    password=PASS,
    db='cpc_climatologies',
    cursorclass=pymysql.cursors.DictCursor
)

for id in ak_ids:
    for date in pd.period_range('20000101', '20001231').strftime('%Y-%m-%d'):
        sql = f"INSERT INTO {TABLE} VALUES({id}, '{date}', 0)"
        print(sql)
        try:
            with connection.cursor() as cursor:
                # Execute SQL statement
                cursor.execute(sql)
        except pymysql.err.IntegrityError:
            pass
        connection.commit()
connection.close()
