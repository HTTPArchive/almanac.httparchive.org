#standardSQL
# TTL by resource and third-party
SELECT
  client,
  percentile,
  type,
  IF (STRPOS(NET.HOST(url), REGEXP_EXTRACT(NET.REG_DOMAIN(page), r'([\w-]+)')) > 0, 1, 3) AS party,
  APPROX_QUANTILES(expAge, 1000)[OFFSET(percentile * 10)] AS ttl
FROM
  `httparchive.almanac.requests`,
  UNNEST([10, 25, 50, 75, 90]) AS percentile
WHERE
  date = '2020-08-01' AND
  expAge > 0
GROUP BY
  client,
  type,
  party,
  percentile
ORDER BY
  client,
  type,
  party,
  percentile
