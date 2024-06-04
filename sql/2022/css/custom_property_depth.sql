#standardSQL
CREATE TEMPORARY FUNCTION getCustomPropertyLengths(payload STRING)
RETURNS ARRAY<STRUCT<depth INT64, freq INT64>>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  function compute(vars) {
    function walkElements(node, callback, parent) {
      if (Array.isArray(node)) {
        for (let n of node) {
          walkElements(n, callback, parent);
        }
      }
      else {
        callback(node, parent);

        if (node.children) {
          walkElements(node.children, callback, node);
        }
      }
    }

    let ret = {
      depths: {}
    };

    function countDependencyLength(node, property) {
      if (!node) {
        return 0;
      }

      let declarations = node.declarations;

      if (!declarations || !(property in declarations)) {
        return countDependencyLength(node.parent, property);
      }

      let o = declarations[property];

      if (!o.references || o.references.length === 0) {
        return 0;
      }

      let lengths = o.references.map(p => countDependencyLength(node, p));

      return 1 + Math.max(...lengths);
    }

    walkElements(vars.computed, (node, parent) => {
      if (parent && !node.parent) {
        node.parent = parent;
      }

      if (node.declarations) {
        for (let property in node.declarations) {

          let o = node.declarations[property];
          if (o.computed && o.computed.trim() !== o.value.trim() && (o.computed === "initial" || o.computed === "null")) {
            // Cycle or missing ref
            incrementByKey(ret, "cycles_or_initial");
          }
          else {
            let depth = countDependencyLength(node, property);

            incrementByKey(ret.depths, depth);
          }
        }
      }
    });

    return ret;
  }
  var $ = JSON.parse(payload);
  var vars = JSON.parse($['_css-variables']);
  if (!vars || !vars.computed) return null;
  var custom_props = compute(vars);
  return Object.entries(custom_props.depths).map(([depth, freq]) => ({depth, freq}))
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
  depth,
  COUNT(DISTINCT url) AS pages,
  ANY_VALUE(total_pages) AS total_pages,
  COUNT(DISTINCT url) / ANY_VALUE(total_pages) AS pct_pages,
  SUM(freq) AS freq,
  SUM(SUM(freq)) OVER (PARTITION BY client) AS total,
  SUM(freq) / SUM(SUM(freq)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    custom_properties.depth,
    custom_properties.freq
  FROM
    `httparchive.pages.2022_07_01_*`, -- noqa: CV09
    UNNEST(getCustomPropertyLengths(payload)) AS custom_properties
)
JOIN
  totals
USING (client)
GROUP BY
  client,
  depth
ORDER BY
  depth,
  client
