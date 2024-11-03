CREATE TEMPORARY FUNCTION getResourceHints(payload STRING)
RETURNS ARRAY < STRUCT < name STRING, href STRING >>
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

WITH resource_hints AS (
  SELECT DISTINCT
    client,
    page,
    hint.name
  FROM
    `httparchive.all.pages`
  LEFT JOIN
    UNNEST(getResourceHints(payload)) AS hint
  WHERE
    date = '2024-06-01' AND
    is_root_page
),

font_requests AS (
  SELECT
    client,
    page,
    type
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-06-01' AND
    type = 'font' AND
    is_root_page
)

SELECT
  client,
  name,
  COUNT(DISTINCT page) AS pages,
  SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS total,
  COUNT(DISTINCT page) / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS pct_hints
FROM
  resource_hints
LEFT JOIN
  font_requests
USING
  (client, page)
GROUP BY
  client, name, type
ORDER BY
  pct_hints DESC;
