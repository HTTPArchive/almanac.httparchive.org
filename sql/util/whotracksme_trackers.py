"""
This module retrieves and extracts trackers as identified by WhoTracks.me
and appends them to the httparchive.almanac.whotracksme BigQuery table.
"""

import sqlite3
from datetime import datetime as DateTime

import pandas
import requests  # pylint: disable=import-error
from google.cloud import bigquery  # pylint: disable=import-error

# get current year
year = DateTime.now().year

# Retrieve and extract trackers as identified by WhoTracks.me.
# https://github.com/ghostery/whotracks.me/blob/master/blog/generating_adblocker_filters.md#loading-the-data
trackerdb_sql = requests.get(
    "https://raw.githubusercontent.com/whotracksme/whotracks.me/master/whotracksme/data/assets/trackerdb.sql",
    timeout=10
).text

sqlite_query = f"""
SELECT
    '{year}-06-01' AS date,
    categories.name as category,
    tracker,
    domain
FROM
    tracker_domains
INNER JOIN
    trackers
ON trackers.id = tracker_domains.tracker
INNER JOIN
    categories
ON categories.id = trackers.category_id;
"""
connection = sqlite3.connect(":memory:")
connection.executescript(trackerdb_sql)
trackers_df = pandas.read_sql(sqlite_query, connection)
connection.close()

# Append to almanac.whotracksme BQ table
client = bigquery.Client()
job_config = bigquery.LoadJobConfig(
    schema=[
        bigquery.SchemaField("date", "DATE"),
        bigquery.SchemaField("category", "STRING"),
        bigquery.SchemaField("tracker", "STRING"),
        bigquery.SchemaField("domain", "STRING"),
    ],
    source_format=bigquery.SourceFormat.CSV,
    write_disposition="WRITE_APPEND",
)
job = client.load_table_from_dataframe(
    trackers_df, "httparchive.almanac.whotracksme", job_config=job_config
)
job.result()  # Waits for the job to complete.
