#standardSQL
# Third-party pages with unoptimized images

CREATE TEMPORARY FUNCTION getUnminifiedImageUrls(audit STRING)
RETURNS ARRAY<STRUCT<url STRING, wastedBytes INT64, totalBytes INT64>> LANGUAGE js AS '''
try {
  var $ = JSON.parse(audit);
  return $.details.items.map(({url, wastedBytes, totalBytes}) => {
    return {url, wastedBytes, totalBytes};
  });
} catch (e) {
  return [];
}
''';

WITH base AS (
  SELECT
    page,
    domain,
    SUM(IF(is_3p, potential_savings, 0)) AS potential_third_party_savings,
    SUM(IF(is_3p, transfer_size, 0)) AS third_party_transfer_size
  FROM (
    SELECT
      NET.HOST(data.url) AS domain,
      lighthouse.url AS page,
      NET.HOST(data.url) IS NOT NULL AND
      NET.HOST(data.url) IN (
        SELECT domain
        FROM `httparchive.almanac.third_parties`
        WHERE date = '2022-06-01' AND category != 'hosting'
      ) AS is_3p,
      data.wastedBytes AS potential_savings,
      data.totalBytes AS transfer_size
    FROM
      `httparchive.lighthouse.2022_06_01_mobile` AS lighthouse,
      UNNEST(getUnminifiedImageUrls(JSON_EXTRACT(report, "$.audits['uses-optimized-images']"))) AS data
  )
  GROUP BY
    page,
    domain
)

SELECT
  domain,
  COUNT(DISTINCT page) AS total_pages,
  SUM(third_party_transfer_size) AS third_party_transfer_size_bytes,
  SUM(potential_third_party_savings) AS potential_third_party_savings_bytes,
  SUM(potential_third_party_savings) / SUM(third_party_transfer_size) AS pct_potential_third_party_savings,
  SUM(potential_third_party_savings) / COUNT(DISTINCT page) AS potential_third_party_savings_bytes_per_page
FROM
  base
WHERE
  potential_third_party_savings > 0
GROUP BY
  domain
ORDER BY
  total_pages DESC,
  potential_third_party_savings_bytes_per_page DESC,
  domain
