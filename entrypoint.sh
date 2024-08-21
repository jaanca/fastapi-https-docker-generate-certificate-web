#!/bin/bash

# Web Server
uvicorn main:app --host 0.0.0.0 --port 443 --ssl-keyfile cert-example.com/example.com.key --ssl-certfile cert-example.com/example.com.crt