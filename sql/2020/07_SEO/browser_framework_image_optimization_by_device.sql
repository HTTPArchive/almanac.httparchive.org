#standardSQL
# page almanac metrics grouped by device

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _markup
CREATE TEMPORARY FUNCTION get_markup_info(markup_string STRING)
RETURNS STRUCT<
  
  loading ARRAY<STRING>



> LANGUAGE js AS '''
var result = {};

//Function to retrieve only keys if value is >0
function getKey(dict){
  const arr = [],
  obj = Object.keys(dict);
  for (var x in obj){
    if(dict[obj[x]] > 0){
      arr.push(obj[x]);
    }
  }
  return arr;
}

try {
    //var markup = JSON.parse(markup_string); // LIVE

    // TEST
    var markup = {
    "images": {
      "picture": {
        "total": 0
        },
      "source": {
        "total": 0,
        "src_total": 0,
        "srcset_total": 0,
        "media_total": 0,
        "type_total": 0
        },
      "img": {
        "total": 37,
        "src_total": 37,
        "srcset_total": 7,
        "alt": {
          "missing": 1,
          "blank": 36,
          "present": 0
      },
        "loading": {
         "auto": 0,
         "lazy": 4,
         "eager": 0,
         "invalid": 0,
         "missing": 33,
         "blank": 0
         }
      }
      }
      };

    if (Array.isArray(markup) || typeof markup != 'object') return result;

    if (markup.images) {

      result.loading = getKey(markup.images.img.loading);

    }

    // add more code to set result properties here...

} catch (e) {}
return result;
''';

SELECT
  client,
  loading, 
  COUNT(*) AS total
FROM
    ( 
      SELECT 
        _TABLE_SUFFIX AS client,
        get_markup_info('') AS markup_info # TEST
        #get_markup_info(JSON_EXTRACT_SCALAR(payload, '$._markup')) AS markup_info # LIVE      
      FROM
        `httparchive.sample_data.pages_*` # TEST
    ),UNNEST(markup_info.loading) as loading
    GROUP BY loading, client
