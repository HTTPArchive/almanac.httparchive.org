"""

After running the script, please upload the result to `httparchive.almanac.breaches` table.
"""

import json
import requests

year = 2022

with open(f"../{year}/privacy/breaches.json", "w") as outfile:
    breaches = json.loads(
        requests.get("https://haveibeenpwned.com/api/v2/breaches").content
    )
    for entry in breaches:
        entry["date"] = f"{year}-06-01"
        outfile.write(json.dumps(entry) + "\n")
