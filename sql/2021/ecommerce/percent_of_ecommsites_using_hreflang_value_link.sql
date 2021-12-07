#standardSQL
# page wpt_bodies metrics grouped by device and hreflang value in link tags
# this also filters for Ecommerce sites
# helper to create percent fields
CREATE TEMP FUNCTION
AS_PERCENT (freq FLOAT64,
  total FLOAT64)
RETURNS FLOAT64 AS ( SAFE_DIVIDE(freq,
  total) );
# returns all the data we need from _wpt_bodies
CREATE TEMPORARY FUNCTION
get_wpt_bodies_info(wpt_bodies_string STRING)
RETURNS STRUCT< hreflangs ARRAY<STRING> >
LANGUAGE js AS '''
var result = {
hreflangs: []
};
try {
    var wpt_bodies = JSON.parse(wpt_bodies_string);
    if (Array.isArray(wpt_bodies) || typeof wpt_bodies != 'object') return result;
    if (wpt_bodies.hreflangs && wpt_bodies.hreflangs.rendered && wpt_bodies.hreflangs.rendered.values) {
        result.hreflangs = wpt_bodies.hreflangs.rendered.values.map(v=> v); // seems to fix a coercion issue!
    }
} catch (e) {}
return result;
''';
SELECT
  client,
  NORMALIZE_AND_CASEFOLD(hreflang) AS hreflang,
  total,
  COUNT(0) AS count,
  AS_PERCENT(COUNT(0),
    total) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    total,
    get_wpt_bodies_info(JSON_EXTRACT_SCALAR(payload,
        '$._wpt_bodies')) AS wpt_bodies_info
  FROM
    `httparchive.pages.2021_07_01_*`
  JOIN (
    SELECT
      _TABLE_SUFFIX,
      url
    FROM
      `httparchive.technologies.2021_07_01_*`
    WHERE
      category = 'Ecommerce' AND
      (app != 'Cart Functionality' AND
       app != 'Google Analytics Enhanced eCommerce')
    )
  USING
    (_TABLE_SUFFIX,
      url)
  JOIN (
    SELECT
      _TABLE_SUFFIX,
      COUNT(0) AS total
    FROM
      `httparchive.pages.2021_07_01_*`
    GROUP BY
      _TABLE_SUFFIX) # to get an accurate total of pages per device. also seems fast
  USING
    (_TABLE_SUFFIX) ),
  UNNEST(wpt_bodies_info.hreflangs) AS hreflang
GROUP BY
  total,
  hreflang,
  client
ORDER BY
  count DESC,
  client DESC
