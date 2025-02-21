import time
import mysql.connector
import os
from prometheus_client import start_http_server, Summary

REQUEST_TIME = Summary('request_processing_seconds', 'Time spent processing request')

# MySQL credentials from environment variables
MYSQL_USER = os.getenv('MYSQL_USER')
MYSQL_PASSWORD = os.getenv('MYSQL_PASSWORD')
MYSQL_HOST = os.getenv('MYSQL_HOST')
MYSQL_DATABASE = os.getenv('MYSQL_DATABASE')

@REQUEST_TIME.time()
def write_data():
    # Connect to MySQL using environment variables
    conn = mysql.connector.connect(
        user=MYSQL_USER, 
        password=MYSQL_PASSWORD, 
        host=MYSQL_HOST, 
        database=MYSQL_DATABASE
    )
    cursor = conn.cursor()
    cursor.execute("INSERT INTO data (value) VALUES (%s)", (time.time(),))
    conn.commit()
    cursor.close()
    conn.close()
    print("Data written")

if __name__ == '__main__':
    start_http_server(8000)
    while True:
        write_data()
        time.sleep(1)
