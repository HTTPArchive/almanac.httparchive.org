#standardSQL
# Prevalence of correctly configured /.well-known/change-password endpoints:
# defined as `change-password` redirecting and having an 'ok' HTTP status code (https://fetch.spec.whatwg.org/#ok-status),
# while `resource-that-should-not-exist-whose-status-code-should-not-be-200` indeed does not have status code 200,
# as this would indicate that the server is badly configured, and that the redirect to `change-password` can't be trusted.
# `status` reflects the status code after redirection, so checking only for the status code afterwards is fine.
SELECT
  client,
  COUNT(DISTINCT page) AS total_pages,
  COUNTIF(change_password_redirected = 'true' AND (change_password_status BETWEEN 200 AND 299) AND (resource_status NOT BETWEEN 200 AND 299)) AS count_change_password_did_redirect_and_ok,
  COUNTIF(change_password_redirected = 'true' AND (change_password_status BETWEEN 200 AND 299) AND (resource_status NOT BETWEEN 200 AND 299)) / COUNT(DISTINCT page) AS pct_change_password_did_redirect_and_ok
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    JSON_QUERY(JSON_VALUE(payload, '$._well-known'), '$."/.well-known/change-password".data.redirected') AS change_password_redirected,
    CAST(JSON_QUERY(JSON_VALUE(payload, '$._well-known'), '$."/.well-known/change-password".data.status') AS INT64) AS change_password_status,
    CAST(JSON_QUERY(JSON_VALUE(payload, '$._well-known'), '$."/.well-known/resource-that-should-not-exist-whose-status-code-should-not-be-200/".data.status') AS INT64) AS resource_status
  FROM
    `httparchive.pages.2022_06_01_*`
)
GROUP BY
  client
