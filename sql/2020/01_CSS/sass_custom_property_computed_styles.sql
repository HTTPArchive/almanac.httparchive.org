#standardSQL
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

SELECT
  _TABLE_SUFFIX AS client,
  prop,
  COUNT(0) AS pages,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS pct
FROM
  `httparchive.pages.2020_08_01_*`,
  UNNEST(getCustomPropertiesWithComputedStyle(payload)) AS prop
GROUP BY
  client,
  prop
ORDER BY
  pct DESC