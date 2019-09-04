#standardSQL
# 17_02: Percentage of the sites which use a CDN
#Requests to root document of the page which is served by a CDN.
SELECT 
  client, 
  COUNTIF(cdncount > 0) AS freq,
  COUNT(*) AS total,
  ROUND(100 * (COUNTIF(cdncount > 0)/COUNT(*)), 2) AS pct
FROM
(  
  SELECT
    _TABLE_SUFFIX AS client,
    pageid AS pageid,
    COUNTIF(_cdn_provider != '') AS cdncount
  FROM
    `httparchive.summary_requests.2019_07_01_*`
  WHERE firstHtml
  GROUP BY client, pageid
)
GROUP BY client
