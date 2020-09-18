# standardSQL
# Count of HTTP/2 Sites using HTTP/2 Push
SELECT
  client,
  COUNT(DISTINCT IF(was_pushed, page, NULL)) AS num_pages_with_push,
  COUNT(DISTINCT page) AS total,
  COUNT(DISTINCT IF(was_pushed, page, NULL)) / COUNT(DISTINCT page) AS pct
FROM (
  SELECT
    client,
    page,
    JSON_EXTRACT_SCALAR(payload, '$._was_pushed') = '1' AS was_pushed
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2020-08-01' AND
    JSON_EXTRACT_SCALAR(payload, '$._protocol') = 'HTTP/2')
GROUP BY
  client
