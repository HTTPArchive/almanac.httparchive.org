#standardSQL
# 08_34: Groupings of "sec-fetch-" Header(s) parsed values buckets
#   Looks like there are a few possible value groups - no data in archive
#   https://w3c.github.io/webappsec-fetch-metadata/
#
#   `httparchive.almanac.summary_response_bodies` archive = 71.5GB 
#         Zero results within the "archive" tables 
#   `httparchive.summary_requests.2019_07_01_*` = 118.3 GB

SELECT
  val,
  COUNT(0) AS freq,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (), 2) AS pct
FROM
  `httparchive.almanac.summary_requests`,
  UNNEST(REGEXP_EXTRACT_ALL(LOWER(respOtherHeaders),r'sec-fetch-[dest|mode|site|user] = ([\\w-]+)')) AS val
WHERE
  firstHtml
GROUP BY
  val
ORDER BY
  freq DESC
