#standardSQL
# This query uses custom metric '_well-known' - https://github.com/HTTPArchive/legacy.httparchive.org/blob/master/custom_metrics/well-known.js
# Note that in this query, there is a subtle bug where the site could have empty /.well-known/assetlinks.json or /.well-known/apple-app-site-association files which will lead to over counting sites with native app links
# an example is: https://www.allbirds.com/.well-known/assetlinks.json which has a payload of "[]"
# To fix this, this would require response body parsing on well-known.js

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
    `httparchive.technologies.2021_07_01_*`
  WHERE
    category = 'Ecommerce' AND
    (app != 'Cart Functionality' AND
     app != 'Google Analytics Enhanced eCommerce'))
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    JSON_VALUE(JSON_EXTRACT_SCALAR(payload, '$._well-known'), '$."/.well-known/assetlinks.json".found') = 'true' AS android_app_links,
    JSON_VALUE(JSON_EXTRACT_SCALAR(payload, '$._well-known'), '$."/.well-known/apple-app-site-association".found') = 'true' AS ios_universal_links
  FROM
    `httparchive.pages.2021_07_01_*`)
USING
  (client, url)
GROUP BY
  client
ORDER BY
  client
