#standardSQL
# The distribution of CDN adoption on websites by client.
SELECT
  client,
  IF(cdn = '', 'No CDN', cdn) AS cdn,
  COUNT(0) AS freq,
  total,
  COUNT(0) / total AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total,
    ARRAY_CONCAT_AGG(SPLIT(cdn, ', ')) AS cdn_list
  FROM
    `httparchive.summary_pages.2022_06_01_*`
  GROUP BY
    client
),
  UNNEST(cdn_list) AS cdn
GROUP BY
  client,
  cdn,
  total
ORDER BY
  pct DESC,
  client,
  cdn
