#standardSQL
# Top obsolete elements M216 
# See related: sql/2019/03_Markup/03_01b.sql

CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

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

CREATE TEMPORARY FUNCTION isObsolete(element STRING) AS (
  element IN ("applet","acronym","bgsound","dir","frame","frameset","noframes","isindex","keygen","listing","menuitem","nextid","noembed","plaintext","rb","rtc","strike","xmp","basefont","big","blink","center","font","marquee","multicol","nobr","spacer","tt")
);

SELECT
  _TABLE_SUFFIX AS client,
  element AS obsolete,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  AS_PERCENT(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX)) AS pct
FROM
  `httparchive.sample_data.pages_*`,
  UNNEST(getElements(payload)) AS element
WHERE
  isObsolete(element)
GROUP BY
  client,
  obsolete
ORDER BY
  freq / total DESC,
  client
