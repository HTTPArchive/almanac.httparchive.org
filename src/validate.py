import logging
import re
import inspect

from flask import request, abort
from functools import wraps
from language import Language, DEFAULT_LANGUAGE

DEFAULT_YEAR = '2019'
SUPPORTED_YEARS = {
    '2019': (Language.ENGLISH, Language.JAPANESE)
}


def validate(func):
    @wraps(func)
    def decorated_function(*args, **kwargs):
        lang = kwargs.get('lang')
        year = kwargs.get('year')

        accepted_args = inspect.getargspec(func).args

        lang, year = validate_lang_and_year(lang, year)

        if 'lang' in accepted_args:
            kwargs.update({'lang': lang})

        if 'year' in accepted_args:
            kwargs.update({'year': year})

        return func(*args, **kwargs)

    return decorated_function


def validate_lang_and_year(lang, year):
    if year is None:
        logging.debug('Defaulting the year to: %s' % year)
        year = DEFAULT_YEAR

    if year not in SUPPORTED_YEARS:
        logging.debug('Unsupported year requested: %s' % year)
        abort(404, 'Unsupported year requested')

    supported_langs = [l.lang_code for l in SUPPORTED_YEARS.get(year)]
    logging.debug('Languages supported for %s: %s.' % (year, supported_langs))

    # If an unsupported language code is passed in, abort.
    if lang is not None and lang not in supported_langs:
        logging.debug('Unsupported language set: %s.' % lang)
        # TODO: Return this as an  error message to the user, and display
        # it in the custom error page.
        abort(404)

    if lang is None:
        # Extract the language from the Accept-Language header.
        accept_language_header = request.headers.get('Accept-Language')
        lang = parse_accept_language(accept_language_header, supported_langs)

    logging.debug('Using lang: "%s" and year: "%s" ' % (lang, year))

    return lang, year


def parse_accept_language(header, supported_langs):
    # Try and extract the language out of the header. The regex below will pull the
    # alpha characters out of the start of the string, after a comma, or after a space.
    # It may not be exhaustive, and will require testing.

    logging.debug('Trying to extract Accept-Language header.')

    if header is not None:

        accepted_languages = re.findall('(?:^|\s|,)(\w+)', header)

        logging.debug('Accepted languages: %s' % accepted_languages)

        # The header could contain multiple languages, in order of precedence
        # Limit the number of accepted languages tested to 10.
        for lang in accepted_languages[:10]:
            if lang in supported_langs:
                # Return the first found supported language.
                logging.debug('Using "%s" as the highest precedent language.' % lang)
                return lang

    # If all else fails, default the language.
    return DEFAULT_LANGUAGE.lang_code
