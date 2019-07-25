/*
standard sql

04_25
64 GB
looking up 3 top VR frameworks.. I count only 52 responses - not highly utilised in this dataset

*/


select url, respsize, ext, mimetype, format

from `summary_requests.2019_07_01_mobile` 
where url like "%aframe.min.js" or url like "%babylon.js" or url like "%argon.js"
order by url asc, respsize asc
