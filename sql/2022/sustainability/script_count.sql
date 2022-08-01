#standardSQL
# The percentage of scripts used inline v. external
SELECT
  client,
  COUNT(0) AS total_scripts,
  SUM(IF(script NOT LIKE '%src%', 1, 0)) AS inline_script,
  SUM(IF(script LIKE '%src%', 1, 0)) AS external_script,
  SUM(IF(script LIKE '%src%', 1, 0)) / COUNT(0) AS pct_external_script,
  SUM(IF(script NOT LIKE '%src%', 1, 0)) / COUNT(0) AS pct_inline_script,
FROM
  (
    SELECT
      client,
      page,
      url,
      REGEXP_EXTRACT_ALL(LOWER(body), '(<script [^>]*)') AS scripts
    FROM
      `httparchive.sample_data.summary_response_bodies`
    WHERE
      date = '2021-07-01' AND
      firstHtml
  )
CROSS JOIN
  UNNEST(scripts) AS script
GROUP BY
  client
