#standardSQL
CREATE TEMPORARY FUNCTION getSpecificityHacks(css STRING)
RETURNS STRUCT<
  bem NUMERIC,
  attribute_id NUMERIC,
  duplicate_classes NUMERIC,
  root_descendant NUMERIC,
  html_descendant NUMERIC,
  not_id_descendant NUMERIC
>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
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
''';

SELECT
  percentile,
  client,
  COUNT(0) AS total,
  COUNTIF(bem > 0) AS bem_pages,
  COUNTIF(bem > 0) / COUNT(0) AS bem_pages_pct,
  APPROX_QUANTILES(bem, 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS bem_per_page,
  COUNTIF(attribute_id > 0) AS attribute_id_pages,
  COUNTIF(attribute_id > 0) / COUNT(0) AS attribute_id_pages_pct,
  APPROX_QUANTILES(attribute_id, 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS attribute_id_per_page,
  COUNTIF(duplicate_classes > 0) AS duplicate_classes_pages,
  COUNTIF(duplicate_classes > 0) / COUNT(0) AS duplicate_classes_pages_pct,
  APPROX_QUANTILES(duplicate_classes, 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS duplicate_classes_per_page,
  COUNTIF(root_descendant > 0) AS root_descendant_pages,
  COUNTIF(root_descendant > 0) / COUNT(0) AS root_descendant_pages_pct,
  APPROX_QUANTILES(root_descendant, 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS root_descendantem_per_page,
  COUNTIF(html_descendant > 0) AS html_descendant_pages,
  COUNTIF(html_descendant > 0) / COUNT(0) AS html_descendant_pages_pct,
  APPROX_QUANTILES(html_descendant, 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS html_descendant_per_page,
  COUNTIF(not_id_descendant > 0) AS not_id_descendant_pages,
  COUNTIF(not_id_descendant > 0) / COUNT(0) AS not_id_descendant_pages_pct,
  APPROX_QUANTILES(not_id_descendant, 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS not_id_descendant_per_page
FROM (
  SELECT
    client,
    SUM(hack.bem) AS bem,
    SUM(hack.attribute_id) AS attribute_id,
    SUM(hack.duplicate_classes) AS duplicate_classes,
    SUM(hack.root_descendant) AS root_descendant,
    SUM(hack.html_descendant) AS html_descendant,
    SUM(hack.not_id_descendant) AS not_id_descendant
  FROM (
    SELECT
      client,
      page,
      getSpecificityHacks(css) AS hack
    FROM
      `httparchive.almanac.parsed_css`
    WHERE
      date = '2020-08-01' AND
      # Limit the size of the CSS to avoid OOM crashes.
      LENGTH(css) < 0.1 * 1024 * 1024)
  GROUP BY
    client,
    page),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
