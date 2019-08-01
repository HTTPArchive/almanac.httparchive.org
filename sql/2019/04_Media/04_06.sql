/*
standard SQL
04_06
04_08
04_13

10 TB query
only tested on the 1k mobile sample dataset

this query goes into the response bodies and looks for the img tag where it has srcset inside the tag.
I then pull out the image tags from each response and flatten them out of the array into strings
I extract the srcset tag and the sizes tag from each img, and determine how many sources are present 
(I am counting commas and then adding one to get the total, so commas in the url will screw with the numbers)
the ratio is simply sources/sizes.

I then break it into percentiles to see the breakdown of source images and sizes and ratios.  
I also supply the count of scrset and size tags in the dataset.

04_08
I added a query for the src tag... and then feed theat up through the same queries for 04_06. 
in the 1k mobile sample set 2918 have srcset, and 2932 have a fallback src

04_13
added in alt tag query.  get count and length - note that length 6 = alt="" (empty)

*/


select approx_quantiles(srcsetcount,10) srcsetperc, approx_quantiles(sizescount,10) sizesperc, 
approx_quantiles(ratio,10) ratioperc,
approx_quantiles(srccount,10) srcperc,
approx_quantiles(altlength,10) altTextLengthPercentiles,
 count(srcset) srcsetcount, count(sizes) sizecount, count(srccount) srccount, count(altcount) altcount

from(

select 
     #this counts the number of commas, and adds one - to get the number of srcsets
     length(srcset) - LENGTH(REGEXP_REPLACE(srcset, ',', '')) +1 srcsetcount,
     #this counts the number of commas, and adds one - to get the number of sizes
     length(sizes) - LENGTH(REGEXP_REPLACE(sizes, ',', '')) +1 sizescount, 
     #ratio of srcset to sizes
     (length(srcset) - LENGTH(REGEXP_REPLACE(srcset, ',', '')) +1)/(length(sizes) - LENGTH(REGEXP_REPLACE(sizes, ',', '')) +1) ratio
     ,
     length(src)/length(src) srccount,
     length(alt)/length(alt) altcount, length(alt) altlength,
     #double check that its working
     srcset, sizes, alt
from(

select REGEXP_EXTRACT(flat_img,r'srcset=".*?"') srcset, REGEXP_EXTRACT(flat_img,r'sizes=".*?"') sizes,
REGEXP_EXTRACT(flat_img,r'src=".*?"') src, REGEXP_EXTRACT(flat_img,r'alt=".*?"') alt

#here I am extracting the srcset=" *** " and sizes " *** " for analysis   
from(
select url, flat_img 
#this cross join flattens the array of image tags into strings.
from(

#this query grabs all img tags with srcset inside. it also grabs the same for the picture tag
select url, REGEXP_EXTRACT_ALL(lower(body),r'(<img.*?srcset.*?>)') img,REGEXP_EXTRACT_ALL(lower(body),r'(<picture.*?srcset.*?/picture>)') picture
from `response_bodies.2019_07_01_mobile`  srcsets
where body like "%srcset%sizes%")
cross join unnest(img) flat_img
)
)
)