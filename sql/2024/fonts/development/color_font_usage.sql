SELECT
  client,
  COUNT(DISTINCT page) AS freq_color,
  total_page,
  COUNT(DISTINCT page) / total_page AS pct_color
FROM (
  SELECT
    client,
    page
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2022-06-01' AND
    type = 'font' AND
    REGEXP_CONTAINS(JSON_EXTRACT(payload,
        '$._font_details.color.formats'), '(?i)(sbix|CBDT|SVG|COLRv0|COLRv1)'))
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_page
  FROM
    `httparchive.pages.2022_06_01_*`
  GROUP BY
    _TABLE_SUFFIX)
USING
  (client)
GROUP BY
  client,
  total_page
HAVING
  freq_color > 100
ORDER BY
  freq_color DESC
