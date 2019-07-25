/*
standard sql

04_16
60 GB


how many movies.. using Youtube
The query is currently set to NOT YouTube
Deleting the not in like 24 gives YES YouTube



*/

select ext, count(*) cnter


from(

select url, respsize, ext, mimetype, format

from `summary_requests.2019_07_01_mobile` 
where mimetype like "%video%" and url not like "%youtube%"
)
group by format, ext
order by cnter desc