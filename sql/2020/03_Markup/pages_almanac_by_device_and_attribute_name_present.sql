#standardSQL
# Top used elements
# See related: sql/2019/03_Markup/03_02b.sql

CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

CREATE TEMPORARY FUNCTION get_almanac_attribute_names(almanac_string STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
    // var almanac = JSON.parse(almanac_string); // LIVE

    // TEST
    var almanac = {    
      "attributes_used_on_elements": {
      }
    };
    if (Math.floor(Math.random() * 3) == 0) {
      almanac.attributes_used_on_elements.xmlns = 10;
    }
    if (Math.floor(Math.random() * 3) == 0) {
      almanac.attributes_used_on_elements.lang = 10;
    }
    if (Math.floor(Math.random() * 3) == 0) {
      almanac.attributes_used_on_elements.type = 10;
    }
    if (Math.floor(Math.random() * 3) == 0) {
      almanac.attributes_used_on_elements.media = 10;
    }

    if (Array.isArray(almanac) || typeof almanac != 'object') return [];

    if (almanac.attributes_used_on_elements) {
      return Object.keys(almanac.attributes_used_on_elements); 
    }
    
} catch (e) {
    
}
return []; 
''';

SELECT
  _TABLE_SUFFIX AS client,
  attribute_name,
  COUNT(DISTINCT url) AS pages,
  total,
  AS_PERCENT(COUNT(DISTINCT url), total) AS pct_m401
FROM
  `httparchive.sample_data.pages_*` # TEST
JOIN
  (SELECT _TABLE_SUFFIX, COUNT(0) AS total 
  FROM `httparchive.sample_data.pages_*` # TEST
  GROUP BY _TABLE_SUFFIX) # to get an accurate total of pages per device. also seems fast
USING (_TABLE_SUFFIX),
  UNNEST(get_almanac_attribute_names('')) AS attribute_name # TEST
  # UNNEST(get_almanac_attribute_names(JSON_EXTRACT_SCALAR(payload, '$._almanac'))) AS attribute_name # LIVE
GROUP BY
  client,
  total,
  attribute_name
ORDER BY
  pages / total DESC,
  client
