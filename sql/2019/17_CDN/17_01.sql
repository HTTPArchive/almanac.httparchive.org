#standardSQL
# 17_01: Top CDNs used in the requests
#Requests to root document of the page which is served by a CDN.
SELECT 
  client,
  cdn, 
  COUNT(*) AS freq,
  SUM(COUNT(*)) OVER(PARTITION BY client) AS total,
  ROUND(100 * (COUNT(*)/SUM(COUNT(*)) OVER(PARTITION BY client)), 2) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    _cdn_provider AS cdn
  FROM
    `httparchive.summary_requests.2019_07_01_*`
  WHERE firstHtml
  ORDER BY
    client
)
GROUP BY client, cdn
ORDER BY client, freq DESC
