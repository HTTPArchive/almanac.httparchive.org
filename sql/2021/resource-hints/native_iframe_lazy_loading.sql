#standardSQL
# Count the number of lazily loaded iframes

# returns true/false if the page has an iframe with `loading="lazy"` or null if the page has no iframes
CREATE TEMPORARY FUNCTION hasLazyLoadedIframe(almanac_string STRING)
RETURNS BOOL
LANGUAGE js AS '''
try {
    var almanac = JSON.parse(almanac_string)
    if (Array.isArray(almanac) || typeof almanac != 'object') return null;

    var iframes = almanac["iframes"]["iframes"]["nodes"]

    if (iframes.length) {
        return !!iframes.filter(i => (i.loading || "").toLowerCase() === "lazy").length
    }

    return null;
}
catch {
    return null
}
''';

SELECT
  client,
  COUNTIF(has_lazy_iframes) AS is_lazy,
  COUNTIF(has_lazy_iframes IS NOT NULL) AS has_iframe,
  COUNTIF(has_lazy_iframes) / COUNTIF(has_lazy_iframes IS NOT NULL) AS pct,
  COUNT(0) AS total
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    hasLazyLoadedIframe(JSON_EXTRACT_SCALAR(payload, '$._almanac')) AS has_lazy_iframes
  FROM
    `httparchive.pages.2021_07_01_*`
)
GROUP BY
  client
ORDER BY
  client
