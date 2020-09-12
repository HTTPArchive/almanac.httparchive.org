#standardSQL
# 06_03: counts the font types (format)
SELECT
  client,
  LOWER(IFNULL(REGEXP_EXTRACT(mimeType, '/(?:x-)?(?:font-)?(.*)'), ext)) AS mime_type,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct
FROM
  `httparchive.almanac.requests`
WHERE
  type = 'font'
GROUP BY
  client,
  mime_type
ORDER BY
  freq / total DESC
