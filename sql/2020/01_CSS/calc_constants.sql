#standardSQL
CREATE TEMPORARY FUNCTION getCalcConstants(css STRING) RETURNS
ARRAY<STRING> LANGUAGE js AS '''
try {
  function compute(ast) {
    let ret = {
      total: 0,
      properties: {},
      units: {},
      number_of_different_units: {},
      operators: {},
      number_of_operators: {},
      number_of_parens: {},
      constants: new Set()
    };

    walkDeclarations(ast, ({property, value}) => {
      for (let calc of extractFunctionCalls(value, {names: "calc"})) {
        incrementByKey(ret.properties, property);
        ret.total++;

        let args = calc.args.replace(/calc\\(/g, "(");

        let units = args.match(/[a-z]+|%/g) || [];
        units.forEach(e => incrementByKey(ret.units, e));
        incrementByKey(ret.number_of_different_units, new Set(units).size);

        let ops = args.match(/[-+\\/*]/g) || [];
        ops.forEach(e => incrementByKey(ret.operators, e));
        incrementByKey(ret.number_of_operators, ops.length);

        let parens = args.match(/\\(/g) || [];
        incrementByKey(ret.number_of_parens, parens.length);

        if (units.length === 0) {
          ret.constants.add(args);
        }
      }
    }, {
      values: /calc\\(/,
      not: {
        values: /var\\(--/
      }
    });

    ret.constants = [...ret.constants];

    for (let type in ret) {
      if (ret[type].constructor === Object) {
        ret[type] = sortObject(ret[type]);
      }
    }

    return ret;
  }
  var ast = JSON.parse(css);
  var calc = compute(ast);
  return calc.constants;
} catch (e) {
  return [];
}
'''
OPTIONS (library="gs://httparchive/lib/css-utils.js");

SELECT
  client,
  const,
  COUNT(DISTINCT page) AS pages,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    page,
    const
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getCalcConstants(css)) AS const
  WHERE
    date = '2020-08-01' AND
    # Limit the size of the CSS to avoid OOM crashes.
    LENGTH(css) < 0.1 * 1024 * 1024)
GROUP BY
  client,
  const
ORDER BY
  pct DESC
LIMIT
  200