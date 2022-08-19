SELECT
  client,
  format,
  COUNT(DISTINCT page) AS pages_outline,
  total_page,
  COUNT(DISTINCT page) / total_page AS pct_outline
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
    type = 'font')
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_page
  FROM
    `httparchive.pages.2022_06_01_*`
  GROUP BY
    _TABLE_SUFFIX)
USING
  (client),
  UNNEST(REGEXP_EXTRACT_ALL(JSON_EXTRACT(payload, '$._font_details.table_sizes'), '(?i)(CFF |glyf|SVG|CFF2)')) AS format
GROUP BY
  client,
  total_page,
  format
ORDER BY
  pages_outline DESC
