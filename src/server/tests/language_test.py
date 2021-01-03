from server.language import DEFAULT_LANGUAGE, Language


def test_language_equality():
    assert DEFAULT_LANGUAGE == DEFAULT_LANGUAGE


def test_language_inequality():
    assert Language.EN != Language.FR


def test_language_inequality_nonlanguage():
    assert Language != Language.EN


def test_language_name():
    assert str(Language.EN) == 'English'


def test_language_attribute():
    assert str(Language.EN.lang_attribute) == 'en'
