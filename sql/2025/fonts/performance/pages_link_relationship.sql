-- Section: Performance
-- Question: What is the usage of link relationship in HTML?
-- Normalization: Pages

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/{year}/fonts/common.sql

CREATE TEMPORARY FUNCTION HINTS(other JSON)
RETURNS ARRAY<STRUCT<name STRING, type STRING, url STRING>>
LANGUAGE js AS '''
const names = new Set([
  'dns-prefetch',
  'preconnect',
  'prefetch',
  'preload',
]);
try {
  return other.almanac['link-nodes'].nodes.reduce((results, node) => {
    const name = node.rel.toLowerCase();
    if (names.has(name)) {
      results.push({
        'name': name,
        'type': node.as,
        'url': node.href
      });
    }
    return results;
  }, []);
} catch (e) {
  return [];
}
''';

WITH
hints AS (
  SELECT
    pages.date,
    pages.client,
    hint.name AS hint,
    COUNT(DISTINCT pages.page) AS count
  FROM
    `httparchive.crawl.pages` AS pages,
    UNNEST(HINTS(custom_metrics.other)) AS hint
  LEFT JOIN
    `httparchive.crawl.requests` AS requests
  ON
    requests.date IN UNNEST(@dates) AND
    requests.type = 'font' AND
    requests.is_root_page AND
    pages.page = requests.page AND
    hint.url = requests.url
  WHERE
    pages.date IN UNNEST(@dates) AND
    pages.is_root_page AND
    (
      requests.url IS NOT NULL OR
      LOWER(hint.type) = 'font' OR
      SERVICE(hint.url) != 'self-hosted'
    )
  GROUP BY
    date,
    client,
    hint
),

pages AS (
  SELECT
    date,
    client,
    COUNT(DISTINCT page) AS total
  FROM
    `httparchive.crawl.pages`
  WHERE
    date IN UNNEST(@dates) AND
    is_root_page
  GROUP BY
    date,
    client
)

SELECT
  date,
  client,
  hint,
  count,
  total,
  ROUND(count / total, @precision) AS proportion
FROM
  hints
LEFT JOIN
  pages
USING (date, client)
ORDER BY
  date,
  client,
  count DESC
