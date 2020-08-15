#standardSQL
# M221

# returns all the data we need from _wpt_bodies
CREATE TEMPORARY FUNCTION get_heading_info(wpt_bodies_string STRING)
RETURNS ARRAY<STRUCT<
heading STRING,
total INT64
>> LANGUAGE js AS '''
var result = [];
try {
    //var wpt_bodies = JSON.parse(wpt_bodies_string); // LIVE

    // TEST
    var wpt_bodies = {

      "headings": {
        "rendered": {
            "first_non_empty_heading_hidden": false,
            "h1": {
                "total": Math.floor(Math.random() * 2),
                "non_empty_total": 0,
                "characters": 0,
                "words": 0
            },
            "primary": {
                "words": 9,
                "characters": 63,
                "matches_title": false,
                "text": "Savi 8200 Series Wireless Headset Announced at Microsoft Ignite",
                "level": 2
            },
            "h2": {
                "total": Math.floor(Math.random() * 4),
                "non_empty_total": 4,
                "characters": 194,
                "words": 28
            },
            "h3": {
                "total": Math.floor(Math.random() * 8),
                "non_empty_total": 1,
                "characters": 18,
                "words": 4
            },
            "h4": {
                "total": 0,
                "non_empty_total": 0,
                "characters": 0,
                "words": 0
            },
            "h5": {
                "total": 0,
                "non_empty_total": 0,
                "characters": 0,
                "words": 0
            },
            "h6": {
                "total": 0,
                "non_empty_total": 0,
                "characters": 0,
                "words": 0
            },
            "h7": {
                "total": 0,
                "non_empty_total": 0,
                "characters": 0,
                "words": 0
            },
            "h8": {
                "total": Math.floor(Math.random() * 2),
                "non_empty_total": 0,
                "characters": 0,
                "words": 0
            }
        }
        }
    }; 

    if (Array.isArray(wpt_bodies) || typeof wpt_bodies != 'object') return result;

    if (wpt_bodies.headings && wpt_bodies.headings.rendered) {
      ["h1","h2","h3","h4","h5","h6","h7","h8"].forEach(h => {
        if (wpt_bodies.headings.rendered[h]) result.push({heading: h, total: wpt_bodies.headings.rendered[h].total});
      });
    }
} catch (e) {}
return result;
''';

SELECT
  heading,
  percentile,
  client,
  COUNT(DISTINCT url) AS total,

  APPROX_QUANTILES(total, 1000)[OFFSET(percentile * 10)] AS heading_count

FROM (
  SELECT 
    _TABLE_SUFFIX AS client,
    percentile,
    heading_info.heading AS heading,
    heading_info.total AS total,
    url,
  FROM
  `httparchive.sample_data.pages_*`, # TEST
  UNNEST([10, 25, 50, 75, 90]) AS percentile,
  UNNEST(get_heading_info('')) AS heading_info # TEST
  #UNNEST(get_heading_info(JSON_EXTRACT_SCALAR(payload, '$._wpt_bodies'))) AS heading_info # LIVE
)
GROUP BY
  heading,
  percentile,
  client
ORDER BY
  heading,
  percentile,
  client
