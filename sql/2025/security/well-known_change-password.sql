#standardSQL
# Section: Well-known URIs - change-password
# Question What is the prevalence of correctly configured /.well-known/change-password endpoints?
# Notes: Safe Cast is required `.data.status` is not always an INT for some reason

# Prevalence of correctly configured /.well-known/change-password endpoints:
# defined as `change-password` redirecting and having an 'ok' HTTP status code (https://fetch.spec.whatwg.org/#ok-status),
# while `resource-that-should-not-exist-whose-status-code-should-not-be-200` indeed does not have status code 200,
# as this would indicate that the server is badly configured, and that the redirect to `change-password` cant be trusted.
# `status` reflects the status code after redirection, so checking only for the status code afterwards is fine.
SELECT
  client,
  COUNT(DISTINCT page) AS total_pages,
  COUNTIF(change_password_redirected = 'true' AND (change_password_status BETWEEN 200 AND 299) AND (resource_status NOT BETWEEN 200 AND 299)) AS count_change_password_did_redirect_and_ok,
  COUNTIF(change_password_redirected = 'true' AND (change_password_status BETWEEN 200 AND 299) AND (resource_status NOT BETWEEN 200 AND 299)) / COUNT(DISTINCT page) AS pct_change_password_did_redirect_and_ok
FROM (
  SELECT
    client,
    page,
    JSON_VALUE(custom_metrics.well_known, '$."/.well-known/change-password".data.redirected') AS change_password_redirected,
    SAFE_CAST(JSON_VALUE(custom_metrics.well_known, '$."/.well-known/change-password".data.status') AS INT64) AS change_password_status,
    SAFE_CAST(JSON_VALUE(custom_metrics.well_known, '$."/.well-known/resource-that-should-not-exist-whose-status-code-should-not-be-200/".data.status') AS INT64) AS resource_status
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    is_root_page
)
GROUP BY
  client
