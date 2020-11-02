#standardSQL
# Float styles
CREATE TEMPORARY FUNCTION getLayoutUsage(css STRING)
RETURNS ARRAY<STRUCT<name STRING, value INT64>> LANGUAGE js AS '''
try {
  const ast = JSON.parse(css);
  let ret = {};

  walkDeclarations(ast, ({property, value}) => {
    let key = value;

    if (property === "float") {
      key = "floats";
    }
    else if (/^table(-|$)/.test(value)) {
      key = "css-tables";
    }

    incrementByKey(ret, key);
  }, {
    properties: ["display", "position", "float"],
    not: {
      values: [
        "inherit", "initial", "unset", "revert",
        /\\bvar\\(--/,
        "static", "relative", "none"
      ]
    }
  });

  ret = sortObject(ret);

  return Object.entries(ret).map(([name, value]) => ({name, value}));
} catch (e) {
  return [];
}
'''
OPTIONS (library="gs://httparchive/lib/css-utils.js");

SELECT
  client,
  layout,
  COUNT(DISTINCT page) AS pages,
  SUM(value) AS freq,
  SUM(SUM(value)) OVER (PARTITION BY client) AS total,
  SUM(value) / SUM(SUM(value)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    page,
    layout.name AS layout,
    layout.value
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getLayoutUsage(css)) AS layout
  WHERE
    date = '2020-08-01')
GROUP BY
  client,
  layout
HAVING
  pages >= 100
ORDER BY
  pct DESC