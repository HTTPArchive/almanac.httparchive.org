#standardSQL
# distribution of values for different directives for allow attribute on iframes
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
  TRIM(origin) AS origin,
  total_iframes_with_allow,
  COUNT(0) AS freq,
  COUNT(0) / total_iframes_with_allow AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._security'), '$.iframe-allow-sandbox') AS iframeAttrs
  FROM
    `httparchive.pages.2021_07_01_*`
),
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
) USING (client),
  UNNEST(  -- Directive may specify explicit origins or not.
    IF(
      ARRAY_LENGTH(SPLIT(TRIM(allow_attr), ' ')) = 1,  -- test if any explicit origin is provided
      [TRIM(allow_attr), ''],  -- if not, add a dummy empty origin to make the query work
      SPLIT(TRIM(allow_attr), ' '  -- if it is, split the different origins
      )
    )
  ) AS origin WITH OFFSET AS offset
WHERE
  offset > 0  -- do not retain the first part of the directive (as this is the directive name)
GROUP BY
  client,
  directive,
  origin,
  total_iframes_with_allow
HAVING
  pct > 0.001
ORDER BY
  client,
  pct DESC
