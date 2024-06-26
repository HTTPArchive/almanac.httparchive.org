#standardSQL
# Image format popularity by CMS
SELECT
  client,
  cms,
  ANY_VALUE(pages) AS pages,
  format,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client, cms) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client, cms) AS pct
FROM (
  SELECT DISTINCT
    _TABLE_SUFFIX AS client,
    url,
    app AS cms
  FROM
    `httparchive.technologies.2022_06_01_*`
  WHERE
    category = 'CMS'
)
JOIN (
  SELECT
    client,
    page AS url,
    IF(mimeType = 'image/avif', 'avif', IF(mimeType = 'image/webp', 'webp', format)) AS format
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2022-06-01' AND
    type = 'image'
)
USING (client, url)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    app AS cms,
    COUNT(DISTINCT url) AS pages
  FROM
    `httparchive.technologies.2022_06_01_*`
  WHERE
    category = 'CMS'
  GROUP BY
    client,
    cms
)
USING (client, cms)
WHERE
  pages > 1000
GROUP BY
  client,
  cms,
  format
ORDER BY
  freq DESC
