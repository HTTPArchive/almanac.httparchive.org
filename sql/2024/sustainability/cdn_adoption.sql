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
    client,
    COUNT(0) AS total,
    ARRAY_CONCAT_AGG(SPLIT(JSON_EXTRACT_SCALAR(summary, '$.cdn'), ', ')) AS cdn_list
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01' AND
    is_root_page = TRUE
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
  cdn;
