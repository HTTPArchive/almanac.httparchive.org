#standardSQL
# page wpt_bodies metrics grouped by device and title char count

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _wpt_bodies
CREATE TEMPORARY FUNCTION get_wpt_bodies_info(wpt_bodies_string STRING)
RETURNS STRUCT<
    title_char_count INT64
> LANGUAGE js AS '''
var result = {};
try {
    var wpt_bodies = JSON.parse(wpt_bodies_string); 

    if (Array.isArray(wpt_bodies) || typeof wpt_bodies != 'object') return result;

    if (wpt_bodies.title && wpt_bodies.title.rendered && wpt_bodies.title.rendered.primary) {
      result.title_char_count = wpt_bodies.title.rendered.primary.characters;
    }

} catch (e) {}
return result;
''';

SELECT
client,
COUNT(0) AS total, 
wpt_bodies_info.title_char_count as char_count

FROM
    ( 
      SELECT 
        _TABLE_SUFFIX AS client,
        get_wpt_bodies_info(JSON_EXTRACT_SCALAR(payload, '$._wpt_bodies')) AS wpt_bodies_info,        
      FROM
        `httparchive.pages.2020_08_01_*`
    )
GROUP BY client, char_count
