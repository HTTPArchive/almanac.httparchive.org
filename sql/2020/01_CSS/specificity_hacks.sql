#standardSQL
CREATE TEMPORARY FUNCTION getSpecificityHacks(css STRING)
RETURNS STRUCT<
  bem NUMERIC,
  attribute_id NUMERIC,
  duplicate_classes NUMERIC,
  root_descendant NUMERIC,
  html_descendant NUMERIC,
  not_id_descendant NUMERIC
> LANGUAGE js AS '''
try {

function compute() {

let ret = {
  bem: 0,
  attribute_id: 0,
  duplicate_classes: 0,
  root_descendant: 0,
  html_descendant: 0,
  not_id_descendant: 0,
};

const bem = /^(?=.+--|.+__)[a-z0-9-]+(__[\\w-]+)?(--[\\w-]+)?$/i;

walkSelectors(ast, selector => {
  let sast = parsel.parse(selector, {list: false, recursive: false});

  parsel.walk(sast, (node, parent) => {
    if (node.type === "attribute" && node.name === "id" && node.operator === "=") {
      ret.attribute_id++;
    }
    else if (node.type === "compound") {
      // Look for duplicate classes
      let classes = new Set();

      for (let s of node.list) {
        if (s.type === "class") {
          if (classes.has(s.name)) {
            // Found a duplicate class
            ret.duplicate_classes++;
            break;
          }

          classes.add(s.name);
        }
      }
    }
    else if (!parent && node.type === "complex") {
      let first = node;
      // Find the firstmost compound
      while ((first = first.left) && first.type === "complex");

      if (first.combinator === " ") {
        first = first.left;
      }

      if (first.type === "pseudo-class" && first.name === "root") {
        ret.root_descendant++;
      }
      else if (first.type === "type" && first.name === "html") {
        ret.html_descendant++;
      }
      else if (first.type === "pseudo-class" && first.name === "not" && first.argument.startsWith("#")) {
        ret.not_id_descendant++;
      }
    }
    else if (node.type === "class" && (!parent || parent.type === "complex" && parent.combinator === " ")) {
      if (bem.test(node.name)) {
        ret.bem++;
      }
    }
  }, {subtree: true});
});

return ret;

}

  const ast = JSON.parse(css);
  return compute(ast);
} catch (e) {
  return null;
}
'''
OPTIONS (library="gs://httparchive/lib/css-utils.js");

SELECT
  percentile,
  client,
  COUNT(DISTINCT page) AS total,
  COUNT(DISTINCT IF(hack.bem > 0, page, NULL)) AS bem_pages,
  COUNT(DISTINCT IF(hack.bem > 0, page, NULL)) / COUNT(DISTINCT page) AS bem_pages_pct,
  APPROX_QUANTILES(hack.bem, 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS bem_per_page,
  COUNT(DISTINCT IF(hack.attribute_id > 0, page, NULL)) AS attribute_id_pages,
  COUNT(DISTINCT IF(hack.attribute_id > 0, page, NULL)) / COUNT(DISTINCT page) AS attribute_id_pages_pct,
  APPROX_QUANTILES(hack.attribute_id, 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS attribute_id_per_page,
  COUNT(DISTINCT IF(hack.duplicate_classes > 0, page, NULL)) AS duplicate_classes_pages,
  COUNT(DISTINCT IF(hack.duplicate_classes > 0, page, NULL)) / COUNT(DISTINCT page) AS duplicate_classes_pages_pct,
  APPROX_QUANTILES(hack.duplicate_classes, 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS duplicate_classes_per_page,
  COUNT(DISTINCT IF(hack.root_descendant > 0, page, NULL)) AS root_descendant_pages,
  COUNT(DISTINCT IF(hack.root_descendant > 0, page, NULL)) / COUNT(DISTINCT page) AS root_descendant_pages_pct,
  APPROX_QUANTILES(hack.root_descendant, 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS root_descendantem_per_page,
  COUNT(DISTINCT IF(hack.html_descendant > 0, page, NULL)) AS html_descendant_pages,
  COUNT(DISTINCT IF(hack.html_descendant > 0, page, NULL)) / COUNT(DISTINCT page) AS html_descendant_pages_pct,
  APPROX_QUANTILES(hack.html_descendant, 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS html_descendant_per_page,
  COUNT(DISTINCT IF(hack.not_id_descendant > 0, page, NULL)) AS not_id_descendant_pages,
  COUNT(DISTINCT IF(hack.not_id_descendant > 0, page, NULL)) / COUNT(DISTINCT page) AS not_id_descendant_pages_pct,
  APPROX_QUANTILES(hack.not_id_descendant, 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS not_id_descendant_per_page,
  COUNTIF(hack IS NULL) AS parse_errors
FROM (
  SELECT
    client,
    page,
    getSpecificityHacks(css) AS hack
  FROM
    `httparchive.almanac.parsed_css`),
  UNNEST([10, 25, 50, 75, 90, 95, 99, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client