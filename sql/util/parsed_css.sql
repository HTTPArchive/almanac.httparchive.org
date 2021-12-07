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
  url,
  parseCSS(body) AS css
FROM
  `httparchive.almanac.summary_response_bodies`
WHERE
  date = '2020-08-01' AND
  type = 'css' AND
  LENGTH(body) < 3 * 1024 * 1024 # 3 MB
