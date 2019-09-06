import hashlib
import json
import urllib.parse

config_json = {}

DEFAULT_AVATAR_FOLDER_PATH = '/static/images/avatars/'
AVATAR_SIZE = 200
AVATARS_NUMBER = 15

def get_config(year):
  global config_json
  return config_json[year] if year in config_json else None

def update_config():
  global config_json

  # TODO(rviscomi): Dynamically handle multiple annual configs.
  with open('config/2019.json', 'r') as config_file:
    config_json['2019'] = json.load(config_file)

    for contributor_id, contributor in config_json['2019']['contributors'].items():
      if 'gravatar' in contributor:
        gravatar_url = 'https://www.gravatar.com/avatar/' + hashlib.md5(contributor['gravatar'].lower().encode()).hexdigest() + '.jpg?'
        gravatar_url += urllib.parse.urlencode({'d': 'mp','s':str(AVATAR_SIZE)})
        contributor['avatar_url'] = gravatar_url
      else:
        contributor['avatar_url'] = DEFAULT_AVATAR_FOLDER_PATH + str(hash(contributor_id) % AVATARS_NUMBER) + '.jpg'
        
update_config()