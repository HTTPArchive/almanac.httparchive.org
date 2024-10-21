#standardSQL
# CSS-initiated image format popularity
SELECT
  client,
  format,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    page,
    url AS img_url,
    JSON_VALUE(payload, '$._initiator') AS css_url,
    IF(mimeType = 'image/avif', 'avif', IF(mimeType = 'image/webp', 'webp', format)) AS format
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2022-06-01' AND
    type = 'image'
)
JOIN (
  SELECT
    client,
    page,
    url AS css_url
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2022-06-01' AND
    type = 'css'
)
USING (client, page, css_url)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    JSON_EXTRACT_SCALAR(image, '$.url') AS img_url
  FROM
    `httparchive.pages.2022_06_01_*`,
    UNNEST(JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._Images'), '$')) AS image
)
USING (client, page, img_url)
GROUP BY
  client,
  format
ORDER BY
  pct DESC
