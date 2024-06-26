#standardSQL
# 19_04: Popular resource types to preload/prefecth.
CREATE TEMPORARY FUNCTION getResourceHints(payload STRING)
RETURNS ARRAY<STRUCT<name STRING, href STRING>>
LANGUAGE js AS '''
var hints = new Set(['preload', 'prefetch']);
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return almanac['link-nodes'].reduce((results, link) => {
    var hint = link.rel.toLowerCase();
    if (!hints.has(hint)) {
      return results;
    }

    results.push({
      name: hint,
      href: link.href
    });

    return results;
  }, []);
} catch (e) {
  return [];
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  name,
  type,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX, name) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX, name), 2) AS pct
FROM (
  SELECT _TABLE_SUFFIX, url AS page, hint.name, hint.href AS url
  FROM `httparchive.pages.2019_07_01_*`, UNNEST(getResourceHints(payload)) AS hint
)
LEFT JOIN (
  SELECT client AS _TABLE_SUFFIX, page, url, type
  FROM `httparchive.almanac.summary_requests`
  WHERE date = '2019-07-01'
)
USING (_TABLE_SUFFIX, page, url)
GROUP BY
  client,
  name,
  type
ORDER BY
  freq DESC
