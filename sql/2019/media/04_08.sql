#standardSQL
# 04_08: Pages with <picture><img></picture>
SELECT
  client,
  COUNTIF(has_picture_img) AS has_picture_img,
  COUNT(0) AS total,
  ROUND(COUNTIF(has_picture_img) * 100 / COUNT(0), 2) AS pct
FROM (
  SELECT
    client,
    REGEXP_CONTAINS(body, r'(?si)<picture.*?<img.*?/picture>') AS has_picture_img
  FROM
    `httparchive.almanac.summary_response_bodies`
  WHERE
    date = '2019-07-01' AND
    firstHtml
)
GROUP BY
  client
ORDER BY
  client DESC
