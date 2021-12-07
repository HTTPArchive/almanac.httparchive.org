#standardSQL
# 09_19c: % valid ARIA attributes
# Valid attributes from https://github.com/dequelabs/axe-core/blob/master/lib/commons/aria/index.js
CREATE TEMPORARY FUNCTION isValidAttribute(attr STRING) RETURNS BOOLEAN AS
(attr IN ("aria-atomic", "aria-busy", "aria-controls", "aria-current", "aria-describedby", "aria-disabled", "aria-dropeffect", "aria-flowto", "aria-grabbed", "aria-haspopup", "aria-hidden", "aria-invalid", "aria-keyshortcuts", "aria-label", "aria-labelledby", "aria-live", "aria-owns", "aria-relevant", "aria-roledescription"));

SELECT
  client,
  COUNTIF(isValidAttribute(attr)) AS freq,
  COUNT(attr) AS total,
  ROUND(COUNTIF(isValidAttribute(attr)) * 100 / COUNT(attr), 2) AS pct
FROM
  `httparchive.almanac.summary_response_bodies`,
  UNNEST(REGEXP_EXTRACT_ALL(LOWER(body), '<[^>]+\\b(aria-\\w+)=[\'"]?[\\w-]+')) AS attr
WHERE
  date = '2019-07-01' AND
  firstHtml AND
  attr IS NOT NULL
GROUP BY
  client
ORDER BY
  freq / total DESC
