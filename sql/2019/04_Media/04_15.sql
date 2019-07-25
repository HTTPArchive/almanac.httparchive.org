/*
standard sql

04_15
13 GB


how many movies.. how big (in percentiles by extension).. 

remove the percentiles to get a better count for each format.
remove the ext and cnter to get a better idea on sizes.



*/

select ext, count(*) cnter, approx_quantiles(respsize,11) sizepercentiles 

from(

select url, respsize, ext, mimetype, format

from `summary_requests.2019_07_01_mobile` 
where mimetype like "%video%"
)
group by format, ext
order by cnter desc