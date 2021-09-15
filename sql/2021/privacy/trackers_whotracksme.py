"""
Retrieve and extract trackers as identified by WhoTracks.me.

First, download the latest 'tracker database' 
(https://github.com/ghostery/whotracks.me/tree/master/whotracksme/data/assets):
`aws s3 cp --no-sign-request s3://data.whotracks.me/trackerdb.sql .`

Then, execute this script, and copy the result into the tracker-related SQL queries.
"""

import json
import sqlite3

# https://github.com/ghostery/whotracks.me/blob/master/blog/generating_adblocker_filters.md#loading-the-data
def load_tracker_db(loc=':memory:'):
    connection = sqlite3.connect(loc)
    with connection:
        with open('trackerdb.sql', 'rt') as f:
            connection.executescript(f.read())
    return connection

tracker_domains = {}

sql_query = """
    SELECT categories.name, tracker, domain FROM tracker_domains
    INNER JOIN trackers ON trackers.id = tracker_domains.tracker
    INNER JOIN categories ON categories.id = trackers.category_id;
"""
with load_tracker_db() as connection:
    for (category, tracker, domain) in connection.execute(sql_query):
        tracker_domains[domain] = (category, tracker)

formatted_json = [(k,)+v for k, v in tracker_domains.items()]
print(json.dumps(formatted_json,separators=(',', ':')))
