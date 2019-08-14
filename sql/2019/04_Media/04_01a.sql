#standardSQL
/*
04_01a

1.22 TB query
*Lighthouse Lazyloading, resp images, image quality, webp image score score in 1000 percentile points	

this query takes lighthouse data on image performance scores: 
    lazyloading (offscreen), 
    responsiveness, 
    quality (optimized),
    format (webp),

These scores are FROM 0 -1, so we can graph the percentiles at each score (I use 1k points for the charts)
*/

SELECT 
      APPROX_QUANTILES( offscreenScore ,1000) AS offscreenscore,
      APPROX_QUANTILES( repimagesScore ,1000) AS repimagesScore,
      APPROX_QUANTILES( optimagesScore ,1000) AS optimagesScore,
      APPROX_QUANTILES( webpimagesScore ,1000) AS webpimagesScore
FROM(
SELECT
      CAST(offscreenScore AS float64) AS offscreenscore,
     
      CAST(optimagesScore AS Float64) AS optimagesScore,
     
      
      CAST( repimagesScore AS FLOAT64) AS repimagesScore ,
     
      
      CAST( webpimagesScore AS FLOAT64) AS webpimagesScore 
FROM
(  SELECT
    url,
    
    (JSON_EXTRACT_SCALAR(report, "$.audits.offscreen-images.score")) AS offscreenScore,
     
    (JSON_EXTRACT_SCALAR(report, "$.audits.uses-optimized-images.score")) AS optimagesScore,
    
    (JSON_EXTRACT_SCALAR(report, "$.audits.uses-responsive-images.score")) AS repimagesScore,
    
    (JSON_EXTRACT_SCALAR(report, "$.audits.uses-webp-images.score")) AS webpimagesScore
    
    
  FROM
    `httparchive.lighthouse.2019_07_01_mobile` 
)  

  
)
  
