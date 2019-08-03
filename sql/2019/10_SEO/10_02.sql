#standardSQL

# lang attribute usage and mistakes (lang='en')
# source: https://discuss.httparchive.org/t/what-are-the-invalid-uses-of-the-lang-attribute/1022
# note: updated the table, but this has no items details (also 10.04) to parse

CREATE TEMPORARY FUNCTION getLanguages(items STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS """
  try {
    return items.match(/lang="([^"]*)"/ig);
  } catch (e) {
    return [];
  }
""";

SELECT
  COUNT(0) AS volume,
  lang
FROM (
  SELECT
    getLanguages(JSON_EXTRACT(report, "$.audits.valid-lang.details.items")) AS langs
  FROM
    `httparchive.lighthouse.2019_07_01_mobile`)
CROSS JOIN
  UNNEST(langs) AS lang
GROUP BY
  lang
ORDER BY
  volume DESC
