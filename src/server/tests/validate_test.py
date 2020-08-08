from server.config import DEFAULT_YEAR, SUPPORTED_YEARS
from server.language import Language, DEFAULT_LANGUAGE
from server.validate import parse_accept_language


SUPPORTED_LANGUAGES = (Language.EN.lang_code, Language.JA.lang_code)
DEFAULT_LANGUAGE_CODE = DEFAULT_LANGUAGE.lang_code
JAPANESE_LANGUAGE_CODE = Language.JA.lang_code
ENGLISH_LANGUAGE_CODE = Language.EN.lang_code


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
    assert_language('ja-JP',JAPANESE_LANGUAGE_CODE)


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
