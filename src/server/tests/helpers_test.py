from server.helpers import get_file_date_info, get_versioned_filename, get_ebook_size_in_mb
import re

MIN_DATE="2019-11-01T00:00:00.000Z"


def test_date_published_is_returned_and_correct_format():
    pattern = re.compile(r"^20[0-9]{2}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}.[0-9]{3}Z$")
    date_published = get_file_date_info('en/2019/index.html', 'date_published')
    assert pattern.match(date_published)


def test_date_modified_is_returned_and_correct_format():
    pattern = re.compile(r"^20[0-9]{2}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}.[0-9]{3}Z$")
    date_modified = get_file_date_info('en/2019/index.html', 'date_modified')
    assert pattern.match(date_modified)


def test_date_published_is_larger_than_min_date():
    date_published = get_file_date_info('en/2019/index.html', 'date_published')
    assert date_published > MIN_DATE


def test_date_modified_is_larger_than_min_date():
    date_modified = get_file_date_info('en/2019/index.html', 'date_modified')
    assert date_modified > MIN_DATE


def test_hash_is_returned_and_correct_format():
    pattern = re.compile(r"^[0-9a-f]{32}$")
    hash = get_file_date_info('en/2019/index.html', 'hash')
    assert pattern.match(hash)


def test_random_value_is_returned_as_none():
    assert get_file_date_info('en/2019/index.html', 'rubbish') == None


def test_en_ebook_size_at_least_16_mb_info():
    assert get_file_date_info('/static/pdfs/web_almanac_2019_en.pdf', 'size') > 16


def test_versioned_css_file_is_of_correct_format():
    pattern = re.compile(r"^/static/css/2019.css\?v=[0-9a-f]{32}$")
    versioned_filename = get_versioned_filename('/static/css/2019.css')
    assert pattern.match(versioned_filename);


def test_non_versioned_css_file_is_of_correct_format():
    versioned_filename = get_versioned_filename('/static/css/random.css')
    assert versioned_filename == '/static/css/random.css'


def test_en_ebook_size_at_least_16_mb_function():
    assert get_ebook_size_in_mb('en','2019') > 16


def test_ja_ebook_size_at_least_16_mb_function():
    assert get_ebook_size_in_mb('ja','2019') > 16


def test_ebook_size_non_existant_language_is_zero():
    assert get_ebook_size_in_mb('rubbish','2019') == 0


def test_ebook_size_non_existant_year_is_zero():
    assert get_ebook_size_in_mb('en','rubbish') == 0


def test_ebook_size_non_existant_language_and_year_is_zero():
    assert get_ebook_size_in_mb('rubbish','rubbish') == 0
