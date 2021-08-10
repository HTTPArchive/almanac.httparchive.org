#standardSQL
# 04_01: Lighthouse media scores for responsiveImages

SELECT
  COUNT(0) AS PageCount,
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
  APPROX_QUANTILES(ROUND(100 * respImagesBytes / (totalImageBytes + 0.1), 2), 1000)[OFFSET(100)] AS pctImageBytes_p10,
  APPROX_QUANTILES(ROUND(100 * respImagesBytes / (totalImageBytes + 0.1), 2), 1000)[OFFSET(250)] AS pctImageBytes_p25,
  APPROX_QUANTILES(ROUND(100 * respImagesBytes / (totalImageBytes + 0.1), 2), 1000)[OFFSET(500)] AS pctImageBytes_p50,
  APPROX_QUANTILES(ROUND(100 * respImagesBytes / (totalImageBytes + 0.1), 2), 1000)[OFFSET(750)] AS pctImageBytes_p75,
  APPROX_QUANTILES(ROUND(100 * respImagesBytes / (totalImageBytes + 0.1), 2), 1000)[OFFSET(900)] AS pctImageBytes_p90
FROM
(
  SELECT
    url,
    CAST(JSON_EXTRACT_SCALAR(report, '$.audits.resource-summary.details.items[0].size') AS INT64) AS totalBytes,
    CAST(JSON_EXTRACT_SCALAR(report, '$.audits.resource-summary.details.items[1].size') AS INT64) AS totalImageBytes,
    CAST(JSON_EXTRACT_SCALAR(report, '$.audits.uses-responsive-images.details.overallSavingsBytes') AS INT64) AS respImagesBytes,
    IF(REGEX_CONTAINS(JSON_EXTRACT(report, '$.audits.uses-responsive-images.details.items'), ','),
      ARRAY_LENGTH(split(JSON_EXTRACT(report, '$.audits.uses-responsive-images.details.items'), ',')), 0) AS respImagesCount
  FROM
    `httparchive.lighthouse.2019_07_01_mobile`
)
