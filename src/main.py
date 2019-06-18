from flask import Flask, render_template, abort
from flask_talisman import Talisman
from csp import csp
import logging

app = Flask(__name__)
Talisman(app,
         content_security_policy=csp,
         content_security_policy_nonce_in=['script-src'])

DEFAULT_YEAR = '2019'
DEFAULT_LANG = 'en'
SUPPORTED_LANGS = ('en', 'ja')
SUPPORTED_YEARS = {
    '2019': ('en', 'ja')
}


@app.route('/')
@app.route('/<lang>/')
def index(lang=DEFAULT_LANG):
    validate(lang)

    return render_template('%s/splash.html' % lang)


@app.route('/<year>/outline')
@app.route('/<lang>/<year>/outline')
def outline(year, lang=DEFAULT_LANG):
    validate(lang, year)

    return render_template('%s/%s/outline.html' % (lang, year))


@app.route('/<year>/contributors')
@app.route('/<lang>/<year>/contributors')
def contributors(year, lang=DEFAULT_LANG):
    validate(lang, year)

    # TODO: Get contributor data and pass into the template.
    return render_template('%s/%s/contributors.html' % (lang, year), contributors={})


@app.route('/<year>/methodology')
@app.route('/<lang>/<year>/methodology')
def methodology(year, lang=DEFAULT_LANG):
    validate(lang, year)

    return render_template('%s/%s/methodology.html' % (lang, year))


@app.route('/<year>/<chapter>/')
@app.route('/<lang>/<year>/<chapter>')
def chapter(year, chapter, lang=DEFAULT_LANG):
    validate(lang, year)

    # TODO: Validate the chapter.
    # TODO: Get chapter data and pass into the template.
    return render_template('%s/%s/chapter.html' % (lang, year), chapter=chapter)


## This could become a decorator, and be encapsulated. Would that make this a
## cleaner solution? I looked at implementing one, but it seemed complicated.
def validate(lang, year=DEFAULT_YEAR):
    validate_year(year)
    validate_lang(lang, year)


def validate_year(year):
    if year not in SUPPORTED_YEARS:
        abort(404)


def validate_lang(lang, year):
    supported_langs = SUPPORTED_YEARS[year]
    if lang not in supported_langs:
        abort(404)


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
