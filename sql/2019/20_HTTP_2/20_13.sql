#standardSQL
# 20.13 Count of preload HTTP Headers with nopush attribute set. Once off stat for last crawl
CREATE TEMPORARY FUNCTION getLinkHeaders(payload STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS """
  var $ = JSON.parse(payload);
  var headers = $.response.headers;
  var preload=[];
  
  for (i in headers) {
      if (headers[i].name.toLowerCase() === 'link')
        preload.push(headers[i].value);
      }
     return preload;  
    
""";

SELECT 
  client, 
  is_base_page, 
  COUNT(*) as num_requests,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct
FROM (
  SELECT 
    _TABLE_SUFFIX AS client,
    JSON_EXTRACT_SCALAR(payload, "$._is_base_page") AS is_base_page,  
    getLinkHeaders(payload) AS link_headers
  FROM 
   `httparchive.requests.2019_07_01_*`
)
CROSS JOIN
  UNNEST(link_headers) AS link_header
WHERE 
  link_header LIKE '%preload%' 
  AND link_header LIKE '%nopush%'
GROUP BY client, is_base_page
