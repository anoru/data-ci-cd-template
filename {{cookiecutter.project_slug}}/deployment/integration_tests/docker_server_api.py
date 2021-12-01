# Name shouldn't contain 'test' because we want pytest to run it
# only on integration-tests Github actions

import os
from pathlib import Path
from typing import Dict

import requests
from tenacity import retry, stop_after_delay


# remove import from {{ cookiecutter.project_slug.replace('-', '_') }} as we want it to be black box
# and don't rely on library
SOURCE = "source"
DESTINATION = "destination"
PROJECT_URL = os.environ.get(
    "PROJECT_URL", "http://localhost:8080"
)
WAIT_IN_SECONDS = 10


@retry(stop=stop_after_delay(WAIT_IN_SECONDS))
def test_ping_health_check_route() -> None:
    # GIVEN
    # No prerequisite
    # WHEN
    response = requests.get(f"{PROJECT_URL}/ping")
    # THEN
    assert response.status_code == 200


@retry(stop=stop_after_delay(WAIT_IN_SECONDS))
def test_post_none_body() -> None:
    # GIVEN
    json_body = None
    # WHEN
    response = requests.post(f"{PROJECT_URL}/invocations", json=json_body)
    # THEN
    assert response.status_code == 415


@retry(stop=stop_after_delay(WAIT_IN_SECONDS))
def test_post_body() -> None:
    # GIVEN
    json_body: Dict[str, str] = {"body": "test"}
    # WHEN
    response = requests.post(f"{PROJECT_URL}/invocations", json=json_body)
    # THEN
    assert response.status_code == 200 
