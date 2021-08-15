#standardSQL
# 13_21: Native app links association for ecommerce sites.
# This query uses custom metric 'ecommerce' - https://github.com/HTTPArchive/legacy.httparchive.org/blob/master/custom_metrics/ecommerce.js
SELECT
  client,
  COUNTIF(android_app_links) AS android_app_links,
  COUNTIF(ios_universal_links) AS ios_universal_links,
  COUNT(0) AS total,
  COUNTIF(android_app_links) / COUNT(0) AS pct_android_app_links,
  COUNTIF(ios_universal_links) / COUNT(0) AS pct_ios_universal_links
FROM (
  SELECT DISTINCT
    _TABLE_SUFFIX AS client,
    url
  FROM
    `httparchive.technologies.2020_08_01_*`
  WHERE
    category = 'Ecommerce')
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._ecommerce'), '$.AndroidAppLinks') = '1' AS android_app_links,
    JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._ecommerce'), '$.iOSUniveralLinks') = '1' AS ios_universal_links
  FROM
    `httparchive.pages.2020_08_01_*`)
USING
  (client, url)
GROUP BY
  client
ORDER BY
  client
