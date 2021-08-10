#standardSQL
# TTL by resource type for cacheable (no-store absent) content
SELECT
  _TABLE_SUFFIX AS client,
  type AS response_type,
  percentile,
  APPROX_QUANTILES(expAge, 1000)[OFFSET(percentile * 10)] AS ttl
FROM
 `httparchive.summary_requests.2020_08_01_*`,
  UNNEST([10, 25, 50, 75, 90]) AS percentile
WHERE
  NOT REGEXP_CONTAINS(resp_cache_control, r'(?i)no-store') AND
  expAge > 0
GROUP BY
  client,
  response_type,
  percentile
ORDER BY
  client,
  response_type,
  percentile
