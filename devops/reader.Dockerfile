FROM python:3.8-slim

WORKDIR /app

COPY app/reader/* .

RUN pip install -r  /app/requirements.txt

CMD ["python", "/app/reader.py"]
