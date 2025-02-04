SELECT
  client,
  COUNT(DISTINCT IF(async, page, NULL)) AS async,
  COUNT(DISTINCT IF(defer, page, NULL)) AS defer,
  COUNT(DISTINCT IF(async AND defer, page, NULL)) AS both,
  COUNT(DISTINCT page) AS total,
  COUNT(DISTINCT IF(async, page, NULL)) / COUNT(DISTINCT page) AS pct_async,
  COUNT(DISTINCT IF(defer, page, NULL)) / COUNT(DISTINCT page) AS pct_defer,
  COUNT(DISTINCT IF(async AND defer, page, NULL)) / COUNT(DISTINCT page) AS pct_both
FROM (
  SELECT
    client,
    page,
    script,
    REGEXP_CONTAINS(script, r'(?i)\basync\b') AS async,
    REGEXP_CONTAINS(script, r'(?i)\bdefer\b') AS defer
  FROM
    `httparchive.almanac.summary_response_bodies`
  LEFT JOIN
    UNNEST(REGEXP_EXTRACT_ALL(body, r'(?i)(<script[^>]*>)')) AS script
  WHERE
    date = '2020-08-01' AND
    firstHtml
)
GROUP BY
  client
