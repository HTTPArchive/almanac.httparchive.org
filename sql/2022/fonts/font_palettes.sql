SELECT
  client,
  num,
  pages,
  total,
  pages / total AS pct
FROM (
  SELECT
    client,
    SAFE_CAST(JSON_EXTRACT_SCALAR(payload,
      '$._font_details.color.numPalettes') AS INT64) AS num,
    COUNT(DISTINCT page) AS pages
  FROM
    `httparchive.almanac.requests`
  WHERE
    (date = '2022-06-01' AND
      type = 'font')
  GROUP BY
    client,
    num)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2022_06_01_*`
  GROUP BY
    client)
USING
  (client)
ORDER BY
  pct DESC
