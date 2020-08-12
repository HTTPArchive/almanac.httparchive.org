from flask import abort, request
from . import app
from .helpers import render_error_template
import logging


# Catch all route for everything not matched elsewhere
@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
def catch_all(path):
    abort(404, "Not Found")


@app.errorhandler(400)
def bad_request(e):
    logging.exception('An error occurred during a request due to bad request error: %s', request.path)
    return render_error_template(error=e, status_code=400)


@app.errorhandler(404)
def page_not_found(e):
    return render_error_template(error=e, status_code=404)


@app.errorhandler(500)
def handle_internal_server_error(e):
    logging.exception('An error occurred during a request due to internal server error: %s', request.path)
    return render_error_template(error=e, status_code=500)


@app.errorhandler(502)
def handle_bad_gateway(e):
    logging.exception('An error occurred during a request due to bad gateway: %s', request.path)
    return render_error_template(error=e, status_code=502)
