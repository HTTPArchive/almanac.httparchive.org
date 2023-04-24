import json
from collections import defaultdict


def merged_contributors():
    """
    Merge all contributors from all years into one file
    """
    years = ["2019", "2020", "2021", "2022"]
    merged_contributors = defaultdict(lambda: defaultdict(dict))

    for year in years:
        filename = f"src/config/{year}.json"
        with open(filename, "r+") as file:
            data = json.load(file)
            contributors = data.get("contributors", {})

            for key, value in contributors.items():
                if "contributions" not in merged_contributors[key]:
                    merged_contributors[key]["contributions"] = {}
                merged_contributors[key]["contributions"][year] = value.pop("teams")

                merged_contributors[key].update(value)

        del data["contributors"]
        with open(filename, "w") as file:
            json.dump(data, file, indent=2, sort_keys=True)

    with open("src/config/contributors.json", "w") as outfile:
        json.dump(merged_contributors, outfile, indent=2, sort_keys=True)


merged_contributors()
