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
  percentile,
  APPROX_QUANTILES(num_link_rel_preload, 1000)[OFFSET(percentile * 10)] AS num_percentiles
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    getNumLinkRelPreload(payload) AS num_link_rel_preload
  FROM
    `httparchive.pages.2022_06_01_*`
),
UNNEST([10, 25, 50, 75, 90, 95, 100]) AS percentile
GROUP BY
  client,
  percentile
ORDER BY
  client,
  percentile
