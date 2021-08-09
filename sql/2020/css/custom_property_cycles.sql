#standardSQL
CREATE TEMPORARY FUNCTION getCustomPropertyCycles(payload STRING)
RETURNS INT64
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
      max_length: 0,
      cycles_or_initial: 0
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
            ret.cycles_or_initial++;
          }
          else {
            let depth = countDependencyLength(node, property);

            if (depth > ret.max_length) {
              ret.max_length = depth;
            }

            incrementByKey(ret, depth);
          }
        }
      }
    });

    return ret;
  }
  var $ = JSON.parse(payload);
  var vars = JSON.parse($['_css-variables']);
  var custom_props = compute(vars);
  if (!('cycles_or_initial' in custom_props)) return null;
  return custom_props.cycles_or_initial;
} catch (e) {
  return null;
}
''';

SELECT
  client,
  cycles,
  COUNT(DISTINCT url) AS pages,
  SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS total,
  COUNT(DISTINCT url) / SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    SUM(getCustomPropertyCycles(payload)) AS cycles
  FROM
    `httparchive.pages.2020_08_01_*`
  GROUP BY
    client,
    url)
WHERE
  cycles IS NOT NULL
GROUP BY
  client,
  cycles
ORDER BY
  pct DESC
