#standardSQL
# 04_01: Lighthouse media scores, savings, and item lengths

CREATE TEMPORARY FUNCTION getVideoBytes(payload STRING)
RETURNS INT64 LANGUAGE js AS '''
try {
  let data = JSON.parse(payload);
  let videoReq = data.audits['network-requests'].details.items.filter(v => /^video/.test(v.mimeType));
  let bytes = videoReq.reduce((a,c) => a + (c.transferSize || 0), 0)

  return bytes;
} catch (e) {
  return null;
}
''';

CREATE TEMPORARY FUNCTION getVideoCount(payload STRING)
RETURNS INT64 LANGUAGE js AS '''
try {
  let data = JSON.parse(payload);
  let videoReq = data.audits['network-requests'].details.items.filter(v => /^video/.test(v.mimeType));
  return videoReq.length;
} catch (e) {
  return null;
}
''';

SELECT
  type,
  APPROX_QUANTILES(resourceCount, 1000)[OFFSET(100)] AS count_p10,
  APPROX_QUANTILES(resourceCount, 1000)[OFFSET(250)] AS count_p25,
  APPROX_QUANTILES(resourceCount, 1000)[OFFSET(500)] AS count_p50,
  APPROX_QUANTILES(resourceCount, 1000)[OFFSET(750)] AS count_p75,
  APPROX_QUANTILES(resourceCount, 1000)[OFFSET(900)] AS count_p90,
  APPROX_QUANTILES(resourceBytes, 1000)[OFFSET(100)] AS bytes_p10,
  APPROX_QUANTILES(resourceBytes, 1000)[OFFSET(250)] AS bytes_p25,
  APPROX_QUANTILES(resourceBytes, 1000)[OFFSET(500)] AS bytes_p50,
  APPROX_QUANTILES(resourceBytes, 1000)[OFFSET(750)] AS bytes_p75,
  APPROX_QUANTILES(resourceBytes, 1000)[OFFSET(900)] AS bytes_p90,
  APPROX_QUANTILES(resourceBytes, 1000)[OFFSET(990)] AS bytes_p99,
  APPROX_QUANTILES(ROUND(100 * resourceBytes / IFNULL(NULLIF(pageBytes, 0), 0.1), 2), 1000)[OFFSET(100)] AS pct_p10,
  APPROX_QUANTILES(ROUND(100 * resourceBytes / IFNULL(NULLIF(pageBytes, 0), 0.1), 2), 1000)[OFFSET(250)] AS pct_p25,
  APPROX_QUANTILES(ROUND(100 * resourceBytes / IFNULL(NULLIF(pageBytes, 0), 0.1), 2), 1000)[OFFSET(500)] AS pct_p50,
  APPROX_QUANTILES(ROUND(100 * resourceBytes / IFNULL(NULLIF(pageBytes, 0), 0.1), 2), 1000)[OFFSET(750)] AS pct_p75,
  APPROX_QUANTILES(ROUND(100 * resourceBytes / IFNULL(NULLIF(pageBytes, 0), 0.1), 2), 1000)[OFFSET(990)] AS pct_p99,
  APPROX_QUANTILES(ROUND(100 * resourceBytes / IFNULL(NULLIF(pageBytes, 0), 0.1), 2), 1000)[OFFSET(900)] AS pct_p90
FROM
  (
    SELECT
      type,
      pageBytes,
      IF(type = 'image', totalImageCount, totalImageCount + totalVideoCount) AS resourceCount,
      IF(type = 'image', totalImageBytes, totalImageBytes + totalVideoBytes) AS resourceBytes
    FROM
      (
        SELECT
          url,
          CAST(JSON_EXTRACT_SCALAR(report, '$.audits.resource-summary.details.items[0].size') AS INT64) AS pageBytes,
          CAST(JSON_EXTRACT_SCALAR(report, '$.audits.resource-summary.details.items[1].size') AS INT64) AS totalImageBytes,
          CAST(JSON_EXTRACT_SCALAR(report, '$.audits.resource-summary.details.items[1].requestCount') AS INT64) AS totalImageCount,
          getVideoBytes(report) AS totalVideoBytes,
          getVideoCount(report) AS totalVideoCount
        FROM
          `httparchive.lighthouse.2019_07_01_mobile`
      )
    # we to make this a little easier to read we unnest with just image and image+video
    # it's important to remember that each of the results is mutually exclusive and should not imply addition
    # that is, you cannot assume that image + video at the p75 and image at p75 are the same webpages being collected
    # if we wanted to do more advanced percentile based on page size, we would need a different statistics engine (eg: R)
    CROSS JOIN UNNEST(['image', 'image+video']) AS type
  )
GROUP BY
  type
