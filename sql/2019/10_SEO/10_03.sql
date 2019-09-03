#standardSQL

# <link rel="amphtml"> (AMP)

CREATE TEMP FUNCTION hasAmpLink(payload STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return !!almanac['link-nodes'].find(node => node.rel.toLowerCase() == 'amphtml')
} catch (e) {
  return false;
}
''';

SELECT
  COUNTIF(hasAmpLink(payload)) AS score_sum,
  ROUND(COUNTIF(hasAmpLink(payload)) * 100 / COUNT(0), 2) AS score_percentage
FROM
  `httparchive.pages.2019_07_01_*`
