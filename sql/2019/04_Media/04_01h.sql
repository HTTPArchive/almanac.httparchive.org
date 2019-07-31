#standardSQL
/*
04_01g

1.22 TB query
0, 25, 50, 75 and 100 quantile data on ms and KB savings 	
for responsive images when the lighthouse score is < 0.5


this query takes lighthouse data on image performance: 
    lazyloading (offscreen), 
    responsiveness, 
    quality (optimized),
    format (webp),
    animated GIF
    
    I break down this data into: 
         scores (from 0-1) 
         wasted ms in load time
         wasted KB
         count of offending items
    and break them into percentiles - 26 is the median, but 50 seemed 
    like a good number to graph the data with
*/

select 
      APPROX_QUANTILES( respimgwastedms ,5) respimgwastedms,
      APPROX_QUANTILES( respimgwastedkb ,5) respimgwastedkb
    
      
from(
select
      cast(offscreenScore as float64) offscreenscore,
      cast(offscreenwastedms as FLOAT64) offscreenwastedms, 
      cast(offscreenwastedkb as FLOAT64) offscreenwastedkb, 
      offscreenimagecount,
      
      cast(optimagesScore as Float64) optimagesScore,
      cast(optimgwastedms as FLOAT64) optimgwastedms,
      cast( optimgwastedkb as FLOAT64) optimgwastedkb ,
      unoptimagecountcount,
      
      cast( repimagesScore as FLOAT64) repimagesScore ,
      cast(respimgwastedms as FLOAT64) respimgwastedms, 
      cast( respimgwastedkb as FLOAT64) respimgwastedkb ,
      nonresponsivecount,
      
      cast( webpimagesScore as FLOAT64) webpimagesScore ,
      cast(webpimgwastedms as FLOAT64) webpimgwastedms, 
      cast( webpimgwastedkb as FLOAT64) webpimgwastedkb ,
      nonwebpcount,
      
      cast( agifScore as FLOAT64) agifScore ,
      cast( agifwastedms as FLOAT64) agifwastedms ,
      cast( agifwastedkb as FLOAT64) agifwastedkb ,
      agifcountcount,
      
      cast( videocaptionScore as FLOAT64) videocaptionScore ,
      cast( pwaScore as FLOAT64) pwaScore  
from
(  SELECT
    url,
    cast(JSON_EXTRACT_scalar(report, "$.audits.offscreen-images.score")as numeric) +cast(JSON_EXTRACT_scalar(report, "$.audits.uses-optimized-images.score")as numeric) + cast(JSON_EXTRACT_scalar(report, "$.audits.uses-responsive-images.score") as numeric) +cast(JSON_EXTRACT_scalar(report, "$.audits.uses-webp-images.score") as numeric) imgsumscore,
    
    (JSON_EXTRACT_scalar(report, "$.audits.offscreen-images.score")) offscreenScore,
    (JSON_EXTRACT_scalar(report, "$.audits.offscreen-images.details.overallSavingsMs")) offscreenwastedms,
    (JSON_EXTRACT_scalar(report, "$.audits.offscreen-images.details.overallSavingsBytes")) offscreenwastedkb,
     (length(JSON_EXTRACT(report, "$.audits.offscreen-images.details.items")) - length(REGEXP_REPLACE((JSON_EXTRACT(report, "$.audits.offscreen-images.details.items")),"url","")))/3 offscreenimagecount,
    
    (JSON_EXTRACT_scalar(report, "$.audits.uses-optimized-images.score")) optimagesScore,
    (JSON_EXTRACT_scalar(report, "$.audits.uses-optimized-images.details.overallSavingsMs")) optimgwastedms,
    (JSON_EXTRACT_scalar(report, "$.audits.uses-optimized-images.details.overallSavingsBytes")) optimgwastedkb,
     (length(JSON_EXTRACT(report, "$.audits.uses-optimized-images.details.items")) - length(REGEXP_REPLACE((JSON_EXTRACT(report, "$.audits.uses-optimized-images.details.items")),"url","")))/3 unoptimagecountcount,
   
    (JSON_EXTRACT_scalar(report, "$.audits.uses-responsive-images.score")) repimagesScore,
    (JSON_EXTRACT_scalar(report, "$.audits.uses-responsive-images.details.overallSavingsMs")) respimgwastedms,
    (JSON_EXTRACT_scalar(report, "$.audits.uses-responsive-images.details.overallSavingsBytes")) respimgwastedkb,
    (length(JSON_EXTRACT(report, "$.audits.uses-responsive-images.details.items")) - length(REGEXP_REPLACE((JSON_EXTRACT(report, "$.audits.uses-responsive-images.details.items")),"url","")))/3 nonresponsivecount,
    
    (JSON_EXTRACT_scalar(report, "$.audits.uses-webp-images.score")) webpimagesScore,
    (JSON_EXTRACT_scalar(report, "$.audits.uses-webp-images.details.overallSavingsMs")) webpimgwastedms,
    (JSON_EXTRACT_scalar(report, "$.audits.uses-webp-images.details.overallSavingsBytes")) webpimgwastedkb,
    (length(JSON_EXTRACT(report, "$.audits.uses-webp-images.details.items")) - length(REGEXP_REPLACE((JSON_EXTRACT(report, "$.audits.uses-webp-images.details.items")),"url","")))/3 nonwebpcount,
    
     (JSON_EXTRACT_scalar(report, "$.audits.efficient-animated-content.score")) agifScore,
    (JSON_EXTRACT_scalar(report, "$.audits.efficient-animated-content.details.overallSavingsMs")) agifwastedms,
    (JSON_EXTRACT_scalar(report, "$.audits.efficient-animated-content.details.overallSavingsBytes")) agifwastedkb,
    (length(JSON_EXTRACT(report, "$.audits.efficient-animated-content.details.items")) - length(REGEXP_REPLACE((JSON_EXTRACT(report, "$.audits.efficient-animated-content.details.items")),"url","")))/3 agifcountcount,
    
     (JSON_EXTRACT_scalar(report, "$.audits.video-caption.score")) videocaptionScore,
    (JSON_EXTRACT(report, "$.audits.video-caption.scoreDisplayMode")) videocaptiondisplaymode,
    (JSON_EXTRACT_scalar(report, "$.audits.video-description.score")) videoDescription,
    JSON_EXTRACT(report, "$.audits.video-description.scoreDisplayMode") videodescriptiondeisplaymode,
     (JSON_EXTRACT_scalar(report, "$.audits.pwa.score")) pwaScore
    
    
  FROM
    `httparchive.lighthouse.2019_07_01_mobile` 
)  
group by offscreenScore, offscreenwastedms, offscreenwastedkb,offscreenimagecount,
         optimagesScore,optimgwastedms, optimgwastedkb,unoptimagecountcount,
         repimagesScore,respimgwastedms, respimgwastedkb, nonresponsivecount, 
         webpimagesScore, webpimgwastedms, webpimgwastedkb, nonwebpcount,
         agifScore, agifwastedms, agifwastedkb, agifcountcount, videocaptionScore, pwaScore
         
)
where repimagesScore <0.5
