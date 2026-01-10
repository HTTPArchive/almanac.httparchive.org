-- Section: Performance
-- Question: What is the usage of link relationship in HTML?
-- Normalization: Pages

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/2024/fonts/common.sql

CREATE TEMPORARY FUNCTION HINTS(json STRING)
RETURNS ARRAY<STRUCT<name STRING, type STRING, url STRING>>
LANGUAGE js AS '''
const names = new Set([
  'dns-prefetch',
  'preconnect',
  'prefetch',
  'preload',
]);
try {
  const $ = JSON.parse(json);
  return $.almanac['link-nodes'].nodes.reduce((results, node) => {
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
    `httparchive.all.pages` AS pages,
    UNNEST(HINTS(custom_metrics)) AS hint
  LEFT JOIN
    `httparchive.all.requests` AS requests
  ON
    requests.date IN ('2022-06-01', '2022-07-01', '2023-07-01', '2024-07-01') AND -- noqa: CV09
    requests.type = 'font' AND
    requests.is_root_page AND
    pages.page = requests.page AND
    hint.url = requests.url
  WHERE
    pages.date IN ('2022-06-01', '2022-07-01', '2023-07-01', '2024-07-01') AND -- noqa: CV09
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
    `httparchive.all.pages`
  WHERE
    date IN ('2022-06-01', '2022-07-01', '2023-07-01', '2024-07-01') AND -- noqa: CV09
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
  count / total AS proportion
FROM
  hints
LEFT JOIN
  pages
USING (date, client)
ORDER BY
  date,
  client,
  proportion DESC
