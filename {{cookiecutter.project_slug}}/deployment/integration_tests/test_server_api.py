from pathlib import Path
from typing import Dict, Generator

import pytest
from flask import Flask, Response
from flask.testing import FlaskClient

from {{cookiecutter.project_slug.replace('-', '_')}}.server_api import flask_app

@pytest.fixture
def app() -> Generator[Flask, None, None]:
    yield flask_app


@pytest.fixture
def client(app: Flask) -> "FlaskClient[Response]":
    return app.test_client()


def test_ping_health_check_route(client: Flask) -> None:
    # GIVEN
    # No prerequisite
    # WHEN
    response = client.get("/ping")
    # THEN
    assert response.status_code == 200


def test_post_none_body(client: Flask) -> None:
    # GIVEN
    json_body = None
    # WHEN
    response = client.post("/invocations", json=json_body)
    # THEN
    assert response.status_code == 415

def test_post_body(client: Flask) -> None:
    # GIVEN
    json_body = {"body": "test"}
    # WHEN
    response = client.post("/invocations", json=json_body)
    # THEN
    assert response.status_code == 200