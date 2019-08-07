#standardSQL
/*
standard SQL
04_11
265 GB

bytes per pixel photographic

get the natural height/width, AS well AS the height/width on the pag
FROM the custom query.  There's some fun JSON parsing, asn the nested JSON has encoded characters

I then pull in the response size for each image.
I calculate the # of pixels on the screen (imgh*imgw) AND use that to calculate bytes per pixel
to ensure photographic images, I only allow images >50KB 

I then take the quantiles of this total for a chart.

Looking at the extremes - there is some error - lots of images classigied AS h=1 w=1 (when NOT defined on the page)
and some are classifed AS WAY too large AS well.
*/

SELECT APPROX_QUANTILES(byteperpixelonscreen, 1000)

FROM(

SELECT DISTINCT(imgurl),
		/*hratio, 
		wratio, 
		pixelsOnScreen, 
		totalPixels, 
		respsize,*/
       IEEE_DIVIDE(respsize,pixelsOnScreen) AS byteperpixelonscreen
       /*, 
       IEEE_DIVIDE(respsize,totalPixels) AS bytepertotalpixel,pageurl, 
       imgh, 
       imgw, 
       imgnaturalh, 
       imgnaturalw
       */

FROM(

SELECT imgdata.url 
		pageurl, 
		imgurl, 
		imgh, 
		imgw, 
		imgnaturalh, 
		imgnaturalw,
        IEEE_DIVIDE(imgnaturalh,imgh) AS hratio,
        IEEE_DIVIDE(imgnaturalw,imgw) AS wratio,
        imgh*imgw AS pixelsOnScreen,
        imgnaturalh*imgnaturalw AS totalPixels,
        respsize
        

FROM (
SELECT url, TRIM(JSON_EXTRACT(imagelist,'$.url'),'"') AS imgurl, 
            CAST(JSON_EXTRACT(imagelist,'$.height') AS INT64) AS imgh, 
            CAST(JSON_EXTRACT(imagelist,'$.width') AS INT64) AS imgw,
            CAST(JSON_EXTRACT(imagelist,'$.naturalHeight') AS INT64) AS imgnaturalh,
            CAST(JSON_EXTRACT(imagelist,'$.naturalWidth') AS INT64) AS imgnaturalw
FROM(

SELECT url, regexp_replace(regexp_replace(JSON_EXTRACT(payload,"$._Images"),r'(\\)',""),r'(\"\[)',"") AS imagelist

FROM 
`pages.2019_07_01_mobile`
)
ORDER BY url asc


)imgdata
JOIN(
SELECT respsize, url
FROM `httparchive.summary_requests.2019_07_01_mobile`) resp
on(resp.url = imgdata.imgurl)
)
WHERE respsize >50000 AND imgh >0 AND imgw>0 AND pixelsOnScreen > 1 
)
