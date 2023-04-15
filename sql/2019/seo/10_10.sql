#standardSQL
# 10_10: linking - extract <a href> count per page (internal + external + hash)
SELECT
  percentile,
  client,
  APPROX_QUANTILES(internal, 1000)[OFFSET(percentile * 10)] AS internal,
  APPROX_QUANTILES(external, 1000)[OFFSET(percentile * 10)] AS external,
  APPROX_QUANTILES(_hash, 1000)[OFFSET(percentile * 10)] AS _hash
FROM (
  SELECT
    client,
    CAST(JSON_EXTRACT_SCALAR(almanac, "$['seo-anchor-elements'].internal") AS INT64) AS internal,
    CAST(JSON_EXTRACT_SCALAR(almanac, "$['seo-anchor-elements'].external") AS INT64) AS external,
    CAST(JSON_EXTRACT_SCALAR(almanac, "$['seo-anchor-elements'].hash") AS INT64) AS _hash
  FROM (
    SELECT
      _TABLE_SUFFIX AS client,
      JSON_EXTRACT_SCALAR(payload, '$._almanac') AS almanac
    FROM
      `httparchive.pages.2019_07_01_*`
  )
),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
