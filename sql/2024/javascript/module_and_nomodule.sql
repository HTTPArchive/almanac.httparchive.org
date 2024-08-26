# module_and_nomodule.sql
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
    `httparchive.all.requests`
  LEFT JOIN
    UNNEST(REGEXP_EXTRACT_ALL(response_body, r'(?i)(<script[^>]*>)')) AS script
  WHERE
    date = '2024-06-01' AND
    cast(json_value(summary, '$.firstHtml') AS BOOL)
  )
GROUP BY
  client
