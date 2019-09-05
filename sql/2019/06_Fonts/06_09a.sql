#standardSQL
# 06_09a: distribution of fonts per page
SELECT
  percentile,
  client,
  APPROX_QUANTILES(fonts_per_page, 1000)[OFFSET(percentile * 10)] AS fonts
FROM (
  SELECT
    client,
    COUNT(0) AS fonts_per_page
  FROM
    `httparchive.almanac.requests`
  WHERE
    type = 'font'
  GROUP BY
    client,
    page),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client