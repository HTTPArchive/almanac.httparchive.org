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
    `httparchive.technologies.2024_06_01_*`
  WHERE
    category = 'CMS')
JOIN (
    SELECT
    client,
    page AS url,
    CASE 
      WHEN json_value(summary, "$.mimeType") = 'image/avif' THEN 'avif'
      WHEN json_value(summary, "$.mimeType") = 'image/webp' THEN 'webp'
      WHEN json_value(summary, "$.mimeType") = 'image/jpeg' THEN 'jpg'
      WHEN json_value(summary, "$.mimeType") = 'image/png' THEN 'png'
      WHEN json_value(summary, "$.mimeType") = 'image/gif' THEN 'gif'
      WHEN json_value(summary, "$.mimeType") = 'image/svg+xml' THEN 'svg'
      WHEN json_value(summary, "$.mimeType") = 'image/x-icon' THEN 'ico'
      WHEN json_value(summary, "$.mimeType") = 'image/vnd.microsoft.icon' THEN 'ico'
      WHEN json_value(summary, "$.mimeType") = 'image/jpg' THEN 'jpg'
      WHEN json_value(summary, "$.mimeType") = 'image/bmp' THEN 'bmp'
      WHEN json_value(summary, "$.mimeType") = 'binary/octet-stream' THEN 'binary/octet-stream' 
      ELSE 'other/unknown'  -- To handle any unexpected formats
    END AS format
  FROM
    httparchive.all.requests
  WHERE
    date = '2024-06-01' AND
    type = 'image')
USING
  (client, url)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    app AS cms,
    COUNT(DISTINCT url) AS pages
  FROM
    `httparchive.technologies.2024_06_01_*`
  WHERE
    category = 'CMS'
  GROUP BY
    client,
    cms)
USING
  (client, cms)
WHERE
  pages > 1000
GROUP BY
  client,
  cms,
  format
ORDER BY
  freq DESC
