#standardSQL
/*
04_01g

1.22 TB query
0, 25, 50, 75 AND 100 quantile data on ms AND KB savings 	
for responsive images when the lighthouse score is < 0.5


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
      APPROX_QUANTILES( respimgwastedms ,5) AS respimgwastedms,
      APPROX_QUANTILES( respimgwastedkb ,5) AS respimgwastedkb
    
      
FROM(
SELECT

      
      CAST( repimagesScore AS FLOAT64) AS repimagesScore ,
      CAST(respimgwastedms AS FLOAT64) AS respimgwastedms, 
      CAST( respimgwastedkb AS FLOAT64) AS respimgwastedkb ,
      nonresponsiveCOUNT
      
   
FROM
(  SELECT
      
    (JSON_EXTRACT_SCALAR(report, "$.audits.uses-responsive-images.score")) AS repimagesScore,
    (JSON_EXTRACT_SCALAR(report, "$.audits.uses-responsive-images.details.overallSavingsMs")) AS respimgwastedms,
    (JSON_EXTRACT_SCALAR(report, "$.audits.uses-responsive-images.details.overallSavingsBytes")) AS respimgwastedkb,
    (LENGTH(JSON_EXTRACT(report, "$.audits.uses-responsive-images.details.items")) - LENGTH(REGEXP_REPLACE((JSON_EXTRACT(report, "$.audits.uses-responsive-images.details.items")),"url","")))/3 AS nonresponsiveCOUNT
    
   
    
    
  FROM
    `httparchive.lighthouse.2019_07_01_mobile` 
)  
GROUP BY 
         repimagesScore,respimgwastedms, respimgwastedkb, nonresponsiveCOUNT
         
)
WHERE repimagesScore <0.5
