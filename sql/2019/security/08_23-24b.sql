#standardSQL
# 08_23-24b: Chrome preload eligiblity: max-age >= 1 year, includeSubdomains, preload
SELECT
  _TABLE_SUFFIX AS client,
  COUNT(0) AS freq,
  total,
  ROUND(COUNT(0) * 100 / total, 2) AS pct
FROM
  (SELECT _TABLE_SUFFIX, REGEXP_EXTRACT(respOtherHeaders, r'(?i)\W?strict-transport-security =([^,]+)') AS hsts FROM `httparchive.summary_requests.2019_07_01_*` WHERE firstHtml)
JOIN
  (SELECT _TABLE_SUFFIX, COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
USING (_TABLE_SUFFIX)
WHERE
  hsts IS NOT NULL AND
  CAST(REGEXP_EXTRACT(hsts, r'(?i)max-age= *(-?\d+)') AS INT64) >= 31536000 AND
  REGEXP_CONTAINS(hsts, 'includeSubdomains') AND
  REGEXP_CONTAINS(hsts, 'preload')
GROUP BY
  client,
  total
