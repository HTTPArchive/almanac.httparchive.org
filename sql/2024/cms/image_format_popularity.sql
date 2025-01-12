#standardSQL
# Image format popularity BY CMS
# image_format_popularity.sql

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
    client,
    page AS url,
    technologies.technology AS cms
  FROM
    `httparchive.all.pages`,
    UNNEST(technologies) AS technologies,
    UNNEST(technologies.categories) AS cats
  WHERE
    cats = 'CMS' AND
    date = '2024-06-01' AND
    is_root_page
)
JOIN (
  SELECT
    client,
    page AS url,
    CASE
      WHEN JSON_VALUE(summary, '$.mimeType') = 'image/avif' THEN 'avif'
      WHEN JSON_VALUE(summary, '$.mimeType') = 'image/webp' THEN 'webp'
      WHEN JSON_VALUE(summary, '$.mimeType') = 'image/jpeg' THEN 'jpg'
      WHEN JSON_VALUE(summary, '$.mimeType') = 'image/png' THEN 'png'
      WHEN JSON_VALUE(summary, '$.mimeType') = 'image/gif' THEN 'gif'
      WHEN JSON_VALUE(summary, '$.mimeType') = 'image/svg+xml' THEN 'svg'
      WHEN JSON_VALUE(summary, '$.mimeType') = 'image/x-icon' THEN 'ico'
      WHEN JSON_VALUE(summary, '$.mimeType') = 'image/vnd.microsoft.icon' THEN 'ico'
      WHEN JSON_VALUE(summary, '$.mimeType') = 'image/jpg' THEN 'jpg'
      WHEN JSON_VALUE(summary, '$.mimeType') = 'image/bmp' THEN 'bmp'
      WHEN JSON_VALUE(summary, '$.mimeType') = 'binary/octet-stream' THEN 'binary/octet-stream'
      ELSE 'other/unknown' -- TO handle ANY unexpected formats
    END
      AS format
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-06-01' AND
    type = 'image' AND
    is_root_page
)
USING (client, url)
JOIN (
  SELECT
    client,
    technologies.technology AS cms,
    COUNT(DISTINCT page) AS pages
  FROM
    `httparchive.all.pages`,
    UNNEST(technologies) AS technologies,
    UNNEST(technologies.categories) AS cats
  WHERE
    cats = 'CMS' AND
    date = '2024-06-01' AND
    is_root_page
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
