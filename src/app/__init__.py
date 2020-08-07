from flask import Flask
from werkzeug.routing import BaseConverter
from werkzeug.http import HTTP_STATUS_CODES
from .helpers import get_view_args, chapter_lang_exists, ebook_exists, get_ebook_methodology, \
    add_footnote_links, year_live, accentless_sort
from config import TEMPLATES_DIR, STATIC_DIR
import logging


# Set WOFF and WOFF2 caching to return 1 year as they should never change
# Note this requires similar set up in app.yaml for Google App Engine
class MyFlask(Flask):
    def get_send_file_max_age(self, name):
        if name.lower().endswith('.woff') or name.lower().endswith('.woff2'):
            return 31536000
        return Flask.get_send_file_max_age(self, name)


class RegexConverter(BaseConverter):
    def __init__(self, url_map, *items):
        super(RegexConverter, self).__init__(url_map)
        self.regex = items[0]


def create_app():
    app = MyFlask(__name__, template_folder=TEMPLATES_DIR, static_folder=STATIC_DIR)

    # Cache static resources for 10800 secs (3 hrs) with SEND_FILE_MAX_AGE_DEFAULT.
    # Flask default if not set is 12 hours but we want to match app.yaml
    # which is used by Google App Engine as it serves static files directly
    app.config['SEND_FILE_MAX_AGE_DEFAULT'] = 10800

    app.url_map.converters['regex'] = RegexConverter

    logging.basicConfig(level=logging.DEBUG)

    # Make these functions available in templates.
    app.jinja_env.globals['get_view_args'] = get_view_args
    app.jinja_env.globals['chapter_lang_exists'] = chapter_lang_exists
    app.jinja_env.globals['ebook_exists'] = ebook_exists
    app.jinja_env.globals['HTTP_STATUS_CODES'] = HTTP_STATUS_CODES
    app.jinja_env.globals['get_ebook_methodology'] = get_ebook_methodology
    app.jinja_env.globals['add_footnote_links'] = add_footnote_links
    app.jinja_env.globals['year_live'] = year_live
    app.jinja_env.filters['accentless_sort'] = accentless_sort

    return app
