# downloads.py
import csv
import logging
import os

from psycopg import connect, DatabaseError
from psycopg.rows import dict_row

# Don't forget about these guys!
# Try them out!
# import inspect
# import pprint

fmt = "%(levelname)s\t%(funcName)s():%(lineno)i\t%(message)s"
logging.basicConfig(level=logging.DEBUG, format=fmt)
logger = logging.getLogger(__name__)


def connect_to_db(db_name):
    pw = os.getenv(r'PW')
    usr = os.getenv(r'DB_USR')
    conn = connect(
        host="marigold.csse.uwplatt.edu",
        dbname=db_name,
        user=usr,
        port='5432',
        password=pw,
    )

    return conn


try:
    conn = connect_to_db('adamskri')

    cursor = conn.cursor(row_factory=dict_row)
    cursor.execute("SET search_path TO assignment_1")
    cursor.execute("SELECT * FROM pets")
    pet_data = cursor.fetchall()

    cols = pet_data[0].keys()

    with open('./pet_data.csv', 'w', newline='') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=cols)
        writer.writeheader()
        writer.writerows(pet_data)
        
except DatabaseError as e:
    logger.error(e)       
except Exception as e:
    logger.error(e)

# end script