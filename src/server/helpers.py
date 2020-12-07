from flask import request, redirect, url_for, render_template as flask_render_template
from .config import TEMPLATES_DIR, get_config, get_timestamps_config, \
                    DEFAULT_YEAR, SUPPORTED_LANGUAGES, SUPPORTED_YEARS, SUPPORTED_CHAPTERS
from .language import get_language, DEFAULT_LANGUAGE
from werkzeug.routing import BaseConverter
import os.path
import re
import datetime
import logging


def render_template(template, *args, **kwargs):
    # If the year has already been set (e.g. for error pages) then use that
    # Otherwise the requested year, otherwise the default year
    year = kwargs.get('year', request.view_args.get('year', DEFAULT_YEAR))
    config = kwargs.get('config', get_config(year))

    # If the lang has already been set (e.g. for error pages) then use that
    # Otherwise the requested lang, otherwise the default lang
    lang = kwargs.get('lang', request.view_args.get('lang', DEFAULT_LANGUAGE.lang_code))
    language = get_language(lang)
    langcode_length = len(lang) + 1

    # If the template does not exist, then redirect to English version if it exists, else home
    if lang != '' and not (os.path.isfile(TEMPLATES_DIR + '/%s' % template)):
        if os.path.isfile(TEMPLATES_DIR + '/en/%s' % (template[langcode_length:])):
            return redirect('/en%s' % (request.full_path[langcode_length:]), code=302)
        else:
            return redirect(url_for('home', lang=lang, year=year))

    # Although a language may be enabled, all templates may not have been translated yet
    # So check if each language exists and only return languages for templates that do exist
    supported_languages = SUPPORTED_LANGUAGES.get(year, (DEFAULT_LANGUAGE,))
    template_supported_languages = []
    for lan in supported_languages:
        lang_template = TEMPLATES_DIR + '/%s/%s' % (lan.lang_code, template[langcode_length:])
        if os.path.isfile(lang_template):
            template_supported_languages.append(lan)

    # Although a year may be enabled, all templates may not exist yet
    # So check if each template exists and only return years for templates that do exist
    supported_years = SUPPORTED_YEARS
    template_supported_years = []
    for y in supported_years:
        year_lang_template = TEMPLATES_DIR + '/%s/%s/%s' % (lang, y, template[langcode_length + 1 + 4:])
        if os.path.isfile(year_lang_template):
            template_supported_years.append(y)

    date_published = get_file_date_info(template, "date_published")
    date_modified = get_file_date_info(template, "date_modified")
    ebook_size_in_mb = get_ebook_size_in_mb(lang, year)
    supported_chapters = SUPPORTED_CHAPTERS.get(year)

    kwargs.update(year=year, lang=lang, language=language, supported_languages=template_supported_languages,
                  supported_years=template_supported_years, all_supported_years=SUPPORTED_YEARS,
                  supported_chapters=supported_chapters, date_published=date_published, date_modified=date_modified,
                  ebook_size_in_mb=ebook_size_in_mb, get_file_date_info=get_file_date_info, config=config)
    return flask_render_template(template, *args, **kwargs)


# Render any error template by falling back to Default Year and also Default Lang if needed
def render_error_template(error, status_code):
    lang = request.view_args.get('lang') or DEFAULT_LANGUAGE.lang_code
    year = request.view_args.get('year') or DEFAULT_YEAR

    if not SUPPORTED_LANGUAGES.get(year):
        year = DEFAULT_YEAR

    # Special error handling for base templates and other templates that might
    # exist but shouldn't be called
    supported_langs = [lan.lang_code for lan in (SUPPORTED_LANGUAGES.get(year) or [DEFAULT_LANGUAGE])]
    if lang not in supported_langs:
        lang = DEFAULT_LANGUAGE.lang_code

    if not (os.path.isfile(TEMPLATES_DIR + '/%s/error.html' % lang)):
        if os.path.isfile(TEMPLATES_DIR + '/%s/error.html' % DEFAULT_LANGUAGE.lang_code):
            lang = DEFAULT_LANGUAGE.lang_code
    return render_template('%s/error.html' % lang, lang=lang, year=year, error=error), status_code


def chapter_lang_exists(lang, year, chapter):
    if os.path.isfile(TEMPLATES_DIR + '/%s/%s/chapters/%s.html' % (lang, year, chapter)):
        return True
    else:
        return False


def featured_chapters_exists(lang, year):
    if os.path.isfile(TEMPLATES_DIR + '/%s/%s/featured_chapters.html' % (lang, year)):
        return True
    else:
        return False


def get_chapter_nextprev(config, chapter_slug):
    prev_chapter = None
    next_chapter = None
    found = False

    for part in config['outline']:
        for chapter in part['chapters']:
            if found and 'todo' not in chapter:
                next_chapter = chapter
                break
            elif chapter.get('slug') == chapter_slug not in chapter:
                found = True
            elif 'todo' not in chapter:
                prev_chapter = chapter
        if found and next_chapter:
            break

    if not found:
        return (None, None)

    return prev_chapter, next_chapter


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
def convert_old_image_path(folder):
    return '%s' % folder[3:].replace('HTTP_2', 'http2').replace('_', '-').lower()


# Render the methodology chapter and pull out the section. Also applies some
# regexs to change links as appropriate. It's a bit messy, but can't use
# get_template_attribute as doesn't take context which is needed for the way
# our templates work. So it's either this, or just read the file, or move the
# content to base.html, or duplicate the content, but all will need regexs
# anyway, so I think this is the cleanest.
def get_ebook_methodology(lang, year):
    methodology_template = render_template('%s/%s/methodology.html' % (lang, year))
    if not isinstance(methodology_template, str):
        return False
    methodology_maincontent = re.search('<article id="maincontent" class="content">(.+?)</article>',
                                        methodology_template, re.DOTALL | re.MULTILINE)

    # Can't test this as should never end up here unless bad template to 'pragma no cover' it is
    if not methodology_maincontent:  # pragma no cover
        return False

    methodology_maincontent = methodology_maincontent.group(1)
    # Replace methodology links to full anchor link (e.g. #introduction -> #methodology-introduction)
    methodology_maincontent = re.sub('href="#', 'href="#methodology-', methodology_maincontent)
    # Replace header ids to full id (e.g. <h2 id="introduction"> -> <h2 id="methodology-introduction">)
    methodology_maincontent = re.sub('<h([0-6]) id="', '<h\\1 id="methodology-', methodology_maincontent)
    # Replace home-relative URLS generated by url_for (e.g. /en/2019/ -> #)
    methodology_maincontent = re.sub('href="/%s/%s/' % (lang, year), 'href="#', methodology_maincontent)
    # For external links add footnote span
    methodology_maincontent = re.sub('href="http(.*?)"(.*?)>(.*?)</a>',
                                     'href="http\\1"\\2>\\3</a><span class="fn">http\\1</span>',
                                     methodology_maincontent)
    # Replace figure image links to full site, to avoid 0.0.0.0:8080 links
    methodology_maincontent = re.sub('href="/', 'href="https://almanac.httparchive.org/', methodology_maincontent)
    # Replace other chapter references with hash to anchor link (e.g. ./javascript#fig-1 -> #javascript-fig-1)
    methodology_maincontent = re.sub('href="./([a-z0-9-]*)#', 'href="#\\1-', methodology_maincontent)
    # Replace other chapter references to anchor link (e.g. ./javascript -> #javascript)
    methodology_maincontent = re.sub('href="./', 'href="#', methodology_maincontent)
    # Replace double-hashed URLs (e.g. #contributors#patrickhulce -> #contributors-patrickhulce)
    methodology_maincontent = re.sub('href="#([a-z0-9-]*)#', 'href="#\\1-', methodology_maincontent)
    # Remove lazy-loading attributes
    methodology_maincontent = re.sub(' loading="lazy"', '', methodology_maincontent)
    return methodology_maincontent


# This function takes a string and adds the footnote links for printing
def add_footnote_links(html):
    return re.sub('href="http([^"]*?)"([^>]*?)>((?!(www|http|@)).*?)</a>',
                  'href="http\\1"\\2>\\3</a><span class="fn">http\\1</span>',
                  html)


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


def get_file_date_info(file, type):
    timestamps_config = get_timestamps_config()
    # Default Published and Last Updated to today
    today = datetime.datetime.utcnow().isoformat()
    if type == 'date_published' or type == 'date_modified':
        return timestamps_config.get(file, {}).get(type, today)
    else:
        return timestamps_config.get(file, {}).get(type)


def get_versioned_filename(path):
    version = get_file_date_info(path, 'hash')
    if version:
        return '%s?v=%s' % (path, version)
    else:
        logging.exception('An un-versioned file was used: %s', path)
        return '%s' % path


def get_ebook_size_in_mb(lang, year):
    ebook_file = '/static/pdfs/web_almanac_%s_%s.pdf' % (year, lang)
    return int(get_file_date_info(ebook_file, 'size') or 0)


class RegexConverter(BaseConverter):
    def __init__(self, url_map, *items):
        super(RegexConverter, self).__init__(url_map)
        self.regex = items[0]
