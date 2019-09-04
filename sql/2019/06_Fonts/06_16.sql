#standardSQL

-- counts the local() inside @font-face

CREATE TEMPORARY FUNCTION parseCSS(strcss STRING)
RETURNS INT64 LANGUAGE js AS '''
try {
  var css = JSON.parse(strcss);
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
} catch (e) {
  return 0;
}
''';

SELECT
   SUM(parseCSS(css))
FROM
  `httparchive.almanac.parsed_css`
