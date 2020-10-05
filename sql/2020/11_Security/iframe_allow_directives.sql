#standardSQL
# usage of different directives for allow attribute on iframes
CREATE TEMP FUNCTION getNumWithAllowAttribute(payload STRING) AS ((
  SELECT
    COUNT(0)
  FROM UNNEST(JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._security'), "$.iframe-allow-sandbox")) as iframeAttr 
  WHERE JSON_EXTRACT_SCALAR(iframeAttr, '$.allow') IS NOT NULL
));

SELECT
  client,
  SPLIT(TRIM(allow_attr), ' ')[OFFSET(0)] AS directive,
  total,
  COUNT(0) AS freq,
  COUNT(0) / total AS pct
FROM (
  SELECT
    _TABLE_SUFFIX as client,
    JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._security'), "$.iframe-allow-sandbox") AS iframeAttrs
  FROM
    `httparchive.pages.2020_08_01_*`),
  UNNEST(iframeAttrs) AS iframeAttr,
  UNNEST(REGEXP_EXTRACT_ALL(JSON_EXTRACT_SCALAR(iframeAttr, '$.allow'), r'(?i)([^,;]+)')) AS allow_attr
JOIN (
  SELECT
    _TABLE_SUFFIX as client,
    SUM(getNumAllowAttributes(payload)) AS total
  FROM
    `httparchive.pages.2020_08_01_*`
  GROUP BY
    client
) USING (client)
GROUP BY
  client,
  directive,
  total
ORDER BY
  client,
  pct DESC
