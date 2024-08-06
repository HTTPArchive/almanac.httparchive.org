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
  }, []);
} catch (e) {
  return [];
}
''';

WITH
hints AS (
  SELECT
    client,
    hint,
    COUNT(DISTINCT page) AS count
  FROM
    `httparchive.all.pages`,
    UNNEST(HINTS(custom_metrics)) AS hint
  WHERE
    date = '2024-07-01'
  GROUP BY
    client,
    hint
),
pages AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-07-01'
  GROUP BY
    client
)

SELECT
  client,
  hint,
  count,
  total,
  count / total AS proportion
FROM
  hints
LEFT JOIN
  pages USING (client)
ORDER BY
  client,
  proportion DESC
