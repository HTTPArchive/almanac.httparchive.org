#standardSQL
# Percent of pages with fingerprint.js library

WITH requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    page,
    url
  FROM
    `httparchive.requests.2020_08_01_*`
),

base AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total_pages,
    COUNT(DISTINCT IF(url LIKE "%fingerprint2.min.js%" OR url LIKE "%fingerprintjs2%", page, NULL)) AS fingerprint_pages
  FROM
    requests
  GROUP BY
    client
)

SELECT
  client,
  total_pages,
  fingerprint_pages,
  fingerprint_pages / total_pages AS pct_fingerprint_pages
FROM
  base
