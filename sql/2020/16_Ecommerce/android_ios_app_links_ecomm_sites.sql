#standardSQL
# 13_21: Native app links association for mobile ecommerce sites. 
# Querying against mobile dataset as apps are relevant in context of mobile. This query uses custom metric 'ecommerce' - https://github.com/HTTPArchive/legacy.httparchive.org/blob/master/custom_metrics/ecommerce.js
SELECT
  COUNTIF(android_app_links) AS android_app_links,
  COUNTIF(ios_universal_links) AS ios_universal_links,
  COUNT(0) AS total,
  COUNTIF(android_app_links) / COUNT(0) AS pct_android_app_links,
  COUNTIF(ios_universal_links) / COUNT(0) AS pct_ios_universal_links
FROM (
  SELECT DISTINCT
    url
  FROM
    `httparchive.technologies.2020_08_01_mobile`
  WHERE
    category = 'Ecommerce')
JOIN (
  SELECT
    url,
    JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._ecommerce'), '$.AndroidAppLinks') = '1' AS android_app_links,
    JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload, '$._ecommerce'), '$.iOSUniveralLinks') = '1' AS ios_universal_links
  FROM
    `httparchive.pages.2020_08_01_mobile`)
USING
  (url)

