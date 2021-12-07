#standardSQL
# 21_11c: Distribution of # of warnings for the Lighthouse 'Preload key requests' audit
SELECT
  percentile,
  APPROX_QUANTILES(ARRAY_LENGTH(JSON_EXTRACT_ARRAY(report, '$.audits.uses-rel-preload.warnings')), 1000)[OFFSET(percentile * 10)] AS warnings
FROM
  `httparchive.lighthouse.2020_08_01_mobile`,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile
ORDER BY
  percentile
