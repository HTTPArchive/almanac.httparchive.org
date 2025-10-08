#standardSQL
# hreflang header usage

# Returns all the data we need from _wpt_bodies
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
        result.hreflangs = wpt_bodies.hreflangs.http_header.values.map(v => v); // seems to fix a coercion issue!
    }

} catch (e) {}
return result;
''';

WITH hreflang_usage AS (
  SELECT
    client,
    root_page,
    page,
    CASE
      WHEN is_root_page = FALSE THEN 'Secondarypage'
      WHEN is_root_page = TRUE THEN 'Homepage'
      ELSE 'No Assigned Page'
    END AS is_root_page,
    getHreflangWptBodies(JSON_EXTRACT_SCALAR(payload, '$._wpt_bodies')) AS hreflang_wpt_bodies_info
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-06-01'

)

SELECT
  client,
  is_root_page,
  NORMALIZE_AND_CASEFOLD(hreflang) AS hreflang,
  COUNT(DISTINCT page) AS sites,
  SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client, is_root_page) AS total,
  COUNT(0) / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client, is_root_page) AS pct
FROM
  hreflang_usage,
  UNNEST(hreflang_wpt_bodies_info.hreflangs) AS hreflang
GROUP BY
  hreflang,
  client,
  is_root_page
ORDER BY
  sites DESC,
  client DESC;
