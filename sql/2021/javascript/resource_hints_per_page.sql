#standardSQL
CREATE TEMPORARY FUNCTION getResourceHintAttrs(payload STRING)
RETURNS ARRAY<STRUCT<name STRING, attribute STRING, value STRING>>
LANGUAGE js AS '''
var hints = new Set(['preload', 'prefetch']);
var attributes = ['as'];
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return almanac['link-nodes'].nodes.reduce((results, link) => {
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

SELECT
  percentile,
  client,
  APPROX_QUANTILES(script_hint, 1000)[OFFSET(percentile * 10)] AS hints_per_page,
  APPROX_QUANTILES(IF(script_hint = 0, NULL, script_hint), 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS hints_per_page_with_hints
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    COUNTIF(hint.name IN ('prefetch', 'preload') AND hint.value = 'script') AS script_hint
  FROM
    `httparchive.pages.2021_07_01_*`
  LEFT JOIN
    UNNEST(getResourceHintAttrs(payload)) AS hint
  GROUP BY
    client,
    page),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
