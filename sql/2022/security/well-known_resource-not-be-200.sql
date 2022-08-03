#standardSQL
# Prevalence of /.well-known/resource-that-should-not-exist-whose-status-code-should-not-be-200 endpoint and counts for redirection and 'ok' HTTP status codes (https://fetch.spec.whatwg.org/#ok-status).
# "We can see if a web server’s statuses are reliable by fetching a URL that should never result in an ok status." (https://w3c.github.io/webappsec-change-password-url/response-code-reliability.html)
SELECT
  client,
  COUNT(DISTINCT page) AS total_pages,
  COUNTIF(has_resource_not_be_200 = 'true') AS count_has_resource_not_be_200,
  COUNTIF(has_resource_not_be_200 = 'true') / COUNT(DISTINCT page) AS pct_has_resource_not_be_200,
  COUNTIF(redirected = 'true') AS count_redirected,
  SAFE_DIVIDE(COUNTIF(redirected = 'true'), COUNTIF(has_resource_not_be_200 = 'true')) AS pct_redirected,
  # `status` reflects the status code after redirection, so checking only for 200 is fine.
  COUNTIF(status = 200) AS count_status_200,
  SAFE_DIVIDE(COUNTIF(status = 200), COUNTIF(has_resource_not_be_200 = 'true')) AS pct_status_200,
  COUNTIF(status BETWEEN 201 AND 299) AS count_status_other_ok,
  SAFE_DIVIDE(COUNTIF(status BETWEEN 201 AND 299), COUNTIF(has_resource_not_be_200 = 'true')) AS pct_status_other_ok,
  COUNTIF(status NOT BETWEEN 200 AND 299) AS count_status_not_ok,
  SAFE_DIVIDE(COUNTIF(status NOT BETWEEN 200 AND 299), COUNTIF(has_resource_not_be_200 = 'true')) AS pct_status_not_ok
FROM (
    SELECT
      _TABLE_SUFFIX AS client,
      url AS page,
      JSON_VALUE(JSON_VALUE(payload, '$._well-known'), '$."/.well-known/resource-that-should-not-exist-whose-status-code-should-not-be-200".found') AS has_resource_not_be_200,
      JSON_QUERY(JSON_VALUE(payload, '$._well-known'), '$."/.well-known/resource-that-should-not-exist-whose-status-code-should-not-be-200".redirected') AS redirected,
      CAST(JSON_QUERY(JSON_VALUE(payload, '$._well-known'), '$."/.well-known/resource-that-should-not-exist-whose-status-code-should-not-be-200".status') AS INT64) AS status
    FROM
      `httparchive.pages.2022_06_01_*`
)
GROUP BY
  client
