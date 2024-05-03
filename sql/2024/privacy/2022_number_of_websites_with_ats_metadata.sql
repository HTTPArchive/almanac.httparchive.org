#standardSQL
# Counts of pages with Ads Transparency Spotlight metadata
# https://github.com/Ads-Transparency-Spotlight/documentation/blob/main/implement.md

SELECT
  _TABLE_SUFFIX AS client,
  COUNT(DISTINCT url) AS total_websites,
  COUNT(DISTINCT IF(LOWER(JSON_VALUE(meta_node, '$.name')) = 'adsmetadata', url, NULL)) AS number_of_websites,
  COUNT(DISTINCT IF(LOWER(JSON_VALUE(meta_node, '$.name')) = 'adsmetadata', url, NULL)) / COUNT(DISTINCT url) AS pct_websites
FROM
  `httparchive.pages.2022_06_01_*`,
  UNNEST(JSON_QUERY_ARRAY(JSON_VALUE(payload, '$._almanac'), '$.meta-nodes.nodes')) meta_node
GROUP BY 1
