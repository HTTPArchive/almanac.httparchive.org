from flask import Flask, render_template, abort
from flask_talisman import Talisman
from csp import csp

app = Flask(__name__)
Talisman(app,
         content_security_policy=csp,
         content_security_policy_nonce_in=['script-src'])

# TODO: Don't expect the same languages to be supported each year.
SUPPORTED_LANGS = ('en', 'ja')
SUPPORTED_YEARS = ('2019')

##
## English is implied when omitting a language code from the URL.
## TODO: Should we require language codes to simplify this?
##

@app.route('/')
def index():
    return index_i18n('en')

@app.route('/<year>/outline')
def outline(year):
    return outline_i18n('en', year)

@app.route('/<year>/contributors')
def contributors(year):
    return contributors_i18n('en', year)

@app.route('/<year>/methodology')
def methodology(year):
    return methodology_i18n('en', year)

@app.route('/<year>/<chapter>/')
def chapter(year, chapter):
    return chapter_i18n('en', year, chapter)

##
## Internationalization (i18n)
##

@app.route('/<lang>/')
def index_i18n(lang):
    if lang not in SUPPORTED_LANGS:
        abort(404)

    return render_template('%s/splash.html' % lang)

@app.route('/<lang>/<year>/outline')
def outline_i18n(lang, year):
    if lang not in SUPPORTED_LANGS:
        abort(404)
    if year not in SUPPORTED_YEARS:
        abort(404)

    return render_template('%s/%s/outline.html' % (lang, year))

@app.route('/<lang>/<year>/contributors')
def contributors_i18n(lang, year):
    if lang not in SUPPORTED_LANGS:
        abort(404)
    if year not in SUPPORTED_YEARS:
        abort(404)

    # TODO: Get contributor data and pass into the template.
    return render_template('%s/%s/contributors.html' % (lang, year), contributors={})

@app.route('/<lang>/<year>/methodology')
def methodology_i18n(lang, year):
    if lang not in SUPPORTED_LANGS:
        abort(404)
    if year not in SUPPORTED_YEARS:
        abort(404)

    return render_template('%s/%s/methodology.html' % (lang, year))

@app.route('/<lang>/<year>/<chapter>')
def chapter_i18n(lang, year, chapter):
    if lang not in SUPPORTED_LANGS:
        abort(404)
    if year not in SUPPORTED_YEARS:
        abort(404)

    # TODO: Validate the chapter.
    # TODO: Get chapter data and pass into the template.
    return render_template('%s/%s/chapter.html' % (lang, year), chapter=chapter)


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
