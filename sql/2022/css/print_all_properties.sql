CREATE TEMP FUNCTION getPrintStylesheets(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS r'''
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return almanac['link-nodes'].nodes.filter(link => {
    return link.rel == 'stylesheet' && link.media == 'print';
  }).map(link => {
    return link.href;
  });
} catch (e) {
  return [];
}
''';

CREATE TEMPORARY FUNCTION getProperties(css STRING)
RETURNS ARRAY<STRING>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  function compute(ast) {
    let ret = {};

    walkDeclarations(ast, ({property, value}) => {
      if (!property.startsWith("--")) { // Custom props are case sensitive
        property = property.toLowerCase();
      }

      incrementByKey(ret, property);
    });

    return sortObject(ret);
  }

  let ast = JSON.parse(css);
  let props = compute(ast);
  return Object.entries(props).flatMap(([prop, freq]) => {
    return Array(freq).fill(prop);
  });
}
catch (e) {
  return [];
}
''';

WITH print_stylesheets AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    css_url AS url
  FROM
    `httparchive.pages.2022_07_01_*`, -- noqa: CV09
    UNNEST(getPrintStylesheets(payload)) AS css_url
),

totals AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total_pages
  FROM
    print_stylesheets
  GROUP BY
    client
)

SELECT
  *
FROM (
  SELECT
    client,
    prop,
    COUNT(DISTINCT page) AS pages,
    ANY_VALUE(total_pages) AS total_pages,
    COUNT(DISTINCT page) / ANY_VALUE(total_pages) AS pct_pages,
    COUNT(0) AS freq,
    SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
    COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getProperties(css)) AS prop
  JOIN
    totals
  USING (client)
  JOIN
    print_stylesheets
  USING (client, page, url)
  WHERE
    date = '2022-07-01' -- noqa: CV09
  GROUP BY
    client,
    prop
)
WHERE
  pages >= 1000
ORDER BY
  pct DESC
