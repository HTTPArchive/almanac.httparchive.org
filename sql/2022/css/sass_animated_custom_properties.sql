#standardSQL
CREATE TEMPORARY FUNCTION getAnimatedCustomProperties(css STRING)
RETURNS ARRAY<STRING>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  const ast = JSON.parse(css);
  let ret = new Set();

  walkRules(ast, rule => {
    walkDeclarations(rule.keyframes, ({property, value}) => {
      ret.add(property);
    }, {
      properties: /^--/
    });
  }, {
    type: "keyframes"
  });

  return [...ret];
} catch (e) {
  return [];
}
''';

CREATE TEMPORARY FUNCTION getCustomPropertiesWithComputedStyle(payload STRING) RETURNS
ARRAY<STRING> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var vars = JSON.parse($['_css-variables']);

  function walkElements(node, callback) {
    if (Array.isArray(node)) {
      for (let n of node) {
        walkElements(n, callback);
      }
    }
    else {
      callback(node);

      if (node.children) {
        walkElements(node.children, callback);
      }
    }
  }

  let ret = new Set();

  walkElements(vars.computed, node => {
    if (node.declarations) {
      for (let property in node.declarations) {
        let o = node.declarations[property];

        if (property.startsWith("--") && o.type) {
          ret.add(property);
        }
      }
    }
  });

  return [...ret];
} catch (e) {
  return [];
}
''';

WITH totals AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_pages
  FROM
    `httparchive.summary_pages.2022_07_01_*` -- noqa: CV09
  GROUP BY
    client
)

SELECT
  client,
  COUNT(DISTINCT page) AS pages,
  ANY_VALUE(total_pages) AS total_pages,
  COUNT(DISTINCT page) / ANY_VALUE(total_pages) AS pct_pages
FROM (
  SELECT
    client,
    page,
    prop
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getAnimatedCustomProperties(css)) AS prop
  WHERE
    date = '2022-07-01' -- noqa: CV09
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    prop
  FROM
    `httparchive.pages.2022_07_01_*`, -- noqa: CV09
    UNNEST(getCustomPropertiesWithComputedStyle(payload)) AS prop
)
USING (client, page, prop)
JOIN
  totals
USING (client)
GROUP BY
  client
