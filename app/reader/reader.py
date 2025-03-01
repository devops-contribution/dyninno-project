"""This module handles reading data from MySQL and exposing metrics."""

import os
import mysql.connector
from prometheus_client import start_http_server, Summary
from flask import Flask

app = Flask(__name__)
REQUEST_TIME = Summary('request_processing_seconds', 'Time spent processing request')

# MySQL credentials from environment variables
MYSQL_USER = os.getenv('MYSQL_USER')
MYSQL_PASSWORD = os.getenv('MYSQL_PASSWORD')
MYSQL_HOST = os.getenv('MYSQL_HOST')
MYSQL_DATABASE = os.getenv('MYSQL_DATABASE')

@REQUEST_TIME.time()
def read_data():
    """ Connect to MySQL using environment variables. """
    conn = mysql.connector.connect(
        user=MYSQL_USER,
        password=MYSQL_PASSWORD,
        host=MYSQL_HOST,
        database=MYSQL_DATABASE
    )
    cursor = conn.cursor()
    cursor.execute("SELECT COUNT(*) FROM data")
    count = cursor.fetchone()[0]
    cursor.close()
    conn.close()
    print(f"Row count: {count}")
    return count

@app.route('/')
def index():
    """Returns the row count from the database and the current pod name.

    Fetches the row count using `read_data()` and includes the pod's 
    name for identification.

    Returns:
        str: A formatted string containing the row count and pod name.
    """
    count = read_data()
    return f"Row count: {count}, Pod Name: {__name__}"

if __name__ == '__main__':
    start_http_server(8001)
    app.run(host='0.0.0.0', port=5000)
