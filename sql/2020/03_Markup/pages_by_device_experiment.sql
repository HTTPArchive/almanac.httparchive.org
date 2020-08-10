#standardSQL
# metrics grouped by device
# See related: sql/2019/03_Markup/03_01a.sql, sql/2019/03_Markup/03_05.sql, sql/2019/03_Markup/03_03a.sql

CREATE TEMPORARY FUNCTION get_payload_info(payload_string STRING)
RETURNS STRUCT<
  element_count STRUCT<
    contains_custom_element BOOL, 
    contains_obsolete_element BOOL
  >, 
  almanac STRUCT<
    contains_link_nodes BOOL
  >
> LANGUAGE js AS '''
var result = {element_count: {}, almanac: {}};
try {
  var $ = JSON.parse(payload_string); // very slow

  var elements = JSON.parse($._element_count);

  if (!Array.isArray(elements) && typeof elements == 'object') {
    result.element_count.contains_custom_element = Object.keys(elements).filter(e => e.includes('-')).length > 0;

    var obsoleteElements = new Set(["applet","acronym","bgsound","dir","frame","frameset","noframes","isindex","keygen","listing","menuitem","nextid","noembed","plaintext","rb","rtc","strike","xmp","basefont","big","blink","center","font","marquee","multicol","nobr","spacer","tt"]);

    result.element_count.contains_obsolete_element = !!Object.keys(elements).find(e => {
      return obsoleteElements.has(e);
    });
  }

   var almanac = JSON.parse($._almanac);
  if (!Array.isArray(almanac) && typeof almanac == 'object') {
    result.almanac.contains_link_nodes = almanac["link-nodes"] && almanac["link-nodes"].length > 0;
   }

} catch (e) {
}
return result;
''';

CREATE TEMPORARY FUNCTION get_element_info(elements_json_string STRING)
RETURNS STRUCT<
  contains_custom_element BOOL, 
  contains_obsolete_element BOOL
> LANGUAGE js AS '''
var result = {};
try {
  var elements = JSON.parse(elements_json_string);

  if (!Array.isArray(elements) && typeof elements == 'object') {
  
    result.contains_custom_element = Object.keys(elements).filter(e => e.includes('-')).length > 0;

    var obsoleteElements = new Set(["applet","acronym","bgsound","dir","frame","frameset","noframes","isindex","keygen","listing","menuitem","nextid","noembed","plaintext","rb","rtc","strike","xmp","basefont","big","blink","center","font","marquee","multicol","nobr","spacer","tt"]);

    result.contains_obsolete_element = !!Object.keys(elements).find(e => {
        return obsoleteElements.has(e);
    });
  }
} catch (e) {
  
}
return result;
''';

CREATE TEMPORARY FUNCTION get_almanac_info(almanac_json_string STRING)
RETURNS STRUCT<
  contains_link_nodes BOOL
> LANGUAGE js AS '''
var result = {};
try {
  var almanac = JSON.parse(almanac_json_string);

  if (!Array.isArray(elements) && typeof elements == 'object') {
  
    result.contains_link_nodes = almanac["link-nodes"] && almanac["link-nodes"].length > 0;
  }
} catch (e) {

}
return result;
''';

# original 14.8 sec (no almanac function)
# first improvement 14.5 sec try 1
# using payload function = 50 sec
# latest improvement, minus almanac = 7.1 sec
# latest improvement, full = 14sec
# real test ($2.90) 39.1 sec :-)


CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

SELECT
  client,
  COUNT(0) AS total,

  ## element_count

  # % of pages with obsolete elements
  COUNTIF(element_info.contains_obsolete_element) AS freq_contains_obsolete_element,
  AS_PERCENT(COUNTIF(element_info.contains_obsolete_element), COUNT(0)) AS pct_contains_obsolete_element,

  # % of pages with custom elements ("slang")
  COUNTIF(element_info.contains_custom_element) AS freq_contains_custom_element,
  AS_PERCENT(COUNTIF(element_info.contains_custom_element), COUNT(0)) AS pct_contains_custom_element,

  # % of pages with shadow roots
  COUNTIF(has_shadow_root) AS freq_has_shadow_root,
  AS_PERCENT(COUNTIF(has_shadow_root), COUNT(0)) AS pct_has_shadow_root,

  ## almanac 

  #  
  COUNTIF(almanac_info.contains_link_nodes) AS freq_contains_link_nodes,
  AS_PERCENT(COUNTIF(almanac_info.contains_link_nodes), COUNT(0)) AS pct_contains_link_nodes

  FROM
    ( 
      SELECT 
      _TABLE_SUFFIX AS client,
      CAST(JSON_EXTRACT_SCALAR(payload, '$._has_shadow_root') AS BOOLEAN) AS has_shadow_root,
     #  JSON_EXTRACT_SCALAR(payload, '$._markup') AS markup,        
     # JSON_EXTRACT_SCALAR(payload, '$._wpt_bodies') AS wpt_bodies,
     # JSON_EXTRACT_SCALAR(payload, '$._robots_txt') AS robots_txt,
     #get_payload_info(payload) AS payload_info, # slow parsing payload in js. 

     get_almanac_info(JSON_EXTRACT_SCALAR(payload, '$._almanac')) AS almanac_info,
     get_element_info(JSON_EXTRACT_SCALAR(payload, '$._element_count')) AS element_info
      
      FROM
      `httparchive.sample_data.pages_*`
    )

GROUP BY
  client