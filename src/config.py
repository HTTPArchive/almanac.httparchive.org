import json
import urllib.parse, hashlib

config_json = {}

default_avatar_folder_path = "/static/images/"
default_avatar_path = default_avatar_folder_path + "default_avatar.jpg"
avatar_size = 50

def get_config(year):
  global config_json
  return config_json[year] if year in config_json else None

def update_config():
  global config_json

  # TODO(rviscomi): Dynamically handle multiple annual configs.
  with open('config/2019.json', 'r') as config_file:
    config_json['2019'] = json.load(config_file)

    for contributor in config_json['2019']['contributors'].items():
      if 'gravatar' not in contributor[1] and 'teams' in contributor[1]:
        contributor[1]['avatar_url'] = default_avatar_folder_path + contributor[1]['teams'][0] + "_avatar.jpg"
      elif 'teams' not in contributor[1]:
        contributor[1]['avatar_url'] = default_avatar_path
      else:
        gravatar_url = "https://www.gravatar.com/avatar/" + hashlib.md5(contributor[1]['gravatar'].lower().encode()).hexdigest() + ".jpg?"
        gravatar_url += urllib.parse.urlencode({'s':str(avatar_size)})
        contributor[1]['avatar_url'] = gravatar_url


update_config()