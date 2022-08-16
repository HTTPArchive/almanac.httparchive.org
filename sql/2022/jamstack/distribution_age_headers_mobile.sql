SELECT
  round(safe_cast(resp_age as numeric)/3600) as age_hours,
  count(*) as urls
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2022-06-01'
  and client = 'mobile'
  and page = url
  and resp_age is not null
  and resp_age != ''
  and safe_cast(resp_age as numeric) is not null
group by age_hours
order by age_hours
