#standardSQL
# Top Ecommerce platforms, compared to until 2021
# top_ecommerce.sql
SELECT
  client,
  2024 AS year,
  technologies.technology AS ecommerce,
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
  cats = 'Ecommerce' AND
  date = '2024-06-01' AND
  is_root_page AND
  technologies.technology NOT IN ('Cart Functionality', 'Google Analytics Enhanced eCommerce')
GROUP BY
  client,
  total,
  ecommerce
UNION ALL
SELECT
  client,
  2023 AS year,
  technologies.technology AS ecommerce,
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
  cats = 'Ecommerce' AND
  date = '2023-06-01' AND
  is_root_page AND
  technologies.technology NOT IN ('Cart Functionality', 'Google Analytics Enhanced eCommerce')
GROUP BY
  client,
  total,
  ecommerce
UNION ALL
SELECT
  client,
  2022 AS year,
  technologies.technology AS ecommerce,
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
  cats = 'Ecommerce' AND
  date = '2022-08-01' AND
  is_root_page AND
  technologies.technology NOT IN ('Cart Functionality', 'Google Analytics Enhanced eCommerce')
GROUP BY
  client,
  total,
  ecommerce
UNION ALL
SELECT
  client,
  2021 AS year,
  technologies.technology AS ecommerce,
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
  cats = 'Ecommerce' AND
  date = '2021-07-01' AND
  is_root_page AND
  technologies.technology NOT IN ('Cart Functionality', 'Google Analytics Enhanced eCommerce')
GROUP BY
  client,
  total,
  ecommerce
ORDER BY
  year DESC,
  pct DESC
