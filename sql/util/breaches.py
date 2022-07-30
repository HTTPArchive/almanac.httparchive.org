"""

After running the script, please recreate `httparchive.almanac.breaches` table with the current data.
"""

import json
import requests

year = 2022

with open(f"../{year}/privacy/breaches.jsonl", "w") as outfile:
    breaches = json.loads(
        requests.get("https://haveibeenpwned.com/api/v2/breaches").content
    )
    for entry in breaches:
        outfile.write(json.dumps(entry) + "\n")
