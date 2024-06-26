#standardSQL
CREATE TEMPORARY FUNCTION getStatements(payload STRING) RETURNS
ARRAY<STRUCT<statement STRING, freq INT64>> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var scss = JSON.parse($['_sass']);
  if (!scss.scss) {
    return [];
  }

  var statements = new Set(['eaches', 'fors', 'ifs', 'whiles']);
  return Object.entries(scss.scss.stats).filter(([prop]) => {
    return statements.has(prop);
  }).map(([statement, obj]) => {
    if (statement == 'ifs') {
      return {statement, freq: obj.length};
    }
    return {statement, freq: Object.values(obj).reduce((total, i) => {
      if (isNaN(i)) {
        return total;
      }
      return total + i;
    }, 0)};
  });
} catch (e) {
  return [];
}
''';

WITH totals AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_pages,
    COUNTIF(SAFE_CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._sass'), '$.scss.size') AS INT64) > 0) AS total_sass
  FROM
    `httparchive.pages.2022_07_01_*` -- noqa: CV09
  GROUP BY
    client
)

SELECT
  client,
  statement,
  COUNT(DISTINCT IF(freq > 0, page, NULL)) AS pages,
  ANY_VALUE(total_pages) AS total_pages,
  ANY_VALUE(total_sass) AS total_sass_pages,
  COUNT(DISTINCT IF(freq > 0, page, NULL)) / ANY_VALUE(total_pages) AS pct_pages,
  COUNT(DISTINCT IF(freq > 0, page, NULL)) / ANY_VALUE(total_sass) AS pct_sass_pages,
  SUM(freq) AS freq,
  SUM(SUM(freq)) OVER (PARTITION BY client) AS total,
  SUM(freq) / SUM(SUM(freq)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    statement.statement,
    SUM(statement.freq) AS freq
  FROM
    `httparchive.pages.2022_07_01_*`, -- noqa: CV09
    UNNEST(getStatements(payload)) AS statement
  GROUP BY
    client,
    page,
    statement
)
JOIN
  totals
USING (client)
GROUP BY
  client,
  statement
ORDER BY
  pct DESC
