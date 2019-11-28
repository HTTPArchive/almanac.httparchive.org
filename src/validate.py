import logging
import re
import inspect
import json
import os

from flask import request, abort, redirect
from functools import wraps
from language import Language, DEFAULT_LANGUAGE
from datetime import date

import config as config_util

CONFIG_DIR = './config'

SUPPORTED_YEARS = {
    # When there is one supported language, it must have a trailing comma.
    '2019': (Language.ENGLISH,)
}

CHAPTERS = {}

TYPO_CHAPTERS = {
    'http-2': 'http2',
    'mobileweb': 'mobile-web',
    'pageweight': 'page-weight',
    'resourcehints': 'resource-hints',
    'thirdparties': 'third-parties'
}

def validate(func):
    @wraps(func)
    def decorated_function(*args, **kwargs):
        lang = kwargs.get('lang')
        year = kwargs.get('year')
        chapter = kwargs.get('chapter')

        accepted_args = inspect.getargspec(func).args

        if chapter:

            validated_chapter = validate_chapter(chapter,year)

            if chapter != validated_chapter:
                return redirect('/%s/%s/%s' % (lang, year, validated_chapter), code=301)

        lang, year = validate_lang_and_year(lang, year)

        if 'lang' in accepted_args:
            kwargs.update({'lang': lang})

        if 'year' in accepted_args:
            kwargs.update({'year': year})

        return func(*args, **kwargs)

    return decorated_function


def validate_chapter(chapter,year):

    chapters_for_year = CHAPTERS.get(year)
    if chapter not in chapters_for_year:
        if chapter in TYPO_CHAPTERS:
            logging.debug('Typo chapter requested: %s, redirecting to %s' % (chapter, TYPO_CHAPTERS.get(chapter)))
            return TYPO_CHAPTERS.get(chapter)
        else:
            logging.debug('Unsupported chapter requested: %s' % chapter)
            abort(404, 'Unsupported chapter requested')
    
    logging.debug('Using chapter: "%s ' % (chapter))

    return chapter


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

def get_json_files(path):

    files_found = []
    for root, directories, files in os.walk(path):
        for file in files:
            if '.json' in file:
                files_found.append(os.path.join(root, file))

    return files_found

def get_entries_from_json(path, p_key, s_key):

    with open(path) as json_file:
        data = json.load(json_file)

    entries = []

    if p_key in data:
        for values in data.get(p_key):
             entries.append(values.get(s_key))

    return entries

def get_chapters(file):

    chapters = []

    data = get_entries_from_json(file,'outline','chapters')
    for list in data:
        for entry in list:
            chapters.append(entry.get('title').lower().replace(" ", "-").replace("/",""))

    return chapters

def init():
    year_config_files = get_json_files(CONFIG_DIR)

    for file in year_config_files:
        CHAPTERS.update({file[9:-5] : set(get_chapters(file))})

    return sorted(CHAPTERS.keys())[-1]

DEFAULT_YEAR = init()
