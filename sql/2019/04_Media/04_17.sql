#StandardSQL
/*
04_17  

66GB

top video players - I have chosen a few based on my knowledge... Perhaps there are more?
- there are 6400 here WHERE Gzip could make a large difference....

*/


SELECT url, 
      respsize, 
      ext, 
      mimetype, 
      _gzip_save,
      _TABLE_SUFFIX AS client
FROM `summary_requests.2019_07_01_*` 
WHERE (LOWER(url) LIKE "%hls.js" OR  
      LOWER(url) LIKE "%video.js" OR  
      LOWER(url) LIKE "%shaka.js" OR  
      LOWER(url) LIKE "%jwplayer.js" OR  
      LOWER(url) LIKE "brightcove-player-loader.min.js")
     
     
     
ORDER BY respsize desc
