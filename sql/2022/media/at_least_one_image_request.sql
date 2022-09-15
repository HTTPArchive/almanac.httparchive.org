#standardSQL
# What % of pages load at least one image?

SELECT
  _TABLE_SUFFIX AS client,
  COUNTIF(reqImg > 0) AS atLeastOneImgReqCount,
  COUNT(0) AS total,
  SAFE_DIVIDE(COUNTIF(reqImg > 0), COUNT(0)) AS atLeastOneImgReqPct
FROM
  `httparchive.summary_pages.2022_06_01_*`
GROUP BY
  client
