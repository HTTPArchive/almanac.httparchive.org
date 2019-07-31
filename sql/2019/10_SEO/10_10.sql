#standardSQL

# Linking - extract <a href> count per page (internal + external)

# sample: `httparchive.almanac.pages_desktop_1k`
# dataset: `httparchive.pages.2019_07_01_desktop`

CREATE TEMPORARY FUNCTION parseAnchor(payload STRING, element STRING)
RETURNS INT64 LANGUAGE js AS '''
  try {
    var $ = JSON.parse(payload);
    var almanac = JSON.parse($._almanac);
    return almanac['seo-anchor-elements'][element];
  } catch (e) {
    return 0;
  }
''';

SELECT
    COUNTIF(parseAnchor(payload, "internal") > 0) as internal,
    COUNTIF(parseAnchor(payload, "external") > 0) as external,
    COUNTIF( parseAnchor(payload, "hash") > 0) as `hash`
FROM
    `httparchive.almanac.pages_desktop_1k`
