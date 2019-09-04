#standardSQL

-- counts the number of pages given number of font-face

CREATE TEMP FUNCTION parseCSS(stylesheet STRING)
RETURNS INT64 LANGUAGE js AS '''
   try {
    var css = JSON.parse(stylesheet);
    var fontFace = {};

    if (css.type === 'stylesheet' && css.stylesheet && css.stylesheet.rules) {
     for (var rule of css.stylesheet.rules) {
       if (rule.type === 'font-face' || rule.type === 'rule') {
         if (rule.declarations && rule.declarations.length) {
           for (var declaration of rule.declarations) {
             if (declaration.type === 'declaration' && declaration.property === 'font-family') {
               fontFace[declaration.value] = true
             }
           }
         }
       }
     }
   }

   return Object.keys(fontFace).length;
  } catch (e) {
    return 0;
  }

''';

SELECT
  APPROX_QUANTILES(faces_per_page, 1000)[OFFSET(250)] AS p25_faces_per_page,
  APPROX_QUANTILES(faces_per_page, 1000)[OFFSET(500)] AS median_faces_per_page,
  APPROX_QUANTILES(faces_per_page, 1000)[OFFSET(750)] AS p75_faces_per_page
FROM (
  SELECT SUM(parseCSS(css)) as faces_per_page
  FROM `httparchive.almanac.parsed_css`
  GROUP BY page
)
