"""
Retrieve and extract trackers as identified by WhoTracks.me.
https://github.com/ghostery/whotracks.me/blob/master/blog/generating_adblocker_filters.md#loading-the-data

After running the script, please upload the result into the `httparchive.almanac.whotracksme` table.
"""

import requests
import sqlite3
import pandas

year = "2022"

trackerdb_sql = requests.get(
    "https://raw.githubusercontent.com/whotracksme/whotracks.me/master/whotracksme/data/assets/trackerdb.sql"
).text

connection = sqlite3.connect(":memory:")
connection.executescript(trackerdb_sql)

sql_query = """
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
""".format(
    year=year
)

pandas.read_sql(sql_query, connection).to_csv(
    f"../{year}/privacy/trackers.csv", index=False
)
