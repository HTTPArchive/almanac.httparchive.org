#standardSQL
# page almanac metrics grouped by device

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _almanac
CREATE TEMPORARY FUNCTION get_wpt_bodies_info(wpt_bodies_string STRING)
RETURNS STRUCT<
    jsonld_and_microdata_types ARRAY<STRING>
> LANGUAGE js AS '''
var result = {};


try {
    //var wpt_bodies = JSON.parse(wpt_bodies_string); // LIVE

    // TEST
    var wpt_bodies = {

        "structured_data": {
           "rendered": {
              "items_by_format": {
                    "microformats2": 0,
                    "microdata": 0,
                    "jsonld": 31,
                    "rdfa": 0
               },
              "jsonld_and_microdata_types": [
                ]
            }
        }
    }; 

    if (Math.floor(Math.random() * 50) == 0) {
        wpt_bodies.structured_data.rendered.jsonld_and_microdata_types.push({"name": "schema.org/LocalBusiness"});
    }
    if (Math.floor(Math.random() * 10) == 0) {
        wpt_bodies.structured_data.rendered.jsonld_and_microdata_types.push({"name": "schema.org/Organization"});
    }
    if (Math.floor(Math.random() * 3) == 0) {
        wpt_bodies.structured_data.rendered.jsonld_and_microdata_types.push({"name": "schema.org/WebSite"});
    }

    if (Array.isArray(wpt_bodies) || typeof wpt_bodies != 'object') return result;

    if (wpt_bodies.structured_data && wpt_bodies.structured_data.rendered) {
        var temp = wpt_bodies.structured_data.rendered.jsonld_and_microdata_types;
        result.jsonld_and_microdata_types = temp.map(a => a.name);
    }

} catch (e) {}
return result;
''';

SELECT
client,
type,
total, 
COUNT(*) AS count,
AS_PERCENT(COUNT(*), total) AS pct

FROM
    ( 
      SELECT 
        _TABLE_SUFFIX AS client,
        total,
        get_wpt_bodies_info('') AS wpt_bodies_info # TEST
        #get_wpt_bodies_info(JSON_EXTRACT_SCALAR(payload, '$._wpt_bodies')) AS wpt_bodies_info, # LIVE       
      FROM
        `httparchive.sample_data.pages_*` test # TEST
        JOIN
  (SELECT _TABLE_SUFFIX, COUNT(0) AS total 
  FROM `httparchive.sample_data.pages_*` # TEST
  GROUP BY _TABLE_SUFFIX) # to get an accurate total of pages per device. also seems fast
USING (_TABLE_SUFFIX)
    ), UNNEST(wpt_bodies_info.jsonld_and_microdata_types) as type
GROUP BY total, type, client
