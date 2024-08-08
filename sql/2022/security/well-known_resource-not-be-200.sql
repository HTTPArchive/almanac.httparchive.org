#standardSQL
# Prevalence of /.well-known/resource-that-should-not-exist-whose-status-code-should-not-be-200 counts status codes
# "We can see if a web server's statuses are reliable by fetching a URL that should never result in an ok status." (https://w3c.github.io/webappsec-change-password-url/response-code-reliability.html)
SELECT
  client,
  COUNT(DISTINCT page) AS total_pages,
  # `status` reflects the status code after redirection, so checking only for 200 is fine.
  COUNTIF(status BETWEEN 200 AND 299) AS count_status_200,
  SAFE_DIVIDE(COUNTIF(status BETWEEN 200 AND 299), COUNT(DISTINCT page)) AS pct_status_200,
  COUNTIF(status NOT BETWEEN 200 AND 299) AS count_status_not_ok,
  SAFE_DIVIDE(COUNTIF(status NOT BETWEEN 200 AND 299), COUNT(DISTINCT page)) AS pct_status_not_ok
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    JSON_QUERY(JSON_VALUE(payload, '$._well-known'), '$."/.well-known/resource-that-should-not-exist-whose-status-code-should-not-be-200/".data.redirected') AS redirected,
    CAST(JSON_VALUE(JSON_VALUE(payload, '$._well-known'), '$."/.well-known/resource-that-should-not-exist-whose-status-code-should-not-be-200/".data.status') AS INT64) AS status
  FROM
    `httparchive.pages.2022_06_01_*`
)
GROUP BY
  client
