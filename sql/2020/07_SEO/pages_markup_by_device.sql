#standardSQL
# page markup metrics grouped by device

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _markup
CREATE TEMPORARY FUNCTION get_markup_info(markup_string STRING)
RETURNS STRUCT<

  ##Tony
  images_img_total INT64, 

  ##Antoine
  has_html_amp_tag BOOL, 
  has_rel_amphtml_tag BOOL

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

    if (markup.amp) {
      result.has_html_amp_tag = markup.amp.html_amp_attribute_present;
      result.has_rel_amphtml_tag = markup.amp.rel_amphtml;
    }

    // add more code to set result properties here...

} catch (e) {}
return result;
''';

SELECT
  client,
  COUNT(0) AS total,

  ##Tony
  # Pages with img
  #COUNTIF(markup_info.images_img_total > 0) as has_img,
  AS_PERCENT(COUNTIF(markup_info.images_img_total > 0), COUNT(0)) AS pct_has_img,


  ##Antoine

  # Pages with <html amp> tag
  #COUNTIF(markup_info.has_html_amp_tag) as has_html_amp_tag,
  AS_PERCENT(COUNTIF(markup_info.has_html_amp_tag > 0), COUNT(0)) AS pct_has_html_amp_tag,

  # Pages with rel=amphtml
  #COUNTIF(markup_info.has_rel_amphtml_tag) as has_rel_amphtml_tag,
  AS_PERCENT(COUNTIF(markup_info.has_rel_amphtml_tag > 0), COUNT(0)) AS pct_has_rel_amphtml_tag


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