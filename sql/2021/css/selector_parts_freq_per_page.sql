#standardSQL
CREATE TEMPORARY FUNCTION getSelectorParts(css STRING)
RETURNS STRUCT<
  class ARRAY<STRUCT<name STRING, value INT64>>,
  id ARRAY<STRUCT<name STRING, value INT64>>,
  attribute ARRAY<STRUCT<name STRING, value INT64>>,
  pseudo_class ARRAY<STRUCT<name STRING, value INT64>>,
  pseudo_element ARRAY<STRUCT<name STRING, value INT64>>
>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  function compute(ast) {
    let ret = {
      class: {},
      id: {},
      attribute: {},
      "pseudo-class": {},
      "pseudo-element": {}
    };

    walkSelectors(ast, selector => {
      let sast = parsel.parse(selector, {list: false});

      parsel.walk(sast, node => {
        if (node.type in ret) {
          incrementByKey(ret[node.type], node.name);
        }
      }, {subtree: true});
    });

    for (let type in ret) {
      ret[type] = sortObject(ret[type]);
    }

    return ret;
  }

  function unzip(obj) {
    return Object.entries(obj).filter(([name, value]) => {
      return !isNaN(value);
    }).map(([name, value]) => ({name, value}));
  }

  const ast = JSON.parse(css);
  let parts = compute(ast);
  return {
    class: unzip(parts.class),
    id: unzip(parts.id),
    attribute: unzip(parts.attribute),
    pseudo_class: unzip(parts['pseudo-class']),
    pseudo_element: unzip(parts['pseudo-element'])
  }
} catch (e) {
  return {class: [{name: e, value: 0}]};
}
''';

# https://www.stevenmoseley.com/blog/tech/high-performance-sql-correlated-scalar-aggregate-reduction-queries
CREATE TEMPORARY FUNCTION encode(comparator STRING, data STRING) RETURNS STRING AS (
  CONCAT(LPAD(comparator, 11, '0'), data)
);
CREATE TEMPORARY FUNCTION decode(value STRING) RETURNS STRING AS (
  SUBSTR(value, 12)
);

WITH selector_parts AS (
  SELECT
    client,
    page,
    url,
    getSelectorParts(css) AS parts
  FROM
    `httparchive.almanac.parsed_css`
  WHERE
    date = '2021-07-01' AND
    # Limit the size of the CSS to avoid OOM crashes.
    LENGTH(css) < 0.1 * 1024 * 1024
)

SELECT
  client,
  decode(MAX(encode(CAST(class_freq AS STRING), class_name))) AS class_name,
  MAX(class_freq) AS class_freq,
  decode(MAX(encode(CAST(id_freq AS STRING), id_name))) AS id_name,
  MAX(id_freq) AS id_freq,
  decode(MAX(encode(CAST(attribute_freq AS STRING), attribute_name))) AS attribute_name,
  MAX(attribute_freq) AS attribute_freq,
  decode(MAX(encode(CAST(pseudo_class_freq AS STRING), pseudo_class_name))) AS pseudo_class_name,
  MAX(pseudo_class_freq) AS pseudo_class_freq,
  decode(MAX(encode(CAST(pseudo_element_freq AS STRING), pseudo_element_name))) AS pseudo_element_name,
  MAX(pseudo_element_freq) AS pseudo_element_freq
FROM (
  SELECT
    client,
    class.name AS class_name,
    SUM(class.value) OVER (PARTITION BY client, class.name) AS class_freq
  FROM
    selector_parts,
    UNNEST(parts.class) AS class
)
JOIN (
  SELECT
    client,
    id.name AS id_name,
    SUM(id.value) OVER (PARTITION BY client, id.name) AS id_freq
  FROM
    selector_parts,
    UNNEST(parts.id) AS id
)
USING (client)
JOIN (
  SELECT
    client,
    attribute.name AS attribute_name,
    SUM(attribute.value) OVER (PARTITION BY client, attribute.name) AS attribute_freq
  FROM
    selector_parts,
    UNNEST(parts.attribute) AS attribute
)
USING (client)
JOIN (
  SELECT
    client,
    pseudo_class.name AS pseudo_class_name,
    SUM(pseudo_class.value) OVER (PARTITION BY client, pseudo_class.name) AS pseudo_class_freq
  FROM
    selector_parts,
    UNNEST(parts.pseudo_class) AS pseudo_class
)
USING (client)
JOIN (
  SELECT
    client,
    pseudo_element.name AS pseudo_element_name,
    SUM(pseudo_element.value) OVER (PARTITION BY client, pseudo_element.name) AS pseudo_element_freq
  FROM
    selector_parts,
    UNNEST(parts.pseudo_element) AS pseudo_element
)
USING (client)
GROUP BY
  client
