#standardSQL
# Distribution of Percent per page of external scripts using Async, Defer, Module or NoModule attributes.
SELECT 
  percentile,
  client,
  APPROX_QUANTILES(pct_external_async, 1000)[OFFSET(percentile * 10)] AS pct_external_async,
  APPROX_QUANTILES(pct_external_defer, 1000)[OFFSET(percentile * 10)] AS pct_external_defer,
  APPROX_QUANTILES(pct_external_module, 1000)[OFFSET(percentile * 10)] AS pct_external_module,
  APPROX_QUANTILES(pct_external_nomodule, 1000)[OFFSET(percentile * 10)] AS pct_external_nomodule
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
      _TABLE_SUFFIX AS client,
      page, 
      url,
      REGEXP_EXTRACT_ALL(LOWER(body), "(<script [^>]*)") AS scripts
    FROM 
      `httparchive.response_bodies.2020_08_01_*` 
--      `httparchive.sample_data.response_bodies_*`
    WHERE  
      LOWER(body) LIKE "%<html%"
  )
  CROSS JOIN
    UNNEST(scripts) as script
  WHERE 
    script LIKE "%src%"
  GROUP BY 
    client,
    page
),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY 
  percentile,
  client