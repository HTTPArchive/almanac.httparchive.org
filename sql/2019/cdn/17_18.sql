#standardSQL
# 17_18: Percentage of responses that were pushed
SELECT
  client,
  cdn,
  COUNTIF(pushed) AS freq,
  COUNT(0) AS total,
  ROUND(COUNTIF(pushed) * 100 / COUNT(0), 2) AS pct
FROM (
  SELECT
    client,
    _cdn_provider AS cdn,
    JSON_EXTRACT(payload, '$._was_pushed') IS NOT NULL AS pushed
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2019-07-01'
)
GROUP BY
  client,
  cdn
ORDER BY
  total DESC
