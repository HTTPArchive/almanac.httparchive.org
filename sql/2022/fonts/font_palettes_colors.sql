SELECT
  client,
  entries,
  pages,
  total,
  pages / total AS pct
FROM (
  SELECT
    client,
    JSON_EXTRACT_SCALAR(payload,
      '$._font_details.color.numPaletteEntries') AS entries,
    COUNT(DISTINCT page) AS pages
  FROM
    `httparchive.almanac.requests`
  WHERE
    (date = '2022-06-01' AND
      type = 'font')
  GROUP BY
    client,
    entries)
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
WHERE
  entries IS NOT NULL AND
  entries != '0'
ORDER BY
  pct DESC
