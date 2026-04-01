import pymongo
import os
import logging
from pprint import pprint
import inspect

fmt = "%(levelname)s\t%(funcName)s():%(lineno)i\t%(message)s"
logging.basicConfig(level=logging.INFO, format=fmt)
logger = logging.getLogger(__name__)

pw = os.getenv('PW')
try:
    uri = ("mongodb+srv://retreat87:{pw}@ddi.1pvh97s.mongodb.net/").format(pw=pw)
    
    # Create a new client and connect to the server
    client = pymongo.MongoClient(uri)

    movie_db = client["sample_mflix"]
    collection = movie_db["movies"]

    query = {"title": "Jurassic Park"}

    logger.info('querying db')
    movie = collection.find_one(query)

    logger.info(movie.keys())

    for key in movie.keys():
        logger.info(type(key))

    # Uncomment this to explore more deeply:
    # logger.info(pprint(inspect.getmembers(movie)))

except Exception as e:
    print(e)