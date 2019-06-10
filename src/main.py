from flask import Flask, render_template
from flask_talisman import Talisman
from csp import csp

app = Flask(__name__)
Talisman(app,
         content_security_policy=csp,
         content_security_policy_nonce_in=['script-src'])


@app.route('/')
def index():
    return render_template('en-US/index.html')


@app.errorhandler(500)
def server_error(e):
    logging.exception('An error occurred during a request.')
    return """
    An internal error occurred: <pre>{}</pre>
    See logs for full stacktrace.
    """.format(e), 500


if __name__ == '__main__':
    # This is used when running locally. Gunicorn is used to run the
    # application on Google App Engine. See entrypoint in app.yaml.
    app.run(host='127.0.0.1', port=8080, debug=True)
