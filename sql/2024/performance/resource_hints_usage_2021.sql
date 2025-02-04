CREATE TEMPORARY FUNCTION getResourceHints(payload STRING)
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

WITH resource_hints AS (
  SELECT DISTINCT
    _TABLE_SUFFIX AS client,
    url,
    hint.name AS name
  FROM
    `httparchive.pages.2021_07_01_*`
  LEFT JOIN
    UNNEST(getResourceHints(payload)) AS hint
),

totals AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_pages
  FROM
    `httparchive.pages.2021_07_01_*`
  GROUP BY
    client
)

SELECT
  client,
  name,
  COUNT(DISTINCT url) AS pages,
  ANY_VALUE(total_pages) AS total,
  COUNT(DISTINCT url) / ANY_VALUE(total_pages) AS pct
FROM
  resource_hints
JOIN
  totals
USING (client)
GROUP BY
  client,
  name
ORDER BY
  client,
  name
