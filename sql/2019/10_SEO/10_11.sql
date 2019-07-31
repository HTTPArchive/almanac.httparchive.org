#standardSQL

# Linking - fragment URLs (together with SPAs to navigate content)
# sample: `httparchive.almanac.pages_desktop_1k`
# dataset: `httparchive.pages.2019_07_01_desktop`

# todo: include if is SPA (react/vue) or not (see uncommented lines)

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
    COUNTIF(parseAnchor(payload, "navigateHash") > 0) as `navigateHash`
FROM
    `httparchive.almanac.pages_desktop_1k`
# LEFT JOIN
#     `httparchive.almanac.technologies_desktop_1k` ON `httparchive.almanac.technologies_desktop_1k`.url = `httparchive.almanac.pages_desktop_1k`.url
# WHERE
#    REGEXP_CONTAINS(httparchive.almanac.technologies_desktop_1k`.technology, '/(react|vue|angular)/i')
