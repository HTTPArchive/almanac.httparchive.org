import config as config_util
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
    kwargs.update(supported_languages=supported_languages, year=year, language=language, supported_years=list(SUPPORTED_YEARS.keys()))
    return flask_render_template(template, *args, **kwargs)


def get_view_args(lang=None, year=None):
    view_args = request.view_args.copy()
    if lang:
        # Optionally overwrite the lang value in the current request.
        view_args.update(lang=lang)
    if year:
        view_args.update(year=year)
    return view_args


def get_chapter_slug(title):
    return title.lower().replace(' ', '-').replace('/', '')


# Make these functions available in templates.
app.jinja_env.globals['get_view_args'] = get_view_args
app.jinja_env.globals['get_chapter_slug'] = get_chapter_slug

@app.route('/<year>/')
@app.route('/<lang>/<year>/')
@validate
def home(year, lang):
    return render_template('%s/%s/index.html' % (lang, year))

@app.route('/')
@validate
def index(lang):
    return render_template('%s/%s/splash.html' % (lang, DEFAULT_YEAR))


@app.route('/<year>/outline')
@app.route('/<lang>/<year>/outline')
@validate
def outline(year, lang):
    config = config_util.get_config(year)
    return render_template('%s/%s/outline.html' % (lang, year), config=config)


@app.route('/<year>/contributors')
@app.route('/<lang>/<year>/contributors')
@validate
def contributors(year, lang):
    config = config_util.get_config(year)
    return render_template('%s/%s/contributors.html' % (lang, year), config=config)


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
    config = config_util.get_config(year)
    return render_template('%s/%s/chapters/%s.html' % (lang, year, chapter), config=config)


@app.errorhandler(400)
def bad_request(e):
    logging.exception('An error occurred during a request due to bad request error.')
    return render_template('error/400.html', error=e), 400


@app.errorhandler(404)
def page_not_found(e):
    logging.exception('An error occurred during a request due to page not found.')
    return render_template('error/404.html', error=e), 404


@app.errorhandler(500)
def server_error(e):
    logging.exception('An error occurred during a request due to internal server error.')
    return render_template('error/500.html', error=e), 500


@app.errorhandler(502)
def server_error(e):
    logging.exception('An error occurred during a request due to bad gateway.')
    return render_template('error/502.html', error=e), 502


if __name__ == '__main__':
    # This is used when running locally. Gunicorn is used to run the
    # application on Google App Engine. See entrypoint in app.yaml.
    app.run(host='127.0.0.1', port=8080, debug=True)
