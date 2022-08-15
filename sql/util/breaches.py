"""
1. Download breaches.json
2. Create a new table almanac.breaches_2022 via upload, with autodetected schema
3. Append the output of this query to almanac.breaches:
SELECT
    DATE('2022-06-01') AS date,
    Name,
    Title,
    Domain,
    BreachDate,
    AddedDate,
    ModifiedDate,
    PwnCount,
    Description,
    LogoPath,
    IsVerified,
    IsFabricated,
    IsSensitive,
    IsRetired,
    IsSpamList,
    TO_JSON_STRING(DataClasses) AS DataClasses
FROM
    `httparchive.almanac.breaches_2022`
"""

import json
import requests  # pylint: disable=import-error

year = 2022

with open(f"../{year}/privacy/breaches.jsonl", "w") as outfile:
    breaches = json.loads(
        requests.get("https://haveibeenpwned.com/api/v2/breaches").content
    )
    for entry in breaches:
        outfile.write(json.dumps(entry) + "\n")
