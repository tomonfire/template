from fastapi.testclient import TestClient

from app.main import app

client = TestClient(app)


def test_healthz() -> None:
    res = client.get("/healthz")
    assert res.status_code == 200
    assert res.text == "ok"


def test_root() -> None:
    assert client.get("/").json() == {"message": "Hello, world!"}
