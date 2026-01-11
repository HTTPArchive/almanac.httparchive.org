from server import app, talisman
from server.config import DEFAULT_YEAR
from server.language import DEFAULT_LANGUAGE
import pytest


# Create test client without https redirect
# (normally taken care of by running in debug)
@pytest.fixture
def client():
    with app.test_client() as client:
        talisman.force_https = False
        yield client


# Add a function to test routes with optional location
def assert_route(client, path, status, location=None):
    response = client.get(path)
    redirect_loc = response.location
    if redirect_loc:
        redirect_loc = redirect_loc.replace("http://localhost", "")
    if location is not None:
        assert response.status_code == status and redirect_loc == location
    else:
        assert response.status_code == status


# All the tests


def test_render_en_2019_home(client):
    assert_route(client, "/en/2019/", 200)


def test_render_invalid_lang_year(client):
    assert_route(client, "/en/random/", 404)


def test_render_en_home(client):
    assert_route(client, "/en/", 302, "/en/" + DEFAULT_YEAR + "/")


def test_render_en_no_slash_home(client):
    assert_route(client, "/en", 308, "/en/")


def test_render_invalid_lang_home(client):
    assert_route(client, "/random/", 404)


def test_render_invalid_lang_year_home(client):
    assert_route(client, "/random/random/", 404)


def test_render_invalid_lang__valid_year_home(client):
    assert_route(client, "/random/2019/", 404)


def test_render_home(client):
    assert_route(
        client, "/", 302, "/" + DEFAULT_LANGUAGE.lang_code + "/" + DEFAULT_YEAR + "/"
    )


def test_render_en_2019_toc(client):
    assert_route(client, "/en/2019/table-of-contents", 200)


def test_render_en_2019_toc_slash(client):
    assert_route(
        client, "/en/2019/table-of-contents/", 302, "/en/2019/table-of-contents"
    )


def test_render_en_default_year_toc(client):
    assert_route(client, "/en/" + DEFAULT_YEAR + "/table-of-contents", 200)


def test_render_en_2019_contributors(client):
    assert_route(client, "/en/2019/contributors", 200)


def test_render_en_2019_contributors_slash(client):
    assert_route(client, "/en/2019/contributors/", 302, "/en/2019/contributors")


def test_render_en_default_year_contributors(client):
    assert_route(client, "/en/" + DEFAULT_YEAR + "/contributors", 200)


def test_render_en_2019_meth(client):
    assert_route(client, "/en/2019/methodology", 200)


def test_render_caps_en_2019_meth(client):
    assert_route(client, "/EN/2019/methodology", 302, "/en/2019/methodology")


def test_render_en_default_year_meth(client):
    assert_route(client, "/en/" + DEFAULT_YEAR + "/methodology", 200)


def test_render_en_accessibility_statement(client):
    assert_route(client, "/en/accessibility-statement", 200)


def test_render_en_accessibility_statement_slash(client):
    assert_route(
        client, "/en/accessibility-statement/", 301, "/en/accessibility-statement"
    )


def test_render_search(client):
    response = client.get("/en/search")
    assert response.status_code == 200


def test_render_search_slash(client):
    assert_route(client, "/en/search/", 301, "/en/search")


def test_render_search_year(client):
    assert_route(client, "/en/2020/search", 301, "/en/search")


def test_render_search_year_slash(client):
    assert_route(client, "/en/2020/search/", 301, "/en/search")


def test_render_sitemap(client):
    assert_route(client, "/sitemap.xml", 200)


def test_render_en_rss(client):
    assert_route(client, "/en/rss.xml", 200)


def test_render_base_rss(client):
    assert_route(client, "/base/rss.xml", 404)


def test_render_en_2019_good_chapter(client):
    assert_route(client, "/en/2019/css", 200)


def test_render_en_2019_bad_chapter(client):
    assert_route(client, "/en/2019/random", 404)


def test_render_en_2019_good_chapter_slash(client):
    assert_route(client, "/en/2019/css/", 302, "/en/2019/css")


def test_redirect_untranslated_chapter(client):
    assert_route(client, "/nl/2019/http", 302, "/en/2019/http")


def test_redirect_untranslated_chapter_qith_queryparam(client):
    assert_route(client, "/nl/2019/http?queryparam", 302, "/en/2019/http?queryparam")


def test_render_robots(client):
    assert_route(client, "/robots.txt", 200)


def test_render_favicon(client):
    assert_route(client, "/favicon.ico", 200)


def test_apple_icon_redirect(client):
    assert_route(
        client, "/apple-touch-icon.png", 301, "/static/images/apple-touch-icon.png"
    )


def test_apple_icon_redirect_with_slash(client):
    assert_route(
        client, "/apple-touch-icon.png/", 301, "/static/images/apple-touch-icon.png"
    )


def test_chapter_favicon_redirect(client):
    assert_route(
        client, "/static/images/2021/css/favicon.ico", 301, "/static/images/favicon.ico"
    )


def test_render_en_2019_ebook(client):
    assert_route(client, "/en/2019/ebook", 200)


def test_render_old_image_dir_redirect(client):
    assert_route(
        client,
        "/static/images/2019/02_CSS/random.png",
        301,
        "/static/images/2019/css/random.png",
    )


def test_render_pdf_redirect(client):
    assert_route(
        client,
        "/static/pdfs/web_almanac_2019_en_cover_A5.pdf",
        301,
        "https://cdn.httparchive.org/v1/static/almanac/ebooks/web_almanac_2019_en_cover_A5.pdf",
    )


def test_render_old_http_image_dir_redirect(client):
    assert_route(
        client,
        "/static/images/2020/http2/random.png",
        301,
        "/static/images/2020/http/random.png",
    )


def test_render_old_hero_image_dir_redirect(client):
    assert_route(
        client,
        "/static/images/2019/jamstack/random.png",
        301,
        "/static/images/2020/jamstack/random.png",
    )


def test_render_en_2020_story(client):
    response = client.get("/en/2020/stories/page-content")
    assert (
        response.status_code == 200
        and response.headers.get("X-Frame-Options") is None
        and "frame-ancestors *" in response.headers.get("Content-Security-Policy")
    )


def test_render_efonts_cache_control(client):
    response = client.get("/static/fonts/Poppins-Bold.woff2")
    assert response.status_code == 200 and "max-age=3153600" in response.headers.get(
        "Cache-Control"
    )


def test_test_webvitals_js(client):
    response = client.get("/static/js/web-vitals.js")
    assert response.status_code == 200


def test_test_webvitals_js_versioned(client):
    response = client.get("/static/js/web-vitals.js?v=1234")
    assert response.status_code == 200


def test_embed(client):
    response = client.get("/en/2022/embeds/structured-data-sankey")
    assert response.status_code == 200
