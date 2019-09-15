#standardSQL
# 09_17: % pages using tables with headings
SELECT
  client,
  heading,
  COUNT(DISTINCT page) AS pages,
  total,
  ROUND(COUNT(DISTINCT page) * 100 / total, 2) AS pct
FROM
  `httparchive.almanac.summary_response_bodies`,
  UNNEST(ARRAY_CONCAT(
    REGEXP_EXTRACT_ALL(LOWER(body), '<(th)\\b'),
    REGEXP_EXTRACT_ALL(LOWER(body), '\\brole=[\'"]?(rowheader|columnheader)\\b')
  )) AS heading
JOIN
  (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
USING (client)
WHERE
  firstHtml
GROUP BY
  client,
  total,
  heading
ORDER BY
  pages / total DESC