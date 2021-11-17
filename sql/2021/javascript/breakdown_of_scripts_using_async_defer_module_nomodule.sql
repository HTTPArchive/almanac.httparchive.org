#standardSQL
# Breakdown of scripts using Async, Defer, Module or NoModule attributes.  Also breakdown of inline vs external scripts
SELECT
  client,
  COUNT(0) AS total_scripts,
  SUM(IF(script NOT LIKE "%src%", 1, 0)) AS inline_script,
  SUM(IF(script LIKE "%src%", 1, 0)) AS external_script,
  SUM(IF(script LIKE "%async%", 1, 0)) AS async,
  SUM(IF(script LIKE "%defer%", 1, 0)) AS defer,
  SUM(IF(script LIKE "%async%", 1, 0)) / SUM(IF(script LIKE "%src%", 1, 0)) AS pct_external_async,
  SUM(IF(script LIKE "%defer%", 1, 0)) / SUM(IF(script LIKE "%src%", 1, 0)) AS pct_external_defer
FROM
  (
    SELECT
      client,
      page,
      url,
      REGEXP_EXTRACT_ALL(LOWER(body), "(<script [^>]*)") AS scripts
    FROM
      `httparchive.almanac.summary_response_bodies`
    WHERE
      date = '2021-07-01' AND
      firstHtml
  )
CROSS JOIN
  UNNEST(scripts) AS script
GROUP BY
  client
