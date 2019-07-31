/*
standard SQL
04_11
265 GB

bytes per pixel photographic

get the natural height/width, as well as the height/width on the pag
from the custom query.  There's some fun JSON parsing, asn the nested JSON has encoded characters

I then pull in the response size for each image.
I calculate the # of pixels on the screen (imgh*imgw) and use that to calculate bytes per pixel
to ensure photographic images, I only allow images >50KB 

I then take the quantiles of this total for a chart.

Looking at the extremes - there is some error - lots of images classigied as h=1 w=1 (when not defined on the page)
and some are classifed as WAY too large as well.
*/

select approx_quantiles(byteperpixelonscreen, 1000)from(

select DISTINCT(imgurl),hratio, wratio, pixelsOnScreen, totalPixels, respsize,
       IEEE_DIVIDE(respsize,pixelsOnScreen) byteperpixelonscreen, 
       IEEE_DIVIDE(respsize,totalPixels) bytepertotalpixel,pageurl, 
       imgh, imgw, imgnaturalh, imgnaturalw

from(

select imgdata.url pageurl, imgurl, imgh, imgw, imgnaturalh, imgnaturalw,
        IEEE_DIVIDE(imgnaturalh,imgh) AS hratio,
        IEEE_DIVIDE(imgnaturalw,imgw) AS wratio,
        imgh*imgw AS pixelsOnScreen,
        imgnaturalh*imgnaturalw As totalPixels,
        respsize
        

from (
select url, TRIM(JSON_EXTRACT(imagelist,'$.url'),'"') imgurl, 
            CAST(JSON_EXTRACT(imagelist,'$.height') as INT64) imgh, 
            CAST(JSON_EXTRACT(imagelist,'$.width') as INT64) imgw,
            CAST(JSON_EXTRACT(imagelist,'$.naturalHeight') as INT64) imgnaturalh,
            CAST(JSON_EXTRACT(imagelist,'$.naturalWidth') as INT64) imgnaturalw
from(

select url, regexp_replace(regexp_replace(JSON_EXTRACT(payload,"$._Images"),r'(\\)',""),r'(\"\[)',"") as imagelist

from 
`pages.2019_07_01_mobile`
)
order by url asc


)imgdata
join(
select respsize, url
from `httparchive.summary_requests.2019_07_01_mobile`) resp
on(resp.url = imgdata.imgurl)
)
where respsize >50000 and imgh >0 and imgw>0 and pixelsOnScreen > 1 
)
