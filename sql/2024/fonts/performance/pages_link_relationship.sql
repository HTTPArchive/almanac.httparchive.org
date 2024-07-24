-- Section: Performance
-- Question: What is the usage of link relationship in HTML?

CREATE TEMPORARY FUNCTION HINTS(json STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS '''
var hints = new Set(['dns-prefetch', 'preconnect', 'prefetch', 'preload', 'prerender']);
try {
  var $ = JSON.parse(json);
  return $.almanac['link-nodes'].nodes.reduce((results, link) => {
    var hint = link.rel.toLowerCase();
    if (!hints.has(hint)) {
      return results;
    }
    results.push(hint);
    return results;
  }, ['total']);
} catch (e) {
  return ['total'];
}
''';

WITH
fonts AS (
  SELECT
    client,
    page
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND
    type = 'font'
  GROUP BY
    client,
    page
),
hints AS (
  SELECT
    client,
    page,
    hint
  FROM
    `httparchive.all.pages`,
    UNNEST(HINTS(custom_metrics)) AS hint
  WHERE
    date = '2024-07-01'
  GROUP BY
    client,
    page,
    hint
)

SELECT
  client,
  hint,
  COUNT(DISTINCT page) AS count,
  SUM(COUNT(DISTINCT IF(hint = 'total', NULL, page))) OVER (PARTITION BY client) AS total,
  COUNT(DISTINCT page) / SUM(COUNT(DISTINCT IF(hint = 'total', NULL, page))) OVER (PARTITION BY client) AS proportion
FROM
  hints
LEFT JOIN
  fonts USING (client, page)
GROUP BY
  client,
  hint
ORDER BY
  client,
  proportion DESC
