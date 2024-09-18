"""
This module retrieves data from the "haveibeenpwned" API and loads it into a BigQuery table.
"""

import json
from datetime import datetime as DateTime

import pandas
import requests  # pylint: disable=import-error
from bq_writer import write_to_bq, bigquery


# Retrieve data from the "haveibeenpwned" API
breaches = json.loads(
    requests.get("https://haveibeenpwned.com/api/v2/breaches", timeout=10).content
)
df = pandas.DataFrame(breaches)

year = DateTime.now().year
df["date"] = DateTime(year, 6, 1).date()
df["Name"] = df["Name"].astype(str)
df["Title"] = df["Title"].astype(str)
df["Domain"] = df["Domain"].astype(str)
df["BreachDate"] = pandas.to_datetime(
    df["BreachDate"], format="%Y-%m-%d", errors="coerce"
).dt.date
df["AddedDate"] = pandas.to_datetime(
    df["AddedDate"], format="%Y-%m-%d", errors="coerce"
).dt.date
df["ModifiedDate"] = pandas.to_datetime(
    df["ModifiedDate"], format="%Y-%m-%d", errors="coerce"
).dt.date
df["Description"] = df["Description"].astype(str)
df["LogoPath"] = df["LogoPath"].astype(str)
df["DataClasses"] = df["DataClasses"].apply(json.dumps)

# Append to httparchive.almanac.breaches


schema = [
    bigquery.SchemaField("date", "DATE"),
    bigquery.SchemaField("Name", "STRING"),
    bigquery.SchemaField("Title", "STRING"),
    bigquery.SchemaField("Domain", "STRING"),
    bigquery.SchemaField("BreachDate", "DATE"),
    bigquery.SchemaField("AddedDate", "DATE"),
    bigquery.SchemaField("ModifiedDate", "DATE"),
    bigquery.SchemaField("PwnCount", "INTEGER"),
    bigquery.SchemaField("Description", "STRING"),
    bigquery.SchemaField("LogoPath", "STRING"),
    bigquery.SchemaField("IsVerified", "BOOLEAN"),
    bigquery.SchemaField("IsFabricated", "BOOLEAN"),
    bigquery.SchemaField("IsSensitive", "BOOLEAN"),
    bigquery.SchemaField("IsRetired", "BOOLEAN"),
    bigquery.SchemaField("IsSpamList", "BOOLEAN"),
    bigquery.SchemaField("DataClasses", "STRING"),
]

write_to_bq(df, "httparchive.almanac.breaches", schema)
