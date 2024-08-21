# Description

Run an api in FastAPI through a web browser with a self-signed https certificate.

Tested by running the uvicorn console, debugging with vscode and activating the service in docker linux.

# Generate self signed certificate

The following commands were tested on a Linux server

```console
openssl genrsa -out example.com.key 2048
openssl req -new -key example.com.key -out example.com.csr -subj "/CN=*.example.com"

# content test
openssl req -in example.com.csr -noout -text


openssl x509 -req -days 3650 -in example.com.csr -signkey example.com.key -out example.com.crt

# To import into web browsers
openssl pkcs12 -export -out example.com.pfx -inkey example.com.key -in example.com.crt
    Enter Export Password: 1234
```

# Start server and test in web browser

## Add to local hosts the route to : C:\Windows\System32\drivers\etc\hosts
127.0.0.1 example.com www.example.com

## Install certificate in browser, example: Firefox
Tools -> Settings -> Privacy and Security -> Security: View Certificates
Import: Select the pfx file: example.com.pfx

## Run web server
```console
uvicorn main:app --host 0.0.0.0 --port 443 --ssl-keyfile cert-example.com/example.com.key --ssl-certfile cert-example.com/example.com.crt
```

## Url for test
- https://localhost/ (The certificate is not activated correctly, you need the domain)
- https://www.example.com/ (The browser recognizes the domain and certificate)

# Visual Studio Code (Debug)
.vscode\launch.json
```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python Debugger: HTTPS",
            "type": "debugpy",
            "request": "launch",
            "module": "uvicorn",
            "args": [
                "main:app",
                "--host","0.0.0.0",
                "--port","443",
                "--ssl-keyfile","cert-example.com/example.com.key",
                "--ssl-certfile","cert-example.com/example.com.crt",
                "--reload"
            ],
            "jinja": true
        }
    ]
}

```

# Docker

```console
docker build -t fastapi-https .
docker run -d -p 443:443 fastapi-https
```

