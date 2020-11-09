#standardSQL
# Breakdown of scripts using Async, Defer, Module or NoModule attributes.  Also breakdown of inline vs external scripts
SELECT 
  client,
  COUNT(*) as total_scripts,
  SUM(IF(script NOT LIKE "%src%",1,0)) AS inline_script,
  SUM(IF(script LIKE "%src%",1,0)) AS external_script,
  SUM(IF(script LIKE "%src%",1,0)) / COUNT(*) AS pct_external_script,
  SUM(IF(script NOT LIKE "%src%",1,0)) / COUNT(*) AS pct_inline_script,
  SUM(IF(script LIKE "%async%",1,0)) AS async,
  SUM(IF(script LIKE "%defer%",1,0)) AS defer,
  SUM(IF(script LIKE "%module%",1,0)) AS module,
  SUM(IF(script LIKE "%nomodule%",1,0)) AS nomodule,
  SUM(IF(script LIKE "%async%",1,0))    / SUM(IF(script LIKE "%src%",1,0)) AS pct_external_async,
  SUM(IF(script LIKE "%defer%",1,0))    / SUM(IF(script LIKE "%src%",1,0)) AS pct_external_defer,
  SUM(IF(script LIKE "%module%",1,0))   / SUM(IF(script LIKE "%src%",1,0)) AS pct_external_module,
  SUM(IF(script LIKE "%nomodule%",1,0)) / SUM(IF(script LIKE "%src%",1,0)) AS pct_external_nomodule
FROM 
(
  SELECT  
    _TABLE_SUFFIX AS client,
    page, 
    url,
    REGEXP_EXTRACT_ALL(LOWER(body), "(<script [^>]*)") AS scripts
  FROM 
    `httparchive.response_bodies.2020_08_01_*` 
  WHERE  
    LOWER(body) LIKE "%<html%"
)
CROSS JOIN
  UNNEST(scripts) as script
GROUP BY 
  client
