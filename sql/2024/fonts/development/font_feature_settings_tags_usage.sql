-- Section: Development
-- Question: Which OpenType features are used in CSS?

CREATE TEMPORARY FUNCTION FEATURES(json STRING)
RETURNS ARRAY<STRING>
LANGUAGE js
OPTIONS(library = "gs://httparchive/lib/css-utils.js")
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
  const ast = JSON.parse(json);
  const result = [];
  walkDeclarations(ast, decl => {
    const tags = parseFontFeatureSettings(decl.value);
    if (tags && tags.length) {
      tags.forEach(t => result.push(t));
    }
  }, {
    properties: 'font-feature-settings',
    rules: r => r.type !== 'font-face'
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
    date = '2024-06-01'
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
    date = '2024-06-01'
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
  pages USING (client)
ORDER BY
  proportion DESC
