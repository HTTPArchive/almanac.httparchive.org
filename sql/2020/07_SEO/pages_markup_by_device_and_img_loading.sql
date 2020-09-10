#standardSQL
# pages markup metrics grouped by device and image loading attributes

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
    var markup;

    if (true) { // LIVE = true
      markup = JSON.parse(markup_string); // LIVE
    }
    else 
    {
      // TEST
      markup = {
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
            "auto": Math.floor(Math.random() * 3),
            "lazy": Math.floor(Math.random() * 3),
            "eager": Math.floor(Math.random() * 3),
            "invalid": Math.floor(Math.random() * 3),
            "missing": Math.floor(Math.random() * 30),
            "blank": Math.floor(Math.random() * 3)
            }
          }
        }
      };
    }

    if (Array.isArray(markup) || typeof markup != 'object') return result;

    if (markup.images) {

      result.loading = getKey(markup.images.img.loading);

    }

} catch (e) {}
return result;
''';

SELECT
  client,
  loading, 
total, 
COUNT(0) AS count,
AS_PERCENT(COUNT(0), total) AS pct
FROM
    ( 
      SELECT 
        _TABLE_SUFFIX AS client,
        total,
        #get_markup_info('') AS markup_info # TEST
        get_markup_info(JSON_EXTRACT_SCALAR(payload, '$._markup')) AS markup_info # LIVE      
      FROM
        #`httparchive.sample_data.pages_*` # TEST
        `httparchive.pages.2020_08_01_*` # LIVE
        JOIN
  (SELECT _TABLE_SUFFIX, COUNT(0) AS total 
  FROM 
  #`httparchive.sample_data.pages_*` # TEST
  `httparchive.pages.2020_08_01_*` # LIVE
  GROUP BY _TABLE_SUFFIX) # to get an accurate total of pages per device. also seems fast
USING (_TABLE_SUFFIX)
    ),UNNEST(markup_info.loading) as loading
    GROUP BY total, loading, client
