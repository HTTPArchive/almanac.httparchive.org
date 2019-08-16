#standardSQL
# 07_10: Percentiles of first/last painted hero
SELECT
  client,
  ROUND(APPROX_QUANTILES(firstPaintedHero, 1000)[OFFSET(100)] / 1000, 2) AS p10_fph,
  ROUND(APPROX_QUANTILES(firstPaintedHero, 1000)[OFFSET(250)] / 1000, 2) AS p25_fph,
  ROUND(APPROX_QUANTILES(firstPaintedHero, 1000)[OFFSET(500)] / 1000, 2) AS p50_fph,
  ROUND(APPROX_QUANTILES(firstPaintedHero, 1000)[OFFSET(750)] / 1000, 2) AS p75_fph,
  ROUND(APPROX_QUANTILES(firstPaintedHero, 1000)[OFFSET(900)] / 1000, 2) AS p90_fph,
  ROUND(APPROX_QUANTILES(lastPaintedHero, 1000)[OFFSET(100)] / 1000, 2) AS p10_lph,
  ROUND(APPROX_QUANTILES(lastPaintedHero, 1000)[OFFSET(250)] / 1000, 2) AS p25_lph,
  ROUND(APPROX_QUANTILES(lastPaintedHero, 1000)[OFFSET(500)] / 1000, 2) AS p50_lph,
  ROUND(APPROX_QUANTILES(lastPaintedHero, 1000)[OFFSET(750)] / 1000, 2) AS p75_lph,
  ROUND(APPROX_QUANTILES(lastPaintedHero, 1000)[OFFSET(900)] / 1000, 2) AS p90_lph
FROM 
( 
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_EXTRACT(payload, "$['_heroElementTimes.FirstPaintedHero']") AS INT64) AS firstPaintedHero,
    CAST(JSON_EXTRACT(payload, "$['_heroElementTimes.LastPaintedHero']") AS INT64) AS lastPaintedHero
  FROM
    `httparchive.pages.2019_07_01_*`
)
GROUP BY
  client
