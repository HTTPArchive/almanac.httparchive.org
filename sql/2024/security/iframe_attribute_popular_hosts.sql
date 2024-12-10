#standardSQL
# Section: Content Inclusion - Iframe Sandbox/Permissions Policy
# Question: Wich are the most commont hostnames of iframes that have an allow or sandbox attribute?
CREATE TEMP FUNCTION hasPolicy(attr STRING, policy_type STRING)
RETURNS BOOL DETERMINISTIC
LANGUAGE js AS '''
  const $ = JSON.parse(attr);
  return $[policy_type] !== null;
''';

SELECT
  client,
  policy_type,
  hostname,
  total_iframes_with_allow_or_sandbox,
  COUNTIF(has_policy) AS freq,
  COUNTIF(has_policy) / total_iframes_with_allow_or_sandbox AS pct
FROM (
  SELECT
    client,
    policy_type,
    JSON_EXTRACT_SCALAR(iframeAttr, '$.hostname') AS hostname,
    hasPolicy(iframeAttr, policy_type) AS has_policy
  FROM (
    SELECT
      client,
      JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._security'), '$.iframe-allow-sandbox') AS iframeAttrs
    FROM
      `httparchive.all.pages`
    WHERE
      date = '2024-06-01' AND
      is_root_page
    ),
    UNNEST(iframeAttrs) AS iframeAttr,
    UNNEST(['allow', 'sandbox']) AS policy_type
)
JOIN (
  SELECT
    client,
    SUM(ARRAY_LENGTH(JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._security'), '$.iframe-allow-sandbox'))) AS total_iframes_with_allow_or_sandbox
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01' AND
    is_root_page
  GROUP BY
    client)
USING
  (client)
GROUP BY
  client,
  total_iframes_with_allow_or_sandbox,
  policy_type,
  hostname
HAVING
  pct > 0.001
ORDER BY
  client,
  pct DESC
