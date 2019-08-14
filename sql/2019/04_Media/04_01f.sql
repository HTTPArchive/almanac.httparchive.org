#standardSQL
/*
04_01f

1.22 TB query
0, 25, 50, 75 AND 100 quantile data on ms AND KB savings 	
for image quality when the lighthouse score is < 0.5


this query takes lighthouse data on image performance: 
    lazyloading (offscreen), 
    responsiveness, 
    quality (optimized),
    format (webp),
    animated GIF
    
    I break down this data into: 
         scores (FROM 0-1) 
         wasted ms in load time
         wasted KB
         COUNT of offending items
    AND break them into percentiles - 26 is the median, but 50 seemed 
    LIKE a good number to graph the data with
*/

SELECT 
      APPROX_QUANTILES( optimgwastedms ,5) AS optimgwastedms,
      APPROX_QUANTILES( optimgwastedkb ,5) AS optimgwastedkb
    
      
FROM(
SELECT
    
      
      CAST(optimagesScore AS Float64) AS optimagesScore,
      CAST(optimgwastedms AS FLOAT64) AS optimgwastedms,
      CAST( optimgwastedkb AS FLOAT64) AS optimgwastedkb ,
      unoptimageCOUNTCOUNT
FROM
(  SELECT
    
    (JSON_EXTRACT_SCALAR(report, "$.audits.uses-optimized-images.score")) AS optimagesScore,
    (JSON_EXTRACT_SCALAR(report, "$.audits.uses-optimized-images.details.overallSavingsMs")) AS optimgwastedms,
    (JSON_EXTRACT_SCALAR(report, "$.audits.uses-optimized-images.details.overallSavingsBytes")) AS optimgwastedkb,
     (LENGTH(JSON_EXTRACT(report, "$.audits.uses-optimized-images.details.items")) - LENGTH(REGEXP_REPLACE((JSON_EXTRACT(report, "$.audits.uses-optimized-images.details.items")),"url","")))/3 AS unoptimageCOUNTCOUNT
  
    
    
  FROM
    `httparchive.lighthouse.2019_07_01_mobile` 
)  
GROUP BY 
         optimagesScore,optimgwastedms, optimgwastedkb, unoptimageCOUNTCOUNT
         
)
WHERE optimagesScore <0.5
