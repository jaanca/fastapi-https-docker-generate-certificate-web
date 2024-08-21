from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    print("step1")
    return {"Hello": "World"}
