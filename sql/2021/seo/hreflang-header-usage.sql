#standardSQL
# hreflang header usage

# returns all the data we need from _wpt_bodies
CREATE TEMPORARY FUNCTION getHreflangWptBodies(wpt_bodies_string STRING)
RETURNS STRUCT<
  hreflangs ARRAY<STRING>
> LANGUAGE js AS '''
var result = {
  hreflangs: []
};

try {
    var wpt_bodies = JSON.parse(wpt_bodies_string);

    if (Array.isArray(wpt_bodies) || typeof wpt_bodies != 'object') return result;

    if (wpt_bodies.hreflangs && wpt_bodies.hreflangs.http_header && wpt_bodies.hreflangs.http_header.values) {
        result.hreflangs = wpt_bodies.hreflangs.http_header.values.map(v=> v); // seems to fix a coercion issue!
    }

} catch (e) {}
return result;
''';

SELECT
  client,
  NORMALIZE_AND_CASEFOLD(hreflang) AS hreflang,
  total,
  COUNT(0) AS count,
  SAFE_DIVIDE(COUNT(0), total) AS pct

FROM
  (
    SELECT
      _TABLE_SUFFIX AS client,
      total,
      getHreflangWptBodies(JSON_EXTRACT_SCALAR(payload, '$._wpt_bodies')) AS hreflang_wpt_bodies_info
    FROM
      `httparchive.pages.2021_07_01_*`
    JOIN
      (
        SELECT
          _TABLE_SUFFIX, COUNT(0) AS total
        FROM
          `httparchive.pages.2021_07_01_*`
        GROUP BY
          _TABLE_SUFFIX
      )
    USING (_TABLE_SUFFIX)
  ), UNNEST(hreflang_wpt_bodies_info.hreflangs) AS hreflang
GROUP BY
  total,
  hreflang,
  client
ORDER BY
  count DESC,
  client DESC
