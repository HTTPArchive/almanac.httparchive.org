#standardSQL
# page wpt_bodies metrics grouped by device and hreflang value in link tags

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _almanac
CREATE TEMPORARY FUNCTION get_wpt_bodies_info(wpt_bodies_string STRING)
RETURNS STRUCT<
    hreflangs ARRAY<STRING>
> LANGUAGE js AS '''
var result = {};


try {
    var wpt_bodies;

    if (true) { // LIVE = true
        wpt_bodies = JSON.parse(wpt_bodies_string); // LIVE
    }
    else 
    {
        // TEST
        wpt_bodies = {
            "hreflangs": {
                "http_header": {
                    "values": []
                },
                "rendered": {
                    "values": []
                },
                "raw": {
                    "values": []
                }
            }
        }; 
        if (Math.floor(Math.random() * 10) == 0) {
            wpt_bodies.hreflangs.rendered.values.push("en-us");
        }
        if (Math.floor(Math.random() * 50) == 0) {
            wpt_bodies.hreflangs.rendered.values.push("en-gb");
        }
        if (Math.floor(Math.random() * 25) == 0) {
            wpt_bodies.hreflangs.rendered.values.push("en-ca");
        }
    }

    if (Array.isArray(wpt_bodies) || typeof wpt_bodies != 'object') return result;

    if (wpt_bodies.hreflangs && wpt_bodies.hreflangs.rendered && wpt_bodies.hreflangs.rendered.values) {
        result.hreflangs = wpt_bodies.hreflangs.rendered.values;
    }

} catch (e) {}
return result;
''';

SELECT
client,
hreflang,
total, 
COUNT(0) AS count,
AS_PERCENT(COUNT(0), total) AS pct

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
    ), UNNEST(wpt_bodies_info.hreflangs) as hreflang
GROUP BY total, hreflang, client
ORDER BY client, pct DESC
