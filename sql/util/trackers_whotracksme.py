"""
Retrieve and extract trackers as identified by WhoTracks.me.


After running the script, please upload the result into the `httparchive.almanac.whotracksme` table.
"""

import csv
import requests
import sqlite3

year = "2022"

trackerdb_sql = requests.get(
    "https://raw.githubusercontent.com/whotracksme/whotracks.me/master/whotracksme/data/assets/trackerdb.sql"
).text

# https://github.com/ghostery/whotracks.me/blob/master/blog/generating_adblocker_filters.md#loading-the-data
def load_tracker_db(loc=":memory:"):
    connection = sqlite3.connect(loc)

    connection.executescript(trackerdb_sql)
    return connection


sql_query = """
    SELECT
        '{year}-06-01' AS date,
        categories.name,
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

with open(f"../{year}/privacy/trackers.csv", mode="w") as trackers_file:
    trackers_writer = csv.writer(
        trackers_file, delimiter=",", quotechar='"', quoting=csv.QUOTE_MINIMAL
    )
    trackers_writer.writerow(["date", "category", "tracker", "domain"])

    with load_tracker_db() as connection:
        for (date, category, tracker, domain) in connection.execute(sql_query):

            trackers_writer.writerow([date, category, tracker, domain])
