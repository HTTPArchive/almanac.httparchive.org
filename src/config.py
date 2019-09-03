import json

config_json = {}


def get_config(year):
  global config_json
  return config_json[year] if year in config_json else None

def update_config():
  global config_json

  # TODO(rviscomi): Dynamically handle multiple annual configs.
  with open('config/2019.json', 'r') as config_file:
    config_json['2019'] = json.load(config_file)


update_config()