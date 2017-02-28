#!/usr/bin/env python

# --------------------------------------------------------------------------------------------------
# Imports

# Built-in
from os.path import realpath, dirname, expandvars
from configparser import ConfigParser
import re

# Third-party
import pymysql
import jinja2
import pandas as pd
import numpy as np
from cpc.geogrids import Geogrid
from cpc.geogrids.manipulation import interpolate


# --------------------------------------------------------------------------------------------------
# Setup
#
# Get app path
APP_PATH = dirname(dirname(realpath(__file__)))
# Import config
config = ConfigParser()
config.read('{}/input/verif_data.conf'.format(APP_PATH))
# Connect to MySQL
db = pymysql.connect(config['mysql']['host'],
                     config['mysql']['user'],
                     config['mysql']['password'],
                     config['mysql']['db_clim'])
# Prepare a MySQL cursor
cursor = db.cursor()
# Create a Geogrid
input_geogrid = Geogrid(config['clim']['input-geogrid'])
output_geogrid = Geogrid(config['clim']['output-geogrid'])

# --------------------------------------------------------------------------------------------------
# Loop over windows
#
for window in re.split(', ?', config['clim']['windows']):

    # Get the MySQL table name
    table = 'percentDry_{}_{}_grid2deg'.format(window, config['clim']['dates'])

    # Truncate the MySQL table
    cursor.execute('TRUNCATE {}'.format(table))

    # ----------------------------------------------------------------------------------------------
    # Loop over mmdd
    #
    for mmdd in pd.date_range('20000101', '20001231').strftime('%m%d'):
        mm = mmdd[0:2]
        dd = mmdd[2:4]

        # ------------------------------------------------------------------------------------------
        # Load climo data
        #
        # Read climo data from file
        file_template = config['clim']['percent-dry-file-template']
        kwargs = {
            'window': window,
            'mmdd': mmdd
        }
        clim_file = jinja2.Template(expandvars(file_template)).render(**kwargs)
        print('\rImporting {}...'.format(clim_file), end='')
        clim_data = np.fromfile(clim_file, 'float32').reshape((input_geogrid.num_y,
                                                               input_geogrid.num_x))
        # Interpolate data
        clim_data = interpolate(clim_data, input_geogrid, output_geogrid)

        # ------------------------------------------------------------------------------------------
        # Loop over grid point
        #
        for y in range(1, output_geogrid.num_y + 1):
            for x in range(1, output_geogrid.num_x + 1):
                xx = '{:02.0f}'.format(x)
                yy = '{:02.0f}'.format(y)

                # --------------------------------------------------------------------------------------
                # Write climo data to MySQL
                #
                # Determine percentDry value (use NULL instead of np.nan, otherwise use the value)
                value = 'NULL' if np.isnan(clim_data[y - 1, x - 1]) else clim_data[y - 1, x - 1]
                # Create an SQL statement
                sql = 'INSERT INTO {} VALUES(\'{}{}\', \'2000-{}-{}\', {})'.format(table, xx, yy, mm,
                                                                                   dd, value)
                # Execute the SQL statement
                cursor.execute(sql)
