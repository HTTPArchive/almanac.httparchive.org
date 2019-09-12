#standardSQL
# 09_19: Top aria attributes
CREATE TEMPORARY FUNCTION isValidAttribute(attr STRING) RETURNS BOOLEAN AS
# List of valid ARIA attribute names provided by Axe:
# https://github.com/dequelabs/axe-core/blob/c39c3a3db4975fb39365acace3fe1ffa7893004d/lib/commons/aria/index.js#L260
(attr IN ("aria-atomic","aria-busy","aria-controls","aria-current","aria-describedby","aria-disabled","aria-dropeffect","aria-flowto","aria-grabbed","aria-haspopup","aria-hidden","aria-invalid","aria-keyshortcuts","aria-label","aria-labelledby","aria-live","aria-owns","aria-relevant","aria-roledescription"));

SELECT
  client,
  COUNTIF(isValidAttribute(SPLIT(REGEXP_REPLACE(attr, '[\'"]', ''), '=')[OFFSET(0)])) AS pages,
  total,
  ROUND(COUNTIF(isValidAttribute(SPLIT(REGEXP_REPLACE(attr, '[\'"]', ''), '=')[OFFSET(0)])) * 100 / total, 2) AS pct
FROM
  `httparchive.almanac.summary_response_bodies`,
  UNNEST(REGEXP_EXTRACT_ALL(LOWER(body), '<[^>]+\\b(aria-\\w+=[\'"]?[\\w-]+)')) AS attr
JOIN
  (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
USING (client)
WHERE
  firstHtml AND
  attr IS NOT NULL
GROUP BY
  client,
  total
ORDER BY
  pages / total DESC