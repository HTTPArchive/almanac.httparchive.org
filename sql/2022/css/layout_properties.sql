#standardSQL
# Float styles
CREATE TEMPORARY FUNCTION getLayoutUsage(css STRING)
RETURNS ARRAY<STRUCT<name STRING, value INT64>>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  const ast = JSON.parse(css);
  let ret = {};

  walkDeclarations(ast, ({property, value}) => {
    let key;

    if (property === "float") {
      key = "floats";
    }
    else if (/^table(-|$)/.test(value)) {
      key = "css-tables";
    }
    else {
      key = value.replace(/-(webkit|moz|o|webkit|khtml)-|!.+$/g, "").toLowerCase();
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
''';

SELECT
  *,
  pages / total_pages AS pct_pages
FROM (
  SELECT
    client,
    layout,
    SUM(value) AS freq,
    SUM(SUM(value)) OVER (PARTITION BY client) AS total,
    SUM(value) / SUM(SUM(value)) OVER (PARTITION BY client) AS pct,
    COUNT(DISTINCT page) AS pages
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
      date = '2022-07-01' -- noqa: CV09
  )
  GROUP BY
    client,
    layout
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_pages
  FROM
    `httparchive.summary_pages.2022_07_01_*` -- noqa: CV09
  GROUP BY
    client
)
USING (client)
WHERE
  pages >= 100
ORDER BY
  pct DESC
