#standardSQL
/*
standard SQL
04_06
04_08
04_13

10 TB query
only tested on the 1k mobile sample dataset

this query goes into the response bodies AND looks for the img tag WHERE it has srcset inside the tag.
I then pull out the image tags FROM each response AND flatten them out of the array into strings
I extract the srcset tag AND the sizes tag FROM each img, AND determine how many sources are present 
(I am COUNTing commas AND then adding one to get the total, so commas in the url will screw with the numbers)
the ratio is simply sources/sizes.

I then break it into percentiles to see the breakdown of source images AND sizes AND ratios.  
I also supply the COUNT of scrset AND size tags in the dataset.

04_08
I added a query for the src tag... AND then feed theat up through the same queries for 04_06. 
in the 1k mobile sample set 2918 have srcset, AND 2932 have a fallback src

04_13
added in alt tag query.  get COUNT AND LENGTH - note that LENGTH 6 = alt="" (empty)

*/


SELECT client, APPROX_QUANTILES(srcsetCOUNT,10) srcsetperc, APPROX_QUANTILES(sizesCOUNT,10) sizesperc, 
APPROX_QUANTILES(ratio,10) ratioperc,
APPROX_QUANTILES(srcCOUNT,10) srcperc,
APPROX_QUANTILES(altLENGTH,10) altTextLENGTHPercentiles,
 COUNT(srcset) srcsetCOUNT, COUNT(sizes) sizeCOUNT, COUNT(srcCOUNT) srcCOUNT, COUNT(altCOUNT) altCOUNT

FROM(

SELECT 
     #this COUNTs the number of commas, AND adds one - to get the number of srcsets
     LENGTH(srcset) - LENGTH(REGEXP_REPLACE(srcset, ',', '')) +1 srcsetCOUNT,
     #this COUNTs the number of commas, AND adds one - to get the number of sizes
     LENGTH(sizes) - LENGTH(REGEXP_REPLACE(sizes, ',', '')) +1 sizesCOUNT, 
     #ratio of srcset to sizes
     (LENGTH(srcset) - LENGTH(REGEXP_REPLACE(srcset, ',', '')) +1)/(LENGTH(sizes) - LENGTH(REGEXP_REPLACE(sizes, ',', '')) +1) ratio
     ,
     LENGTH(src)/LENGTH(src) srcCOUNT,
     LENGTH(alt)/LENGTH(alt) altCOUNT, LENGTH(alt) altLENGTH, client,
     #double check that its working
     srcset, sizes, alt
FROM(

SELECT REGEXP_EXTRACT(flat_img,r'srcset=".*?"') srcset, REGEXP_EXTRACT(flat_img,r'sizes=".*?"') sizes,
REGEXP_EXTRACT(flat_img,r'src=".*?"') src, REGEXP_EXTRACT(flat_img,r'alt=".*?"') alt, client

#here I am extracting the srcset=" *** " AND sizes " *** " for analysis   
FROM(
SELECT url, flat_img, client
#this CROSS JOIN flattens the array of image tags into strings.
FROM(

#this query grabs all img tags with srcset inside. it also grabs the same for the picture tag
SELECT url, REGEXP_EXTRACT_ALL(LOWER(body),r'(<img.*?srcset.*?>)') img,REGEXP_EXTRACT_ALL(LOWER(body),r'(<picture.*?srcset.*?/picture>)') picture, _TABLE_SUFFIX AS client
FROM `response_bodies.2019_07_01_*`  srcsets
WHERE body LIKE "%srcset%sizes%")
CROSS JOIN UNNEST(img) flat_img
)
)
) GROUP BY client