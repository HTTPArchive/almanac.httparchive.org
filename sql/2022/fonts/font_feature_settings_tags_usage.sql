CREATE TEMPORARY FUNCTION getFontFeatureTags(json STRING)
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

SELECT
  client,
  font_feature,
  pages,
  total,
  pages / total AS pct
FROM (
  SELECT
    client,
    font_feature,
    COUNT(DISTINCT page) AS pages
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getFontFeatureTags(css)) AS font_feature
  WHERE
    date = '2022-07-01' -- noqa: CV09
  GROUP BY
    client,
    font_feature
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2022_07_01_*` -- noqa: CV09
  GROUP BY
    client
)
USING (client)
ORDER BY
  pct DESC
