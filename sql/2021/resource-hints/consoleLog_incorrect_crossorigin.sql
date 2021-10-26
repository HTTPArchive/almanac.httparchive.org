#standardSQL
# returns the number of pages using preload tags without the required crossorigin attribute

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
''' ;

SELECT
  client,
  ARRAY_LENGTH(value) AS num_incorrect_crossorigin,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    REGEXP_EXTRACT_ALL(consoleLog, r'A preload for (.+?) is found, but is not used because the request credentials mode does not match') AS value
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
  num_incorrect_crossorigin
ORDER BY
  client,
  freq DESC
