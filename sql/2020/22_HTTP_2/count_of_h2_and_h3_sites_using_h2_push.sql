# standardSQL
# Count of H2 and H3 Sites using HTTP/2 Push
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
    (LOWER(JSON_EXTRACT_SCALAR(payload, "$._protocol")) LIKE "http/2" OR
     LOWER(JSON_EXTRACT_SCALAR(payload, "$._protocol")) LIKE "%quic%" OR
     LOWER(JSON_EXTRACT_SCALAR(payload, "$._protocol")) LIKE "h3%" OR
     LOWER(JSON_EXTRACT_SCALAR(payload, "$._protocol")) LIKE "http/3%")   
    )
GROUP BY
  client
