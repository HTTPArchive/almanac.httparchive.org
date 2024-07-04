CREATE TEMPORARY FUNCTION FILE_FORMAT(url STRING, header STRING) AS (
  LOWER(COALESCE(
    REGEXP_EXTRACT(LOWER(header), r'(otf|sfnt|svg|ttf|woff2?|fontobject|opentype|truetype)'),
    REGEXP_EXTRACT(url, r'\.(\w+)(?:$|\?|#)'),
    header
  ))
);

SELECT
  client,
  FILE_FORMAT(url, header.value) AS format,
  COUNT(0) AS count,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS proportion
FROM
  `httparchive.all.requests`,
  UNNEST(response_headers) AS header
WHERE
  date = '2024-06-01' AND
  type = 'font' AND
  LOWER(header.name) = 'content-type' AND
  TRIM(header.value) != ''
GROUP BY
  client,
  format
ORDER BY
  client,
  proportion DESC
