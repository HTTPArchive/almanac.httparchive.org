# Rework CSS parsing
CREATE OR REPLACE FUNCTION `httparchive.almanac.PARSE_CSS`(stylesheet STRING) RETURNS STRING LANGUAGE js
OPTIONS (library = ["gs://httparchive/lib/parse-css.js"]) AS R"""
try {
  var css = parse(stylesheet)
  return JSON.stringify(css);
} catch (e) {
  return null;
}
""";
