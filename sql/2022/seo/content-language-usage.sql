#standardSQL
# Content language usage

# returns all the data we need from _almanac
CREATE TEMPORARY FUNCTION getContentLanguagesAlmanac(almanac_string STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS '''
var result = [];
try {
    var almanac = JSON.parse(almanac_string);

    if (Array.isArray(almanac) || typeof almanac != 'object') return ["NO PAYLOAD"];

    if (almanac && almanac["meta-nodes"] && almanac["meta-nodes"].nodes && almanac["meta-nodes"].nodes.filter) {
      result = almanac["meta-nodes"].nodes.filter(n => n["http-equiv"] && n["http-equiv"].toLowerCase().trim() == 'content-language' && n.content).map(am => am.content.toLowerCase().trim());
    }

    if (result.length === 0)
        result.push("NO TAG");

} catch (e) {result.push("ERROR "+e);} // results show some issues with the validity of the payload
return result;
''';

SELECT
  client,
  total,

  content_language,
  COUNT(0) AS count,
  SAFE_DIVIDE(COUNT(0), total) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    total,
    getContentLanguagesAlmanac(JSON_EXTRACT_SCALAR(payload, '$._almanac')) AS content_languages
  FROM
    `httparchive.pages.2022_07_01_*` -- noqa: CV09
  JOIN (

    SELECT _TABLE_SUFFIX, COUNT(0) AS total
    FROM
      `httparchive.pages.2022_07_01_*` -- noqa: CV09

    GROUP BY _TABLE_SUFFIX
  )
  USING (_TABLE_SUFFIX)
),
  UNNEST(content_languages) AS content_language
GROUP BY
  total,
  content_language,
  client
ORDER BY
  count DESC,
  content_language,
  client DESC
LIMIT 1000
