import hashlib
import json
import urllib.parse
import os

from language import Language, DEFAULT_LANGUAGE

SUPPORTED_YEARS = []
DEFAULT_YEAR = '2019'
#Use the following variable to temporarily exclude years until they are ready to be published
EXCLUDED_YEARS = ['2020']

config_json = {}

DEFAULT_AVATAR_FOLDER_PATH = '/static/images/avatars/'
AVATAR_SIZE = 200
AVATARS_NUMBER = 15

CHAPTERS = {}
LANGUAGES = {}

def get_config(year):
  global config_json
  return config_json[year] if year in config_json else None


def get_entries_from_json(json_config, p_key, s_key):
    entries = []
    if p_key in json_config:
        for values in json_config.get(p_key):
             entries.append(values.get(s_key))
    return entries


def get_chapters(json_config):
    chapters = []
    data = get_entries_from_json(json_config,'outline','chapters')
    for list in data:
        for entry in list:
            chapters.append(entry.get('slug'))
    return chapters


def get_languages(json_config):
    languages = []
    data = get_entries_from_json(json_config,'settings','supported_languages')
    for list in data:
        for entry in list:
            languages.append(getattr(Language,entry))
    return languages


def update_config():
  global SUPPORTED_YEARS
  global CHAPTERS
  global LANGUAGES
  global config_json

  for root, directories, files in os.walk('config'):
    for file in files:
      if '.json' in file:
        year = file[0:4]
        if year not in EXCLUDED_YEARS:
          SUPPORTED_YEARS.append(year)

  for year in SUPPORTED_YEARS:
    config_filename = 'config/%s.json' % year
    with open(config_filename, 'r') as config_file:
      json_config = json.load(config_file)
      config_json[year] = json_config

      LANGUAGES.update({year : get_languages(json_config)})
      CHAPTERS.update({year : set(get_chapters(json_config))})

      for contributor_id, contributor in json_config['contributors'].items():
        if 'avatar_url' not in contributor:
          if 'gravatar' in contributor:
            gravatar_url = 'https://www.gravatar.com/avatar/' + hashlib.md5(contributor['gravatar'].lower().encode()).hexdigest() + '.jpg?'
            gravatar_url += urllib.parse.urlencode({'d': 'mp','s':str(AVATAR_SIZE)})
            contributor['avatar_url'] = gravatar_url
          else:
            contributor['avatar_url'] = DEFAULT_AVATAR_FOLDER_PATH + str(hash(contributor_id) % AVATARS_NUMBER) + '.jpg'
        
update_config()
