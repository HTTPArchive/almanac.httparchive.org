#standardSQL
# Third-party pages with unminified CSS

CREATE TEMPORARY FUNCTION getUnminifiedCssUrls(audit STRING)
RETURNS ARRAY<STRUCT<url STRING, wastedBytes INT64>> LANGUAGE js AS '''
try {
  var $ = JSON.parse(audit);
  return $.details.items.map(({url, wastedBytes}) => {
    return {url, wastedBytes};
  });
} catch (e) {
  return [];
}
''';

WITH base AS (
  SELECT
    page,
    domain,
    SUM(IF(is_3p, potential_savings, 0)) AS potential_savings
  FROM (
    SELECT
      NET.HOST(data.url) as domain,
      lighthouse.url AS page,
      NET.HOST(data.url) IS NOT NULL AND
      NET.HOST(data.url) IN (
        SELECT domain
        FROM `httparchive.almanac.third_parties`
        WHERE date = '2022-06-01' AND category != 'hosting'
      ) AS is_3p,
      data.wastedBytes AS potential_savings
    FROM
      `httparchive.lighthouse.2022_06_01_mobile` AS lighthouse,
      UNNEST(getUnminifiedCssUrls(JSON_EXTRACT(report, "$.audits['unminified-css']"))) AS data
  )
  GROUP BY
    page,
    domain
)

SELECT
  domain,
  SUM(potential_savings) AS total_potential_savings_bytes,
  COUNT(DISTINCT page) AS total_pages,
  SUM(potential_savings) / COUNT(DISTINCT page) AS total_potential_savings_bytes_per_page
FROM 
  base
WHERE
  potential_savings > 0
GROUP BY
  domain
ORDER BY
  total_pages DESC,
  total_potential_savings_bytes_per_page DESC,
  domain
