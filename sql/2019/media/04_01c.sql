#standardSQL
# 04_01: Lighthouse media scores for unoptimized images

SELECT
  COUNT(0) AS PageCount,
  APPROX_QUANTILES(unoptimizedImagesCount, 1000)[OFFSET(100)] AS count_p10,
  APPROX_QUANTILES(unoptimizedImagesCount, 1000)[OFFSET(250)] AS count_p25,
  APPROX_QUANTILES(unoptimizedImagesCount, 1000)[OFFSET(500)] AS count_p50,
  APPROX_QUANTILES(unoptimizedImagesCount, 1000)[OFFSET(750)] AS count_p75,
  APPROX_QUANTILES(unoptimizedImagesCount, 1000)[OFFSET(900)] AS count_p90,
  APPROX_QUANTILES(unoptimizedImagesBytes, 1000)[OFFSET(100)] AS bytes_p10,
  APPROX_QUANTILES(unoptimizedImagesBytes, 1000)[OFFSET(250)] AS bytes_p25,
  APPROX_QUANTILES(unoptimizedImagesBytes, 1000)[OFFSET(500)] AS bytes_p50,
  APPROX_QUANTILES(unoptimizedImagesBytes, 1000)[OFFSET(750)] AS bytes_p75,
  APPROX_QUANTILES(unoptimizedImagesBytes, 1000)[OFFSET(900)] AS bytes_p90,
  APPROX_QUANTILES(ROUND(100 * unoptimizedImagesBytes / (totalImageBytes + 0.1), 2), 1000)[OFFSET(100)] AS pctImageBytes_p10,
  APPROX_QUANTILES(ROUND(100 * unoptimizedImagesBytes / (totalImageBytes + 0.1), 2), 1000)[OFFSET(250)] AS pctImageBytes_p25,
  APPROX_QUANTILES(ROUND(100 * unoptimizedImagesBytes / (totalImageBytes + 0.1), 2), 1000)[OFFSET(500)] AS pctImageBytes_p50,
  APPROX_QUANTILES(ROUND(100 * unoptimizedImagesBytes / (totalImageBytes + 0.1), 2), 1000)[OFFSET(750)] AS pctImageBytes_p75,
  APPROX_QUANTILES(ROUND(100 * unoptimizedImagesBytes / (totalImageBytes + 0.1), 2), 1000)[OFFSET(900)] AS pctImageBytes_p90,
  APPROX_QUANTILES(unoptimizedImagesSavingsMs, 1000)[OFFSET(100)] AS ms_p10,
  APPROX_QUANTILES(unoptimizedImagesSavingsMs, 1000)[OFFSET(250)] AS ms_p25,
  APPROX_QUANTILES(unoptimizedImagesSavingsMs, 1000)[OFFSET(500)] AS ms_p50,
  APPROX_QUANTILES(unoptimizedImagesSavingsMs, 1000)[OFFSET(750)] AS ms_p75,
  APPROX_QUANTILES(unoptimizedImagesSavingsMs, 1000)[OFFSET(900)] AS ms_p90
FROM
  (
    SELECT
      url,
      CAST(JSON_EXTRACT_SCALAR(report, '$.audits.resource-summary.details.items[0].size') AS INT64) AS totalBytes,
      CAST(JSON_EXTRACT_SCALAR(report, '$.audits.resource-summary.details.items[1].size') AS INT64) AS totalImageBytes,
      CAST(JSON_EXTRACT_SCALAR(report, '$.audits.uses-optimized-images.details.overallSavingsMs') AS INT64) AS unoptimizedImagesSavingsMs,
      CAST(JSON_EXTRACT_SCALAR(report, '$.audits.uses-optimized-images.details.overallSavingsBytes') AS INT64) AS unoptimizedImagesBytes,
      IF(REGEX_CONTAINS(JSON_EXTRACT(report, '$.audits.uses-optimized-images.details.items'), ','),
        ARRAY_LENGTH(split(JSON_EXTRACT(report, '$.audits.uses-optimized-images.details.items'), ',')), 0) AS unoptimizedImagesCount
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`
  )
