SELECT 
  app,
  count(*)
FROM `httparchive.technologies.2022_06_01_mobile`
where category = 'JavaScript frameworks'
group by app
order by count(*) desc
