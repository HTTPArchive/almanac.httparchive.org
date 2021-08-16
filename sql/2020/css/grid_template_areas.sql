#standardSQL
CREATE TEMPORARY FUNCTION hasGridTemplateAreas(css STRING)
RETURNS BOOLEAN
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  function compute(ast) {
    let ret = {};

    walkDeclarations(ast, ({property, value}) => {
      for (let area of value.matchAll(/(['"])(?<names>[-\\w\\s.]+?)\\1/g)) {
        let names = area.groups.names.split(/\\s+/);

        for (let name of names) {
          incrementByKey(ret, name);
        }
      }
    }, {
      properties: /^grid(-template(-areas)?)?$/
    });

    return sortObject(ret);
  }

  const ast = JSON.parse(css);
  return Object.keys(compute(ast)).length > 0;
} catch (e) {
  return false;
}
''';

SELECT
  client,
  COUNTIF(grid_template_areas) AS pages_with_grid_template_areas,
  total,
  COUNTIF(grid_template_areas) / total AS pct
FROM (
  SELECT
    client,
    page,
    COUNTIF(hasGridTemplateAreas(css)) > 0 AS grid_template_areas
  FROM
    `httparchive.almanac.parsed_css`
  WHERE
    date = '2020-08-01'
  GROUP BY
    client,
    page)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2020_08_01_*`
  GROUP BY
    client)
USING
  (client)
GROUP BY
  client,
  total
