#standardSQL
# Distribution of max-age values
SELECT
  percentile,
  _TABLE_SUFFIX AS client,
  APPROX_QUANTILES(CAST(max_age AS NUMERIC), 1000)[OFFSET(percentile * 10)] AS max_age
FROM (
  SELECT
    _TABLE_SUFFIX,
    REGEXP_EXTRACT(resp_cache_control, r'(?i)max-age\s*=\s*(\d+)') AS max_age
  FROM
    `httparchive.summary_requests.2021_07_01_*`
  ),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
WHERE
  max_age IS NOT NULL
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
