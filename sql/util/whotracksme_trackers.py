"""
This module retrieves and extracts trackers as identified by WhoTracks.me
and appends them to the httparchive.almanac.whotracksme BigQuery table.
"""

# pylint: disable=import-error

from datetime import datetime as DateTime
import sqlite3

import pandas
import requests
from bq_writer import write_to_bq, bigquery


# get current year
year = DateTime.now().year

# Retrieve and extract trackers as identified by WhoTracks.me.
# https://github.com/ghostery/whotracks.me/blob/master/blog/generating_adblocker_filters.md#loading-the-data
tracker_db = requests.get(
    "https://raw.githubusercontent.com/whotracksme/whotracks.me/master/whotracksme/data/assets/trackerdb.sql",
    timeout=10,
).text

trackers_query = f"""
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
connection.executescript(tracker_db)
trackers_df = pandas.read_sql(trackers_query, connection)
connection.close()

# Append to almanac.whotracksme BQ table
schema = [
    bigquery.SchemaField("date", "DATE"),
    bigquery.SchemaField("category", "STRING"),
    bigquery.SchemaField("tracker", "STRING"),
    bigquery.SchemaField("domain", "STRING"),
]

write_to_bq(trackers_df, "httparchive.almanac.whotracksme", schema)
