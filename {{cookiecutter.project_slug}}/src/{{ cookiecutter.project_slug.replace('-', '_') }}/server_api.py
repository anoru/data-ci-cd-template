import traceback
from logging import INFO
from typing import Any, Dict, Literal, Tuple

from flask import Flask, json, request
from flask.logging import default_handler
from werkzeug import Response
from werkzeug.exceptions import HTTPException


flask_app = Flask(__name__)


# Configure logging
flask_app.logger.setLevel(INFO)


@flask_app.route("/ping", methods=["GET"])
def ping() -> Tuple[Literal["OK"], int, Dict[str, str]]:
    return ("OK", 200, {"ContentType": "text/plain"})


@flask_app.route("/invocations", methods=["POST"])
def invocations() -> Tuple[Dict[str, Any], int, Dict[str, str]]:
    # Check Mimetype
    # https://flask.palletsprojects.com/en/2.0.x/api/#flask.Request.is_json
    if not request.is_json:
        return (
            {
                "title": "Unsupported Media Type",
                "detail": (
                    "Mimetype doesn't indicate JSON data. Use either application/json"
                    " or application/*+json."
                ),
            },
            415,
            {"ContentType": "application/problem+json"},
        )

    # Parse the body as JSON. This will throw a 400 if the JSON is malformed.
    # https://flask.palletsprojects.com/en/2.0.x/api/#flask.Request.json
    body = request.json

    # Perform prediction
    try:
        response = "Horraaaay, You made it"
        return (response, 200, {"ContentType": "application/json"})

    except Exception:
        flask_app.logger.error(
            "Internal Server Error",
            extra={
                "http.request.body.content": request.json,
                "error.stack_trace": traceback.format_exc(),
            },
        )
        return (
            {"title": "Internal Server Error"},
            500,
            {"ContentType": "application/problem+json"},
        )


@flask_app.errorhandler(HTTPException)
def handle_exception(error: HTTPException) -> Response:
    """
    Return JSON instead of HTML for HTTP errors.
    """
    # Start with the initial error response
    response = error.get_response()
    # Replace the body with JSON
    response.data = json.dumps(
        {
            "title": error.name,
            "detail": error.description,
        }
    )
    # Update the content type
    response.content_type = "application/problem+json"
    return response
