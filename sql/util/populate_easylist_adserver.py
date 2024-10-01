# pylint: disable=import-error
import requests
import pandas as pd
from bq_writer import bigquery, write_to_bq


def extract_domains(content):
    domains_set = set()
    for line in content.splitlines():

        # Skip comments and regexes
        if line.startswith("!") or line.startswith("/"):
            continue

        # Remove the '||' prefix and '^.*' suffix
        domain = line.strip().lstrip("||").split('^')[0]

        # Ensure the domain is not empty
        if domain:
            domains_set.add(domain)

    return domains_set


# URL to the text file containing the regex patterns
URL = "https://raw.githubusercontent.com/easylist/easylist/master/easylist/easylist_adservers.txt"

# Download the file
response = requests.get(URL)

# Extract domains
domains = extract_domains(response.text)

# Create a DataFrame from the list of domains
df = pd.DataFrame(domains, columns=["Domain"]).sort_values("Domain").reset_index(drop=True)

write_to_bq(
    df,
    "httparchive.almanac.easylist_adservers",
    [bigquery.SchemaField("Domain", "STRING")],
    "WRITE_TRUNCATE",
)
