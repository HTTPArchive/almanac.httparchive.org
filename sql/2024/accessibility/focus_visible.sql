#standardSQL

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

WITH focus_visible_data AS (
  -- Extracting pages that use :focus-visible pseudo-class
  SELECT
    client,
    page,
    COUNTIF(pseudo_class = 'focus-visible') > 0 AS has_focus_visible
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getSelectorParts(css).pseudo_class) AS pseudo_class
  WHERE
    date = '2022-06-01' AND
    LENGTH(css) < 0.1 * 1024 * 1024  -- Limit the size of the CSS to avoid OOM crashes
  GROUP BY
    client, page
),

total_pages_data AS (
  -- Calculating the total number of pages per client
  SELECT
    client,
    COUNT(0) AS total_pages
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2022-06-01'
  GROUP BY
    client
)

SELECT
  f.client,
  COUNTIF(f.has_focus_visible) AS pages_focus_visible,
  tp.total_pages,
  COUNTIF(f.has_focus_visible) / tp.total_pages AS pct_pages_focus_visible
FROM
  focus_visible_data AS f
JOIN
  total_pages_data AS tp
ON
  f.client = tp.client
GROUP BY
  f.client, tp.total_pages
ORDER BY
  pct_pages_focus_visible DESC;
