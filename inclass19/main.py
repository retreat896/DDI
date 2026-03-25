import logging
import subprocess
import os

fmt = "%(levelname)s\t%(funcName)s():%(lineno)i\t%(message)s"
logging.basicConfig(level=logging.DEBUG, format=fmt)
logger = logging.getLogger(__name__)

pw = os.getenv('PW')

conn = "postgresql://adamskri:{pw}@marigold.csse.uwplatt.edu:5432/adamskri".format(pw=pw)

uploaded = subprocess.check_output([
    '.\\csvsql.exe',
    '--verbose', 
    '--db',
    conn, 
    '--insert', 
    '--create-if-not-exists',
    '--db-schema',
    'test_schema',
    'earthquakes.csv' 
    ], text=True)

logger.info('Check pgAdmin for the earthquakes table!')