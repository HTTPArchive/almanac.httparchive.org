import hashlib
import json
import urllib.parse

config_json = {}

DEFAULT_AVATAR_FOLDER_PATH = '/static/images/avatars/'
AVATAR_SIZE = 200
AVATARS_NUMBER = 15

CHAPTERS = {}

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
            languages.append(getattr(Language,entry.get('language')))
    return languages


def update_config():
  global config_json

  # TODO(rviscomi): Dynamically handle multiple annual configs.
  with open('config/2019.json', 'r') as config_file:
    config_json['2019'] = json.load(config_file)

    for contributor_id, contributor in config_json['2019']['contributors'].items():
      if 'avatar_url' not in contributor:
        if 'gravatar' in contributor:
          gravatar_url = 'https://www.gravatar.com/avatar/' + hashlib.md5(contributor['gravatar'].lower().encode()).hexdigest() + '.jpg?'
          gravatar_url += urllib.parse.urlencode({'d': 'mp','s':str(AVATAR_SIZE)})
          contributor['avatar_url'] = gravatar_url
        else:
          contributor['avatar_url'] = DEFAULT_AVATAR_FOLDER_PATH + str(hash(contributor_id) % AVATARS_NUMBER) + '.jpg'
    

    CHAPTERS.update({'2019' : set(get_chapters(config_json['2019']))})
        
update_config()
