CREATE TEMP FUNCTION getAxes(fvar STRING) RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  return Object.keys(JSON.parse(fvar));
} catch (e) {
  return [];
}
''';
SELECT
  client,
  axis,
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
    UNNEST(getAxes(JSON_EXTRACT(payload, '$._font_details.fvar'))) AS axis
  WHERE
    date = '2022-06-01' AND
    type = 'font')
GROUP BY
  client,
  axis
ORDER BY
  pct_freq DESC
