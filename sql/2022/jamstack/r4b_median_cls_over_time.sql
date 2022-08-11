WITH cls_values AS (
  SELECT
    url,
    CAST(JSON_EXTRACT(payload, "$['_chromeUserTiming.CumulativeLayoutShift']") AS NUMERIC) AS cls
  FROM `httparchive.pages.2020_06_01_mobile`
),

cls_all AS (
  SELECT
    round(cls, 3) AS cls_round
  FROM cls_values
  WHERE cls IS NOT NULL
  ORDER BY cls_round
)

SELECT
  PERCENTILE_CONT(cls_round, 0.5) OVER() AS median
FROM cls_all LIMIT 1
