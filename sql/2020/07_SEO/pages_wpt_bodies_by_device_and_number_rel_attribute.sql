#standardSQL
# page almanac metrics grouped by device

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _almanac
CREATE TEMPORARY FUNCTION get_wpt_bodies_info(wpt_bodies_string STRING)
RETURNS STRUCT<
    rel ARRAY<STRING>
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
            "anchors": {
                "rendered": {
                    "crawlable": {
                        "follow": 128,
                        "nofollow": 0
                    },
                    "hash_link": 0,
                    "hash_only_link": 4,
                    "javascript_void_links": 0,
                    "same_page": {
                        "total": 8,
                        "jumpto": {
                            "total": 0,
                            "early": 0,
                            "other": 0,
                            "using_id": 0,
                            "using_name": 0
                        },
                        "dynamic": {
                            "total": 0,
                            "onclick_attributes": {
                                "total": 0,
                                "window_location": 0,
                                "window_open": 0,
                                "unknown_action": 0
                            },
                            "href_javascript": 0,
                            "hash_link": 0
                        },
                        "other": {
                            "total": 8,
                            "hash_link": 0
                        }
                    },
                    "same_site": 111,
                    "same_property": 1,
                    "other_property": 8,
                    "rel_attributes": {
                        "dofollow": Math.floor(Math.random() * 100),
                        "follow": Math.floor(Math.random() * 100),
                        "nofollow": Math.floor(Math.random() * 10),
                        "ugc": Math.floor(Math.random() * 20),
                        "sponsored": Math.floor(Math.random() * 20),
                        "noopener": Math.floor(Math.random() * 10),
                        "noreferrer": Math.floor(Math.random() * 10)
                    },
                    "image_links": 0,
                    "invisible_links": 37,
                    "text_links": 91,
                    "target_blank": {
                        "total": 14,
                        "noopener_noreferrer": 0,
                        "noopener": 2,
                        "noreferrer": 0,
                        "neither": 12
                    },
                    "targets": {
                        "_blank": 14,
                        "_self": 20,
                        "target=": 1
                    },
                    "protocols": {
                        "https": 128
                    }
                }
            }
        };
    } 

    if (Array.isArray(wpt_bodies) || typeof wpt_bodies != 'object') return result;

    if (wpt_bodies.anchors && wpt_bodies.anchors.rendered && wpt_bodies.anchors.rendered.rel_attributes) {
      result.rel = getKey(wpt_bodies.anchors.rendered.rel_attributes);
    }

} catch (e) {}
return result;
''';

SELECT
client,
rel,
total, 
COUNT(0) AS count,
AS_PERCENT(COUNT(0), total) AS pct


FROM
( 
    SELECT 
        _TABLE_SUFFIX AS client,
        total,
        #get_wpt_bodies_info('') AS wpt_bodies_info # TEST
        get_wpt_bodies_info(JSON_EXTRACT_SCALAR(payload, '$._wpt_bodies')) AS wpt_bodies_info # LIVE       
    FROM
        #`httparchive.sample_data.pages_*` # TEST
        `httparchive.pages.2020_08_01_*` # LIVE
    JOIN
    (
        # to get an accurate total of pages per device. also seems fast
        SELECT _TABLE_SUFFIX, COUNT(0) AS total 
        FROM 
        #`httparchive.sample_data.pages_*` # TEST
        `httparchive.pages.2020_08_01_*` # LIVE
        GROUP BY _TABLE_SUFFIX
    ) 
    USING (_TABLE_SUFFIX)
),
UNNEST(wpt_bodies_info.rel) as rel
GROUP BY total, rel, client
