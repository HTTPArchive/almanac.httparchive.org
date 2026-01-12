#standardSQL
# Top WordPress page builder combinations
# wordpress_page_builders.sql

SELECT
  client,
  page_builders,
  COUNT(0) AS pages,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT DISTINCT
    client,
    page AS url
  FROM
    `httparchive.crawl.pages`,
    UNNEST(technologies) AS technologies,
    UNNEST(technologies.categories) AS cats
  WHERE
    technologies.technology = 'WordPress' AND
    date = '2025-07-01'
)
JOIN (
  SELECT
    client,
    page AS url,
    ARRAY_TO_STRING(ARRAY_AGG(technologies.technology ORDER BY technologies.technology), ', ') AS page_builders
  FROM
    `httparchive.crawl.pages`,
    UNNEST(technologies) AS technologies,
    UNNEST(technologies.categories) AS cats
  WHERE
    cats = 'Page builders' AND
    date = '2025-07-01'
  GROUP BY
    client,
    url
)
USING (client, url)
GROUP BY
  client,
  page_builders
ORDER BY
  pct DESC
