#standardSQL
#
# This query is based off the HTTP/3 support query on HTTP Archive time series.
#
# The amount of requests either using HTTP/3 or able to use it.
#
# We measure "ability to use" as well as "actual use", as HTTP Archive is a
# cold crawl and so less likely to use HTTP/3 which requires prior visits.
#
# For "able to use" we look at the alt-svc response header.
#
# We also only measure official HTTP/3 (ALPN h3, h3-29) and not gQUIC or other
# prior versions. h3-29 is the final draft version and will be switched to h3
# when HTTP/3 is approved so we include that as it is HTTP/3 in all but name.
#
SELECT
  date,
  client,
  CASE
    WHEN respHttpVersion IN ('HTTP/3', 'h3', 'h3-29') OR
      reqHttpVersion IN ('HTTP/3', 'h3', 'h3-29') OR
      REGEXP_EXTRACT(REGEXP_EXTRACT(respOtherHeaders, r'alt-svc = (.*)'), r'(.*?)(?:, [^ ]* = .*)?$') LIKE '%h3=%' OR
      REGEXP_EXTRACT(REGEXP_EXTRACT(respOtherHeaders, r'alt-svc = (.*)'), r'(.*?)(?:, [^ ]* = .*)?$') LIKE '%h3-29=%' THEN 'h3_supported'
    ELSE 'h3_not_supported'
  END AS h3_status,
  COUNT(0) AS num_reqs,
  SUM(count(0)) OVER (PARTITION BY date, client) AS total_reqs,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY date, client) AS pct_reqs,
  COUNTIF(firsthtml) AS num_pages,
  SUM(count(firsthtml)) OVER (PARTITION BY date, client) AS total_pages,
  COUNTIF(firsthtml) / SUM(COUNT(firsthtml)) OVER (PARTITION BY date, client) AS pct_pages
FROM
  `httparchive.almanac.requests`
WHERE
  date IN ('2022-06-01', '2021-07-01')
GROUP BY
  date,
  client,
  h3_status
ORDER BY
  date,
  client
