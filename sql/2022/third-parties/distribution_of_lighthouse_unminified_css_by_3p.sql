#standardSQL
#Third-party pages with unminified CSS

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
    SUM(IF(is_3p, potential_savings, 0)) AS potential_savings
  FROM (
    SELECT
      lighthouse.url AS page,
      NET.HOST(data.url) IS NOT NULL AND NET.HOST(data.url) IN (
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
    page
)

SELECT
  percentile,
  APPROX_QUANTILES(potential_savings, 1000)[OFFSET(percentile * 10)] AS potential_savings_bytes
FROM 
  base,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile
ORDER BY
  percentile
