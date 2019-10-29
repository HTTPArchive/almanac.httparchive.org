#standardSQL
# 17_10b: Common vary headers as seen from CDNs

SELECT client, resp_vary, count(*) as total
FROM `httparchive.almanac.requests`
where _cdn_provider != ''
group by client, resp_vary
order by total desc