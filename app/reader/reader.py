import time
import mysql.connector
from prometheus_client import start_http_server, Summary
from flask import Flask

app = Flask(__name__)
REQUEST_TIME = Summary('request_processing_seconds', 'Time spent processing request')

@REQUEST_TIME.time()
def read_data():
    conn = mysql.connector.connect(user='root', password='rootpassword', host='mysql-slave', database='test')
    cursor = conn.cursor()
    cursor.execute("SELECT COUNT(*) FROM data")
    count = cursor.fetchone()[0]
    cursor.close()
    conn.close()
    print(f"Row count: {count}")
    return count

@app.route('/')
def index():
    count = read_data()
    return f"Row count: {count}, Pod Name: {__name__}"

if __name__ == '__main__':
    start_http_server(8001)
    app.run(host='0.0.0.0', port=5000)
