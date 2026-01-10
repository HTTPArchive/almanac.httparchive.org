#standardSQL
# Content Language

CREATE TEMPORARY FUNCTION getContentLanguagesAlmanac(almanac JSON)
RETURNS ARRAY<STRING>
LANGUAGE js AS '''
var result = [];
try {

    if (Array.isArray(almanac) || typeof almanac != 'object') return ["NO PAYLOAD"];

    if (almanac && almanac["meta-nodes"] && almanac["meta-nodes"].nodes && almanac["meta-nodes"].nodes.filter) {
      result = almanac["meta-nodes"].nodes.filter(n => n["http-equiv"] && n["http-equiv"].toLowerCase().trim() == 'content-language' && n.content).map(am => am.content.toLowerCase().trim());
    }

    if (result.length === 0)
        result.push("NO TAG");

} catch (e) {result.push("ERROR "+e);} // results show some issues with the validity of the payload
return result;
''';
WITH content_language_usage AS (
  SELECT
    client,
    root_page,
    page,
    CASE
      WHEN is_root_page = FALSE THEN 'Secondarypage'
      WHEN is_root_page = TRUE THEN 'Homepage'
      ELSE 'No Assigned Page'
    END AS is_root_page,
    getContentLanguagesAlmanac(custom_metrics.other.almanac) AS content_languages
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
)

SELECT
  client,
  is_root_page,
  content_language,
  COUNT(DISTINCT page) AS sites,
  SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client, is_root_page) AS total,
  COUNT(0) / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client, is_root_page) AS pct
FROM
  content_language_usage,
  UNNEST(content_languages) AS content_language
GROUP BY
  client,
  is_root_page,
  content_language
ORDER BY
  sites DESC,
  client DESC;
