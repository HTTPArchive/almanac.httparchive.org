#StandardSQL
/*
standard sql

04_25
64 GB
looking up 3 top VR frameworks.. I COUNT only 52 responses - NOT highly utilised in this dataset

*/


SELECT url, respsize, ext, mimetype, format, _TABLE_SUFFIX AS client

FROM `summary_requests.2019_07_01_*` 
WHERE url LIKE "%aframe.min.js" OR  url LIKE "%babylon.js" OR  url LIKE "%argon.js"
ORDER BY url asc, respsize asc
