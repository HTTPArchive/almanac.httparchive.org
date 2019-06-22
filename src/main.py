from flask import Flask, render_template, jsonify
from flask_talisman import Talisman
from csp import csp
from validate import validate
import logging

app = Flask(__name__)
Talisman(app,
         content_security_policy=csp,
         content_security_policy_nonce_in=['script-src'])
logging.basicConfig(level=logging.DEBUG)


@app.route('/')
@app.route('/<lang>/')
@validate
def index(lang):
    return render_template('%s/splash.html' % lang)


@app.route('/<year>/outline')
@app.route('/<lang>/<year>/outline')
@validate
def outline(year, lang):
    return render_template('%s/%s/outline.html' % (lang, year))


@app.route('/<year>/contributors')
@app.route('/<lang>/<year>/contributors')
@validate
def contributors(year, lang):
    # TODO: Get contributor data and pass into the template.
    return render_template('%s/%s/contributors.html' % (lang, year), contributors={})


@app.route('/<year>/methodology')
@app.route('/<lang>/<year>/methodology')
@validate
def methodology(year, lang):
    return render_template('%s/%s/methodology.html' % (lang, year))


@app.route('/<year>/<chapter>/')
@app.route('/<lang>/<year>/<chapter>')
@validate
def chapter(year, chapter, lang):
    # TODO: Validate the chapter.
    # TODO: Get chapter data and pass into the template.

    return render_template('%s/%s/chapter.html' % (lang, year), chapter=chapter)


@app.route('/<year>/contributors')
@app.route('/<lang>/<year>/contributors')
reports = report_util.get_reports()

  # TODO: Add any additional information about contributors to include
  if get_format(request) == 'json':
    return jsonify(name=contributors.name, teams=team.name)

  return render_template('contributors.html', name=contributors.name, teams=contributors.teams)


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
