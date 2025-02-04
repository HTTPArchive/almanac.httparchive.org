#standardSQL
# Adoption of top CDNs
SELECT
  client,
  cdn,
  COUNT(0) AS freq,
  total,
  COUNT(0) / total AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total,
    ARRAY_CONCAT_AGG(SPLIT(cdn, ', ')) AS cdn_list
  FROM
    `httparchive.summary_pages.2021_07_01_*`
  GROUP BY
    client
),
  UNNEST(cdn_list) AS cdn
GROUP BY
  client,
  cdn,
  total
ORDER BY
  pct DESC
