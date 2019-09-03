#StandardSQL
#standardSQL
# WARNING! This query consumes 6.2 TB!
#this is ricks query: https://discuss.httparchive.org/t/what-are-the-invalid-uses-of-the-lang-attribute/1022/5?u=rviscomi
SELECT
  APPROX_TOP_COUNT(LOWER(REGEXP_EXTRACT(body, '(?i)<html[^>]*lang=[\'"]?([a-z]{2})')), 50) AS lang
FROM
  `httparchive.response_bodies.2019_04_01_desktop`
WHERE
  page = url