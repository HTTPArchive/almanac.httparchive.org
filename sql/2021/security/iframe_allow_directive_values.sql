#standardSQL
# distribution of values for different directives for allow attribute on iframes
CREATE TEMP FUNCTION getNumWithAllowAttribute(payload STRING) AS ((
  SELECT
    COUNT(0)
  FROM
    UNNEST(JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._security'), "$.iframe-allow-sandbox")) AS iframeAttr
  WHERE
    JSON_EXTRACT_SCALAR(iframeAttr, '$.allow') IS NOT NULL
));

SELECT
  client,
  SPLIT(TRIM(allow_attr), ' ')[OFFSET(0)] AS directive,
  TRIM(SPLIT(TRIM(allow_attr), ' ')[SAFE_OFFSET(1)], "'") AS directive_value,
  -- slice array: https://stackoverflow.com/a/54835472/7391782 + https://stackoverflow.com/a/59668907/7391782
  (
    SELECT STRING_AGG(origin, ' ' ORDER BY offset)
    FROM UNNEST(SPLIT(TRIM(allow_attr), ' ')) AS origin WITH OFFSET AS offset
    WHERE offset > 1
  ) AS origins,
  total_iframes_with_allow,
  COUNT(0) AS freq,
  COUNT(0) / total_iframes_with_allow AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._security'), "$.iframe-allow-sandbox") AS iframeAttrs
  FROM
    `httparchive.pages.2021_07_01_*`),
  UNNEST(iframeAttrs) AS iframeAttr,
  UNNEST(REGEXP_EXTRACT_ALL(JSON_EXTRACT_SCALAR(iframeAttr, '$.allow'), r'(?i)([^,;]+)')) AS allow_attr
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    SUM(getNumWithAllowAttribute(payload)) AS total_iframes_with_allow
  FROM
    `httparchive.pages.2021_07_01_*`
  GROUP BY
    client
) USING (client)
GROUP BY
  client,
  directive,
  directive_value,
  origins,
  total_iframes_with_allow
HAVING
  pct > 0.001
ORDER BY
  client,
  pct DESC
