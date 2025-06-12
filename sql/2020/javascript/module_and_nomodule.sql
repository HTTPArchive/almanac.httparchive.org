SELECT
  client,
  COUNT(DISTINCT IF(module, page, NULL)) AS module,
  COUNT(DISTINCT IF(nomodule, page, NULL)) AS nomodule,
  COUNT(DISTINCT IF(nomodule AND module, page, NULL)) AS both,
  COUNT(DISTINCT page) AS total,
  COUNT(DISTINCT IF(module, page, NULL)) / COUNT(DISTINCT page) AS pct_module,
  COUNT(DISTINCT IF(nomodule, page, NULL)) / COUNT(DISTINCT page) AS pct_nomodule,
  COUNT(DISTINCT IF(module AND nomodule, page, NULL)) / COUNT(DISTINCT page) AS pct_both
FROM (
  SELECT
    client,
    page,
    script,
    REGEXP_CONTAINS(script, r'(?i)\bmodule\b') AS module,
    REGEXP_CONTAINS(script, r'(?i)\bnomodule\b') AS nomodule
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
