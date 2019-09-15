#StandardSQL
/*
04_19 

10TB

only tested on the sample response body samples

This pulls out every parameter FROM the video tag AND totals them.

_09_07 is looking for a cations track... added to this query  
*/
SELECT 
	  client,
	  COUNT(*) COUNTvideo, 
      SUM(cntsrc) totalsrc, 
      SUM(cnttype) totaltype,
      SUM(cntw	) totalwidth,
      SUM(cnth	) totalheight,
      SUM(cntcontrols	) totalcontrols,
      SUM(cntautoplay	) totalsutoplay,
      SUM(cntmobileautoplay	) totalmobileautplay,
      SUM(cntloop	) totalloop,
      SUM(cntmuted	) totalmuted,
      SUM(cntposter	) totalposter,
      SUM(cntpreload	) totalpreload,
      SUM(cntpreloadauto	) totalpreloadauto,
      SUM(cntpreloadmetadata	) totalprelaodmetadata,
      SUM(cntpreloadnone	) totalprelaodnone,
      SUM(hero	) totalhero,
      SUM(track) totaltrack,
      SUM(vtt) totalvtt
FROM(


SELECT
  url,
  client,
  IF(flat_videotag LIKE "%src%", (LENGTH(flat_videotag) - LENGTH(REGEXP_REPLACE(flat_videotag, 'src', '')))/3,0) cntsrc,
  
  IF(flat_videotag LIKE "%source%", (LENGTH(flat_videotag) - LENGTH(REGEXP_REPLACE(flat_videotag, 'source', '')))/6,0) cntsource,
 
  IF(flat_videotag LIKE "%type%", (LENGTH(flat_videotag) - LENGTH(REGEXP_REPLACE(flat_videotag, 'type', '')))/4,0) cnttype,
  IF(flat_videotag LIKE "%width%",1,0) cntw,
  IF(flat_videotag LIKE "%height%",1,0) cnth,
  IF(flat_videotag LIKE "%controls%",1,0) cntcontrols,
  IF(flat_videotag LIKE "%autoplay%",1,0) cntautoplay,
  /*mobile autoplay requires autoplay AND muted*/
  IF(flat_videotag LIKE "%autoplay%",IF(flat_videotag LIKE "%muted%",1,0),0) cntmobileautoplay,
  IF(flat_videotag LIKE "%loop%",1,0) cntloop,
  IF(flat_videotag LIKE "%muted%",1,0)cntmuted,
  IF(flat_videotag LIKE "%poster%",1,0)cntposter,
  IF(flat_videotag LIKE "%preload%",1,0)cntpreload,
  
  IF(flat_videotag LIKE "%preload%", IF(flat_videotag LIKE "%auto%", 1,0),0) AS cntpreloadauto,
  IF(flat_videotag LIKE "%preload%", IF(flat_videotag LIKE "%metadata%", 1,0),0) AS cntpreloadmetadata,
  IF(flat_videotag LIKE "%preload%", IF(flat_videotag LIKE "%none%", 1,0),0) AS cntpreloadnone,
  IF(flat_videotag LIKE "%hero%",1,0) hero,
  IF(flat_videotag LIKE "%track%",1,0) track,
  IF(flat_videotag LIKE "%vtt%",1,0) vtt,
  flat_videotag 
  FROM

(
SELECT url, flat_videotag, client
FROM(
SELECT
url, REGEXP_EXTRACT_ALL(LOWER(body),r'(<video[\s\S]+?<\/video>)') videotag,_TABLE_SUFFIX AS client
FROM `response_bodies.2019_07_01_*` videotagset
WHERE body LIKE "%</video>%"
)
CROSS JOIN UNNEST(videotag) flat_videotag
)
)GROUP BY client