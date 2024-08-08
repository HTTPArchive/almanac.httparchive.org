#standardSQL
# page wpt_bodies metrics grouped by device
# M235

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT(freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _wpt_bodies
CREATE TEMPORARY FUNCTION get_wpt_bodies_protocols(wpt_bodies_string STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
var result = [];
try {
    var wpt_bodies = JSON.parse(wpt_bodies_string);

    if (Array.isArray(wpt_bodies) || typeof wpt_bodies != 'object') return result;

    if (wpt_bodies.anchors && wpt_bodies.anchors.rendered && wpt_bodies.anchors.rendered.protocols) {
        return Object.keys(wpt_bodies.anchors.rendered.protocols);
    }

} catch (e) {}
return result;
''';

SELECT
  _TABLE_SUFFIX AS client,
  COUNT(DISTINCT url) AS pages,
  total,
  protocol,

  AS_PERCENT(COUNT(DISTINCT url), total) AS pct

FROM
  `httparchive.pages.2020_08_01_*`
JOIN (SELECT _TABLE_SUFFIX, COUNT(0) AS total FROM
  `httparchive.pages.2020_08_01_*`
GROUP BY _TABLE_SUFFIX) # to get an accurate total of pages per device. also seems fast
USING (_TABLE_SUFFIX),
  UNNEST(get_wpt_bodies_protocols(JSON_EXTRACT_SCALAR(payload, '$._wpt_bodies'))) AS protocol
GROUP BY
  client,
  total,
  protocol
ORDER BY
  pages DESC
LIMIT 1000
