FROM python:3.8-slim

WORKDIR /app

COPY ../app/reader/* .

RUN pip install -r  ../app/reader/requirements.txt

CMD ["python", "reader.py"]
