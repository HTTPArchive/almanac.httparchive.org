#standardSQL

# Number of <link rel="preload">.

CREATE TEMPORARY FUNCTION getNumLinkRelPreload(almanac_custom_metric STRING)
RETURNS INT LANGUAGE js AS '''
try {
  const almanac = JSON.parse(almanac_custom_metric);
  const link_preload_nodes = almanac['link-nodes']['nodes'].filter(link_node => link_node['rel'] === 'preload')
  return link_preload_nodes.length;
} catch (e) {
  return -1;
}
''';

SELECT
  client,
  is_root_page,
  COUNTIF(num_link_rel_preload_tag > 0) AS num_sites_using_link_preload_tag,
  COUNT(0) AS total_sites,
  COUNTIF(num_link_rel_preload_tag > 0) / COUNT(0) AS pct_sites_using_link_preload_tag
FROM (
  SELECT
    client,
    is_root_page,
    getNumLinkRelPreload(JSON_EXTRACT(custom_metrics, '$.almanac')) AS num_link_rel_preload_tag
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
)
GROUP BY
  client,
  is_root_page
ORDER BY
  client,
  is_root_page
