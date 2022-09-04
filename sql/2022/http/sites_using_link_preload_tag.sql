#standardSQL

# Number of <link rel="preload">.

CREATE TEMPORARY FUNCTION getNumLinkRelPreload(payload STRING)
RETURNS INT LANGUAGE js AS """
try {
  const $ = JSON.parse(payload)
  const almanac = JSON.parse($._almanac);
  const link_preload_nodes = almanac['link-nodes']['nodes'].filter(link_node => link_node['rel'] === 'preload')
  return link_preload_nodes.length;
} catch (e) {
  return -1;
}
""";

SELECT
  client,
  COUNTIF(num_link_rel_preload_tag > 0) AS num_sites_using_link_preload_tag,
  COUNT(0) AS total_sites,
  COUNTIF(num_link_rel_preload_tag > 0) / COUNT(0) AS pct_sites_using_link_preload_tag
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    getNumLinkRelPreload(payload) AS num_link_rel_preload_tag
  FROM
    `httparchive.pages.2022_06_01_*`
)
GROUP BY
  client
