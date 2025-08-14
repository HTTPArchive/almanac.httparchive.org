SELECT
  client,
  COUNT(0) AS total_pages,
  COUNTIF(REGEXP_CONTAINS(JSON_VALUE(logs, '$.text'), 'Mixed Content')) AS mixed_content_count,
  COUNTIF(REGEXP_CONTAINS(JSON_VALUE(logs, '$.text'), 'Mixed Content')) / COUNT(0) AS mixed_content_freq,
  COUNTIF(REGEXP_CONTAINS(JSON_VALUE(logs, '$.text'), 'has been blocked by CORS policy')) AS cors_blocked_count,
  COUNTIF(REGEXP_CONTAINS(JSON_VALUE(logs, '$.text'), 'has been blocked by CORS policy')) / COUNT(0) AS cors_blocked_freq,
  COUNTIF(REGEXP_CONTAINS(JSON_VALUE(logs, '$.text'), 'Content Security Policy') OR REGEXP_CONTAINS(JSON_VALUE(logs, '$.text'), 'Content-Security-Policy')) AS content_security_policy_count,
  COUNTIF(REGEXP_CONTAINS(JSON_VALUE(logs, '$.text'), 'Content Security Policy') OR REGEXP_CONTAINS(JSON_VALUE(logs, '$.text'), 'Content-Security-Policy')) / COUNT(0) AS content_security_policy_freq,
  COUNTIF(REGEXP_CONTAINS(JSON_VALUE(logs, '$.text'), 'Error with Feature-Policy')) AS error_with_feature_policy_count,
  COUNTIF(REGEXP_CONTAINS(JSON_VALUE(logs, '$.text'), 'Error with Feature-Policy')) / COUNT(0) AS error_with_feature_policy_freq,
  COUNTIF(REGEXP_CONTAINS(JSON_VALUE(logs, '$.text'), 'Error with Permissions-Policy')) AS error_with_permissions_policy_count,
  COUNTIF(REGEXP_CONTAINS(JSON_VALUE(logs, '$.text'), 'Error with Permissions-Policy')) / COUNT(0) AS error_with_permissions_policy_freq,
  COUNTIF(REGEXP_CONTAINS(JSON_VALUE(logs, '$.text'), 'because its MIME type')) AS x_content_type_count,
  COUNTIF(REGEXP_CONTAINS(JSON_VALUE(logs, '$.text'), 'because its MIME type')) / COUNT(0) AS x_content_type_freq,
  COUNTIF(REGEXP_CONTAINS(JSON_VALUE(logs, '$.text'), 'X-Frame-Options')) AS x_frame_options_count,
  COUNTIF(REGEXP_CONTAINS(JSON_VALUE(logs, '$.text'), 'X-Frame-Options')) / COUNT(0) AS x_frame_options_freq,
  COUNTIF(REGEXP_CONTAINS(JSON_VALUE(logs, '$.text'), 'The request has been aborted')) AS navigator_credentials_count,
  COUNTIF(REGEXP_CONTAINS(JSON_VALUE(logs, '$.text'), 'The request has been aborted')) / COUNT(0) AS navigator_credentials_freq,
  COUNTIF(REGEXP_CONTAINS(JSON_VALUE(logs, '$.text'), 'The Cross-Origin-Opener-Policy has been ignored')) AS cross_originer_opener_count,
  COUNTIF(REGEXP_CONTAINS(JSON_VALUE(logs, '$.text'), 'The Cross-Origin-Opener-Policy has been ignored')) / COUNT(0) AS cross_originer_opener_freq,
  COUNTIF(REGEXP_CONTAINS(JSON_VALUE(logs, '$.text'), 'Document-Policy HTTP header') OR REGEXP_CONTAINS(JSON_VALUE(logs, '$.text'), 'Document Policy violation')) AS document_policy_count,
  COUNTIF(REGEXP_CONTAINS(JSON_VALUE(logs, '$.text'), 'Document-Policy HTTP header') OR REGEXP_CONTAINS(JSON_VALUE(logs, '$.text'), 'Document Policy violation')) / COUNT(0) AS document_policy_freq,
  COUNTIF(REGEXP_CONTAINS(JSON_VALUE(logs, '$.text'), 'The resource has been blocked')) AS subresource_integrity_count,
  COUNTIF(REGEXP_CONTAINS(JSON_VALUE(logs, '$.text'), 'The resource has been blocked')) / COUNT(0) AS subresource_integrity_freq,
  COUNTIF(REGEXP_CONTAINS(JSON_VALUE(logs, '$.text'), 'This document requires')) AS trusted_types_count,
  COUNTIF(REGEXP_CONTAINS(JSON_VALUE(logs, '$.text'), 'This document requires')) / COUNT(0) AS trusted_types_freq


FROM (
  SELECT
    client,
    logs
  FROM
    `httparchive.sample_data.pages_10k` ,
    UNNEST(JSON_QUERY_ARRAY(payload, "$._browser_logs")) as logs
  WHERE
    date = '2025-07-01' AND
    is_root_page
)
GROUP BY
  client
