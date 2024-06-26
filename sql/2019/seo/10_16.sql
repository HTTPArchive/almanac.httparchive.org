#standardSQL
# 10_16: <h1> length
SELECT
  percentile,
  client,
  APPROX_QUANTILES(LENGTH(h1), 1000)[OFFSET(percentile * 10)] AS h1_length
FROM (
  SELECT
    client,
    REGEXP_EXTRACT(body, '(?i)<h1>([^(</h1>)]*)</h1>') AS h1
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
