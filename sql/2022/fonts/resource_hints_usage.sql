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
SELECT
  client,
  name,
  COUNT(DISTINCT page) AS pages,
  SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS total,
  COUNT(DISTINCT page) / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS pct_hints
FROM (
  SELECT DISTINCT
    _TABLE_SUFFIX AS client,
    url AS page,
    hint.name
  FROM
    `httparchive.pages.2022_06_01_*`
  LEFT JOIN
    UNNEST(getResourceHints(payload)) AS hint
)
LEFT JOIN (
  SELECT
    client,
    page,
    type
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2022-06-01'
)
USING (client, page)
WHERE
  type = 'font'
GROUP BY
  client,
  name,
  type
ORDER BY
  pct_hints DESC
