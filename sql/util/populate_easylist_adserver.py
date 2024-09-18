# pylint: disable=import-error
import requests
import pandas as pd
from bq_writer import bigquery, write_to_bq


def extract_domains(content):
    domains_list = []
    for line in content.splitlines():

        # Skip comments
        if line.startswith("!"):
            continue

        # Remove the '||' prefix and '^' suffix
        domain = line.strip().lstrip("||").rstrip("^")

        # Ensure the domain is not empty
        if domain:
            domains_list.append(domain)

    return domains_list


# URL to the text file containing the regex patterns
URL = "https://raw.githubusercontent.com/easylist/easylist/master/easylist/easylist_adservers.txt"

# Download the file
response = requests.get(URL)

# Extract domains
domains = extract_domains(response.text)

# Create a DataFrame from the list of domains
df = pd.DataFrame(domains, columns=["Domain"])

write_to_bq(
    df,
    "httparchive.almanac.easylist_adservers",
    [bigquery.SchemaField("Domain", "STRING")],
    "WRITE_TRUNCATE",
)
