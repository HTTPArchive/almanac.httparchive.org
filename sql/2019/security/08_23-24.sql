#standardSQL
# 08_23-24: HSTS subdomains and preload usage
SELECT
  _TABLE_SUFFIX AS client,
  directive,
  COUNT(0) AS freq,
  total,
  ROUND(COUNT(0) * 100 / total, 2) AS pct
FROM
  `httparchive.summary_requests.2019_07_01_*`,
  UNNEST(REGEXP_EXTRACT_ALL(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\W?strict-transport-security =([^,]+)'), '(max-age|includeSubDomains|preload)')) AS directive
JOIN
  (SELECT _TABLE_SUFFIX, COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
USING (_TABLE_SUFFIX)
WHERE
  firstHtml
GROUP BY
  client,
  total,
  directive
ORDER BY
  freq / total DESC
