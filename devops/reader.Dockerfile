FROM python:3.8-slim

WORKDIR /app

COPY app/reader/* .

RUN pip install  --no-cache-dir -r  /app/requirements.txt

EXPOSE 5000 8001

CMD ["python", "/app/reader.py"]
