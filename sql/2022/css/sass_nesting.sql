#standardSQL
CREATE TEMPORARY FUNCTION getNestedUsage(payload STRING)
RETURNS ARRAY<STRUCT<nested STRING, freq INT64>>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  var $ = JSON.parse(payload);
  var scss = JSON.parse($['_sass']);
  if (!scss.scss) {
    return [];
  }

  let ret = scss.scss.stats.nested;
  ret.total = sumObject(ret);
  return Object.entries(ret).map(([nested, freq]) => {
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
  total_sass,
  COUNT(DISTINCT IF(freq > 0, page, NULL)) / total_sass AS pct_pages,
  SUM(freq) AS freq,
  SUM(SUM(freq)) OVER (PARTITION BY client) / 2 AS total,
  SUM(freq) / (SUM(SUM(freq)) OVER (PARTITION BY client) / 2) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    nested.nested,
    SUM(nested.freq) AS freq
  FROM
    `httparchive.pages.2022_07_01_*`, -- noqa: CV09
    UNNEST(getNestedUsage(payload)) AS nested
  GROUP BY
    client,
    page,
    nested
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNTIF(SAFE_CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._sass'), '$.scss.size') AS INT64) > 0) AS total_sass
  FROM
    `httparchive.pages.2022_07_01_*` -- noqa: CV09
  GROUP BY
    client
)
USING (client)
GROUP BY
  client,
  nested,
  total_sass
ORDER BY
  pct DESC
