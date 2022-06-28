#standardSQL
# summary_pages trends grouped by device

WITH summary_requests AS (
  SELECT
    '2019' AS year,
    _TABLE_SUFFIX AS client,
    *
  FROM
    `httparchive.summary_pages.2019_07_01_*`
  UNION ALL
  SELECT
    '2020' AS year,
    _TABLE_SUFFIX AS client,
    *
  FROM
    `httparchive.summary_pages.2020_08_01_*`
  UNION ALL
  SELECT
    '2021' AS year,
    _TABLE_SUFFIX AS client,
    *
  FROM
    `httparchive.summary_pages.2021_07_01_*`
  UNION ALL
  SELECT
    '2022' AS year,
    _TABLE_SUFFIX AS client,
    * EXCEPT (metadata)
  FROM
    `httparchive.summary_pages.2022_06_01_*`
)

SELECT
  year,
  client,
  APPROX_QUANTILES(bytesHtml / 1024, 1000)[OFFSET(500)] AS median_kbytes_html,
  COUNT(0) AS total
FROM
  summary_requests
GROUP BY
  year,
  client
ORDER BY
  year,
  client
