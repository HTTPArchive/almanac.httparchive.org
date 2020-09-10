#standardSQL
# pages markup metrics grouped by device and button type

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _markup
CREATE TEMPORARY FUNCTION get_markup_buttons_info(markup_string STRING)
RETURNS ARRAY<STRUCT<
name STRING,
freq INT64
>> LANGUAGE js AS '''
var result = [];
try {
    var markup;
    if (true) { // LIVE = true
      markup = JSON.parse(markup_string); // LIVE
    } 
    else 
    {
      // TEST
      markup = {    
        "buttons": {
          "types": {
              "button": Math.floor(Math.random()*5),
              "fish": Math.floor(Math.random()*3)
          },
          "total": Math.floor(Math.random()*2)+2
        }
      }; 
    }

    if (Array.isArray(markup) || typeof markup != 'object') return result;

    if (markup.buttons && markup.buttons.types) {
      return Object.entries(markup.buttons.types).map(([name, freq]) => ({name, freq})); 
    }

} catch (e) {}
return result;
''';

SELECT
  _TABLE_SUFFIX AS client,
  button_type_info.name AS button_type,
  SUM(button_type_info.freq) AS freq, 
  AS_PERCENT(SUM(button_type_info.freq), SUM(SUM(button_type_info.freq)) OVER (PARTITION BY _TABLE_SUFFIX)) AS pct_m304
FROM
    #`httparchive.sample_data.pages_*` # TEST
    `httparchive.pages.2020_08_01_*` # LIVE
    JOIN
      (SELECT _TABLE_SUFFIX, COUNT(0) AS total FROM 
      #`httparchive.sample_data.pages_*`  # TEST
      `httparchive.pages.2020_08_01_*` # LIVE
      GROUP BY _TABLE_SUFFIX) # to get an accurate total of pages per device. also seems fast
    USING (_TABLE_SUFFIX),
    #UNNEST(get_markup_buttons_info('')) AS button_type_info # TEST
    UNNEST(get_markup_buttons_info(JSON_EXTRACT_SCALAR(payload, '$._markup'))) AS button_type_info # LIVE
GROUP BY
  client,
  button_type
