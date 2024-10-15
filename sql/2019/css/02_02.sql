#standardSQL
# 02_02: % of sites that use @import and @supports.
SELECT
  client,
  SUM(IF(ENDS_WITH(feature, 'Import'), freq, 0)) AS freq_import,
  SUM(IF(ENDS_WITH(feature, 'Supports'), freq, 0)) AS freq_supports,
  total,
  ROUND(SUM(IF(ENDS_WITH(feature, 'Import'), freq, 0)) * 100 / total, 2) AS pct_import,
  ROUND(SUM(IF(ENDS_WITH(feature, 'Supports'), freq, 0)) * 100 / total, 2) AS pct_supports
FROM (
  SELECT
    client,
    feature,
    COUNT(DISTINCT url) AS freq
  FROM
    `httparchive.blink_features.features`
  WHERE
    yyyymmdd = '20190701' AND
    feature IN ('CSSAtRuleImport', 'CSSAtRuleSupports')
  GROUP BY
    client,
    feature
)
JOIN (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_*` GROUP BY client)
USING (client)
GROUP BY
  client,
  total
