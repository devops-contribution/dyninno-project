FROM python:3.8-slim

WORKDIR /app

COPY app/writer/* .

RUN pip install --no-cache-dir  -r /app/requirements.txt

EXPOSE 8000

CMD ["python", "/app/writer.py"]
