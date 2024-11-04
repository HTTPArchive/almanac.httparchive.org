#standardSQL
# most common hostnames of iframes that have the allow or sandbox attribute

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
  COUNTIF(has_policy) AS freq,
  total_iframes,
  COUNTIF(has_policy) / total_iframes AS pct
FROM (
  SELECT
    client,
    policy_type,
    JSON_EXTRACT_SCALAR(iframeAttr, '$.hostname') AS hostname,
    hasPolicy(iframeAttr, policy_type) AS has_policy
  FROM (
    SELECT
      _TABLE_SUFFIX AS client,
      JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._security'), '$.iframe-allow-sandbox') AS iframeAttrs
    FROM
      `httparchive.pages.2024_06_01_*`),
    UNNEST(iframeAttrs) AS iframeAttr,
    UNNEST(['allow', 'sandbox']) AS policy_type
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    SUM(ARRAY_LENGTH(JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._security'), '$.iframe-allow-sandbox'))) AS total_iframes
  FROM
    `httparchive.pages.2024_06_01_*`
  GROUP BY
    client)
USING
  (client)
GROUP BY
  client,
  total_iframes,
  policy_type,
  hostname
HAVING
  pct > 0.001
ORDER BY
  client,
  policy_type,
  pct DESC
