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

WITH afters AS (
  SELECT DISTINCT
    client,
    page
  FROM
    `httparchive.almanac.parsed_css`
  LEFT JOIN
    UNNEST(getSelectorParts(css).pseudo_class) AS pseudo_class
  WHERE
    date = '2022-07-01' AND -- noqa: CV09
    # Limit the size of the CSS to avoid OOM crashes.
    LENGTH(css) < 0.1 * 1024 * 1024 AND
    pseudo_class = 'after'
),

totals AS (
  SELECT
    client,
    COUNT(0) AS total_pages
  FROM
    afters
  GROUP BY
    client
),

technologies AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    ARRAY_TO_STRING(ARRAY_AGG(category ORDER BY category), ', ') AS categories,
    app
  FROM
    `httparchive.technologies.2022_07_01_*` -- noqa: CV09
  GROUP BY
    client,
    page,
    app
)

SELECT
  client,
  ANY_VALUE(categories) AS categories,
  app,
  COUNT(0) AS pages,
  ANY_VALUE(total_pages) AS total,
  COUNT(0) / ANY_VALUE(total_pages) AS pct
FROM
  totals
JOIN
  afters
USING (client)
JOIN
  technologies
USING (client, page)
GROUP BY
  client,
  app
ORDER BY
  pct DESC
