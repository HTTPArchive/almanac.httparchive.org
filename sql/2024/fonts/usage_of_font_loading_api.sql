SELECT
  client,
  font_loading_api,
  pages,
  total,
  pages / total AS pct
FROM (
  SELECT
    client,
    REGEXP_CONTAINS(body, r'new FontFace\(') AS font_loading_api,
    COUNT(DISTINCT page) AS pages
  FROM
    `httparchive.almanac.summary_response_bodies`
  WHERE
    type = 'script' AND
    date = '2022-06-01'
  GROUP BY
    client,
    font_loading_api)
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
