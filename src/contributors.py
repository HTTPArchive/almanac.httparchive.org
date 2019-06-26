import json

contributors_json = {}


def get_contributors():
  return contributors_json

def update_contributors():
  global contributors_json
  
  with open('config/contributors.json', 'r') as contributors_file:
    contributors_json = json.load(contributors_file)
# need to return data

# Alphabatize data?

get_contributors()
