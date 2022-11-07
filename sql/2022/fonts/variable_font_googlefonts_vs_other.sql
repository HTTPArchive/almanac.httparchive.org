SELECT
  client,
  REGEXP_CONTAINS(url, r'(fonts\.(gstatic|googleapis)\.com)|(themes.googleusercontent.com/static/fonts)|(ssl.gstatic.com/fonts/)') AS googlefonts,
  COUNT(0) AS total,
  COUNT(0) * 1.0 / SUM(COUNT(0)) OVER(PARTITION BY client) AS pct
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2022-06-01' AND
  type = 'font' AND
  REGEXP_CONTAINS(JSON_EXTRACT(payload,
      '$._font_details.table_sizes'), '(?i)gvar|CFF2')
GROUP BY
  client,
  googlefonts
