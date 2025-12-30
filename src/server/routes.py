from flask import redirect, url_for, request, send_from_directory
from . import app, talisman
from .helpers import (
    render_template,
    convert_old_image_path,
    get_chapter_nextprev,
    get_chapter_config,
)
from .validate import validate
from .config import get_config, DEFAULT_YEAR
from . import stories_csp
from . import search_csp
from . import embeds_csp
import random


@app.route("/<lang>/<year>/")
@validate
def home(lang, year):
    return render_template("%s/%s/index.html" % (lang, year))


@app.route("/<lang>/")
@validate
def lang_only(lang):
    return redirect(url_for("home", lang=lang, year=DEFAULT_YEAR))


@app.route("/")
@validate
def root(lang):
    response = redirect(url_for("home", lang=lang, year=DEFAULT_YEAR))
    response.vary = "Accept-Language"
    return response


@app.route("/<lang>/<year>/table-of-contents")
@validate
def table_of_contents(lang, year):
    return render_template("%s/%s/table_of_contents.html" % (lang, year), slug="table-of-contents")


@app.route("/<lang>/<year>/contributors")
@validate
def contributors(lang, year):
    config = get_config(year)
    contributors_list = list(config["contributors"].items())
    random.shuffle(contributors_list)
    config["contributors"] = dict(contributors_list)
    return render_template("%s/%s/contributors.html" % (lang, year), config=config, slug="contributors")


@app.route("/<lang>/<year>/methodology")
@validate
def methodology(lang, year):
    return render_template("%s/%s/methodology.html" % (lang, year), slug="methodology")


# Accessibility Statement needs special case handling for trailing slashes
# as, unlike Flask, we generally prefer no trailing slashes
# For chapters we handle this in the validate function
@app.route("/<lang>/accessibility-statement", strict_slashes=False)
@validate
def accessibility_statement(lang):

    if request.base_url[-1] == "/":
        return redirect("/%s/accessibility-statement" % (lang)), 301
    else:
        return render_template("%s/accessibility_statement.html" % (lang), slug="accessibility-statement")


# Search needs special case handling for trailing slashes
# as, unlike Flask, we generally prefer no trailing slashes
# For chapters we handle this in the validate function
# It also needs a special CSP
@app.route("/<lang>/search", strict_slashes=False)
@validate
@talisman(
    content_security_policy=search_csp.csp,
    content_security_policy_nonce_in=["script-src"],
    frame_options=None,
)
def search(lang):

    if request.base_url[-1] == "/":
        return redirect("/%s/search" % lang), 301
    else:
        return render_template("%s/search.html" % lang, slug="search")


# Redirect search by year
@app.route("/<lang>/<year>/search", strict_slashes=False)
@validate
def search_year(lang, year):
    return redirect("/%s/search" % lang), 301


@app.route("/sitemap.xml")
# Chrome and Safari use inline styles to display XMLs files.
# https://bugs.chromium.org/p/chromium/issues/detail?id=924962
# Override default CSP (including turning off nonce) to allow sitemap to display
@talisman(
    content_security_policy={
        "default-src": ["'self'"],
        "script-src": ["'self'"],
        "style-src": ["'unsafe-inline'"],
        "img-src": ["'self'", "data:"],
    },
    content_security_policy_nonce_in=["script-src"],
)
def sitemap():
    xml = render_template("sitemap.xml")
    resp = app.make_response(xml)
    resp.mimetype = "text/xml"
    return resp


@app.route("/<lang>/rss.xml")
# Chrome and Safari use inline styles to display XMLs files.
# https://bugs.chromium.org/p/chromium/issues/detail?id=924962
# Override default CSP (including turning off nonce) to allow sitemap to display
@talisman(
    content_security_policy={
        "default-src": ["'self'"],
        "script-src": ["'self'"],
        "style-src": ["'unsafe-inline'"],
        "img-src": ["'self'", "data:"],
    },
    content_security_policy_nonce_in=["script-src"],
)
@validate
def rss(lang):
    xml = render_template("%s/rss.xml" % lang)
    resp = app.make_response(xml)
    resp.mimetype = "application/atom+xml"
    return resp


# Stories require their own CSP and to allow framing
@app.route("/<lang>/<year>/stories/<story>")
@validate
@talisman(
    content_security_policy=stories_csp.csp,
    content_security_policy_nonce_in=["script-src"],
    frame_options=None,
)
def stories(lang, year, story):
    return render_template(
        "%s/%s/stories/%s.html" % (lang, year, story.replace("-", "_"))
    )


# Allow embeds
@app.route("/<lang>/<year>/embeds/<path:embed>")
@validate
@talisman(
    content_security_policy=embeds_csp.csp,
    content_security_policy_nonce_in=["script-src"],
)
def embed(lang, year, embed):
    return render_template(
        "%s/%s/embeds/%s.html" % (lang, year, embed)
    )


# Assume anything else with at least 3 directories is a chapter
# so we can give lany and year specific error messages
@app.route("/<lang>/<year>/<path:chapter>")
@validate
def chapter(lang, year, chapter):
    config = get_config(year)
    chapter_config = get_chapter_config(config, chapter)
    (prev_chapter, next_chapter) = get_chapter_nextprev(config, chapter)
    return render_template(
        "%s/%s/chapters/%s.html" % (lang, year, chapter),
        config=config,
        prev_chapter=prev_chapter,
        next_chapter=next_chapter,
        chapter_config=chapter_config,
        slug=chapter
    )


@app.route("/robots.txt")
def static_from_root():
    return send_from_directory(app.static_folder, request.path[1:])


@app.route("/favicon.ico")
def default_favicon():
    return send_from_directory(app.static_folder, "images/favicon.ico")


# Redirect chapter favicon requests
# Dunno why this happens but see some of these in logs
@app.route("/static/images/<year>/<chapter>/favicon.ico")
def redirect_chapter_favicons(year, chapter):
    return redirect("/static/images/favicon.ico"), 301


# Redirect root level apple icons
# Dunno the this happens as not mandatory to be in root but let's redirect anyway
# https://stackoverflow.com/questions/25041622/does-the-apple-touch-icon-have-to-be-in-the-root-folder/25041921
@app.route("/apple-touch<string:appleicon>")
def redirect_apple_icons(appleicon):
    return redirect("/static/images/apple-touch-icon.png"), 301


# Redirect root level apple icons with slash
@app.route("/apple-touch<string:appleicon>/")
def redirect_apple_icons_slash(appleicon):
    return redirect("/static/images/apple-touch-icon.png"), 301


@app.route("/<lang>/<year>/ebook")
@validate
def ebook(lang, year):
    config = get_config(year)
    sorted_contributors = sorted(
        config["contributors"].items(), key=lambda items: items[1]["name"]
    )
    config["contributors"] = dict(sorted_contributors)
    return render_template("%s/%s/ebook.html" % (lang, year), config=config, slug="ebook")


# Redirect requests for http2 to new http URLs
@app.route("/static/images/20<int(fixed_digits=2):year>/http2/<image>")
def redirect_old_http2(year, image):
    return redirect("/static/images/20%s/http/%s" % (year, image)), 301


# Redirect requests for the older 2019 mage URLs to new URLs
@app.route(
    "/static/images/2019/<int(fixed_digits=2):chap_num>_<string:chap_name>/<image>"
)
def redirect_old_images(chap_num, chap_name, image):
    return (
        redirect(
            "/static/images/2019/%s/%s"
            % (convert_old_image_path(str(chap_num).zfill(2) + "_" + chap_name), image)
        ),
        301,
    )


# Redirect requests for the older image URLs to new URLs
@app.route(
    '/static/images/2019/<any("privacy","jamstack","capabilities"):folder>/<image>'
)
def redirect_old_hero_images(folder, image):
    return redirect("/static/images/2020/%s/%s" % (folder, image)), 301


# Redirect requests for the pdfs to GitHub
@app.route("/static/pdfs/<pdf>")
def redirect_pdfs(pdf):
    return redirect("https://cdn.httparchive.org/v1/static/almanac/ebooks/%s" % (pdf)), 301
