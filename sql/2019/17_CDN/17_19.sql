#standardSQL
# 17_19: Percentage of HTTPS responses by protocol
SELECT
  client,
  cdn,
  protocol,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client, cdn) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client, cdn), 2) AS pct
FROM (
  SELECT
    client,
    _cdn_provider AS cdn,
    JSON_EXTRACT_SCALAR(payload, '$._protocol') AS protocol
  FROM
    `httparchive.almanac.requests`
  WHERE
    STARTS_WITH(url, 'https'))
GROUP BY
  client,
  cdn,
  protocol
ORDER BY
  total DESC,
  freq DESC