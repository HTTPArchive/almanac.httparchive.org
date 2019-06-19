import logging
import re

from flask import request
from werkzeug.exceptions import abort
from functools import wraps

DEFAULT_YEAR = '2019'
DEFAULT_LANG = 'en'
SUPPORTED_YEARS = {
    '2019': ('en', 'ja')
}


def validate_i18n(func):
    @wraps(func)
    def decorated_function(*args, **kwargs):
        lang = kwargs.get('lang')
        year = kwargs.get('year')

        updated_kwargs = validate(lang, year)

        kwargs.update(updated_kwargs)

        return func(*args, **kwargs)

    return decorated_function


def validate(lang, year):
    if year is None:
        logging.debug('Defaulting the year to: %s' % year)
        year = DEFAULT_YEAR

    if year not in SUPPORTED_YEARS:
        logging.debug('Unsupported year requested: %s' % year)
        abort(404)

    supported_langs = SUPPORTED_YEARS[year]
    logging.debug('Languages supported for %s: %s.' % (year, supported_langs))

    # If an unsupported language code is passed in, abort.
    # TODO: Should we still redirect back to default?
    if lang is not None and lang not in supported_langs:
        logging.debug('Unsupported language set: %s.' % lang)
        abort(404)

    if lang is None:
        # Extract the language from the Accept-Language header.
        lang = parse_accept_language(supported_langs)

    logging.debug('Using lang: "%s" and year: "%s" ' % (lang, year))

    return {'lang': lang, 'year': year}


def parse_accept_language(supported_langs):
    # Try and extract the language out of the header. The regex below will pull the
    # alpha characters out of the start of the string, after a comma, or after a space.
    # It may not be exhaustive, and will require testing.

    logging.debug('Trying to extract Accept-Language header.')

    header = request.headers.get('Accept-Language')
    accepted_languages = re.findall('(?:^|\s|,)(\w+)', header)

    logging.debug('Accepted languages: %s' % accepted_languages)

    # The header could contain multiple languages, in order of precedence
    for lang in accepted_languages:
        if lang in supported_langs:
            # Return the first found supported language.
            logging.debug('Using "%s" as the highest precedent language.' % lang)
            return lang

    # If all else fails, default the language.
    return DEFAULT_LANG
