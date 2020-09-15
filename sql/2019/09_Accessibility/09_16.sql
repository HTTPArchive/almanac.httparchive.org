#standardSQL
# 09_16: % pages using invalid/required form field attributes
SELECT
  client,
  attr,
  COUNT(DISTINCT page) AS pages,
  total,
  ROUND(COUNT(DISTINCT page) * 100 / total, 2) AS pct
FROM
  `httparchive.almanac.summary_response_bodies`,
  UNNEST(ARRAY_CONCAT(
    REGEXP_EXTRACT_ALL(body, '<input[^>]+(aria-invalid|aria-required)\\b'),
    REGEXP_EXTRACT_ALL(body, '<input[^>]+[^-](required)\\b')
  )) AS attr
JOIN
  (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
USING (client)
WHERE
  date = '2019-07-01' AND
  firstHtml
GROUP BY
  client,
  total,
  attr
ORDER BY
  pages / total DESC
