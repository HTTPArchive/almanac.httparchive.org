#standardSQL
# 10_07b: <title> length
SELECT
  percentile,
  client,
  APPROX_QUANTILES(LENGTH(title), 1000)[OFFSET(percentile * 10)] AS title_length
FROM (
  SELECT
    client,
    REGEXP_EXTRACT(body, '(?i)<title>([^(</title>)]*)</title>') AS title
  FROM
    `httparchive.almanac.summary_response_bodies`
  WHERE
    date = '2019-07-01' AND
    firstHtml
),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
