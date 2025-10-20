"""
Retrieves breach data from the Have I Been Pwned API and loads it into BigQuery.

"""

import json
from datetime import datetime

import pandas as pd
import requests  # pylint: disable=import-error
from bq_writer import bigquery, write_to_bq

# Fetch breach data from API
response = requests.get("https://haveibeenpwned.com/api/v2/breaches", timeout=10)
breaches = response.json()
df = pd.DataFrame(breaches)

# Convert date fields
df["BreachDate"] = pd.to_datetime(df["BreachDate"], errors="coerce")
df["AddedDate"] = pd.to_datetime(df["AddedDate"], errors="coerce")
df["ModifiedDate"] = pd.to_datetime(df["ModifiedDate"], errors="coerce")

# Define BigQuery schema
schema = [
    bigquery.SchemaField("Name", "STRING"),
    bigquery.SchemaField("Title", "STRING"),
    bigquery.SchemaField("Domain", "STRING"),
    bigquery.SchemaField("BreachDate", "DATE"),
    bigquery.SchemaField("AddedDate", "TIMESTAMP"),
    bigquery.SchemaField("ModifiedDate", "TIMESTAMP"),
    bigquery.SchemaField("PwnCount", "INTEGER"),
    bigquery.SchemaField("Description", "STRING"),
    bigquery.SchemaField("LogoPath", "STRING"),
    bigquery.SchemaField("IsVerified", "BOOLEAN"),
    bigquery.SchemaField("IsFabricated", "BOOLEAN"),
    bigquery.SchemaField("IsSensitive", "BOOLEAN"),
    bigquery.SchemaField("IsRetired", "BOOLEAN"),
    bigquery.SchemaField("IsSpamList", "BOOLEAN"),
    bigquery.SchemaField("IsMalware", "BOOLEAN"),
    bigquery.SchemaField("IsSubscriptionFree", "BOOLEAN"),
    bigquery.SchemaField("IsStealerLog", "BOOLEAN"),
    bigquery.SchemaField("DataClasses", "STRING", mode="REPEATED"),
    bigquery.SchemaField("Attribution", "STRING"),
    bigquery.SchemaField("DisclosureUrl", "STRING"),
]

# Write to BigQuery
write_to_bq(df, "httparchive.almanac.breaches", schema, write_disposition="WRITE_TRUNCATE")
