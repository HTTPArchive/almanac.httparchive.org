#standardSQL
# The distribution of CDN adoption on websites by percentile and client.
SELECT
  client,
  percentile,
  cdn,
  COUNT(0) AS freq,
  total,
  COUNT(0) / total AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    percentile,
    COUNT(0) AS total,
    ARRAY_CONCAT_AGG(SPLIT(cdn, ', ')) AS cdn_list
  FROM
    `httparchive.summary_pages.2022_06_01_*`,
    UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
  GROUP BY
    percentile,
    client),
  UNNEST(cdn_list) AS cdn
GROUP BY
  percentile,
  client,
  cdn,
  total
ORDER BY
  client,
  percentile
