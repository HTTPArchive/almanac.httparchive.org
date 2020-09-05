#standardSQL
# Top obsolete elements M216 
# See related: sql/2019/03_Markup/03_01b.sql

CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

CREATE TEMPORARY FUNCTION get_element_types(element_count_string STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
    if (!element_count_string) return ["ERROR: payload._element_count is missing"]; // 2019 had a few cases

    var element_count = JSON.parse(element_count_string); // should be an object with element type properties with values of how often they are present

    if (Array.isArray(element_count)) return ["ERROR: payload._element_count is an array"];
    if (typeof element_count != 'object') return ["ERROR: payload._element_count is a " + typeof(element_count)];

    return Object.keys(element_count); 
} catch (e) {
    return ["ERROR: "+e.message]; 
}
''';

CREATE TEMPORARY FUNCTION is_obsolete(element STRING) AS (
  element IN ("applet","acronym","bgsound","dir","frame","frameset","noframes","isindex","keygen","listing","menuitem","nextid","noembed","plaintext","rb","rtc","strike","xmp","basefont","big","blink","center","font","marquee","multicol","nobr","spacer","tt")
);

SELECT
  _TABLE_SUFFIX AS client,
  element_type AS obsolete_element_type,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total_pages_with_obsolete_elements, # not accurate unless you only care about pages with obsolete element
  AS_PERCENT(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX)) AS pct_from_pages_with_obsolete_elements
FROM
  #`httparchive.sample_data.pages_*`, # TEST
  `httparchive.pages.2020_08_01_*`, # LIVE
  UNNEST(get_element_types(JSON_EXTRACT_SCALAR(payload, '$._element_count'))) AS element_type
WHERE
  is_obsolete(element_type)
GROUP BY
  client,
  obsolete_element_type
ORDER BY
  pct_from_pages_with_obsolete_elements DESC,
  client
