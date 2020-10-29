#standardSQL
#OpenType axis
CREATE TEMP FUNCTION getAxes(font_details STRING) RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  return Object.keys(JSON.parse(font_details).table_sizes);
} catch (e) {
  return [];
}
''';
SELECT
  client,
  axis,
  COUNT(DISTINCT page) AS pages,
  total_page,
  COUNT(DISTINCT page) / total_page AS pct_page,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_freq,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_freq
FROM (
  SELECT
    client,
    page,
    axis
  FROM
    `httparchive.almanac.requests`,
    UNNEST(getAxes(JSON_EXTRACT(payload,'$._font_details'))) AS axis
  WHERE
    date = '2020-09-01' AND
    type = 'font')
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_page
  FROM
    `httparchive.summary_pages.2020_09_01_*`
  GROUP BY
    _TABLE_SUFFIX)
USING
  (client)
GROUP BY
  client,
  axis,
  total_page
ORDER BY
  pct_freq DESC