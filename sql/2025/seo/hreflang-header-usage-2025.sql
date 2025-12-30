#standardSQL
# hreflang header usage

# Returns all the data we need from _wpt_bodies
CREATE TEMPORARY FUNCTION getHreflangInfo(hreflang JSON)
RETURNS STRUCT<
  hreflangs ARRAY<STRING>
> LANGUAGE js AS '''
var result = {
  hreflangs: []
};

try {
    if (Array.isArray(hreflang) || typeof hreflang != 'object') return result;

    if (hreflang && hreflang.http_header && hreflang.http_header.values) {
        result.hreflangs = hreflang.http_header.values.map(v => v); // seems to fix a coercion issue!
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
    getHreflangInfo(custom_metrics.wpt_bodies.hreflangs) AS hreflang_info
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'

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
  UNNEST(hreflang_info.hreflangs) AS hreflang
GROUP BY
  hreflang,
  client,
  is_root_page
ORDER BY
  sites DESC,
  client DESC;
