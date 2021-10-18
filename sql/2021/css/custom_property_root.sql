#standardSQL
CREATE TEMPORARY FUNCTION getCustomPropertyRoots(payload STRING)
RETURNS ARRAY<STRUCT<name STRING, freq INT64>>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  function compute(vars) {
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

    let ret = {
      root: 0,
      body: 0,
      descendants: 0
    };

    walkElements(vars.computed, node => {
      if (node.declarations) {
        for (let property in node.declarations) {
          let value;
          let o = node.declarations[property];

          if (property.startsWith("--")) {
            if (/^HTML\\b/.test(node.element)) {
              ret.root++;
            }
            else if (/^BODY\\b/.test(node.element)) {
              ret.body++;
            }
            else {
              ret.descendants++;
            }
          }
        }
      }
    });

    return ret;
  }
  var $ = JSON.parse(payload);
  var vars = JSON.parse($['_css-variables']);
  var custom_properties = compute(vars);
  return Object.entries(custom_properties).map(([name, freq]) => ({name, freq}))
} catch (e) {
  return null;
}
''';

SELECT
  client,
  name AS root,
  SUM(freq) AS freq,
  SUM(SUM(freq)) OVER (PARTITION BY client) AS total,
  SUM(freq) / SUM(SUM(freq)) OVER (PARTITION BY client) AS pct,
  COUNT(DISTINCT IF(freq > 0, page, NULL)) AS pages,
  total_pages,
  COUNT(DISTINCT IF(freq > 0, page, NULL)) / total_pages AS pct_pages
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    root.name,
    root.freq
  FROM
    `httparchive.pages.2021_07_01_*`,
    UNNEST(getCustomPropertyRoots(payload)) AS root)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_pages
  FROM
    `httparchive.summary_pages.2021_07_01_*`
  GROUP BY
    client)
USING
  (client)
GROUP BY
  client,
  root,
  total_pages
ORDER BY
  pct DESC
