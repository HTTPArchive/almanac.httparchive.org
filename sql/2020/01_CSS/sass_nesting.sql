#standardSQL
CREATE TEMPORARY FUNCTION getNestedUsage(payload STRING) RETURNS
ARRAY<STRUCT<nested STRING, freq INT64>> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var scss = JSON.parse($['_sass']);
  if (!scss.scss) {
    return [];
  }

  return Object.entries(scss.scss.stats.nested).map(([nested, freq]) => {
    return {nested, freq};
  });
} catch (e) {
  return [];
}
''';

SELECT
  client,
  nested,
  COUNT(DISTINCT IF(freq > 0, page, NULL)) AS pages,
  SUM(freq) AS freq,
  SUM(SUM(freq)) OVER (PARTITION BY client) AS total,
  SUM(freq) / SUM(SUM(freq)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    nested.nested,
    SUM(nested.freq) AS freq
  FROM
    `httparchive.pages.2020_08_01_*`,
    UNNEST(getNestedUsage(payload)) AS nested
  GROUP BY
    client,
    page,
    nested)
GROUP BY
  client,
  nested
ORDER BY
  pct DESC