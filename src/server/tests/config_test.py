from server.config import get_config, get_chapters, get_languages, get_live, \
    SUPPORTED_YEARS, SUPPORTED_CHAPTERS, SUPPORTED_LANGUAGES


test_year = ['2020', '2019', '2018']


def test_get_config_year():
    assert get_config(test_year[0]) is not None
    assert get_config(test_year[1]) is not None
    assert get_config(test_year[2]) is None


def test_static_avatar():
    for contributor in get_config('2020'):
        if contributor == 'michelleoconnor':
            static_url = contributor['avatar_url']
            assert static_url is not None and static_url.startswith('/static')


def test_get_config_in_supported_year():
    for year in SUPPORTED_YEARS:
        assert get_config(year) is not None


def test_get_chapters_in_supported_chapters():
    for year in SUPPORTED_YEARS:
        for chapter in get_chapters(get_config(year)):
            assert chapter in SUPPORTED_CHAPTERS[year]


def test_get_languages_in_supported_languages():
    for year in SUPPORTED_YEARS:
        for language in get_languages(get_config(year)):
            assert language in SUPPORTED_LANGUAGES[year]


def test_get_live():
    for year in SUPPORTED_YEARS:
        assert get_live(get_config(year)) is True
