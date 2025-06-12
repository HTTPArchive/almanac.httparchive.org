from flask import Flask
from flask_talisman import Talisman
from werkzeug.http import HTTP_STATUS_CODES
from .helpers import (
    get_view_args,
    chapter_lang_exists,
    page_lang_exists,
    featured_chapters_exists,
    get_ebook_methodology,
    add_footnote_links,
    year_live,
    accentless_sort,
    get_versioned_filename,
)
from datetime import datetime
from .config import TEMPLATES_DIR, STATIC_DIR
from . import csp, feature_policy
import logging


logging.basicConfig(level=logging.DEBUG)


# Set WOFF and WOFF2 caching to return 1 year as they should never change
# Note this requires similar set up in app.yaml for Google App Engine
class WebAlmanacServer(Flask):
    def get_send_file_max_age(self, name):
        if name:
            if name.lower().endswith(".woff") or name.lower().endswith(".woff2"):
                return 31536000
        return Flask.get_send_file_max_age(self, name)


# Initialize The Server
app = WebAlmanacServer(
    __name__, template_folder=TEMPLATES_DIR, static_folder=STATIC_DIR
)


@app.after_request
def add_header(response):
    # Make sure bad responses are not cached
    #
    # Cache good responses for 10 mins if no other Cache-Control header set
    # This is used for the dynamically generated files (e.g. the HTML)
    # (currently don't use unique filenames so cannot use long caches and
    # some say they are overrated anyway as caches smaller than we think).
    # Note this IS used by Google App Engine as dynamic content.
    if "Cache-Control" not in response.headers:
        if response.status_code != 200 and response.status_code != 304:
            response.cache_control.no_store = True
            response.cache_control.no_cache = True
            response.cache_control.max_age = 0
        if response.status_code == 200 or response.status_code == 304:
            response.cache_control.public = True
            response.cache_control.max_age = 600
    return response


# Cache static resources for 10800 secs (3 hrs) with SEND_FILE_MAX_AGE_DEFAULT.
# Flask default if not set is 12 hours but we want to match app.yaml
# which is used by Google App Engine as it serves static files directly
app.config["SEND_FILE_MAX_AGE_DEFAULT"] = 10800

# Make these functions available in templates.
app.jinja_env.globals["get_view_args"] = get_view_args
app.jinja_env.globals["chapter_lang_exists"] = chapter_lang_exists
app.jinja_env.globals["page_lang_exists"] = page_lang_exists
app.jinja_env.globals["featured_chapters_exists"] = featured_chapters_exists
app.jinja_env.globals["HTTP_STATUS_CODES"] = HTTP_STATUS_CODES
app.jinja_env.globals["get_ebook_methodology"] = get_ebook_methodology
app.jinja_env.globals["add_footnote_links"] = add_footnote_links
app.jinja_env.globals["year_live"] = year_live
app.jinja_env.globals["get_versioned_filename"] = get_versioned_filename
app.jinja_env.filters["accentless_sort"] = accentless_sort
app.jinja_env.globals['now'] = datetime.now

talisman = Talisman(
    app,
    content_security_policy=csp.csp,
    content_security_policy_nonce_in=["script-src", "style-src"],
    feature_policy=feature_policy.feature_policy,
)


# Circular Import but this is fine because routes and errors modules are not used in here and
# this way we make app available for decorators in both modules
# For more details, check https://flask.palletsprojects.com/en/1.1.x/patterns/packages/
import server.routes
import server.errors
