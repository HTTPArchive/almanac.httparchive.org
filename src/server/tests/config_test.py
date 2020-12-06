from server.config import get_config, get_chapters, get_languages, get_live, \
    SUPPORTED_YEARS, SUPPORTED_CHAPTERS, SUPPORTED_LANGUAGES
import pytest


def test_get_config_year():
    assert get_config('2020') is not None
    assert get_config('2019') is not None
    assert get_config('2018') is None


def test_static_avatar():
    # For this test we use an existing contributor with no avatar as they should be assigned one on initial load
    static_url = get_config('2020').get('contributors').get('michelleoconnor').get('avatar_url')
    assert static_url is not None and static_url.startswith('/static/images/avatars/')


def test_get_config_for_all_supported_years():
    for year in SUPPORTED_YEARS:
        assert get_config(year) is not None


def test_get_chapters_for_all_supported_chapters():
    for year in SUPPORTED_YEARS:
        for chapter in get_chapters(get_config(year)):
            assert chapter in SUPPORTED_CHAPTERS[year]


def test_get_chapters_good_chapter():
    assert 'javascript' in get_chapters(get_config('2019'))


def test_get_chapters_bad_chapter():
    assert 'random' not in get_chapters(get_config('2019'))


def test_get_languages_for_all_supported_languages():
    for year in SUPPORTED_YEARS:
        for language in get_languages(get_config(year)):
            assert language in SUPPORTED_LANGUAGES[year]


def test_get_languages_good_and_bad():
    languages = [str(language) for language in get_languages(get_config('2019'))]
    assert 'English' in languages
    assert 'random' not in languages


def test_get_live_for_all_supported_years():
    for year in SUPPORTED_YEARS:
        assert get_live(get_config(year)) is True


def test_get_live_for_known_years():
    assert get_live(get_config('2019')) is True
    assert get_live(get_config('2020')) is True


def test_get_live_for_bad_year_raises_error():
    with pytest.raises(TypeError):
        get_live(get_config('2018'))
