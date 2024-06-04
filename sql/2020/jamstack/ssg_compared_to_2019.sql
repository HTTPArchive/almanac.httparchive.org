#standardSQL
# SSG adoptions and top SSGs YoY
SELECT
  _TABLE_SUFFIX AS client,
  2020 AS year,
  app AS ssg,
  COUNT(0) AS freq,
  total,
  COUNT(0) / total AS pct
FROM
  `httparchive.technologies.2020_08_01_*`
JOIN (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2020_08_01_*`
  GROUP BY
    _TABLE_SUFFIX
)
USING (_TABLE_SUFFIX)
WHERE
  LOWER(category) = 'static site generator' OR
  app = 'Next.js' OR
  app = 'Nuxt.js' OR
  app = 'Docusaurus'
GROUP BY
  client,
  total,
  ssg
UNION ALL
SELECT
  _TABLE_SUFFIX AS client,
  2019 AS year,
  app AS ssg,
  COUNT(0) AS freq,
  total,
  COUNT(0) / total AS pct
FROM
  `httparchive.technologies.2019_07_01_*`
JOIN (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2019_07_01_*`
  GROUP BY
    _TABLE_SUFFIX
)
USING (_TABLE_SUFFIX)
WHERE
  LOWER(category) = 'static site generator' OR
  app = 'Next.js' OR
  app = 'Nuxt.js' OR
  app = 'Docusaurus'
GROUP BY
  client,
  total,
  ssg
ORDER BY
  year DESC,
  pct DESC
