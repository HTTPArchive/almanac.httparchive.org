#standardSQL

# Linking - fragment URLs (together with SPAs to navigate content)
# sample: `httparchive.almanac.pages_desktop_1k`
# dataset: `httparchive.pages.2019_07_01_desktop`

# todo: include if is SPA (react/vue) or not

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
    COUNT(url) AS `total`,
    COUNT(DISTINCT url) AS `distinct_total`,
    SUM(parseAnchor(payload, "navigateHash")) as `navigateHash`
FROM
    `httparchive.almanac.pages_desktop_1k`
