#standardSQL
# 08_34: Groupings of "sec-fetch-" Header(s) parsed values buckets
#   Looks like there are a few possible value groups - no data in archive
#   https://w3c.github.io/webappsec-fetch-metadata/
#
#   `httparchive.almanac.summary_response_bodies` archive = 71.5GB 
#         Zero results within the "archive" tables 
#   `httparchive.summary_requests.2019_07_01_*` = 118.3 GB

SELECT
  client, 
  SUM(COUNT(0)) OVER (PARTITION BY client) AS client_tot,
  sec_fetch_val,
  count(0) as sec_fetch_val_freq,
  ROUND(COUNT(0)*100/SUM(COUNT(0)) OVER (PARTITION BY client),2) as sec_fetch_val_pct 
FROM
  `httparchive.almanac.summary_response_bodies`,
  UNNEST(REGEXP_EXTRACT_ALL(LOWER(respOtherHeaders),r'sec-fetch-[dest|mode|site|user] = ([^,\r\n]+)')) AS sec_fetch_val
WHERE
  firstHtml
GROUP BY
  client, sec_fetch_val
ORDER BY
  client, sec_fetch_val_freq DESC
