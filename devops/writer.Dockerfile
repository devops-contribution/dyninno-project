FROM python:3.8-slim

WORKDIR /app

COPY ../app/writer/* .

RUN pip install -r ../app/writer/requirements.txt

CMD ["python", "writer.py"]
