/*
09_05

10TB

only tested on the 10k sample response body samples
from the sample data
Get the aria roles - and the tags that contain them.  
(this is not a perfect query - as some are too long, and probably some areas are grabbed 2x)

get the length of the body, and the sum of the lengths of all the roles - and find the percentage that are ariacovered

then calculate the percentiles of he percentages of ARia coverage
*/
select Approx_quantiles(percentgearia, 11)
from(

select url, bodylength, sum(rolelength) sumroles, sum(rolelength)/bodylength*100 percentgearia
from(
select url, BYTE_LENGTH(flat_ariaenclosed) rolelength, BYTE_LENGTH(body) bodylength
from(

select
      url, 
      REGEXP_EXTRACT_ALL(lower(body),r'<?.*role=[\'"]*[^\s\'"]+[\'"]*.*?>') ariaenclosed,
      body
from `almanac.response_bodies_mobile_1k` 
where lower(body) like "%role=%"

)
cross join unnest(ariaenclosed) flat_ariaenclosed
group by url, flat_ariaenclosed, body
)
group by url, bodylength
order by sum(rolelength)/bodylength*100 desc
)