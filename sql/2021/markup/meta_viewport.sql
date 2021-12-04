#standardSQL
# meta viewport

CREATE TEMPORARY FUNCTION normalise(content STRING)
RETURNS STRING LANGUAGE js AS '''
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
  _TABLE_SUFFIX AS client,
  normalise(meta_viewport) AS meta_viewport,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS pct
FROM
  `httparchive.summary_pages.2021_07_01_*`
GROUP BY
  client,
  meta_viewport
ORDER BY
  pct DESC,
  client,
  freq DESC
LIMIT 100
