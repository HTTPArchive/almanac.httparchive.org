#standardSQL
CREATE TEMPORARY FUNCTION HASCONTENTVISIBILITY(css STRING)
RETURNS ARRAY<STRUCT<property STRING, freq INT64>>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  var ast = JSON.parse(css);

  let ret = {};

  walkDeclarations(ast, ({property}) => {
    // Strip hacks like *property, _property etc and normalize to lowercase
    property = property.replace(/[^a-z-]/g, "").toLowerCase();

    if (matches(property, 'content-visibility')) {
      incrementByKey(ret, property);
    }
  });

  return Object.entries(ret).map(([property, freq]) => {
    return {property, freq};
  });
} catch (e) {
  return [];
}
''';

WITH totals AS (
  SELECT
    client,
    COUNT(DISTINCT root_page) AS total_pages
  FROM
    `httparchive.crawl.parsed_css`
  WHERE
    date = '2025-06-01' AND
    is_root_page
  GROUP BY
    client
),

content_visibility_pages AS (
  SELECT
    client,
    COUNT(DISTINCT root_page) AS pages_with_content_visibility
  FROM
    `httparchive.crawl.parsed_css`,
    UNNEST(HASCONTENTVISIBILITY(TO_JSON_STRING(css)))
  WHERE
    date = '2025-06-01' AND
    is_root_page
  GROUP BY
    client
)

SELECT
  totals.client,
  totals.total_pages,
  COALESCE(
    content_visibility_pages.pages_with_content_visibility, 0
  ) AS pages_with_content_visibility,
  ROUND(
    COALESCE(
      content_visibility_pages.pages_with_content_visibility, 0
    ) * 100.0 / totals.total_pages,
    2
  ) AS pct_pages
FROM
  totals
LEFT JOIN
  content_visibility_pages
ON totals.client = content_visibility_pages.client
ORDER BY
  totals.client
