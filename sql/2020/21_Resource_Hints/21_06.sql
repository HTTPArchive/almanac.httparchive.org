#standardSQL
# 21_06: Frequency of link tags that set both preconnect & dns-prefetch
CREATE TEMPORARY FUNCTION getResourceHints(payload STRING)
RETURNS BOOLEAN
LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return !!almanac['link-nodes'].find((node) => {
    var rel = node.rel.toLowerCase();
    return rel.includes("preconnect") && rel.includes("dns-prefetch");
  });
} catch (e) {
  return false;
}
''';
SELECT
    COUNTIF(getResourceHints(payload)) AS freq,
    COUNT(0) AS total
FROM
    `httparchive.almanac.pages`
WHERE
    edition = "2020"