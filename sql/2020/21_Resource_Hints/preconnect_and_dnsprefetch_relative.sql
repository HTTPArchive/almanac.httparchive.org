#standardSQL
# 21_06: Frequency of link tags that set both preconnect & dns-prefetch
CREATE TEMPORARY FUNCTION preconnectsAndPrefetchesDns(payload STRING)
RETURNS STRUCT<both BOOLEAN, either BOOLEAN> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return almanac['link-nodes'].nodes.reduce((obj, node) => {
    var rel = node.rel.toLowerCase();
    if (rel.includes("preconnect") && rel.includes("dns-prefetch")) {
      obj.both = true;
    }
    if (rel.includes("preconnect") || rel.includes("dns-prefetch")) {
      obj.either = true;
    }
    return obj;
  }, {});
} catch (e) {
  return {};
}
''';

SELECT
  client,
  COUNTIF(hint.both) AS freq_both,
  COUNTIF(hint.either) AS total_either,
  COUNTIF(hint.both) / COUNTIF(hint.either) AS pct_both
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    preconnectsAndPrefetchesDns(payload) AS hint
  FROM
    `httparchive.pages.2020_08_01_*`)
GROUP BY
  client