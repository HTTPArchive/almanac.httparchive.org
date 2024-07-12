-- Section: Performance
-- Question: Which file formats are used?

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
  COUNT(DISTINCT url) AS count,
  SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS total,
  COUNT(DISTINCT url) / SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS proportion
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
