#standardSQL
# returns the number of unused preloaded resources

CREATE TEMPORARY FUNCTION getResourceHints(payload STRING)
RETURNS STRUCT<preload BOOLEAN, prefetch BOOLEAN, preconnect BOOLEAN, prerender BOOLEAN, `dns-prefetch` BOOLEAN, `modulepreload` BOOLEAN>
LANGUAGE js AS '''
var hints = ['preload', 'prefetch', 'preconnect', 'prerender', 'dns-prefetch', 'modulepreload'];
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return hints.reduce((results, hint) => {
    results[hint] = !!almanac['link-nodes'].nodes.find(link => link.rel.toLowerCase() == hint);
    return results;
  }, {});
} catch (e) {
  return hints.reduce((results, hint) => {
    results[hint] = false;
    return results;
  }, {});
}
''';

SELECT
  client,
  ARRAY_LENGTH(value) AS num_unused_preload,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    REGEXP_EXTRACT_ALL(consoleLog, r'The resource (.*?) was preloaded using link preload but not used within a few seconds from the window\'s load event') AS value
  FROM (
    SELECT
      _TABLE_SUFFIX AS client,
      JSON_EXTRACT(payload, "$._consoleLog") AS consoleLog,
      getResourceHints(payload) AS hints
    FROM
      `httparchive.pages.2021_07_01_*`
  )
  WHERE hints.preload
)
GROUP BY
  client,
  num_unused_preload
ORDER BY
  client,
  num_unused_preload
