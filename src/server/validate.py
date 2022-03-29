import logging
import re
import inspect

from flask import request, abort, redirect
from functools import wraps
from .language import DEFAULT_LANGUAGE, LANGUAGE_MAPPING

from .config import SUPPORTED_YEARS, DEFAULT_YEAR, SUPPORTED_CHAPTERS, SUPPORTED_LANGUAGES

TYPO_CHAPTERS = {
    'http-2': 'http',
    'http2': 'http',
    'http3': 'http',
    'html': 'markup',
    'mobileweb': 'mobile-web',
    'pageweight': 'page-weight',
    'resourcehints': 'resource-hints',
    'thirdparties': 'third-parties',
    'third-party': 'third-parties',
    'sécurité': 'security',
    'js': 'javascript'
}


def validate(func):
    @wraps(func)
    def decorated_function(*args, **kwargs):
        lang_arg = kwargs.get('lang')
        year = kwargs.get('year')
        chapter = kwargs.get('chapter')

        accepted_args = inspect.getfullargspec(func).args

        lang, year = validate_lang_and_year(lang_arg, year)

        if 'lang' in accepted_args:
            kwargs.update({'lang': lang})
            if lang != lang_arg and lang_arg is not None:
                full_path = request.full_path.replace(lang_arg, lang, 1)
                # If the full_path has an empty query string then remove it
                # as not needed and bit pointless and breaks tests
                if full_path[-1] == "?":
                    full_path = full_path[:-1]
                return redirect('%s' % full_path, code=302)

        if 'year' in accepted_args:
            kwargs.update({'year': year})

        if chapter:

            validated_chapter = validate_chapter(chapter, year)

            if chapter != validated_chapter:
                return redirect('/%s/%s/%s' % (lang, year, validated_chapter), code=302)

        return func(*args, **kwargs)

    return decorated_function


def validate_chapter(chapter, year):
    chapters_for_year = []

    if year <= DEFAULT_YEAR:
        chapters_for_year = SUPPORTED_CHAPTERS.get(year)

    if chapter not in chapters_for_year:
        if chapter[-1] == "/":
            # Automatically remove any trailing slashes
            return chapter[:-1]
        elif year > DEFAULT_YEAR:
            # Until a year is live and the default year, redirect any requests back to the home page
            return ""
        elif chapter.lower() in chapters_for_year:
            # Automatically redirect to lowercase
            return chapter.lower()
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

    supported_langs = [lan.lang_code for lan in (SUPPORTED_LANGUAGES.get(year) or [DEFAULT_LANGUAGE])]

    # If an unsupported language code is passed in, check if we have similar.
    if lang is not None and lang not in supported_langs:
        logging.debug('Unsupported language set: %s.' % lang)

        # Check it's not just a simple case issue
        if lang.lower() in supported_langs:
            return (lang.lower(), year)

        # Handle lookups for special cases (e.g. Chinese)
        if lang.lower() in LANGUAGE_MAPPING and LANGUAGE_MAPPING.get(lang.lower()) in supported_langs:
            return (LANGUAGE_MAPPING.get(lang.lower()), year)

        # Split on '-' to see if we support base lang (e.g. en-US -> en)
        lang_only = lang.split('-')[0].lower()
        if lang_only in supported_langs:
            return (lang_only, year)

        # If still can't find a match then 404:
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
