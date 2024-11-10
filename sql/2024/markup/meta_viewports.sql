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

WITH viewports AS (
  SELECT
    client,
    normalise(SAFE_CAST(JSON_EXTRACT(summary, '$.meta_viewport') AS STRING)) AS meta_viewport,
    COUNT(0) AS freq,
    SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
    COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
  GROUP BY
    client,
    meta_viewport
)

SELECT
  *
FROM
  viewports
ORDER BY
  pct DESC
LIMIT
  100
