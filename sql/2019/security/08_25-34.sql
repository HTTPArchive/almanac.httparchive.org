#standardSQL
# 08_25-34: Security headers
SELECT
  _TABLE_SUFFIX AS client,
  header,
  COUNTIF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', header, ' ='))) AS freq,
  total,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', header, ' ='))) * 100 / total, 2) AS pct
FROM
  `httparchive.summary_requests.2019_07_01_*`,
  UNNEST([
    'nel', 'report-to', 'referrer-policy',
    'feature-policy', 'x-content-type-options',
    'x-xss-protection', 'x-frame-options',
    'cross-origin-resource-policy',
    'cross-origin-opener-policy',
    'sec-fetch-(dest|mode|site|user)',
    'strict-transport-security',
    'content-security-policy'
  ])
JOIN (
  SELECT _TABLE_SUFFIX, COUNT(0) AS total
  FROM `httparchive.summary_pages.2019_07_01_*`
  GROUP BY _TABLE_SUFFIX
)
USING (_TABLE_SUFFIX)
WHERE
  firstHtml
GROUP BY
  client,
  total,
  header
ORDER BY
  freq / total DESC
