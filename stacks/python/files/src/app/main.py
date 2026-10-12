import os

from fastapi import FastAPI
from fastapi.responses import PlainTextResponse

app = FastAPI(title="app")


@app.get("/healthz", response_class=PlainTextResponse)
def healthz() -> str:
    return "ok"


@app.get("/")
def root() -> dict[str, str]:
    return {"message": "Hello, world!"}


def run() -> None:
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=int(os.environ.get("PORT", "8080")))
