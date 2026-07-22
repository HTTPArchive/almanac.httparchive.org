# Note due to a problem with meta_viewport this doesn't actually return data for '2025-07-01' but will for later years

CREATE TEMPORARY FUNCTION normalise(content STRING) RETURNS STRING LANGUAGE js AS '''
try {
  // split by ,
  // trim
  // lower case
  // alphabetize
  // re join by comma

  return content.split(",").map(c1 => c1.trim().toLowerCase().replace(/ +/g, "").replace(/\\.0*/,"")).sort().join(",");
} catch (e) {
  return '';
}
''';

SELECT
  client,
  normalise(JSON_VALUE(custom_metrics.other.meta_viewport)) AS meta_viewport,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.crawl.pages`
WHERE
  date = '2025-07-01'
GROUP BY
  client,
  meta_viewport
ORDER BY
  pct DESC
LIMIT
  100
