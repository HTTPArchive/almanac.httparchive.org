#standardSQL
# usage of different directives for allow attribute on iframes

CREATE TEMP FUNCTION getNumWithAllowAttribute(payload STRING) AS ((
  SELECT
    COUNT(0)
  FROM
    UNNEST(JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._security'), '$.iframe-allow-sandbox')) AS iframeAttr
  WHERE
    JSON_EXTRACT_SCALAR(iframeAttr, '$.allow') IS NOT NULL
));

SELECT
  client,
  SPLIT(TRIM(allow_attr), ' ')[OFFSET(0)] AS directive,
  total_iframes_with_allow,
  COUNT(0) AS freq,
  COUNT(0) / total_iframes_with_allow AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._security'), '$.iframe-allow-sandbox') AS iframeAttrs
  FROM
    `httparchive.pages.2024_06_01_*`),
  UNNEST(iframeAttrs) AS iframeAttr,
  UNNEST(REGEXP_EXTRACT_ALL(JSON_EXTRACT_SCALAR(iframeAttr, '$.allow'), r'(?i)([^,;]+)')) AS allow_attr
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    SUM(getNumWithAllowAttribute(payload)) AS total_iframes_with_allow
  FROM
    `httparchive.pages.2024_06_01_*`
  GROUP BY
    client
) USING (client)
GROUP BY
  client,
  directive,
  total_iframes_with_allow
HAVING
  pct > 0.001
ORDER BY
  client,
  pct DESC
