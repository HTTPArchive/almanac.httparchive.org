#standardSQL
# Copy of sql/2021/css/focus_visible.sql
CREATE TEMPORARY FUNCTION getSelectorParts(css STRING)
RETURNS STRUCT<
  class ARRAY<STRING>,
  id ARRAY<STRING>,
  attribute ARRAY<STRING>,
  pseudo_class ARRAY<STRING>,
  pseudo_element ARRAY<STRING>
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
    }).map(([name, value]) => name);
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
  return null;
}
''';

SELECT
  client,
  COUNTIF(num_focus_visible > 0) AS has_focus_visible,
  COUNT(0) AS total,
  COUNTIF(num_focus_visible > 0) / COUNT(0) AS pct_pages_focus_visible
FROM (
  SELECT
    client,
    page,
    COUNTIF(pseudo_class = 'focus-visible') AS num_focus_visible
  FROM
    `httparchive.almanac.parsed_css`
  LEFT JOIN
    UNNEST(getSelectorParts(css).pseudo_class) AS pseudo_class
  WHERE
    date = '2022-07-01' AND -- noqa: CV09
    # Limit the size of the CSS to avoid OOM crashes.
    LENGTH(css) < 0.1 * 1024 * 1024
  GROUP BY
    client,
    page
)
GROUP BY
  client
