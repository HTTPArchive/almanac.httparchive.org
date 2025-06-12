SELECT
  client,
  format,
  COUNT(DISTINCT page) AS pages_variable,
  total_page,
  COUNT(DISTINCT page) / total_page AS pct_variable
FROM (
  SELECT
    client,
    page,
    format,
    payload
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2022-06-01' AND
    type = 'font' AND
    REGEXP_CONTAINS(JSON_EXTRACT(payload, '$._font_details.table_sizes'), '(?i)gvar|CFF2')
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_page
  FROM
    `httparchive.summary_pages.2022_06_01_*`
  GROUP BY
    _TABLE_SUFFIX
)
USING (client),
  # Variable fonts have either a glyf or CFF2 table
  UNNEST(REGEXP_EXTRACT_ALL(JSON_EXTRACT(payload, '$._font_details.table_sizes'), '(?i)(CFF2|glyf)')) AS format
GROUP BY
  client,
  total_page,
  format
ORDER BY
  pages_variable DESC
