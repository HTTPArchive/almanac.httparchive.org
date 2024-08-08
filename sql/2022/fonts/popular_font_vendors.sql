SELECT
  client,
  vendor,
  pages,
  total,
  pages / total AS pct
FROM (
  SELECT
    client,
    JSON_EXTRACT_SCALAR(
      payload,
      '$._font_details.OS2.achVendID'
    ) AS vendor,
    COUNT(DISTINCT page) AS pages
  FROM
    `httparchive.almanac.requests`
  WHERE (
    date = '2022-06-01' AND
    type = 'font'
  )
  GROUP BY
    client,
    vendor
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2022_06_01_*`
  GROUP BY
    client
)
USING (client)
WHERE
  pages / total >= 0.001
ORDER BY
  pct DESC
