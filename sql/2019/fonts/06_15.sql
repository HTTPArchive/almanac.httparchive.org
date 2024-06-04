#standardSQL
# 06_15: % of pages preconnecting a web font host
CREATE TEMPORARY FUNCTION getPreconnectUrls(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return almanac['link-nodes'].filter(link => link.rel == 'preconnect').map(link => link.href);
} catch (e) {
  return [];
}
''';

SELECT
  client,
  COUNT(DISTINCT page) AS freq,
  total,
  ROUND(COUNT(DISTINCT page) * 100 / total, 2) AS pct
FROM (SELECT _TABLE_SUFFIX AS client, url AS page, payload FROM `httparchive.pages.2019_07_01_*`)
JOIN (SELECT client, page, url FROM `httparchive.almanac.requests` WHERE date = '2019-07-01' AND type = 'font')
USING (client, page)
JOIN (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
USING (client),
  UNNEST(getPreconnectUrls(payload)) AS preconnect_url
WHERE
  # hosts match
  NET.HOST(preconnect_url) = NET.HOST(url) AND
  # protocols match
  SUBSTR(preconnect_url, 0, 5) = SUBSTR(url, 0, 5)
GROUP BY
  client,
  total
