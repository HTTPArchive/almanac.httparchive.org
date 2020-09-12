#standardSQL
# 03_05: % of pages with shadow roots
CREATE TEMPORARY FUNCTION hasShadowRoot(payload STRING) AS (
  JSON_EXTRACT_SCALAR(payload, '$._has_shadow_root') = 'true'
);

SELECT
  _TABLE_SUFFIX AS client,
  COUNTIF(hasShadowRoot(payload)) AS pages,
  ROUND(COUNTIF(hasShadowRoot(payload)) * 100 / COUNT(0), 2) AS pct_pages
FROM
  `httparchive.pages.2019_07_01_*`
GROUP BY
  client
