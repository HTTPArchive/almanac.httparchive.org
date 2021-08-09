#standardSQL
# page wpt_bodies metrics grouped by device and rel attributes
# Note: this query only reports if a rel attribute value was ever used on a page. It is not a per anchor report.

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _wpt_bodies
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
    var wpt_bodies = JSON.parse(wpt_bodies_string);

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
AS_PERCENT(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY client)) AS pct
FROM
(
    SELECT
        _TABLE_SUFFIX AS client,
        total,
        get_wpt_bodies_info(JSON_EXTRACT_SCALAR(payload, '$._wpt_bodies')) AS wpt_bodies_info
    FROM
        `httparchive.pages.2020_08_01_*`
    JOIN
    (
        # to get an accurate total of pages per device. also seems fast
        SELECT _TABLE_SUFFIX, COUNT(0) AS total
        FROM
        `httparchive.pages.2020_08_01_*`
        GROUP BY _TABLE_SUFFIX
    )
    USING (_TABLE_SUFFIX)
),
UNNEST(wpt_bodies_info.rel) AS rel
GROUP BY total, rel, client
ORDER BY count DESC
