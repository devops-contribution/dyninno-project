import time
import mysql.connector
from prometheus_client import start_http_server, Summary

REQUEST_TIME = Summary('request_processing_seconds', 'Time spent processing request')

@REQUEST_TIME.time()
def write_data():
    conn = mysql.connector.connect(user='user', password='password', host='mysql-0.mysql.default.svc.cluster.local', database='test')
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
