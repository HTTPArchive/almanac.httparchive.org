#standardSQL
# usage of different directives for sandbox attribute on iframes
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
    _TABLE_SUFFIX AS client,
    JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._security'), '$.iframe-allow-sandbox') AS iframeAttrs
  FROM
    `httparchive.pages.2022_06_01_*`
),
  UNNEST(iframeAttrs) AS iframeAttr,
  UNNEST(SPLIT(JSON_EXTRACT_SCALAR(iframeAttr, '$.sandbox'), ' ')) AS sandbox_attr
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    SUM(getNumWithSandboxAttribute(payload)) AS total_iframes_with_sandbox
  FROM
    `httparchive.pages.2022_06_01_*`
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
