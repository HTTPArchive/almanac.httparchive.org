#standardSQL
# page almanac metrics grouped by device

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _almanac
CREATE TEMPORARY FUNCTION get_wpt_bodies_info(wpt_bodies_string STRING)
RETURNS STRUCT<
    items_by_format ARRAY<STRING>
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
    var wpt_bodies;

    if (true) { // LIVE = true
        wpt_bodies = JSON.parse(wpt_bodies_string); // LIVE
    }
    else 
    {
      // TEST
      wpt_bodies = {
          "structured_data": {
            "rendered": {
                "items_by_format": {
                      "microformats2": Math.floor(Math.random() * 50) == 0 ? 1 : 0,
                      "microdata": Math.floor(Math.random() * 10) == 0 ? 1 : 0,
                      "jsonld": Math.floor(Math.random() * 5) == 0 ? 1 : 0,
                      "rdfa": Math.floor(Math.random() * 1000) == 0 ? 1 : 0
                  }
              }
          }
      }; 
    }

    if (Array.isArray(wpt_bodies) || typeof wpt_bodies != 'object') return result;

    if (wpt_bodies.structured_data && wpt_bodies.structured_data.rendered && wpt_bodies.structured_data.rendered.items_by_format) {
        result.items_by_format = getKey(wpt_bodies.structured_data.rendered.items_by_format);
    }

} catch (e) {}
return result;
''';

SELECT
client,
format, 
total, 
COUNT(*) AS count,
AS_PERCENT(COUNT(*), total) AS pct

FROM
    ( 
      SELECT 
        _TABLE_SUFFIX AS client,
        total,
        #get_wpt_bodies_info('') AS wpt_bodies_info # TEST
        get_wpt_bodies_info(JSON_EXTRACT_SCALAR(payload, '$._wpt_bodies')) AS wpt_bodies_info, # LIVE       
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
    ), UNNEST(wpt_bodies_info.items_by_format) as format
    GROUP BY total, format, client
