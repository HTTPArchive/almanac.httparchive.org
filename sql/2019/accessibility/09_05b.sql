#standardSQL
# 09_05b: % of sites using ARIA role
SELECT
  client,
  COUNT(0) AS total_sites,
  COUNTIF(uses_roles) AS total_using_roles,
  ROUND(COUNTIF(uses_roles) * 100 / COUNT(0), 2) AS perc_using_roles
FROM (
  SELECT
    client,
    REGEXP_CONTAINS(body, r'role=[\'"]?([\w-]+)') AS uses_roles
  FROM
    `httparchive.almanac.summary_response_bodies`
  WHERE
    date = '2019-07-01' AND
    firstHtml
)
GROUP BY
  client
