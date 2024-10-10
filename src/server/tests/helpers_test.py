from server.helpers import (
    get_file_date_info,
    get_versioned_filename,
    get_ebook_size_in_mb,
    chapter_lang_exists,
    page_lang_exists,
    featured_chapters_exists,
    get_chapter_nextprev,
    get_chapter_config,
    convert_old_image_path,
    add_footnote_links,
    year_live,
    get_previous_year,
    strip_accents,
    accentless_sort,
    render_template,
    render_error_template,
    get_ebook_methodology,
    plural_ru,
)
from server.config import (
    get_config,
    SUPPORTED_LANGUAGES,
    SUPPORTED_YEARS,
    get_entries_from_json,
)
from server.language import _Language
from server import app
from flask import request
import re
import pytest


MIN_DATE = "2019-11-01T00:00:00.000Z"

# Get all configured ebooks across all years - used to test all ebook sizes are correct later
all_ebooks = []
for year in SUPPORTED_YEARS:
    ebook_languages = get_entries_from_json(
        get_config(year), "settings", "ebook_languages"
    )[0]
    for ebook_language in ebook_languages:
        year_lang = [ebook_language, year]
        all_ebooks.append(year_lang)


def test_render_template_success():
    with app.test_request_context():
        render_call = render_template("en/2019/index.html", lang="en", year="2019")
        # Check it's a decent size with 'Web Almanac' somewhere in there
        assert len(render_call) > 3000 and "Web Almanac" in render_call


def test_render_template_no_chapter():
    # Note normally this would be caught by validate before render_template is called
    with app.test_request_context():
        request.full_path = "/en/2019/random"
        render_call = render_template(
            template="en/2019/chapters/random.html", lang="en", year="2019"
        )
        assert (
            render_call.status_code == 302
            and render_call.headers["Location"] == "/en/2019/"
        )


def test_render_template_translation_valid_chapter():
    with app.test_request_context():
        request.full_path = "/es/2019/css"
        render_call = render_template(
            template="es/2019/chapters/css.html",
            lang="es",
            year="2019",
            chapter_config="",
        )
        assert len(render_call) > 3000 and '<html lang="es"' in render_call


def test_render_template_no_translation_valid_chapter():
    with app.test_request_context():
        request.full_path = "/es/2019/css"
        # Use a fake template that won't ever be found by overriding lang to 99
        render_call = render_template(
            template="99/2019/chapters/css.html", lang="es", year="2019"
        )
        assert (
            render_call.status_code == 302
            and render_call.headers["Location"] == "/en/2019/css"
        )


def test_render_template_no_translation_invalid_chapter():
    with app.test_request_context():
        request.full_path = "/es/2019/random"
        render_call = render_template(
            template="es/2019/chapters/random.html", lang="es", year="2019"
        )
        assert (
            render_call.status_code == 302
            and render_call.headers["Location"] == "/es/2019/"
        )


def test_render_error_template_404():
    with app.test_request_context():
        render_call = render_error_template(error="Not Found", status_code=404)
        assert render_call[1] == 404


def test_render_error_template_404_es():
    with app.test_request_context():
        request.view_args = {"lang": "es", "year": "2019"}
        render_call = render_error_template(error="Not Found", status_code=404)
        assert render_call[1] == 404 and '<html lang="es"' in render_call[0]


def test_render_error_template_404_bad_lang():
    with app.test_request_context():
        request.view_args = {"lang": "12", "year": "2019"}
        render_call = render_error_template(error="Not Found", status_code=404)
        assert render_call[1] == 404 and '<html lang="en"' in render_call[0]


def test_render_error_template_404_bad_year():
    with app.test_request_context():
        request.view_args = {"lang": "en", "year": "2018"}
        render_call = render_error_template(error="Not Found", status_code=404)
        assert render_call[1] == 404 and '<html lang="en"' in render_call[0]


def test_render_error_template_404_bad_lang_and_year():
    with app.test_request_context():
        request.view_args = {"lang": "12", "year": "2018"}
        render_call = render_error_template(error="Not Found", status_code=404)
        assert render_call[1] == 404 and '<html lang="en"' in render_call[0]


def test_render_error_template_404_no_error_template():
    with app.test_request_context():
        # As all languages should have an error template we fake a new "valid" language called random
        request.view_args = {"lang": "random", "year": "2020"}

        class Language(object):
            EN = _Language("English", "en")
            RANDOM = _Language("Random", "random")

        Languages = []
        Languages.append(getattr(Language, "EN"))
        Languages.append(getattr(Language, "RANDOM"))
        SUPPORTED_LANGUAGES.update({"2020": Languages})
        render_call = render_error_template(error="Not Found", status_code=404)
        assert render_call[1] == 404 and '<html lang="en"' in render_call[0]


def test_chapter_lang_exists():
    assert chapter_lang_exists("en", "2019", "css") is True


def test_chapter_lang_not_exists():
    assert chapter_lang_exists("en", "2019", "random") is False


def test_page_lang_exists():
    assert page_lang_exists("en", "2019", "methodology") is True


def test_page_lang_not_exists():
    assert page_lang_exists("en", "2019", "random") is False


def test_featured_chapters_exists():
    assert featured_chapters_exists("en", "2019") is True


def test_featured_chapters_not_exists():
    assert featured_chapters_exists("random", "2019") is False


def test_get_chapter_nextprev_1st_chapter():
    nextprev = get_chapter_nextprev(get_config("2019"), "javascript")
    prev_slug = nextprev[0]
    next_slug = nextprev[1]["slug"]
    assert next_slug == "css" and prev_slug is None


def test_get_chapter_nextprev_mid_chapter():
    nextprev = get_chapter_nextprev(get_config("2019"), "css")
    prev_slug = nextprev[0]["slug"]
    next_slug = nextprev[1]["slug"]
    assert next_slug == "markup" and prev_slug == "javascript"


def test_get_chapter_nextprev_last_chapter():
    nextprev = get_chapter_nextprev(get_config("2019"), "http")
    prev_slug = nextprev[0]["slug"]
    next_slug = nextprev[1]
    assert next_slug is None and prev_slug == "resource-hints"


def test_get_chapter_nextprev_unknown_chapter():
    nextprev = get_chapter_nextprev(get_config("2019"), "random")
    prev_slug = nextprev[0]
    next_slug = nextprev[1]
    assert prev_slug is None and next_slug is None


def test_get_valid_chapter_config():
    chapter_config = get_chapter_config(get_config("2019"), "javascript")
    assert chapter_config is not None


def test_get_invalid_chapter_config():
    chapter_config = get_chapter_config(get_config("2019"), "random")
    assert chapter_config is None


def test_get_chapter_config_no_hero_dir():
    chapter_config = get_chapter_config(get_config("2020"), "javascript")
    assert chapter_config.get("hero_dir") is None


def test_get_chapter_config_hero_dir():
    chapter_config = get_chapter_config(get_config("2020"), "jamstack")
    assert chapter_config.get("hero_dir") == "2020"


def test_convert_old_image_path_http():
    new_folder = convert_old_image_path("20_HTTP_2")
    assert new_folder == "http"


def test_convert_old_image_path_fake_css():
    new_folder = convert_old_image_path("99_CSS")
    assert new_folder == "css"


def test_convert_old_image_path_random():
    new_folder = convert_old_image_path("99_RANDOM")
    assert new_folder == "random"


def test_render_methodology():
    with app.test_request_context():
        render_call = get_ebook_methodology("en", "2019")
        # Check it's a decent size with 'Web Almanac' somewhere in there
        assert len(render_call) > 3000 and "Web Almanac" in render_call


def test_render_methodology_bad_year():
    with app.test_request_context():
        render_call = get_ebook_methodology("en", "2018")
        assert render_call is False


def test_render_methodology_bad_lang():
    with app.test_request_context():
        render_call = get_ebook_methodology("random", "2019")
        assert render_call is False


def test_render_methodology_bad_year_lang():
    with app.test_request_context():
        render_call = get_ebook_methodology("random", "2018")
        assert render_call is False


def test_add_footnote_links():
    footnote_html = add_footnote_links('<a href="http://example.com">linktext</a>')
    assert (
        footnote_html
        == '<a href="http://example.com">linktext</a><span class="fn">http://example.com</span>'
    )


def test_year_live_2018():
    assert year_live("2018") is False


def test_year_live_2019():
    assert year_live("2019") is True


def test_year_live_2020():
    assert year_live("2020") is True


def test_previous_year_2018():
    assert get_previous_year("2018") is None


def test_previous_year_2019():
    assert get_previous_year("2019") is None


def test_previous_year_2022():
    assert get_previous_year("2022") == "2021"


def test_previous_year_2024():
    assert get_previous_year("2024") == "2022"


def test_strip_accents_fr_edition():
    assert strip_accents("Édition") == "Edition"


def test_strip_accents_en_edition():
    assert strip_accents("Edition") == "Edition"


def test_accentless_sort():
    unsorted_french_teams_dict = {
        "analysts": "Analyse",
        "authors": "Rédaction",
        "brainstormers": "Réflexion",
        "designers": "Design",
        "developers": "Développement",
        "editors": "Édition",
        "leads": "Gestion de projet",
        "reviewers": "Relecture",
        "translators": "Traduction",
    }
    sorted_french_teams_list = [
        ("analysts", "Analyse"),
        ("designers", "Design"),
        ("developers", "Développement"),
        ("editors", "Édition"),
        ("leads", "Gestion de projet"),
        ("authors", "Rédaction"),
        ("brainstormers", "Réflexion"),
        ("reviewers", "Relecture"),
        ("translators", "Traduction"),
    ]
    assert (
        accentless_sort(unsorted_french_teams_dict.items()) == sorted_french_teams_list
    )


def test_date_published_is_returned_and_correct_format():
    pattern = re.compile(
        r"^20[0-9]{2}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}.[0-9]{3}Z$"
    )
    date_published = get_file_date_info("en/2019/index.html", "date_published")
    assert pattern.match(date_published)


def test_date_modified_is_returned_and_correct_format():
    pattern = re.compile(
        r"^20[0-9]{2}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}.[0-9]{3}Z$"
    )
    date_modified = get_file_date_info("en/2019/index.html", "date_modified")
    assert pattern.match(date_modified)


def test_date_published_is_larger_than_min_date():
    date_published = get_file_date_info("en/2019/index.html", "date_published")
    assert date_published > MIN_DATE


def test_date_modified_is_larger_than_min_date():
    date_modified = get_file_date_info("en/2019/index.html", "date_modified")
    assert date_modified > MIN_DATE


def test_hash_is_returned_and_correct_format():
    pattern = re.compile(r"^[0-9a-f]{32}$")
    hash = get_file_date_info("en/2019/index.html", "hash")
    assert pattern.match(hash)


def test_random_value_is_returned_as_none():
    assert get_file_date_info("en/2019/index.html", "rubbish") is None


def test_en_ebook_size_at_least_16_mb_info():
    assert get_file_date_info("/static/pdfs/web_almanac_2019_en.pdf", "size") > 16


def test_versioned_css_file_is_of_correct_format():
    pattern = re.compile(r"^/static/css/almanac.css\?v=[0-9a-f]{32}$")
    versioned_filename = get_versioned_filename("/static/css/almanac.css")
    assert pattern.match(versioned_filename)


def test_non_versioned_css_file_is_of_correct_format():
    versioned_filename = get_versioned_filename("/static/css/random.css")
    assert versioned_filename == "/static/css/random.css"


def test_en_ebook_size_at_least_16_mb():
    assert get_ebook_size_in_mb("en", "2019") > 16


@pytest.mark.parametrize("config", all_ebooks)
def test_all_configured_ebooks_at_least_16_mb(config):
    assert get_ebook_size_in_mb(config[0], config[1]) > 16


def test_ebook_size_non_existant_language_is_zero():
    assert get_ebook_size_in_mb("rubbish", "2019") == 0


def test_ebook_size_non_existant_year_is_zero():
    assert get_ebook_size_in_mb("en", "rubbish") == 0


def test_ebook_size_non_existant_language_and_year_is_zero():
    assert get_ebook_size_in_mb("rubbish", "rubbish") == 0


def test_russian_singlar():
    assert plural_ru(1, ["участник", "участника", "участников"]) == "участник"


def test_russian_ends_in_eleven():
    assert plural_ru(11, ["участник", "участника", "участников"]) == "участников"


def test_russian_two():
    assert plural_ru(2, ["участник", "участника", "участников"]) == "участника"


def test_russian_seven():
    assert plural_ru(7, ["участник", "участника", "участников"]) == "участников"
