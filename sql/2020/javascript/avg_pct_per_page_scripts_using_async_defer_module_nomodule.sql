#standardSQL
# Average Percent per page of external scripts using Async, Defer, Module or NoModule attributes.
SELECT
  client,
  AVG(pct_external_async) AS avg_pct_external_async,
  AVG(pct_external_defer) AS avg_pct_external_defer,
  AVG(pct_external_module) AS avg_pct_external_module,
  AVG(pct_external_nomodule) AS avg_pct_external_nomodule
FROM (
  SELECT
    client,
    page,
    COUNT(0) AS external_scripts,
    COUNTIF(REGEXP_CONTAINS(script, r'\basync\b')) / COUNT(0) AS pct_external_async,
    COUNTIF(REGEXP_CONTAINS(script, r'\bdefer\b')) / COUNT(0) AS pct_external_defer,
    COUNTIF(REGEXP_CONTAINS(script, r'\bmodule\b')) / COUNT(0) AS pct_external_module,
    COUNTIF(REGEXP_CONTAINS(script, r'\bnomodule\b')) / COUNT(0) AS pct_external_nomodule
  FROM (
    SELECT
      client,
      page,
      url,
      REGEXP_EXTRACT_ALL(body, '(?i)(<script [^>]*)') AS scripts
    FROM
      `httparchive.almanac.summary_response_bodies`
    WHERE
      date = '2020-08-01' AND
      firstHtml
  ),
    UNNEST(scripts) AS script
  WHERE
    REGEXP_CONTAINS(script, r'\bsrc\b')
  GROUP BY
    client,
    page
)
GROUP BY
  client
