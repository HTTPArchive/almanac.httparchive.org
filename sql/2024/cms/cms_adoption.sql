#standardSQL
# CMS adoption OVER time
# cms_adoption.sql

SELECT
  client,
  2024 AS year,
  COUNT(DISTINCT page) AS freq,
  total,
  COUNT(DISTINCT page) / total AS pct
FROM
  `httparchive.all.pages`,
  UNNEST(technologies) AS technologies,
  UNNEST(technologies.categories) AS cats
JOIN (
  SELECT
    client,
    COUNT(0) AS total
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01' AND
    is_root_page
  GROUP BY
    client)
USING
  (client)
WHERE
  cats = 'CMS' AND
  date = '2024-06-01' AND
  is_root_page
GROUP BY
  client,
  total
UNION ALL
SELECT
  client,
  2023 AS year,
  COUNT(DISTINCT page) AS freq,
  total,
  COUNT(DISTINCT page) / total AS pct
FROM
  `httparchive.all.pages`,
  UNNEST(technologies) AS technologies,
  UNNEST(technologies.categories) AS cats
JOIN (
  SELECT
    client,
    COUNT(0) AS total
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2023-06-01' AND
    is_root_page
  GROUP BY
    client)
USING
  (client)
WHERE
  cats = 'CMS' AND
  date = '2023-06-01' AND
  is_root_page
GROUP BY
  client,
  total
UNION ALL
SELECT
  client,
  2022 AS year,
  COUNT(DISTINCT page) AS freq,
  total,
  COUNT(DISTINCT page) / total AS pct
FROM
  `httparchive.all.pages`,
  UNNEST(technologies) AS technologies,
  UNNEST(technologies.categories) AS cats
JOIN (
  SELECT
    client,
    COUNT(0) AS total
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2022-06-01' AND
    is_root_page
  GROUP BY
    client)
USING
  (client)
WHERE
  cats = 'CMS' AND
  date = '2022-06-01' AND
  is_root_page
GROUP BY
  client,
  total
ORDER BY
  year DESC,
  pct DESC
