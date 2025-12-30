import json
import os

from .language import Language

ROOT_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..")
TEMPLATES_DIR = ROOT_DIR + "/templates"
STATIC_DIR = ROOT_DIR + "/static"

SUPPORTED_YEARS = []
DEFAULT_YEAR = "2025"

DEFAULT_AVATAR_FOLDER_PATH = "/static/images/avatars/"
AVATAR_SIZE = 200
AVATARS_NUMBER = 15

SUPPORTED_CHAPTERS = {}
SUPPORTED_LANGUAGES = {}

config_json = {}
timestamps_json = {}
contributors = {}


def get_config(year):
    return config_json[year] if year in config_json else None


def get_timestamps_config():
    return timestamps_json


def get_entries_from_json(json_config, p_key, s_key):
    entries = []
    if p_key in json_config:
        for values in json_config.get(p_key):
            entries.append(values.get(s_key))
    return entries


def get_chapters(json_config):
    chapters = []
    data = get_entries_from_json(json_config, "outline", "chapters")
    for list in data:
        for entry in list:
            chapters.append(entry.get("slug"))
    return chapters


def get_languages(json_config):
    languages = []
    data = get_entries_from_json(json_config, "settings", "supported_languages")
    for list in data:
        for entry in list:
            languages.append(getattr(Language, entry.upper().replace("-", "_")))
    return languages


def get_live(json_config):
    is_live = False
    data = get_entries_from_json(json_config, "settings", "is_live")
    for list in data:
        if list is True:
            is_live = True
    return is_live


def update_config():
    global timestamps_json
    global contributors

    config_files = []

    for root, directories, files in os.walk(ROOT_DIR + "/config"):
        for file in files:
            if file == "last_updated.json":
                config_filename = "config/%s" % file
                with open(config_filename, "r") as config_file:
                    timestamps_json = json.load(config_file)
            elif file == "contributors.json":
                config_filename = "config/%s" % file
                with open(config_filename, "r") as config_file:
                    contributors = json.load(config_file)
            elif ".json" in file:
                config_files.append(file[0:4])

    # Sort the config files so read in year order
    config_files.sort()

    for year in config_files:
        config_filename = "config/%s.json" % year
        with open(config_filename, "r") as config_file:
            json_config = json.load(config_file)
            config_json[year] = json_config

            if get_live(json_config):
                SUPPORTED_YEARS.append(year)
                SUPPORTED_LANGUAGES.update({year: get_languages(json_config)})
                SUPPORTED_CHAPTERS.update({year: set(get_chapters(json_config))})

                # Add the contributors details that contributed to this year
                # for ease of look up later
                json_config["contributors"] = {}
                for contributor_id, contributor in contributors.items():
                    if (year in contributor["teams"]):
                        json_config["contributors"][contributor_id] = {**contributor}
                        json_config["contributors"][contributor_id]["teams"] = contributor["teams"][year]

                for contributor_id, contributor in json_config["contributors"].items():
                    if "avatar_url" not in contributor:
                        contributor["avatar_url"] = (
                            DEFAULT_AVATAR_FOLDER_PATH
                            + str(hash(contributor_id) % AVATARS_NUMBER)
                            + ".jpg"
                        )


update_config()
