#standardSQL
# Pages that use device sensors (based on event listeners)

# https://stackoverflow.com/questions/65048929/bigquery-extract-keys-from-json-object-convert-json-from-object-to-key-value-a
CREATE TEMP FUNCTION jsonToKeyValueArray(input STRING)
RETURNS ARRAY<STRUCT<key STRING, value ARRAY<STRING>>>
LANGUAGE js AS """
  try {
    let json = JSON.parse(input ? input: "{}");
    return Object.keys(json).map(e => ({"key": e, "value": json[e]}));
  } catch (error) {
    return []
  }
""";

WITH pages_events AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    JSON_QUERY(payload, '$._event-names') AS events
  FROM
    `httparchive.pages.2021_07_01_*`
),

sites_and_events AS (
  SELECT
    client,
    site, -- the home page that was crawled
    url_and_events.key AS url, -- the url that added the event listener, can be scripts etc.
    event -- the name of the event
  FROM (SELECT client, url AS site, jsonToKeyValueArray(events) AS events_per_site FROM pages_events),
    UNNEST(events_per_site) url_and_events,
    UNNEST(url_and_events.value) event
),

total_pages AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total
  FROM
    `httparchive.pages.2021_07_01_*`
  GROUP BY
    _TABLE_SUFFIX
)

SELECT
  client,
  event,
  COUNT(DISTINCT site) AS number_of_websites,
  COUNT(DISTINCT site) / total AS pct_of_websites,
  COUNT(DISTINCT url) AS number_of_urls
FROM
  sites_and_events
JOIN
  total_pages
USING (client)
WHERE
  -- device* events, from https://www.esat.kuleuven.be/cosic/publications/article-3078.pdf
  event LIKE 'device%'
GROUP BY
  client,
  event,
  total
ORDER BY
  client,
  event
