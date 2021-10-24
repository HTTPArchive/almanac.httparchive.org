#standardSQL
# Percentage of websites receiving more traffic from mobile than desktop. Tablet is excluded since it does not fit well in either category

WITH base AS (
  SELECT
    date,
    origin,
    rank,

    desktopDensity,
    phoneDensity
  FROM
    `chrome-ux-report.materialized.metrics_summary`
  WHERE
    date IN ('2021-07-01')
)

SELECT
  date,
  CASE
    WHEN rank_grouping = 10000000 THEN 'all'
    ELSE CAST(rank_grouping AS STRING)
  END AS ranking,

  COUNT(DISTINCT origin) AS total_origins,

  COUNTIF(desktopDensity = phoneDensity) AS total_equal,
  COUNTIF(desktopDensity < phoneDensity) AS total_more_mobile,
  COUNTIF(desktopDensity > phoneDensity) AS total_more_desktop,

  SAFE_DIVIDE(COUNTIF(desktopDensity = phoneDensity), COUNT(DISTINCT origin)) AS perc_equal,
  SAFE_DIVIDE(COUNTIF(desktopDensity < phoneDensity), COUNT(DISTINCT origin)) AS perc_more_mobile,
  SAFE_DIVIDE(COUNTIF(desktopDensity > phoneDensity), COUNT(DISTINCT origin)) AS perc_more_desktop,
FROM
  base,
  UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
WHERE
  rank <= rank_grouping
GROUP BY
  date,
  rank_grouping
ORDER BY
  rank_grouping
