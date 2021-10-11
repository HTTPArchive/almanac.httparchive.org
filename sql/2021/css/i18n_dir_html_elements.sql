#standardSQL
CREATE TEMPORARY FUNCTION getMarkupDirs(payload STRING)
RETURNS ARRAY<STRUCT<element STRING, value STRING>>
LANGUAGE js
AS '''
try {
  var $ = JSON.parse(payload);
  var dirs = JSON.parse($._markup).dirs;
  var result = [];

  result.push({
    element: 'html',
    value: dirs.html_dir.trim().toLowerCase()
  });

  Object.entries(dirs.body_nodes_dir.values).forEach(([value, freq]) => {
    result.push({
      element: 'body',
      value: value.trim().toLowerCase()
    });
  });

  return result;
} catch (e) {
  return [];
}
''';

SELECT
  *
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    dir.element,
    dir.value,
    COUNT(0) AS freq,
    SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX, dir.element) AS total,
    COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX, dir.element) AS pct
  FROM
    `httparchive.pages.2021_07_01_*`,
    UNNEST(getMarkupDirs(payload)) AS dir
  GROUP BY
    client,
    element,
    value)
WHERE
  freq >= 100
ORDER BY
  pct DESC
