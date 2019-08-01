/*
04_19 

10TB

only tested on the sample response body samples

This pulls out every parameter from the video tag and totals them.

_09_07 is looking for a cations track... added to this query  
*/
select count(*) countvideo, 
      sum(cntsrc) totalsrc, 
      sum(cnttype) totaltype,
      sum(cntw	) totalwidth,
      sum(cnth	) totalheight,
      sum(cntcontrols	) totalcontrols,
      sum(cntautoplay	) totalsutoplay,
      sum(cntmobileautoplay	) totalmobileautplay,
      sum(cntloop	) totalloop,
      sum(cntmuted	) totalmuted,
      sum(cntposter	) totalposter,
      sum(cntpreload	) totalpreload,
      sum(cntpreloadauto	) totalpreloadauto,
      sum(cntpreloadmetadata	) totalprelaodmetadata,
      sum(cntpreloadnone	) totalprelaodnone,
      sum(hero	) totalhero,
      sum(track) totaltrack,
      sum(vtt) totalvtt
from(


SELECT
  url,
 
  IF(flat_videotag like "%src%", (LENGTH(flat_videotag) - LENGTH(REGEXP_REPLACE(flat_videotag, 'src', '')))/3,0) cntsrc,
  
  IF(flat_videotag like "%source%", (LENGTH(flat_videotag) - LENGTH(REGEXP_REPLACE(flat_videotag, 'source', '')))/6,0) cntsource,
 
  IF(flat_videotag like "%type%", (LENGTH(flat_videotag) - LENGTH(REGEXP_REPLACE(flat_videotag, 'type', '')))/4,0) cnttype,
  IF(flat_videotag like "%width%",1,0) cntw,
  IF(flat_videotag like "%height%",1,0) cnth,
  IF(flat_videotag like "%controls%",1,0) cntcontrols,
  IF(flat_videotag like "%autoplay%",1,0) cntautoplay,
  /*mobile autoplay requires autoplay AND muted*/
  IF(flat_videotag like "%autoplay%",IF(flat_videotag like "%muted%",1,0),0) cntmobileautoplay,
  IF(flat_videotag like "%loop%",1,0) cntloop,
  IF(flat_videotag like "%muted%",1,0)cntmuted,
  IF(flat_videotag like "%poster%",1,0)cntposter,
  IF(flat_videotag like "%preload%",1,0)cntpreload,
  
  IF(flat_videotag like "%preload%", IF(flat_videotag like "%auto%", 1,0),0) AS cntpreloadauto,
  IF(flat_videotag like "%preload%", IF(flat_videotag like "%metadata%", 1,0),0) AS cntpreloadmetadata,
  IF(flat_videotag like "%preload%", IF(flat_videotag like "%none%", 1,0),0) AS cntpreloadnone,
  IF(flat_videotag like "%hero%",1,0) hero,
  IF(flat_videotag like "%track%",1,0) track,
  IF(flat_videotag like "%vtt%",1,0) vtt,
  flat_videotag 
  from

(
select url, flat_videotag
from(
select
url, REGEXP_EXTRACT_ALL(lower(body),r'(<video[\s\S]+?<\/video>)') videotag
from `response_bodies.2019_07_01_mobile` videotagset
where body like "%</video>%"
)
cross join unnest(videotag) flat_videotag
)
)