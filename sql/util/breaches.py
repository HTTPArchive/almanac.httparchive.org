"""

After running the script, please update the `httparchive.almanac.breaches` table with the resulting file.
"""

import json
import requests

year = 2022

with open("../{year}/privacy/breaches.jsonl", "w") as outfile:
    breaches = json.loads(
        requests.get("https://haveibeenpwned.com/api/v2/breaches").content
    )

    for entry in breaches:
        json.dump(entry, outfile)
        outfile.write("\n")
