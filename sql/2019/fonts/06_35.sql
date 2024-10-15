#standardSQL
# 06_35: Pages using the most fonts
SELECT
  _TABLE_SUFFIX AS client,
  reqFont AS fonts,
  url
FROM
  `httparchive.summary_pages.2019_07_01_*`
JOIN (SELECT _TABLE_SUFFIX, MAX(reqFont) AS reqFont FROM `httparchive.summary_pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
USING (_TABLE_SUFFIX, reqFont)
ORDER BY
  fonts DESC
