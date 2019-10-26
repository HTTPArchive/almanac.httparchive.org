#standardSQL
# 04_01: Lighthouse media scores for responsiveImages

SELECT
  count(0) as PageCount,
  APPROX_QUANTILES(respImagesCount, 1000)[OFFSET(100)] AS count_p10,
  APPROX_QUANTILES(respImagesCount, 1000)[OFFSET(250)] AS count_p25,
  APPROX_QUANTILES(respImagesCount, 1000)[OFFSET(500)] AS count_p50,
  APPROX_QUANTILES(respImagesCount, 1000)[OFFSET(750)] AS count_p75,
  APPROX_QUANTILES(respImagesCount, 1000)[OFFSET(900)] AS count_p90,
  APPROX_QUANTILES(respImagesBytes, 1000)[OFFSET(100)] AS bytes_p10,
  APPROX_QUANTILES(respImagesBytes, 1000)[OFFSET(250)] AS bytes_p25,
  APPROX_QUANTILES(respImagesBytes, 1000)[OFFSET(500)] AS bytes_p50,
  APPROX_QUANTILES(respImagesBytes, 1000)[OFFSET(750)] AS bytes_p75,
  APPROX_QUANTILES(respImagesBytes, 1000)[OFFSET(900)] AS bytes_p90,
  APPROX_QUANTILES(round(100*respImagesBytes/(totalImageBytes + 0.1), 2), 1000)[OFFSET(100)] AS pctImageBytes_p10,
  APPROX_QUANTILES(round(100*respImagesBytes/(totalImageBytes + 0.1), 2), 1000)[OFFSET(250)] AS pctImageBytes_p25,
  APPROX_QUANTILES(round(100*respImagesBytes/(totalImageBytes + 0.1), 2), 1000)[OFFSET(500)] AS pctImageBytes_p50,
  APPROX_QUANTILES(round(100*respImagesBytes/(totalImageBytes + 0.1), 2), 1000)[OFFSET(750)] AS pctImageBytes_p75,
  APPROX_QUANTILES(round(100*respImagesBytes/(totalImageBytes + 0.1), 2), 1000)[OFFSET(900)] AS pctImageBytes_p90
FROM
(
  SELECT
    url,
    cast(json_extract_scalar(report, '$.audits.resource-summary.details.items[0].size') AS INT64) totalBytes,
    cast(json_extract_scalar(report, '$.audits.resource-summary.details.items[1].size') AS INT64) totalImageBytes,
    cast(json_extract_scalar(report, '$.audits.uses-responsive-images.details.overallSavingsBytes') AS INT64) respImagesBytes,
    if(regexp_contains(json_extract(report, '$.audits.uses-responsive-images.details.items'), ','),
      ARRAY_LENGTH(split(json_extract(report, '$.audits.uses-responsive-images.details.items'), ',')), 0) respImagesCount
  FROM
    `httparchive.lighthouse.2019_07_01_mobile`
)
