#standardSQL
# Average Percent per page of external scripts using Async, Defer, Module or NoModule attributes.
SELECT 
  client,
  AVG(pct_external_async) AS avg_pct_external_async,
  AVG(pct_external_defer) AS avg_pct_external_defer,
  AVG(pct_external_module) AS avg_pct_external_module,
  AVG(pct_external_nomodule) AS avg_pct_external_nomodule
FROM
(
  SELECT 
    client,
    page,
    COUNT(*) as external_scripts,
    SUM(IF(script LIKE "%async%",1,0)) AS async,
    SUM(IF(script LIKE "%defer%",1,0)) AS defer,
    SUM(IF(script LIKE "%module%",1,0)) AS module,
    SUM(IF(script LIKE "%nomodule%",1,0)) AS nomodule,
    SUM(IF(script LIKE "%async%",1,0))    / COUNT(*) AS pct_external_async,
    SUM(IF(script LIKE "%defer%",1,0))    / COUNT(*) AS pct_external_defer,
    SUM(IF(script LIKE "%module%",1,0))   / COUNT(*) AS pct_external_module,
    SUM(IF(script LIKE "%nomodule%",1,0)) / COUNT(*) AS pct_external_nomodule
  FROM 
  (
    SELECT  
      client,
      page, 
      url,
      REGEXP_EXTRACT_ALL(LOWER(body), "(<script [^>]*)") AS scripts
    FROM 
      `httparchive.almanac.summary_response_bodies` 
    WHERE
      date = '2020-08-01' AND
      firstHtml
  )
  CROSS JOIN
    UNNEST(scripts) as script
  WHERE 
    script LIKE "%src%"
  GROUP BY 
    client,
    page
)
GROUP BY 
  client