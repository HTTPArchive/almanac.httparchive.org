#standardSQL
#font_formats
SELECT
  client,
  LOWER(IFNULL(REGEXP_EXTRACT(mimeType, '/(?:x-)?(?:font-)?(.*)'), ext)) AS mime_type,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2021-07-01' AND
  type = 'font' AND
  mimeType != ''
GROUP BY
  client,
  mime_type
ORDER BY
  client,
  pct DESC
