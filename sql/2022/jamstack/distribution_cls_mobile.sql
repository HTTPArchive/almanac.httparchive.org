-- getting bucketed distribution of CLS scores to find median and other percentiles
WITH cls_values AS (
  SELECT
    url,
    CAST(JSON_EXTRACT(payload, "$['_chromeUserTiming.CumulativeLayoutShift']") AS NUMERIC) AS cls
  FROM `httparchive.pages.2022_06_01_mobile`
),

cls_clean AS (
  SELECT
    url,
    round(cls, 3) AS cls_round
  FROM cls_values
  WHERE cls IS NOT NULL
)

SELECT
  cls_round,
  count(distinct(url)) AS urls
FROM cls_clean
GROUP BY cls_round
ORDER BY cls_round
