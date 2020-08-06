from config import get_config, SUPPORTED_YEARS, SUPPORTED_LANGUAGES, DEFAULT_YEAR
from csp import csp
from feature_policy import feature_policy
from flask import Flask, abort, redirect, render_template as flask_render_template, request, send_from_directory, url_for
from flask_talisman import Talisman
from language import DEFAULT_LANGUAGE, get_language
import logging
import random
from werkzeug.routing import BaseConverter
from werkzeug.http import HTTP_STATUS_CODES
from validate import validate
import os.path
import re
import sys

# Set WOFF and WOFF2 caching to return 1 year as they should never change
# Note this requires similar set up in app.yaml for Google App Engine
class MyFlask(Flask):
    def get_send_file_max_age(self, name):
        if name.lower().endswith('.woff') or name.lower().endswith('.woff2'):
            return 31536000
        return Flask.get_send_file_max_age(self, name)

app = MyFlask(__name__)
# Cache static resources for 10800 secs (3 hrs) with SEND_FILE_MAX_AGE_DEFAULT.
# Flask default if not set is 12 hours but we want to match app.yaml
# which is used by Google App Engine as it serves static files directly
app.config['SEND_FILE_MAX_AGE_DEFAULT'] = 10800
talisman = Talisman(app,
         content_security_policy=csp,
         content_security_policy_nonce_in=['script-src','style-src'],
         feature_policy=feature_policy)
logging.basicConfig(level=logging.DEBUG)

@app.after_request
def add_header(response):
    # Make sure bad responses are not cached
    # 
    # Cache good responses for 3 hours if no other Cache-Control header set
    # This is used for the dynamically generated files (e.g. the HTML)
    # (currently don't use unique filenames so cannot use long caches and
    # some say they are overrated anyway as caches smaller than we think).
    # Note this IS used by Google App Engine as dynamic content.
    if 'Cache-Control' not in response.headers:
        if response.status_code != 200 and response.status_code != 304:
            response.cache_control.no_store = True
            response.cache_control.no_cache = True
            response.cache_control.max_age = 0
        if response.status_code == 200 or response.status_code == 304:
            response.cache_control.public = True
            response.cache_control.max_age = 10800
    return response

def render_template(template, *args, **kwargs):
    # If the year has already been set (e.g. for error pages) then use that
    # Otherwise the requested year, otherwise the default year
    year = kwargs.get('year', request.view_args.get('year', DEFAULT_YEAR))
    
    # If the lang has already been set (e.g. for error pages) then use that
    # Otherwise the requested lang, otherwise the default lang
    lang = kwargs.get('lang', request.view_args.get('lang', DEFAULT_LANGUAGE.lang_code))
    language = get_language(lang)
    langcode_length = len(lang) + 1

    # If the template does not exist, then redirect to English version if it exists, else home
    if (lang != '' and not(os.path.isfile('templates/%s' % template))):
        if (os.path.isfile('templates/en/%s' % (template[langcode_length:]))):
            return redirect('/en%s' % (request.full_path[langcode_length:]), code=302)
        else:
            return redirect(url_for('home', lang=lang, year=year))

    # Although a language may be enabled, all templates may not have been translated yet
    # So check if each language exists and only return languages for templates that do exist
    supported_languages = SUPPORTED_LANGUAGES.get(year, (DEFAULT_LANGUAGE,))
    template_supported_languages = []
    for l in supported_languages:
        langTemplate = 'templates/%s/%s' % (l.lang_code, template[langcode_length:])
        if (os.path.isfile(langTemplate)):
            template_supported_languages.append(l)

    # Although a year may be enabled, all templates may not exist yet
    # So check if each template exists and only return years for templates that do exist
    supported_years = SUPPORTED_YEARS
    template_supported_years = []
    for y in supported_years:
        yearLangTemplate = 'templates/%s/%s/%s' % (lang, y, template[langcode_length+1+4:])
        if (os.path.isfile(yearLangTemplate)):
            template_supported_years.append(y)

    kwargs.update(year=year, lang=lang, language=language, supported_languages=template_supported_languages, supported_years=template_supported_years, all_supported_years=SUPPORTED_YEARS)
    return flask_render_template(template, *args, **kwargs)


# Render any error template by falling back to Default Year and also Default Lang if needed
def render_error_template(error, status_code):
    lang = request.view_args.get('lang')
    year = request.view_args.get('year')
    if (not(os.path.isfile('templates/%s/%s/error.html' % (lang, year)))):
        if (os.path.isfile('templates/%s/%s/error.html' % (lang, DEFAULT_YEAR))):
            year = DEFAULT_YEAR
        elif (os.path.isfile('templates/%s/%s/error.html' % (DEFAULT_LANGUAGE.lang_code, DEFAULT_YEAR))):
            lang = DEFAULT_LANGUAGE.lang_code
            year = DEFAULT_YEAR
    return render_template('%s/%s/error.html' % (lang, year), lang=lang, year=year, error=error), status_code


def chapter_lang_exists(lang, year, chapter):
    if os.path.isfile('templates/%s/%s/chapters/%s.html' % (lang, year, chapter)):
        return True
    else:
        return False


def ebook_exists(lang, year):
    return os.path.isfile('static/pdfs/web_almanac_%s_%s.pdf' % (year, lang))


def get_view_args(lang=None, year=None):
    view_args = request.view_args.copy()
    if lang:
        # Optionally overwrite the lang value in the current request.
        view_args.update(lang=lang)
    if year:
        view_args.update(year=year)
    return view_args


# Images were originally in folders with naming conventions like 05_Third_Parties
# These have been mapped to the standard slug names (e.g. third-parties)
def convertOldImagePath(folder):
    return '%s' % folder[3:].replace('HTTP_2','http2').replace('_', '-').lower()


# Render the methodology chapter and pull out the section. Also applies some
# regexs to change links as appropriate. It's a bit messy, but can't use
# get_template_attribute as doesn't take context which is needed for the way
# our templates work. So it's either this, or just read the file, or move the
# content to base.html, or duplicate the content, but all will need regexs
# anyway, so I think this is the cleanest.
def get_ebook_methodology(lang, year):
    config = get_config(year)
    methodology_template = render_template('%s/%s/methodology.html' % (lang, year), config=config)
    methodology_maincontent = re.search('<article id="maincontent" class="content">(.+?)</article>', methodology_template, re.DOTALL|re.MULTILINE)
    if not methodology_maincontent:
        return False
        
    methodology_maincontent = methodology_maincontent.group(1)
    # Replace methodology links to full anchor link (e.g. #introduction -> #methodology-introduction)
    methodology_maincontent = re.sub('href="#', 'href="#methodology-', methodology_maincontent)
    # Replace header ids to full id (e.g. <h2 id="introduction"> -> <h2 id="methodology-introduction">)
    methodology_maincontent = re.sub('<h([0-6]) id="', '<h\\1 id="methodology-', methodology_maincontent)
    # Replace home-relative URLS generated by url_for (e.g. /en/2019/ -> #)
    methodology_maincontent = re.sub('href="\/%s\/%s\/' % (lang, year), 'href="#', methodology_maincontent)
    # For external links add footnote span
    methodology_maincontent = re.sub('href="http(.*?)"(.*?)>(.*?)<\/a>', 'href="http\\1"\\2>\\3</a><span class="fn">http\\1</span>', methodology_maincontent)
    # Replace figure image links to full site, to avoid 0.0.0.0:8080 links
    methodology_maincontent = re.sub('href="\/', 'href="https://almanac.httparchive.org/', methodology_maincontent)
    # Replace other chapter references with hash to anchor link (e.g. ./javascript#fig-1 -> #javascript-fig-1)
    methodology_maincontent = re.sub('href="./([a-z0-9-]*)#', 'href="#\\1-', methodology_maincontent)
    # Replace other chapter references to anchor link (e.g. ./javascript -> #javascript)
    methodology_maincontent = re.sub('href="\.\/', 'href="#', methodology_maincontent)
    # Replace double-hashed URLs (e.g. #contributors#patrickhulce -> #contributors-patrickhulce)
    methodology_maincontent = re.sub('href="#([a-z0-9-]*)#', 'href="#\\1-', methodology_maincontent)
    # Remove lazy-loading attributes
    methodology_maincontent = re.sub(' loading="lazy"', '', methodology_maincontent)
    return methodology_maincontent


# This function takes a string and adds the footnote links for printing
def add_footnote_links(html):
    html = re.sub('href="http([^"]*?)"([^>]*?)>((?!(www|http|@)).*?)<\/a>', 'href="http\\1"\\2>\\3</a><span class="fn">http\\1</span>', html)
    return html


# This checks whether a requested year is live - used to control the year selector
def year_live(year):
    return year in SUPPORTED_YEARS


# A simple function to strip accents rather than having to import a 3rd party
# library like unicodedata
def strip_accents(string):
    repl = str.maketrans(
    "áéúíóÁÉÚÍÓ",
    "aeuioAEUIO"
    )
    return string.translate(repl)


def accentless_sort(value):
  return sorted(value, key=lambda i: strip_accents(i[1]).lower())


# Make these functions available in templates.
app.jinja_env.globals['get_view_args'] = get_view_args
app.jinja_env.globals['chapter_lang_exists'] = chapter_lang_exists
app.jinja_env.globals['ebook_exists'] = ebook_exists
app.jinja_env.globals['HTTP_STATUS_CODES'] = HTTP_STATUS_CODES
app.jinja_env.globals['get_ebook_methodology'] = get_ebook_methodology
app.jinja_env.globals['add_footnote_links'] = add_footnote_links
app.jinja_env.globals['year_live'] = year_live
app.jinja_env.filters['accentless_sort'] = accentless_sort


@app.route('/<lang>/<year>/')
@validate
def home(lang, year):
    config = get_config(year)
    return render_template('%s/%s/index.html' % (lang, year), config=config)


@app.route('/<lang>/')
@validate
def lang_only(lang):
    return redirect(url_for('home', lang=lang, year=DEFAULT_YEAR))


@app.route('/')
@validate
def root(lang):
    response = redirect(url_for('home', lang=lang, year=DEFAULT_YEAR))
    response.vary = 'Accept-Language'
    return response


@app.route('/<lang>/<year>/table-of-contents')
@validate
def table_of_contents(lang, year):
    config = get_config(year)
    return render_template('%s/%s/table_of_contents.html' % (lang, year), config=config)


@app.route('/<lang>/<year>/contributors')
@validate
def contributors(lang, year):
    config = get_config(year)
    contributors = list(config["contributors"].items())
    random.shuffle(contributors)
    config["contributors"] = dict(contributors)
    return render_template('%s/%s/contributors.html' % (lang, year), config=config)


@app.route('/<lang>/<year>/methodology')
@validate
def methodology(lang, year):
    return render_template('%s/%s/methodology.html' % (lang, year))


# Accessibility Statement needs special case handling for trailing slashes
# as, unlike Flask, we generally prefer no trailing slashes
# For chapters we handle this in the validate function
@app.route('/<lang>/accessibility-statement', strict_slashes=False)
@validate
def accessibility_statement(lang):
    if request.base_url[-1] == "/":
        return redirect("/%s/accessibility-statement" % (lang)), 301
    else:
        return render_template('%s/2019/accessibility_statement.html' % (lang))


@app.route('/sitemap.xml')
# Chrome and Safari use inline styles to display XMLs files.
# https://bugs.chromium.org/p/chromium/issues/detail?id=924962
# Override default CSP (including turning off nonce) to allow sitemap to display
@talisman(
    content_security_policy = { 'default-src': ['\'self\''], 'script-src': ['\'self\''], 'style-src': ['\'unsafe-inline\''], 'img-src': ['\'self\'', 'data:'] },
    content_security_policy_nonce_in=['script-src']
)
def sitemap():
    # Flask-Talisman doesn't allow override of content_security_policy_nonce_in
    # per route yet
    # https://github.com/GoogleCloudPlatform/flask-talisman/issues/62
    # So remove Nonce value from request object for now which has same effect
    delattr(request,'csp_nonce')
    xml = render_template('sitemap.xml')
    resp = app.make_response(xml)
    resp.mimetype = "text/xml"
    return resp


# Assume anything else with at least 3 directories is a chapter
# so we can give lany and year specific error messages
@app.route('/<lang>/<year>/<path:chapter>')
@validate
def chapter(lang, year, chapter):
    config = get_config(year)
    (prev_chapter, next_chapter) = get_chapter_nextprev(config, chapter)
    return render_template('%s/%s/chapters/%s.html' % (lang, year, chapter), config=config, prev_chapter=prev_chapter, next_chapter=next_chapter)


def get_chapter_nextprev(config, chapter_slug):
    prev_chapter = None
    next_chapter = None
    found =  False

    for part in config['outline']:
        for chapter in part['chapters']:
            if found and 'todo' not in chapter:
                next_chapter = chapter
                break
            elif chapter.get('slug') == chapter_slug and 'todo' not in chapter:
                found = True
            elif 'todo' not in chapter:
                prev_chapter = chapter
        if found and next_chapter:
            break

    return (prev_chapter, next_chapter)


@app.route('/robots.txt')
def static_from_root():
    return send_from_directory(app.static_folder, request.path[1:])


@app.route('/favicon.ico')
def default_favicon():
    return send_from_directory(app.static_folder, 'images/favicon.ico')

@app.route('/<lang>/<year>/ebook')
@validate
def ebook(lang, year):
    config = get_config(year)
    sorted_contributors = sorted(config["contributors"].items(), key=lambda items: items[1]['name'])
    config["contributors"] = dict(sorted_contributors)
    return render_template('%s/%s/ebook.html' % (lang, year), config=config)

class RegexConverter(BaseConverter):
    def __init__(self, url_map, *items):
        super(RegexConverter, self).__init__(url_map)
        self.regex = items[0]


app.url_map.converters['regex'] = RegexConverter


# Redirect requests for the older image URLs to new URLs
@app.route('/static/images/2019/<regex("[0-2][0-9]_.*"):folder>/<image>')
def redirect_old_images(folder, image):
    return redirect("/static/images/2019/%s/%s" % (convertOldImagePath(folder), image)), 301


# Catch all route for everything not matched elsewhere
@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
def catch_all(path):
    abort(404,"Not Found")


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


if __name__ == '__main__':
    # This is used when running locally. Gunicorn is used to run the
    # application on Google App Engine. See entrypoint in app.yaml.

    # If the 'background' command line argument is given:
    #    python main.py background &
    # then run in non-debug mode, as debug mode can't be backgrounded
    # but debug mode is useful in general (as auto reloads on change)
    if (len(sys.argv) > 1 and sys.argv[1] == 'background'):
        # Turn off HTTPS redirects (automatically turned off for debug)
        talisman.force_https=False
        app.run(host='0.0.0.0', port=8080)
    else:
        app.run(host='0.0.0.0', port=8080, debug=True)
