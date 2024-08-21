FROM python:3.11-slim

WORKDIR /app

COPY . /app

COPY cert-example.com/example.com.crt /app/example.com.crt
COPY cert-example.com/example.com.key /app/example.com.key

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 443

ENTRYPOINT ["/bin/bash", "entrypoint.sh"]
