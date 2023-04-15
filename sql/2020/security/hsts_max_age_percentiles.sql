#standardSQL
# Distribution of max-age value of Strict-Transport-Security header
SELECT
  client,
  percentile,
  APPROX_QUANTILES(max_age, 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS max_age
FROM (
  SELECT
    client,
    SAFE_CAST(REGEXP_EXTRACT(REGEXP_EXTRACT(respOtherHeaders, r'(?i)strict-transport-security =([^,]+)'), r'(?i)max-age=\s*(-?\d+)') AS NUMERIC) AS max_age
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2020-08-01'
),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
