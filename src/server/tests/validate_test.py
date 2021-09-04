from server.config import DEFAULT_YEAR, SUPPORTED_YEARS
from server.language import Language, DEFAULT_LANGUAGE
from server.validate import parse_accept_language, validate_lang_and_year, validate_chapter
import pytest
from werkzeug.exceptions import NotFound


SUPPORTED_LANGUAGES = (Language.EN.lang_code, Language.JA.lang_code)
DEFAULT_LANGUAGE_CODE = DEFAULT_LANGUAGE.lang_code
JAPANESE_LANGUAGE_CODE = Language.JA.lang_code
ENGLISH_LANGUAGE_CODE = Language.EN.lang_code


def assert_validate_chapter(chapter, year, expected_chapter):
    assert expected_chapter == validate_chapter(chapter, year)


def assert_validate_lang(lang, year, expected_lang, expected_year):
    assert (expected_lang, expected_year) == validate_lang_and_year(lang, year)


def assert_language(accept_language_header, expected_lang):
    lang = parse_accept_language(accept_language_header, SUPPORTED_LANGUAGES)
    assert lang == expected_lang


def test_supports_default_year():
    assert DEFAULT_YEAR in SUPPORTED_YEARS


def test_returns_default_language_if_none_specified():
    assert_language(None, DEFAULT_LANGUAGE_CODE)


def test_returns_default_language_if_all_specified():
    assert_language('*', DEFAULT_LANGUAGE_CODE)


def test_returns_default_language_if_invalid_code_specified():
    assert_language('this is a test', DEFAULT_LANGUAGE_CODE)


def test_returns_default_language_if_unsupported_code_specified():
    assert_language('de', DEFAULT_LANGUAGE_CODE)


def test_returns_correct_language_if_simple_code_specified():
    assert_language('ja', JAPANESE_LANGUAGE_CODE)


def test_returns_correct_language_if_locale_is_specified():
    assert_language('ja-JP', JAPANESE_LANGUAGE_CODE)


def test_returns_correct_language_if_quality_is_specified():
    assert_language('ja-JP;q=0.5', JAPANESE_LANGUAGE_CODE)


def test_returns_correct_language_if_multiple_codes_are_specified():
    assert_language('ja-JP;q=0.5,en,en-GB;q=0.5', ENGLISH_LANGUAGE_CODE)


def test_returns_correct_language_if_multiple_codes_with_spaces_are_specified():
    assert_language('ja-JP;q=0.5, en, en-GB;q=0.5', ENGLISH_LANGUAGE_CODE)


def test_returns_best_match_language_if_multiple_codes_are_specified():
    assert_language('de-DE,ko-KR,ja-JP,en-GB;q=0.5', JAPANESE_LANGUAGE_CODE)


def test_returns_default_if_multiple_codes_are_specified_but_none_supported():
    assert_language('de-DE, ko-KR', DEFAULT_LANGUAGE_CODE)


def test_returns_same_year_and_lang_if_supported():
    assert_validate_lang('en', '2019', 'en', '2019')


def test_returns_lowercase_lang():
    assert_validate_lang('EN', '2019', 'en', '2019')


def test_returns_lang_without_country_when_supported():
    assert_validate_lang('en-GB', '2019', 'en', '2019')


def test_returns_preferred_simplified_chinese():
    assert_validate_lang('zh-SG', '2019', 'zh-CN', '2019')


def test_returns_preferred_traditional_chinese():
    assert_validate_lang('zh-TW', '2019', 'zh-TW', '2019')


def test_returns_preferred_traditional_chinese_from_CHT():
    assert_validate_lang('zh-CHT', '2019', 'zh-TW', '2019')


def test_returns_preferred_chinese():
    assert_validate_lang('zh', '2019', 'zh-CN', '2019')


def test_returns_default_year():
    assert_validate_lang('en', None, 'en', DEFAULT_YEAR)


def test_valid_chapter():
    assert_validate_chapter('javascript', '2019', 'javascript')


def test_valid_chapter_future_year():
    assert_validate_chapter('javascript', '2999', '')


def test_invalid_chapter():
    with pytest.raises(NotFound):
        assert_validate_chapter('random', '2019', 'javascript')


def test_typo_chapter():
    assert_validate_chapter('http-2', '2019', 'http')


def test_typo_chapter2():
    assert_validate_chapter('http2', '2020', 'http')


def test_uppercase_chapter():
    assert_validate_chapter('Javascript', '2019', 'javascript')


def test_miduppercase_chapter():
    assert_validate_chapter('JavaScript', '2019', 'javascript')


def test_2020_chapter():
    assert_validate_chapter('capabilities', '2020', 'capabilities')


def test_2020_chapter_not_in_2019():
    with pytest.raises(NotFound):
        assert_validate_chapter('capabilities', '2019', 'capabilities')
