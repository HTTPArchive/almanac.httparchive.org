#standardSQL
# 03_01b: Top deprecated elements
CREATE TEMPORARY FUNCTION getElements(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var elements = JSON.parse($._element_count);
  if (Array.isArray(elements) || typeof elements != 'object') return [];
  return Object.keys(elements);
} catch (e) {
  return [];
}
''';

CREATE TEMPORARY FUNCTION isDeprecated(element STRING) AS (
  element IN ("applet","acronym","bgsound","dir","frame","frameset","noframes","isindex","keygen","listing","menuitem","nextid","noembed","plaintext","rb","rtc","strike","xmp","basefont","big","blink","center","font","marquee","multicol","nobr","spacer","tt")
);

SELECT
  client,
  deprecated,
  COUNT(0) AS freq,
  total,
  ROUND(COUNT(0) * 100 / total, 2) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    element AS deprecated,
    COUNT(DISTINCT url) OVER (PARTITION BY _TABLE_SUFFIX) AS total
  FROM
    `httparchive.pages.2019_07_01_*`,
    UNNEST(getElements(payload)) AS element
  WHERE
    isDeprecated(element))
GROUP BY
  client,
  total,
  deprecated
ORDER BY
  freq / total DESC
