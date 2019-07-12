import contributors as contributors_util
from csp import csp
from flask import Flask, render_template as flask_render_template, request
from flask_talisman import Talisman
from language import DEFAULT_LANGUAGE, get_language
import logging
from validate import validate, SUPPORTED_YEARS, DEFAULT_YEAR

app = Flask(__name__)
Talisman(app,
         content_security_policy=csp,
         content_security_policy_nonce_in=['script-src'])
logging.basicConfig(level=logging.DEBUG)

def render_template(template, *args, **kwargs):
    year = request.view_args.get('year', DEFAULT_YEAR)
    supported_languages = SUPPORTED_YEARS.get(year, (DEFAULT_LANGUAGE))

    lang = request.view_args.get('lang')
    language = get_language(lang)
    kwargs.update(supported_languages=supported_languages, language=language)
    return flask_render_template(template, *args, **kwargs)


def get_view_args(lang=None):
    view_args = request.view_args.copy()
    if lang:
        # Optionally overwrite the lang value in the current request.
        view_args.update(lang=lang)
    return view_args

# Make this function available in templates.
app.jinja_env.globals['get_view_args'] = get_view_args


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
    contributors=contributors_util.get_contributors()
    return render_template('%s/%s/contributors.html' % (lang, year), contributors=contributors)


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
