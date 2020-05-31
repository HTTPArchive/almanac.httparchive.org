import hashlib
import json
import urllib.parse
import os

from language import Language, DEFAULT_LANGUAGE

SUPPORTED_YEARS = []
DEFAULT_YEAR = '2019'

config_json = {}

DEFAULT_AVATAR_FOLDER_PATH = '/static/images/avatars/'
AVATAR_SIZE = 200
AVATARS_NUMBER = 15

SUPPORTED_CHAPTERS = {}
SUPPORTED_LANGUAGES = {}

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
      languages.append(getattr(Language,entry.upper()))
  return languages


def get_live(json_config):
  is_live = False
  data = get_entries_from_json(json_config,'settings','is_live')
  for list in data:
    if list == True:
      is_live = True
  return is_live


def update_config():
  global SUPPORTED_YEARS
  global SUPPORTED_CHAPTERS
  global SUPPORTED_LANGUAGES
  global config_json

  config_files = []

  for root, directories, files in os.walk('config'):
    for file in files:
      if '.json' in file:
        config_files.append(file[0:4])

  for year in config_files:
    config_filename = 'config/%s.json' % year
    with open(config_filename, 'r') as config_file:
      json_config = json.load(config_file)
      config_json[year] = json_config

      if get_live(json_config):
        SUPPORTED_YEARS.append(year)
        SUPPORTED_LANGUAGES.update({year : get_languages(json_config)})
        SUPPORTED_CHAPTERS.update({year : set(get_chapters(json_config))})

        for contributor_id, contributor in json_config['contributors'].items():
          if 'avatar_url' not in contributor:
            if 'gravatar' in contributor:
              gravatar_url = 'https://www.gravatar.com/avatar/' + hashlib.md5(contributor['gravatar'].lower().encode()).hexdigest() + '.jpg?'
              gravatar_url += urllib.parse.urlencode({'d': 'mp','s':str(AVATAR_SIZE)})
              contributor['avatar_url'] = gravatar_url
            else:
              contributor['avatar_url'] = DEFAULT_AVATAR_FOLDER_PATH + str(hash(contributor_id) % AVATARS_NUMBER) + '.jpg'

update_config()
