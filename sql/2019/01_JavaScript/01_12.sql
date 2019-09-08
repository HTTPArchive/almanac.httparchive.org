#standardSQL
# 01_12: Percent of pages that include script[type=module]
SELECT
  _TABLE_SUFFIX AS client,
  ROUND(COUNTIF(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), "$['01.12']") = '1') * 100 / COUNT(0), 2) AS pct_module
FROM
  `httparchive.pages.2019_07_01_*`
GROUP BY
  client