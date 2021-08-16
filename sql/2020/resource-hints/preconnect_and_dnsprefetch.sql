#standardSQL
# 21_06: Frequency of link tags that set both preconnect & dns-prefetch
CREATE TEMPORARY FUNCTION preconnectsAndPrefetchesDns(payload STRING)
RETURNS BOOLEAN
LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return !!almanac['link-nodes'].nodes.find((node) => {
    var rel = node.rel.toLowerCase();
    return rel.includes("preconnect") && rel.includes("dns-prefetch");
  });
} catch (e) {
  return false;
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  COUNTIF(preconnectsAndPrefetchesDns(payload)) AS freq,
  COUNT(0) AS total,
  COUNTIF(preconnectsAndPrefetchesDns(payload)) / COUNT(0) AS pct
FROM
  `httparchive.pages.2020_08_01_*`
GROUP BY
  client
