#standardSQL
# 08_22: HSTS - variance in max-age
SELECT
  percentile,
  client,
  APPROX_QUANTILES(max_age, 1000)[OFFSET(percentile * 10)] AS max_age
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(REGEXP_EXTRACT(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\W?strict-transport-security =([^,]+)'), r'(?i)max-age= *-?(\d+)') AS INT64) AS max_age
  FROM
    `httparchive.summary_requests.2019_07_01_*`
  WHERE
    firstHtml
),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
WHERE
  max_age IS NOT NULL
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
