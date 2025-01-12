#standardSQL
# 10_03: <link rel="amphtml"> (AMP)
CREATE TEMP FUNCTION hasAmpLink(payload STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return !!almanac['link-nodes'].find(node => node.rel.toLowerCase() == 'amphtml');
} catch (e) {
  return false;
}
''';

SELECT
  client,
  COUNTIF(has_amp_link) AS freq,
  COUNT(0) AS total,
  ROUND(COUNTIF(has_amp_link) * 100 / COUNT(0), 2) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    hasAmpLink(payload) AS has_amp_link
  FROM
    `httparchive.pages.2019_07_01_*`
)
GROUP BY
  client
