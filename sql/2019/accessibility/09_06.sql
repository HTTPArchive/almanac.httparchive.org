#standardSQL
# 09_06: % of pages having duplicate id attributes
SELECT
  client,
  COUNT(DISTINCT page) AS pages,
  total,
  ROUND(COUNT(DISTINCT page) * 100 / total, 2) AS pct
FROM (
  SELECT
    client,
    total,
    page,
    id,
    COUNT(0) AS freq
  FROM
    (SELECT client, page, body FROM `httparchive.almanac.summary_response_bodies` WHERE date = '2019-07-01' AND firstHtml),
    UNNEST(REGEXP_EXTRACT_ALL(body, '(?i)\\sid=[\'"]?([^\'"\\s]+)')) AS id
  JOIN
    (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
  USING (client)
  GROUP BY
    client,
    total,
    page,
    id)
WHERE
  freq > 1
GROUP BY
  client,
  total
