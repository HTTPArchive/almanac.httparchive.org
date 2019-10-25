#standardSQL
# 09_19b: Top aria attributes
SELECT
  client,
  SPLIT(REGEXP_REPLACE(attr, '[\'"]', ''), '=')[OFFSET(0)] AS attribute,
  COUNT(DISTINCT page) AS pages,
  total,
  ROUND(COUNT(DISTINCT page) * 100 / total, 2) AS pct
FROM
  `httparchive.almanac.summary_response_bodies`,
  UNNEST(REGEXP_EXTRACT_ALL(LOWER(body), '<[^>]+\\b(aria-\\w+=[\'"]?[\\w-]+)')) AS attr
JOIN
  (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
USING (client)
WHERE
  firstHtml
GROUP BY
  client,
  total,
  attribute
ORDER BY
  pages / total DESC
