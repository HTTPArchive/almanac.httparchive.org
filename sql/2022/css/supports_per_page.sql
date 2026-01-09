#standardSQL
CREATE TEMPORARY FUNCTION getSupports(css STRING)
RETURNS INT64
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  function compute(ast) {
    let ret = {};

    walkRules(ast, rule => {
      incrementByKey(ret, "total");

      let condition = rule.supports;

      // Drop whitespace around parens
      condition = condition.replace(/\\s*\\(\\s*/g, "(").replace(/\\s*\\)\\s*/g, ")");

      // Match property: value queries first
      for (let match of condition.matchAll(/\\([\\w-]+\\s*:/g)) {
        let arg = parsel.gobbleParens(condition, match.index);
        incrementByKey(ret, arg);
      }

      // Then find selector queries
      for (let match of condition.matchAll(/selector\\(/gi)) {
        let arg = parsel.gobbleParens(condition, match.index + match[0].length - 1);
        incrementByKey(ret, "selector" + arg);
      }
    }, {type: "supports"});

    ret = sortObject(ret);

    return ret;
  }

  const ast = JSON.parse(css);
  let supports = compute(ast);
  return supports.total || 0;
} catch (e) {
  return 0;
}
''';

WITH supports AS (
  SELECT
    client,
    SUM(getSupports(css)) AS supports_per_page
  FROM
    `httparchive.almanac.parsed_css`
  WHERE
    date = '2022-07-01' -- noqa: CV09
  GROUP BY
    client,
    page
)

SELECT
  percentile,
  client,
  APPROX_QUANTILES(supports_per_page, 1000)[OFFSET(percentile * 10)] AS supports_per_page
FROM
  supports,
  UNNEST([10, 25, 50, 75, 90, 95, 99, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
