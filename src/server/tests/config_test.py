from server.config import get_config, get_chapters, get_languages, get_live, SUPPORTED_YEARS, SUPPORTED_CHAPTERS, SUPPORTED_LANGUAGES

def test_get_config_in_suppoted_year():
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
        assert get_live(get_config(year)) == True
