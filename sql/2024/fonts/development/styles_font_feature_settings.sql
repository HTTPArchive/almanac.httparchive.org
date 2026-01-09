-- Section: Development
-- Question: Which features are used via font-feature-settings in CSS?
-- Normalization: Pages

CREATE TEMPORARY FUNCTION FEATURES(json STRING)
RETURNS ARRAY<STRING>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
function parseFontFeatureSettings(value) {
  const features = (value || '').split(/\\s*,\\s*/);
  const result = []
  for (let i = 0; i < features.length; i++) {
    const match = /^"([\u0020-\u007e]{1,4})"(?:\\s+(\\d+|on|off))?$/i.exec(features[i]);
    if (match) {
      result.push(match[1]);
    }
  }
  return result;
}

try {
  const $ = JSON.parse(json);
  const result = [];
  walkDeclarations($, (declaration) => {
    const tags = parseFontFeatureSettings(declaration.value);
    if (tags && tags.length) {
      tags.forEach((tag) => result.push(tag));
    }
  }, {
    properties: 'font-feature-settings',
    rules: (rule) => rule.type.toLowerCase() !== 'font-face'
  });
  return result;
} catch (e) {
  return [];
}
''';

WITH
features AS (
  SELECT
    client,
    feature,
    COUNT(DISTINCT page) AS count
  FROM
    `httparchive.all.parsed_css`,
    UNNEST(FEATURES(css)) AS feature
  WHERE
    date = '2024-07-01' AND -- noqa: CV09
    is_root_page
  GROUP BY
    client,
    feature
),

pages AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND -- noqa: CV09
    is_root_page
  GROUP BY
    client
)

SELECT
  client,
  feature,
  count,
  total,
  count / total AS proportion
FROM
  features
JOIN
  pages
USING (client)
ORDER BY
  client,
  proportion DESC
