-- Section: Performance
-- Question: What is the usage of link relationship in HTML?

CREATE TEMPORARY FUNCTION HINTS(payload STRING)
RETURNS ARRAY<STRUCT<name STRING, href STRING>>
LANGUAGE js AS '''
var hints = new Set(['preload', 'prefetch', 'preconnect', 'prerender', 'dns-prefetch']);
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return almanac['link-nodes'].nodes.reduce((results, link) => {
    var hint = link.rel.toLowerCase();
    if (!hints.has(hint)) {
      return results;
    }
    results.push({
      name: hint,
      href: link.href
    });
    return results;
  }, []);
} catch (e) {
  return [];
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
    date = '2024-06-01' AND
    type = 'font'
  GROUP BY
    client,
    page
),
hints AS (
  SELECT
    client,
    page,
    hint.name AS hint
  FROM
    `httparchive.all.requests`,
    UNNEST(HINTS(payload)) AS hint
  WHERE
    date = '2024-06-01' AND
    type = 'html'
  GROUP BY
    client,
    page,
    hint
)

SELECT
  client,
  hint,
  COUNT(DISTINCT page) AS count,
  SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS total,
  COUNT(DISTINCT page) / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS proportion
FROM
  fonts
LEFT JOIN
  hints USING (client, page)
GROUP BY
  client,
  hint
ORDER BY
  client,
  proportion DESC
