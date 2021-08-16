#standardSQL
# 21_03: Attribute popularity for each hint.
CREATE TEMPORARY FUNCTION getResourceHintAttrs(payload STRING)
RETURNS ARRAY<STRUCT<name STRING, attribute STRING, value STRING>>
LANGUAGE js AS '''
var hints = new Set(['preload', 'prefetch', 'preconnect', 'prerender', 'dns-prefetch']);
var attributes = ['as', 'crossorigin', 'media'];
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  var nodes = almanac['link-nodes'].nodes || almanac['link-nodes'];
  return nodes.reduce((results, link) => {
    var hint = link.rel.toLowerCase();
    if (!hints.has(hint)) {
      return results;
    }
    attributes.forEach(attribute => {
      var value = link[attribute];
      results.push({
        name: hint,
        attribute: attribute,
        // Support empty strings.
        value: typeof value == 'string' ? value : null
      });
    });
    return results;
  }, []);
} catch (e) {
  return [];
}
''';

WITH pages AS (
  SELECT
    _TABLE_SUFFIX,
    2020 AS year,
    payload
  FROM
    `httparchive.pages.2020_08_01_*`
  UNION ALL
  SELECT
    _TABLE_SUFFIX,
    2019 AS year,
    payload
  FROM
    `httparchive.pages.2019_07_01_*`
)

SELECT
  year,
  _TABLE_SUFFIX AS client,
  IFNULL(NORMALIZE_AND_CASEFOLD(hint.value), 'not set') AS value,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY year, _TABLE_SUFFIX) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY year, _TABLE_SUFFIX) AS pct
FROM
  pages,
  UNNEST(getResourceHintAttrs(payload)) AS hint
WHERE
  name IN ('preload', 'prefetch') AND
  attribute = 'as'
GROUP BY
  year,
  client,
  value
ORDER BY
  pct DESC
