#standardSQL
CREATE TEMPORARY FUNCTION getFunctionCalls(payload STRING) RETURNS
ARRAY<STRUCT<fn STRING, freq INT64>> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var scss = JSON.parse($['_sass']);
  if (!scss.scss) {
    return [];
  }

  return Object.entries(scss.scss.stats.functionCalls).map(([fn, freq]) => {
    return {fn, freq};
  });
} catch (e) {
  return [];
}
''';

SELECT
  *
FROM (
  SELECT
    client,
    fn,
    SUM(freq) AS freq,
    SUM(SUM(freq)) OVER (PARTITION BY client) AS total,
    SUM(freq) / SUM(SUM(freq)) OVER (PARTITION BY client) AS pct
  FROM (
    SELECT
      _TABLE_SUFFIX AS client,
      fn.fn,
      fn.freq
    FROM
      `httparchive.pages.2020_08_01_*`,
      UNNEST(getFunctionCalls(payload)) AS fn)
  GROUP BY
    client,
    fn)
WHERE
  freq >= 1000
ORDER BY
  pct DESC