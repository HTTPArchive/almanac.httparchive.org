SELECT
    client,
    (select count(*) from `httparchive.almanac.requests` WHERE date = '2021-07-01' and resp_content_type like '%image%') as images,
    (select count(*) from `httparchive.almanac.requests` WHERE date = '2021-07-01' and resp_content_type like '%font%') as font, 
    (select count(*) from `httparchive.almanac.requests` WHERE date = '2021-07-01' and resp_content_type like '%css%') as css, 
    (select count(*) from `httparchive.almanac.requests` WHERE date = '2021-07-01' and resp_content_type like '%javascript%') as javascript, 
    (select count(*) from `httparchive.almanac.requests` WHERE date = '2021-07-01' and resp_content_type like '%json%') as json,
    count(*) as total
  FROM
    `httparchive.almanac.requests`
GROUP BY
  client
ORDER BY
  client
