# standardSQL
# Count of H2 and H3 Sites using Push
SELECT
  client,
  http_version,
  COUNT(DISTINCT IF(was_pushed, page, NULL)) AS num_pages_with_push,
  total AS total_pages,
  COUNT(DISTINCT IF(was_pushed, page, NULL)) / total AS pct
FROM
  (
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
JOIN
  (
    SELECT
      client,
      COUNT(DISTINCT page) AS total
    FROM
      `httparchive.almanac.requests`
    WHERE
      date = '2021-07-01'
    GROUP BY
      client
  )
USING (client)
GROUP BY
  client,
  http_version,
  total
ORDER BY
  pct DESC,
  client,
  http_version
