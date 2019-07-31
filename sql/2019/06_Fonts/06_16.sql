#standardSQL

-- counts the local() inside @font-face

CREATE TEMP FUNCTION parseCSS(stylesheet STRING)
RETURNS INT64 LANGUAGE js AS '''
   var css = parse(stylesheet, { silent: true })
   var re = /local\\(/g
   var local = 0

   if (css.type === 'stylesheet' && css.stylesheet && css.stylesheet.rules) {
     for (var rule of css.stylesheet.rules) {
       if (rule.type === 'font-face') {
         if (rule.declarations && rule.declarations.length) {
           for (var declaration of rule.declarations) {
             if (declaration.type === 'declaration' && declaration.property === 'src') {
               local = local + ((declaration.value || '').match(re) || []).length;
             }
           }
         }
       }
     }
   }

   return local;
'''
OPTIONS (library="gs://httparchive/lib/parse-css.js");

SELECT
  SUM(local_usage) as local_usage
FROM (
  SELECT SUM(parseCSS(body)) as local_usage
  FROM `httparchive.response_bodies.2017_01_01_*`
  JOIN `httparchive.summary_requests.2017_01_01_*`
  USING (url)
  WHERE type = 'css'
  GROUP BY pageid
)

-- WITH
--   response_bodies AS (
--     SELECT * FROM `httparchive.response_bodies.2019_07_01_desktop`
--     UNION ALL
--     SELECT * FROM `httparchive.response_bodies.2019_07_01_mobile`
--   ),
--   temp AS (
--     SELECT REGEXP_EXTRACT_ALL(body, r"\@font-face\s*\{[^}]+\}") AS font_display_arr, url, page
--     FROM response_bodies WHERE STRPOS(body, "@font-face") > 0
--   ),
--   temp2 AS (
--     SELECT ARRAY_LENGTH(REGEXP_EXTRACT_ALL(font_face, r"local\(")) AS local_usage
--     FROM temp, UNNEST(font_display_arr) AS font_face
--   ),
--   processedTable AS (
--     SELECT SUM(local_usage) AS local_usage FROM temp2
--   )
-- SELECT * FROM processedTable
