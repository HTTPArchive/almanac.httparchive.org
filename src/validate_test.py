from validate import parse_accept_language

supported_languages = ['en', 'ja']


def assert_language(accept_language_header, expected_lang):
    lang = parse_accept_language(accept_language_header, supported_languages)

    assert lang == expected_lang


def test_returns_default_language_if_none_specified():
    assert_language(None, 'en')


def test_returns_default_language_if_all_specified():
    assert_language('*', 'en')


def test_returns_default_language_if_invalid_code_specified():
    assert_language('this is a test', 'en')


def test_returns_default_language_if_unsupported_code_specified():
    assert_language('de', 'en')


def test_returns_correct_language_if_simple_code_specified():
    assert_language('ja', 'ja')


def test_returns_correct_language_if_locale_is_specified():
    assert_language('ja-JP', 'ja')


def test_returns_correct_language_if_quality_is_specified():
    assert_language('ja-JP;q=0.5', 'ja')


def test_returns_correct_language_if_multiple_codes_are_specified():
    assert_language('ja-JP;q=0.5,en,en-GB;q=0.5', 'ja')


def test_returns_correct_language_if_multiple_codes_with_spaces_are_specified():
    assert_language('ja-JP;q=0.5, en, en-GB;q=0.5', 'ja')


def test_returns_best_match_language_if_multiple_codes_are_specified():
    assert_language('de-DE,ko-KR,ja-JP,en-GB;q=0.5', 'ja')


def test_returns_default_if_multiple_codes_are_specified_but_none_supported():
    assert_language('de-DE, ko-KR', 'en')
