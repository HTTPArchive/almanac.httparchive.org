#standardSQL
# page markup metrics grouped by device and image alt percents
# I think percientile may be a better way?

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _markup
CREATE TEMPORARY FUNCTION get_markup_info(markup_string STRING)
RETURNS STRUCT<
  
  images INT64, 
  images_with_alt INT64 



> LANGUAGE js AS '''
var result = {};
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
      }
      }
      }
      };

    if (Array.isArray(markup) || typeof markup != 'object') return result;

    if (markup.images) {
        result.images = markup.images.img.total;
        result.images_with_alt = markup.images.img.alt.present;
    }

    // add more code to set result properties here...

} catch (e) {}
return result;
''';

SELECT
  client,
  COUNT(0) AS total,
  ROUND((markup_info.images_with_alt/markup_info.images)) as images_with_alt_percent
FROM
    ( 
      SELECT 
        _TABLE_SUFFIX AS client,
        get_markup_info('') AS markup_info # TEST
        #get_markup_info(JSON_EXTRACT_SCALAR(payload, '$._markup')) AS markup_info # LIVE      
      FROM
        `httparchive.sample_data.pages_*` # TEST
    )
    GROUP BY client, images_with_alt_percent
