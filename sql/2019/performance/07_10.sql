#standardSQL
# 07_10: Percentiles of first/last painted hero
SELECT
  percentile,
  client,
  ROUND(APPROX_QUANTILES(first_painted_hero, 1000)[OFFSET(percentile * 10)] / 1000, 2) AS first_painted_hero,
  ROUND(APPROX_QUANTILES(last_painted_hero, 1000)[OFFSET(percentile * 10)] / 1000, 2) AS last_painted_hero
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_EXTRACT(payload, "$['_heroElementTimes.FirstPaintedHero']") AS INT64) AS first_painted_hero,
    CAST(JSON_EXTRACT(payload, "$['_heroElementTimes.LastPaintedHero']") AS INT64) AS last_painted_hero
  FROM
    `httparchive.pages.2019_07_01_*`
),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
