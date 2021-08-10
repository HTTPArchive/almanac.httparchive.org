#standardSQL
# 09_05: ARIA role popularity
SELECT
  client,
  role,
  COUNT(DISTINCT page) AS pages,
  total,
  ROUND(COUNT(DISTINCT page) * 100 / total, 2) AS pct
FROM
  `httparchive.almanac.summary_response_bodies`,
  UNNEST(REGEXP_EXTRACT_ALL(LOWER(body), 'role=[\'"]?([\\w-]+)')) AS role
JOIN
  (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
USING
  (client)
WHERE
  date = '2019-07-01' AND
  firstHtml
GROUP BY
  client,
  total,
  role
ORDER BY
  pages / total DESC
LIMIT
  1000
