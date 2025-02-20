FROM python:3.8-slim

WORKDIR /app

COPY app/writer/* .

RUN pip install -r /app/requirements.txt

CMD ["python", "/app/writer.py"]
