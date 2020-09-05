#standardSQL
# pages almanac metrics grouped by device and element attribute use (frequency)

CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

CREATE TEMPORARY FUNCTION get_almanac_attribute_info(almanac_string STRING)
RETURNS ARRAY<STRUCT<name STRING, freq INT64>> LANGUAGE js AS '''
try {
    var almanac;
    if (true) { // LIVE = true
      almanac = JSON.parse(almanac_string); // LIVE
    }
    else {
      // TEST
      almanac = {    
        "attributes_used_on_elements": {
          "xmlns": 2,
          "lang": 1,
          "name": 33,
          "content": 33,
          "rel": 33,
          "type": 51,
          "title": 40,
          "href": 159,
          "media": 8,
          "sizes": 3,
          "color": 1,
          "src": 30,
          "async": 9,
          "id": 109,
          "data-loader": 2,
          "data-hsjs-portal": 2,
          "data-hsjs-env": 2,
          "crossorigin": 1,
          "data-leadin-portal-id": 1,
          "data-leadin-env": 1,
          "property": 12,
          "hreflang": 4,
          "class": 453,
          "charset": 2,
          "data-rsssl": 1,
          "data-nosnippet": 1,
          "target": 36,
          "defer": 1,
          "xmlns:xlink": 6,
          "viewBox": 5,
          "x": 2,
          "y": 2,
          "width": 2,
          "height": 2,
          "xlink:href": 7,
          "transform": 2,
          "fill": 4,
          "fill-rule": 4,
          "d": 4,
          "stroke-width": 2,
          "data-component-name": 2,
          "data-row-info": 8,
          "style": 51,
          "data-wow-delay": 5,
          "alt": 38,
          "_blank": 1,
          "data-wow-duration": 11,
          "data-portal-id": 2,
          "data-form-id": 2,
          "novalidate": 1,
          "accept-charset": 1,
          "action": 2,
          "enctype": 1,
          "method": 2,
          "data-reactid": 273,
          "placeholder": 13,
          "for": 7,
          "required": 7,
          "value": 216,
          "autocomplete": 4,
          "disabled": 2,
          "selected": 2
        }
      };
    }

    if (Array.isArray(almanac) || typeof almanac != 'object') return [];

    if (almanac.attributes_used_on_elements) {
      return Object.entries(almanac.attributes_used_on_elements).map(([name, freq]) => ({name, freq})); 
    }
    
} catch (e) {
    
}
return []; 
''';

SELECT
  _TABLE_SUFFIX AS client,
  almanac_attribute_info.name,
  SUM(almanac_attribute_info.freq) AS freq, # total count from all pages
  AS_PERCENT(SUM(almanac_attribute_info.freq), SUM(SUM(almanac_attribute_info.freq)) OVER (PARTITION BY _TABLE_SUFFIX)) AS pct_m400 
FROM
  #`httparchive.sample_data.pages_*`, # TEST
  `httparchive.pages.2020_08_01_*`, # LIVE
  # UNNEST(get_almanac_attribute_info('')) AS almanac_attribute_info # TESY
  UNNEST(get_almanac_attribute_info(JSON_EXTRACT_SCALAR(payload, '$._almanac'))) AS almanac_attribute_info # LIVE
GROUP BY
  client,
  almanac_attribute_info.name
ORDER BY
  client,
  pct_m400 DESC
LIMIT
  10000
