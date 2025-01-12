#standardSQL
# Section: Content Inclusion - Iframe Sandbox
# Question: Which are the most common directives for the sandbox attribute on iframes?
CREATE TEMP FUNCTION getNumWithSandboxAttribute(payload STRING) AS ((
  SELECT
    COUNT(0)
  FROM
    UNNEST(JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._security'), '$.iframe-allow-sandbox')) AS iframeAttr
  WHERE
    JSON_EXTRACT_SCALAR(iframeAttr, '$.sandbox') IS NOT NULL
));

SELECT
  client,
  TRIM(sandbox_attr) AS directive,
  total_iframes_with_sandbox,
  COUNT(0) AS freq,
  COUNT(0) / total_iframes_with_sandbox AS pct
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
  UNNEST(SPLIT(JSON_EXTRACT_SCALAR(iframeAttr, '$.sandbox'), ' ')) AS sandbox_attr
JOIN (
  SELECT
    client,
    SUM(getNumWithSandboxAttribute(payload)) AS total_iframes_with_sandbox
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01' AND
    is_root_page
  GROUP BY
    client
) USING (client)
GROUP BY
  client,
  directive,
  total_iframes_with_sandbox
ORDER BY
  client,
  pct DESC
