#standardSQL
# client_hints.sql : Distribution of status code by client

select client,sc,count(sc) from (
select client,JSON_EXTRACT_SCALAR(summary, '$.status') as sc from `httparchive.all.requests` WHERE date = "2024-06-01")
group by client,sc