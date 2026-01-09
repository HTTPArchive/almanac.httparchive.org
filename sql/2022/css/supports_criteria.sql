#standardSQL
CREATE TEMPORARY FUNCTION getSupports(css STRING)
RETURNS ARRAY<STRING>
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
  return Object.entries(supports).filter(([criteria]) => {
    return criteria != 'total';
  }).flatMap(([criteria, freq]) => {
    return new Array(freq).fill(criteria);
  });
} catch (e) {
  return [];
}
''';

WITH totals AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_pages
  FROM
    `httparchive.summary_pages.2022_07_01_*` -- noqa: CV09
  GROUP BY
    client
)

SELECT
  client,
  supports,
  COUNT(DISTINCT page) AS pages,
  ANY_VALUE(total_pages) AS total_pages,
  COUNT(DISTINCT page) / ANY_VALUE(total_pages) AS pct_pages,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.almanac.parsed_css`,
  UNNEST(getSupports(css)) AS supports
JOIN
  totals
USING (client)
WHERE
  date = '2022-07-01' -- noqa: CV09
GROUP BY
  client,
  supports
ORDER BY
  pct DESC
LIMIT 300
