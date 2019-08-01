/*
04_17  

66GB

top video players - I have chosen a few based on my knowledge... Perhaps there are more?
- there are 6400 here where Gzip could make a large difference....

*/


select url, respsize, ext, mimetype, _gzip_save
from `summary_requests.2019_07_01_mobile` 
where (lower(url) like "%hls.js" or 
      lower(url) like "%video.js" or 
      lower(url) like "%shaka.js" or 
      lower(url) like "%jwplayer.js" or 
      lower(url) like "brightcove-player-loader.min.js")
     
     
     
order by respsize desc
