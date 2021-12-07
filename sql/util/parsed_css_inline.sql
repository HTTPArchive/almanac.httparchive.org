CREATE TEMP FUNCTION parseCSS(stylesheet STRING)
RETURNS STRING
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/parse-css.js")
AS '''
  try {
   var css = parse(stylesheet)
   return JSON.stringify(css);
  } catch (e) {
    '';
  }
''';

SELECT
  date,
  client,
  page,
  'inline' AS url,
  parseCSS(style) AS css
FROM
  (SELECT date, client, page, url, body FROM `httparchive.almanac.summary_response_bodies` WHERE DATE = '2020-08-01' AND firstHtml),
  UNNEST(REGEXP_EXTRACT_ALL(body, '(?i)<style[^>]*>(.*)</style>')) AS style
WHERE
  style IS NOT NULL AND
  LENGTH(style) > 0 AND
  LENGTH(style) < 3 * 1024 * 1024 # 3 MB
