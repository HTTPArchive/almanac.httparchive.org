#standardSQL
# 04_06: Pages with source[sizes]
SELECT
  client,
  COUNTIF(hasSizes) AS hasSizes,
  COUNTIF(hasSrcSet) AS hasSrcSet,
  COUNTIF(hasPicture) AS hasPicture,
  COUNT(0) AS total,
  ROUND(COUNTIF(hasSizes) * 100 / COUNT(0), 2) AS pctSizes,
  ROUND(COUNTIF(hasSrcSet) * 100 / COUNT(0), 2) AS pctSrcSet,
  ROUND(COUNTIF(hasPicture) * 100 / COUNT(0), 2) AS pctPicture,
  ROUND(COUNTIF(hasPicture OR hasSrcSet OR hasSizes) * 100 / COUNT(0), 2) AS anyRespImg
FROM (
  SELECT
    client,
    REGEXP_CONTAINS(body, r'(?is)<(?:img|source)[^>]*sizes=[\'"]?([^\'"]*)') AS hasSizes,
    REGEXP_CONTAINS(body, r'(?is)<(?:img|source)[^>]*srcset=[\'"]?([^\'"]*)') AS hasSrcSet,
    REGEXP_CONTAINS(body, r'(?si)<picture.*?<img.*?/picture>') AS hasPicture
  FROM
    `httparchive.almanac.summary_response_bodies`
  WHERE
    firstHtml
)
GROUP BY
  client
ORDER BY
  client DESC