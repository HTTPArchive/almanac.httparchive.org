#standardSQL
# Pages with unminified JS by 1P/3P
CREATE TEMPORARY FUNCTION getUnminifiedJsUrls(audit STRING)
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

SELECT
  AVG(pct_1p_wasted_bytes) AS avg_pct_1p_wasted_bytes,
  AVG(pct_3p_wasted_bytes) AS avg_pct_3p_wasted_bytes
FROM (
  SELECT
    page,
    SUM(IF(is_3p, 0, wasted_bytes)) / SUM(wasted_bytes) AS pct_1p_wasted_bytes,
    SUM(IF(is_3p, wasted_bytes, 0)) / SUM(wasted_bytes) AS pct_3p_wasted_bytes
  FROM (
    SELECT
      test.url AS page,
      NET.HOST(unminified.url) IS NOT NULL AND NET.HOST(unminified.url) IN (
        SELECT domain FROM `httparchive.almanac.third_parties` WHERE date = '2020-08-01' AND category != 'hosting'
      ) AS is_3p,
      unminified.wastedBytes AS wasted_bytes
    FROM
      `httparchive.lighthouse.2020_08_01_mobile` AS test,
      UNNEST(getUnminifiedJsUrls(JSON_EXTRACT(report, "$.audits['unminified-javascript']"))) AS unminified
  )
  GROUP BY
    page
)
