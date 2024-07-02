SELECT
  percentile,
  client,
  COUNT(DISTINCT url) AS total,
  APPROX_QUANTILES(KiB_size, 1000)[OFFSET(percentile * 10)] AS KiB_size
FROM (
  SELECT
    url,
    client,
    percentile,
    respBodySize / 1024 AS KiB_size
  FROM
    `httparchive.almanac.requests`,
    UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
  WHERE
    date = '2022-06-01' AND
    type = 'font')
GROUP BY
  client,
  percentile
ORDER BY
  client,
  percentile
