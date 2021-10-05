"""
Retrieve and extract trackers as identified by WhoTracks.me.

First, download the latest 'tracker database'
(https://github.com/ghostery/whotracks.me/tree/master/whotracksme/data/assets):
`aws s3 cp --no-sign-request s3://data.whotracks.me/trackerdb.sql .`

Then, execute this script.
Finally, copy the result into the tracker-related SQL queries.
"""

import csv
import sqlite3


# https://github.com/ghostery/whotracks.me/blob/master/blog/generating_adblocker_filters.md#loading-the-data
def load_tracker_db(loc=":memory:"):
    connection = sqlite3.connect(loc)
    with connection:
        with open(
            "sql/2021/privacy/trackerdb.sql",
            "rt",
        ) as f:
            connection.executescript(f.read())
    return connection


tracker_domains = {}

sql_query = """
    SELECT
      categories.name, tracker, domain
    FROM
      tracker_domains
    INNER JOIN
      trackers
    ON trackers.id = tracker_domains.tracker
    INNER JOIN
      categories
    ON categories.id = trackers.category_id;
"""

with open("sql/2021/privacy/trackers.csv", mode="w") as trackers_file:
    trackers_writer = csv.writer(
        trackers_file, delimiter=",", quotechar='"', quoting=csv.QUOTE_MINIMAL
    )
    trackers_writer.writerow(["category", "tracker", "domain"])

    with load_tracker_db() as connection:
        for (category, tracker, domain) in connection.execute(sql_query):

            trackers_writer.writerow([category, tracker, domain])
