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
      CAST(offscreenwastedms AS FLOAT64) AS offscreenwastedms, 
      CAST(offscreenwastedkb AS FLOAT64) AS offscreenwastedkb, 
      offscreenimageCOUNT,
      
      CAST(optimagesScore AS Float64) AS optimagesScore,
      CAST(optimgwastedms AS FLOAT64) AS optimgwastedms,
      CAST( optimgwastedkb AS FLOAT64) AS optimgwastedkb ,
      unoptimageCOUNTCOUNT,
      
      CAST( repimagesScore AS FLOAT64) AS repimagesScore ,
      CAST(respimgwastedms AS FLOAT64) AS respimgwastedms, 
      CAST( respimgwastedkb AS FLOAT64) AS respimgwastedkb ,
      nonresponsiveCOUNT,
      
      CAST( webpimagesScore AS FLOAT64) AS webpimagesScore ,
      CAST(webpimgwastedms AS FLOAT64) AS webpimgwastedms, 
      CAST( webpimgwastedkb AS FLOAT64) AS webpimgwastedkb ,
      nonwebpCOUNT,
      
      CAST( agifScore AS FLOAT64) AS agifScore ,
      CAST( agifwastedms AS FLOAT64) AS  agifwastedms ,
      CAST( agifwastedkb AS FLOAT64) AS agifwastedkb ,
      agifCOUNTCOUNT,
      
      CAST( videocaptionScore AS FLOAT64) AS videocaptionScore ,
      CAST( pwaScore AS FLOAT64) AS pwaScore  
FROM
(  SELECT
    url,
    CAST(JSON_EXTRACT_SCALAR(report, "$.audits.offscreen-images.score")as numeric) +CAST(JSON_EXTRACT_SCALAR(report, "$.audits.uses-optimized-images.score")as numeric) + CAST(JSON_EXTRACT_SCALAR(report, "$.audits.uses-responsive-images.score") AS numeric) +CAST(JSON_EXTRACT_SCALAR(report, "$.audits.uses-webp-images.score") AS numeric) imgSUMscore,
    
    (JSON_EXTRACT_SCALAR(report, "$.audits.offscreen-images.score")) AS offscreenScore,
    (JSON_EXTRACT_SCALAR(report, "$.audits.offscreen-images.details.overallSavingsMs")) AS offscreenwastedms,
    (JSON_EXTRACT_SCALAR(report, "$.audits.offscreen-images.details.overallSavingsBytes")) AS offscreenwastedkb,
     (LENGTH(JSON_EXTRACT(report, "$.audits.offscreen-images.details.items")) - LENGTH(REGEXP_REPLACE((JSON_EXTRACT(report, "$.audits.offscreen-images.details.items")),"url","")))/3 AS offscreenimageCOUNT,
    
    (JSON_EXTRACT_SCALAR(report, "$.audits.uses-optimized-images.score")) AS optimagesScore,
    (JSON_EXTRACT_SCALAR(report, "$.audits.uses-optimized-images.details.overallSavingsMs")) AS optimgwastedms,
    (JSON_EXTRACT_SCALAR(report, "$.audits.uses-optimized-images.details.overallSavingsBytes")) AS optimgwastedkb,
     (LENGTH(JSON_EXTRACT(report, "$.audits.uses-optimized-images.details.items")) - LENGTH(REGEXP_REPLACE((JSON_EXTRACT(report, "$.audits.uses-optimized-images.details.items")),"url","")))/3 AS unoptimageCOUNTCOUNT,
   
    (JSON_EXTRACT_SCALAR(report, "$.audits.uses-responsive-images.score")) AS repimagesScore,
    (JSON_EXTRACT_SCALAR(report, "$.audits.uses-responsive-images.details.overallSavingsMs")) AS respimgwastedms,
    (JSON_EXTRACT_SCALAR(report, "$.audits.uses-responsive-images.details.overallSavingsBytes")) AS respimgwastedkb,
    (LENGTH(JSON_EXTRACT(report, "$.audits.uses-responsive-images.details.items")) - LENGTH(REGEXP_REPLACE((JSON_EXTRACT(report, "$.audits.uses-responsive-images.details.items")),"url","")))/3 AS nonresponsiveCOUNT,
    
    (JSON_EXTRACT_SCALAR(report, "$.audits.uses-webp-images.score")) AS webpimagesScore,
    (JSON_EXTRACT_SCALAR(report, "$.audits.uses-webp-images.details.overallSavingsMs")) AS webpimgwastedms,
    (JSON_EXTRACT_SCALAR(report, "$.audits.uses-webp-images.details.overallSavingsBytes")) AS webpimgwastedkb,
    (LENGTH(JSON_EXTRACT(report, "$.audits.uses-webp-images.details.items")) - LENGTH(REGEXP_REPLACE((JSON_EXTRACT(report, "$.audits.uses-webp-images.details.items")),"url","")))/3 AS nonwebpCOUNT,
    
     (JSON_EXTRACT_SCALAR(report, "$.audits.efficient-animated-content.score")) AS agifScore,
    (JSON_EXTRACT_SCALAR(report, "$.audits.efficient-animated-content.details.overallSavingsMs")) AS agifwastedms,
    (JSON_EXTRACT_SCALAR(report, "$.audits.efficient-animated-content.details.overallSavingsBytes"))AS  agifwastedkb,
    (LENGTH(JSON_EXTRACT(report, "$.audits.efficient-animated-content.details.items")) - LENGTH(REGEXP_REPLACE((JSON_EXTRACT(report, "$.audits.efficient-animated-content.details.items")),"url","")))/3 AS agifCOUNTCOUNT,
    
     (JSON_EXTRACT_SCALAR(report, "$.audits.video-caption.score")) AS videocaptionScore,
    (JSON_EXTRACT(report, "$.audits.video-caption.scoreDisplayMode")) AS videocaptiondisplaymode,
    (JSON_EXTRACT_SCALAR(report, "$.audits.video-description.score")) AS videoDescription,
    JSON_EXTRACT(report, "$.audits.video-description.scoreDisplayMode") AS videodescriptiondeisplaymode,
     (JSON_EXTRACT_SCALAR(report, "$.audits.pwa.score")) AS pwaScore
    
    
  FROM
    `httparchive.lighthouse.2019_07_01_mobile` 
)  
GROUP BY offscreenScore, offscreenwastedms, offscreenwastedkb,offscreenimageCOUNT,
         optimagesScore,optimgwastedms, optimgwastedkb,unoptimageCOUNTCOUNT,
         repimagesScore,respimgwastedms, respimgwastedkb, nonresponsiveCOUNT, 
         webpimagesScore, webpimgwastedms, webpimgwastedkb, nonwebpCOUNT,
         agifScore, agifwastedms, agifwastedkb, agifCOUNTCOUNT, videocaptionScore, pwaScore
         
  
)
  
