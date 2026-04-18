from fastapi import FastAPI
from routers import fertilizer_router

app = FastAPI()

@app.get("/")
def home():
    return {"message": "AgriSense Backend Running"}

app.include_router(fertilizer_router.router)