#standardSQL
# page canonicals metrics grouped by device

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _canonicals
CREATE TEMPORARY FUNCTION get_canonicals_info(canonicals_string STRING)
RETURNS STRUCT<

  ##Antoine
  canonicals ARRAY<STRING>, 
  has_self_canonical BOOL, 
  is_canonicalized BOOL,
  http_canonicals ARRAY<STRING>, 
  has_canonical_mismatch BOOL, 
  canonical_raw ARRAY<STRING>, 
  canonical_rendered ARRAY<STRING>



  # add more properties here...

> LANGUAGE js AS '''
var result = {};
try {
    //var canonicals = JSON.parse(canonicals_string); // LIVE

    // TEST
    // Fill with test data 

    var canonicals = {}; 

    if (Array.isArray(canonicals) || typeof canonicals != 'object') return result;


    if (canonicals.canonicals) {
      result.canonicals = canonicals.canonicals;
    }

    if (canonicals.self_canonical) {
      result.has_self_canonical = canonicals.self_canonical;
    }

    if (canonicals.other_canonical) {
      result.is_canonicalized = canonicals.other_canonical;
    }

    if (canonicals.http_header_link_canonical) {
      result.http_canonicals = canonicals.http_header_link_canonical;
    }

    if (canonicals.canonical_mismatch) {
      result.has_canonical_mismatch = canonicals.canonical_mismatch;
    }

    if (canonicals.raw) {
      result.canonical_raw = canonicals.raw;
    }


    if (canonicals.rendered) {
      result.canonical_rendered = canonicals.rendered;
    }



    // add more code to set result properties here...

} catch (e) {}
return result;
''';

SELECT
  client,
  COUNT(0) AS total,

  ##Antoine

  # Pages with canonical
  #COUNTIF(ARRAY_LENGTH(canonicals_info.canonicals) > 0) as has_canonical,
  AS_PERCENT(COUNTIF(ARRAY_LENGTH(canonicals_info.canonicals) > 0), COUNT(0)) AS pct_has_canonical,

  # Pages with self-canonical
  #COUNTIF(canonicals_info.has_self_canonical) as has_self_canonical,
  AS_PERCENT(COUNTIF(canonicals_info.has_self_canonical), COUNT(0)) AS pct_has_self_canonical,

  # Pages canonicalized
  #COUNTIF(canonicals_info.is_canonicalized)) as is_canonicalized,
  AS_PERCENT(COUNTIF(canonicals_info.is_canonicalized), COUNT(0)) AS pct_has_canonical,

  # Pages with canonical in HTTP header 
  #COUNTIF(ARRAY_LENGTH(canonicals_info.http_canonicals) > 0) as has_http_canonical,
  AS_PERCENT(COUNTIF(ARRAY_LENGTH(canonicals_info.http_canonicals) > 0), COUNT(0)) AS pct_http_canonical,

  # Pages with canonical mismatch
  #COUNTIF(canonicals_info.has_canonical_mismatch) > 0) as has_canonical_mismatch,
  AS_PERCENT(COUNTIF(canonicals_info.has_canonical_mismatch), COUNT(0)) AS pct_has_canonical_mismatch,

  ######

  #not sure how to make this one works. We need to check that 
  #there is no difference between two arrays, which is not 
  #the same as checking for equality :/ 

  #######

  # Pages with canonical conflict between raw and rendered 
  #COUNTIF(canonicals_info.canonical_raw != canonicals_info-canonical_rendred) as has_conflict_raw_rendered_canonical,
  AS_PERCENT(COUNTIF(canonicals_info.canonical_raw != canonicals.canonical_rendered), COUNT(0)) AS pct_has_conflict_raw_rendered_canonical,





  FROM
    ( 
      SELECT 
        _TABLE_SUFFIX AS client,
        get_canonicals_info('') AS canonicals_info # TEST
        #get_canonicals_info(JSON_EXTRACT_SCALAR(payload, '$._canonicals')) AS canonicals_info # LIVE      
      FROM
        `httparchive.sample_data.pages_*` # TEST
    )
GROUP BY
  client