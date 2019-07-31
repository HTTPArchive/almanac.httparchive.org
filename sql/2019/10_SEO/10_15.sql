#standardSQL

# speed metrics (FCP, server response time)

# speeds from lighthouse
# speeds from Crux (more interesting?)
# https://discuss.httparchive.org/t/measuring-cms-host-ttfb-in-crux/1676/1

# todo: onload event? document html size? images size? soo many more metrics


# sample: `httparchive.almanac.lighthouse_mobile_1k`
# dataset: `httparchive.lighthouse.2019_07_01_desktop`

SELECT
    COUNT(url) AS `total`,
    COUNT(DISTINCT url) AS `distinct_total`,
    AVG(SAFE_CAST(JSON_EXTRACT_SCALAR(report, '$.audits.time-to-first-byte.numericValue') as NUMERIC)) AS `ttfbAvgMs`,
    AVG(SAFE_CAST(JSON_EXTRACT_SCALAR(report, '$.audits.first-contentful-paint.numericValue') as NUMERIC)) AS `fcpAvgMs`,
    AVG(SAFE_CAST(JSON_EXTRACT_SCALAR(report, '$.audits.first-meaningful-paint.numericValue') as NUMERIC)) AS `tmpAvgMs`,
    AVG(SAFE_CAST(JSON_EXTRACT_SCALAR(report, '$.audits.interactive.numericValue') as NUMERIC)) AS `ttiAvgMs`,
    AVG(SAFE_CAST(JSON_EXTRACT_SCALAR(report, '$.audits.estimated-input-latency.numericValue') as NUMERIC)) AS `eilAvgMs`
FROM
    `httparchive.almanac.lighthouse_mobile_1k`
