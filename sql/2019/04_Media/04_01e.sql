#standardSQL
/*
04_01e

1.22 TB query
0, 25, 50, 75 AND 100 quantile data on ms AND KB savings 	
for lazy loading when the lighthouse score is < 0.5


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
      APPROX_QUANTILES( offscreenwastedms ,5) AS offscreenwastedms,
      APPROX_QUANTILES( offscreenwastedkb ,5) AS offscreenwastedkb
    
      
FROM(
SELECT
      CAST(offscreenScore AS float64) AS offscreenscore,
      CAST(offscreenwastedms AS FLOAT64) AS offscreenwastedms, 
      CAST(offscreenwastedkb AS FLOAT64) AS offscreenwastedkb, 
      offscreenimageCOUNT 
FROM
(  SELECT
   
    (JSON_EXTRACT_SCALAR(report, "$.audits.offscreen-images.score")) AS offscreenScore,
    (JSON_EXTRACT_SCALAR(report, "$.audits.offscreen-images.details.overallSavingsMs")) AS offscreenwastedms,
    (JSON_EXTRACT_SCALAR(report, "$.audits.offscreen-images.details.overallSavingsBytes")) AS offscreenwastedkb,
     (LENGTH(JSON_EXTRACT(report, "$.audits.offscreen-images.details.items")) - LENGTH(REGEXP_REPLACE((JSON_EXTRACT(report, "$.audits.offscreen-images.details.items")),"url","")))/3 AS offscreenimageCOUNT
   
  FROM
    `httparchive.lighthouse.2019_07_01_mobile` 
)  
GROUP BY offscreenScore, offscreenwastedms, offscreenwastedkb,offscreenimageCOUNT
         
)
WHERE offscreenScore <0.5
