#standardSQL
# CSS-initiated image px dimension popularity
SELECT
  client,
  height,
  width,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    page,
    url AS img_url,
    JSON_VALUE(payload, '$._initiator') AS css_url
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2021-07-01' AND
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
    date = '2021-07-01' AND
    type = 'css'
)
USING (client, page, css_url)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    JSON_EXTRACT_SCALAR(image, '$.url') AS img_url,
    SAFE_CAST(JSON_EXTRACT_SCALAR(image, '$.naturalHeight') AS INT64) AS height,
    SAFE_CAST(JSON_EXTRACT_SCALAR(image, '$.naturalWidth') AS INT64) AS width
  FROM
    `httparchive.pages.2021_07_01_*`,
    UNNEST(JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._Images'), '$')) AS image
)
USING (client, page, img_url)
WHERE
  height IS NOT NULL AND
  width IS NOT NULL
GROUP BY
  client,
  height,
  width
ORDER BY
  pct DESC
LIMIT 500
