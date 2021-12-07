#standardSQL
# Adoption of image formats in SSGs
SELECT
  client,
  format,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    format,
    page
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2020-08-01' AND
    type = 'image')
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page
  FROM
    `httparchive.technologies.2020_08_01_*`
  WHERE
    LOWER(category) = "static site generator" OR
    app = "Next.js" OR
    app = "Nuxt.js" OR
    app = "Docusaurus")
USING
  (client, page)
GROUP BY
  client,
  format
ORDER BY
  pct DESC
