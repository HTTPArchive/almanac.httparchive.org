#standardSQL
# 03_01a: % of pages with deprecated elements
CREATE TEMPORARY FUNCTION containsDeprecatedElement(payload STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var elements = JSON.parse($._element_count)
  var deprecatedElements = new Set(["applet", "acronym", "bgsound", "dir", "frame", "frameset", "noframes", "isindex", "keygen", "listing", "menuitem", "nextid", "noembed", "plaintext", "rb", "rtc", "strike", "xmp", "basefont", "big", "blink", "center", "font", "marquee", "multicol", "nobr", "spacer", "tt"]);
  return !!Object.keys(elements).find(e => {
    return deprecatedElements.has(e);
  });
} catch (e) {
  return false;
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  COUNTIF(containsDeprecatedElement(payload)) AS pages,
  ROUND(COUNTIF(containsDeprecatedElement(payload)) * 100 / COUNT(0), 2) AS pct_pages
FROM
  `httparchive.pages.2019_07_01_*`
GROUP BY
  client
