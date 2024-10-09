#standardSQL
# 09_15: % pages using duplicate aria-keyshortcuts, accesskey attrs
CREATE TEMPORARY FUNCTION hasDuplicates(values ARRAY<STRING>)
RETURNS BOOLEAN LANGUAGE js AS '''
return values.length != new Set(values).size;
''';

SELECT
  client,
  COUNTIF(hasDuplicates(aria_keyshortcuts)) AS freq_aria_keyshortcuts,
  COUNTIF(hasDuplicates(accesskeys)) AS freq_accesskey
FROM (
  SELECT
    client,
    REGEXP_EXTRACT_ALL(LOWER(body), '<[^>]+aria-keyshortcuts=[\'"]?([^\\s\'"]+)') AS aria_keyshortcuts,
    REGEXP_EXTRACT_ALL(LOWER(body), '<[^>]+accesskey=[\'"]?([^\\s\'"]+)') AS accesskeys
  FROM
    `httparchive.almanac.summary_response_bodies`
  WHERE
    date = '2019-07-01' AND
    firstHtml
)
GROUP BY
  client
