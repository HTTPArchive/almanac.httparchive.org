WITH lh AS (
  SELECT
    IF(STARTS_WITH(_TABLE_SUFFIX, '2022'), '2022', IF(STARTS_WITH(_TABLE_SUFFIX, '2023'),'2023', '2024')) AS year,
    IF(ENDS_WITH(_TABLE_SUFFIX, 'desktop'), 'desktop', 'mobile') AS client,
    CAST(JSON_VALUE(report, '$.audits.render-blocking-resources.score') AS FLOAT64) >= 0.9 AS is_passing
  FROM
    `httparchive.lighthouse.*`
  WHERE
    _TABLE_SUFFIX IN ('2022_06_01_mobile', '2022_06_01_desktop', '2023_06_01_mobile', '2023_06_01_desktop', '2024_06_01_mobile', '2024_06_01_desktop')
)

SELECT
  year,
  client,
  COUNTIF(is_passing) AS is_passing,
  COUNT(0) AS total,
  COUNTIF(is_passing) / COUNT(0) AS pct_passing
FROM
  lh
GROUP BY
  year,
  client
