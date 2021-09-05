# standardSQL
# Count of H2 and H3 Sites using Push
SELECT
  client,
  http_version,
  COUNT(DISTINCT IF(was_pushed, page, NULL)) AS num_pages_with_push,
  COUNT(DISTINCT page) AS total,
  COUNT(DISTINCT IF(was_pushed, page, NULL)) / COUNT(DISTINCT page) AS pct
FROM (
  SELECT
    client,
    page,
    protocol AS http_version,
    pushed = '1' AS was_pushed
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2021-07-01' AND
    (LOWER(protocol) = "http/2" OR
      LOWER(protocol) LIKE "%quic%" OR
      LOWER(protocol) LIKE "h3%" OR
      LOWER(protocol) = "http/3")
)
GROUP BY
  client,
  http_version
