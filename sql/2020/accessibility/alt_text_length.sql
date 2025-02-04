#standardSQL
# Alt text length
SELECT
  client,

  percentile,
  APPROX_QUANTILES(alt_length, 1000)[OFFSET(percentile * 10)] AS alt_length
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    SAFE_CAST(alt_length_string AS INT64) AS alt_length
  FROM
    `httparchive.pages.2020_08_01_*`,
    UNNEST(
      JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.images.alt_lengths')
    ) AS alt_length_string
),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
WHERE
  alt_length > 0
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
