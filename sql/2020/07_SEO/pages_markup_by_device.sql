#standardSQL
# page markup metrics grouped by device

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _markup
CREATE TEMPORARY FUNCTION get_markup_info(markup_string STRING)
RETURNS STRUCT<
  images_img_total INT64
  # add more properties here...
> LANGUAGE js AS '''
var result = {};
try {
    //var markup = JSON.parse(markup_string); // LIVE

    // TEST
    var markup = {
      "images": {
          "img": {
              "total": Math.floor(Math.random() * 100)
          }
      }
    }; 

    if (Array.isArray(markup) || typeof markup != 'object') return result;

    if (markup.images) {
      if (markup.images.img) {
        result.images_img_total = markup.images.img.total;
      }
    }

    // add more code to set result properties here...

} catch (e) {}
return result;
''';

SELECT
  client,
  COUNT(0) AS total,

  # Pages with img
  COUNTIF(markup_info.images_img_total > 0) as has_img,
  AS_PERCENT(COUNTIF(markup_info.images_img_total > 0), COUNT(0)) AS pct_has_img,
  # AS_PERCENT(COUNTIF(markup_info.images_img_total > 0), SUM(COUNT(0) OVER())) AS pct_overall_has_img, # Could not get this to work?

  # add more fields here...

  FROM
    ( 
      SELECT 
        _TABLE_SUFFIX AS client,
        get_markup_info('') AS markup_info # TEST
        #get_markup_info(JSON_EXTRACT_SCALAR(payload, '$._markup')) AS markup_info # LIVE      
      FROM
        `httparchive.sample_data.pages_*` # TEST
    )
GROUP BY
  client