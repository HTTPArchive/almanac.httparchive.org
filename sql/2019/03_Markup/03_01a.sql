#standardSQL
# 03_01a: % of pages with deprecated elements
CREATE TEMPORARY FUNCTION getElements(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var elements = JSON.parse($._element_count)
  return Object.keys(elements);
} catch (e) {
  return [];
}
''';

CREATE TEMPORARY FUNCTION isDeprecated(element STRING) AS (
  element IN ("applet","acronym","bgsound","dir","frame","frameset","noframes","isindex","keygen","listing","menuitem","nextid","noembed","plaintext","rb","rtc","strike","xmp","basefont","big","blink","center","font","marquee","multicol","nobr","spacer","tt")
);

SELECT
  _TABLE_SUFFIX AS client,
  COUNTIF(isDeprecated(element)) AS pages,
  ROUND(COUNTIF(isDeprecated(element)) * 100 / COUNT(0), 2) AS pct_pages
FROM
  `httparchive.pages.2019_07_01_*`,
  UNNEST(getElements(payload)) AS element
GROUP BY
  client