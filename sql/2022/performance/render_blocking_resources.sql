WITH lh AS (
  SELECT
    IF(STARTS_WITH(_TABLE_SUFFIX, '2021'), '2021', '2022') AS year,
    CAST(JSON_VALUE(report, '$.audits.render-blocking-resources.score') AS FLOAT64) >= 0.9 AS is_passing
  FROM
    `httparchive.lighthouse.*`
  WHERE
    _TABLE_SUFFIX IN ('2021_07_01_mobile', '2022_06_01_mobile')
)

SELECT
  year,
  COUNTIF(is_passing) AS is_passing,
  COUNT(0) AS total,
  COUNTIF(is_passing) / COUNT(0) AS pct_passing
FROM
  lh
GROUP BY
  year
