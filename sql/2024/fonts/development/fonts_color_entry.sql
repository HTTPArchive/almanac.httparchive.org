-- Section: Development
-- Question: How many entries are there in color palettes?

-- INCLUDE ../common.sql

SELECT
  client,
  SAFE_CAST(JSON_EXTRACT_SCALAR(payload, '$._font_details.color.numPaletteEntries') AS INT64) AS entries,
  COUNT(DISTINCT url) AS count,
  SUM(COUNT(DISTINCT url)) OVER(PARTITION BY client) AS total,
  COUNT(DISTINCT url) / SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS proportion
FROM
  `httparchive.all.requests`
WHERE
  date = '2024-07-01' AND
  type = 'font' AND
  IS_COLOR(payload)
GROUP BY
  client,
  entries
ORDER BY
  client,
  proportion DESC
