SELECT 
  app,
  count(*)
FROM `httparchive.technologies.2022_06_01_mobile`
where category = 'PaaS'
group by app
order by count(*) desc
