#standardSQL
# Top CMS platforms, compared to 2020
# top_cms.sql
SELECT
  client,
  2024 AS year,
  technologies.technology AS cms,
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
  total,
  cms
UNION ALL
SELECT
  client,
  2023 AS year,
  technologies.technology AS cms,
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
  total,
  cms
UNION ALL
SELECT
  client,
  2022 AS year,
  technologies.technology AS cms,
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
    date = '2022-08-01' AND
    is_root_page
  GROUP BY
    client)
USING
  (client)
WHERE
  cats = 'CMS' AND
  date = '2022-08-01' AND
  is_root_page
GROUP BY
  client,
  total,
  cms
UNION ALL
SELECT
  client,
  2021 AS year,
  technologies.technology AS cms,
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
    date = '2021-07-01' AND
    is_root_page
  GROUP BY
    client)
USING
  (client)
WHERE
  cats = 'CMS' AND
  date = '2021-07-01' AND
  is_root_page
GROUP BY
  client,
  total,
  cms
ORDER BY
  year DESC,
  pct DESC
