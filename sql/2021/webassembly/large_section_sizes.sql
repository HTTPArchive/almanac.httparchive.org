SELECT
  ANY_VALUE(url) AS url,
  ANY_VALUE(size.custom) AS custom_sections_size,
  ARRAY_TO_STRING(ANY_VALUE(custom_sections), ', ') AS custom_sections
FROM
  `httparchive.almanac.wasm_stats`
WHERE
  date = '2021-09-01'
GROUP BY
  filename
ORDER BY
  custom_sections_size DESC
