import logging
import re
import inspect

from flask import request, abort, redirect
from functools import wraps
from language import Language, DEFAULT_LANGUAGE

from config import SUPPORTED_YEARS, DEFAULT_YEAR, SUPPORTED_CHAPTERS, SUPPORTED_LANGUAGES

TYPO_CHAPTERS = {
    'http-2': 'http2',
    'mobileweb': 'mobile-web',
    'pageweight': 'page-weight',
    'resourcehints': 'resource-hints',
    'thirdparties': 'third-parties',
    'third-party': 'third-parties',
    'sécurité': 'security'
}


def validate(func):
    @wraps(func)
    def decorated_function(*args, **kwargs):
        lang = kwargs.get('lang')
        year = kwargs.get('year')
        chapter = kwargs.get('chapter')

        accepted_args = inspect.getargspec(func).args

        lang, year = validate_lang_and_year(lang, year)

        if 'lang' in accepted_args:
            kwargs.update({'lang': lang})

        if 'year' in accepted_args:
            kwargs.update({'year': year})

        if chapter:

            validated_chapter = validate_chapter(chapter, year)

            if chapter != validated_chapter:
                return redirect('/%s/%s/%s' % (lang, year, validated_chapter), code=302)

        return func(*args, **kwargs)

    return decorated_function


def validate_chapter(chapter,year):
    chapters_for_year = SUPPORTED_CHAPTERS.get(year)
    if chapter not in chapters_for_year:
        if (chapter[-1] == "/"):
            # Automatically remove any trailing slashes
            return chapter[:-1]
        elif chapter in TYPO_CHAPTERS:
            # Automatically redirect for configured typos
            logging.debug('Typo chapter requested: %s, redirecting to %s' % (chapter, TYPO_CHAPTERS.get(chapter)))
            return TYPO_CHAPTERS.get(chapter)
        else:
            logging.debug('Unsupported chapter requested: %s' % chapter)
            abort(404, 'Unsupported chapter requested')
    
    return chapter


def validate_lang_and_year(lang, year):
    if year is None:
        logging.debug('Defaulting the year to: %s' % year)
        year = DEFAULT_YEAR

    if year not in SUPPORTED_YEARS:
        logging.debug('Unsupported year requested: %s' % year)
        abort(404, 'Unsupported year requested')

    supported_langs = [l.lang_code for l in (SUPPORTED_LANGUAGES.get(year) or [DEFAULT_LANGUAGE])]

    # If an unsupported language code is passed in, abort.
    if lang is not None and lang not in supported_langs:
        logging.debug('Unsupported language set: %s.' % lang)
        abort(404, 'Unsupported language requested')

    if lang is None:
        # Extract the language from the Accept-Language header.
        accept_language_header = request.headers.get('Accept-Language')
        lang = parse_accept_language(accept_language_header, supported_langs)

    return lang, year


def parse_accept_language(header, supported_langs):
    # Try and extract the language out of the header. The regex below will pull the
    # alpha characters out of the start of the string, after a comma, or after a space.
    # It may not be exhaustive, and will require testing.

    logging.debug('Trying to extract Accept-Language header.')

    if header is not None:

        # Looks for languages of the format en or en-US first
        accepted_languages = re.findall(r'(?:^|\s|,)(\w+-?\w*)', header)
        logging.debug('Accepted languages: %s' % accepted_languages)

        # The header could contain multiple languages, in order of precedence
        # Limit the number of accepted languages tested to 10.
        for lang in accepted_languages[:10]:
            if lang in supported_langs:
                # Return the first found supported language.
                logging.debug('Using "%s" as the highest precedent language.' % lang)
                return lang

        # If that didn't find anything, then strip off the country code and try just the language
        accepted_languages = re.findall(r'(?:^|\s|,)(\w+)', header)
        logging.debug('Accepted languages (no country): %s' % accepted_languages)
        for lang in accepted_languages[:10]:
            if lang in supported_langs:
                # Return the first found supported language.
                logging.debug('Using "%s" as the highest precedent language.' % lang)
                return lang

    # If all else fails, default the language.
    return DEFAULT_LANGUAGE.lang_code
