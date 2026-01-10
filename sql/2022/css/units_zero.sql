#standardSQL
CREATE TEMPORARY FUNCTION getZeroUnits(css STRING)
RETURNS ARRAY<STRUCT<unit STRING, freq INT64>>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  function compute(ast) {
    let ret = {
      zeroes: {},
      by_property: {}
    };

    const lengths = /(?<![-#\\w])\\b(?<number>-?\\d*\\.?\\d+)(?<unit>%|[a-z]{1,4}\\b|(?=\\s|$|,|\\*|\\/)\\b)/gi;

    walkDeclarations(ast, ({property, value}) => {
      // Remove color functions to avoid mucking results
      value = removeFunctionCalls(value, {names: ["rgb", "rgba", "hsl", "hsla"]});

      for (let length of value.matchAll(lengths)) {
        let {number, unit} = length.groups;
        ret.by_property[property] = ret.by_property[property] || {};

        if (number === "0") {
          incrementByKey(ret.zeroes, unit || "<number>");
        }

        if (unit) {
          incrementByKey(ret, unit);
          incrementByKey(ret.by_property[property], unit);
        }
        else {
          incrementByKey(ret, "<number>");
          incrementByKey(ret.by_property[property], "<number>");
        }

        incrementByKey(ret, "total"); // for calculating %
        incrementByKey(ret.by_property[property], "total"); // for calculating %
      }
    }, {
      // Properties that take one or more lengths
      // We avoid shorthands because they're a mess to parse
      // This helped: https://codepen.io/leaverou/pen/rNergbW?editors=0010
      properties: [
        "baseline-shift",
        "box-shadow",
        "vertical-align",
        "clip-path",
        /^column[s-]|^inset\b/g,
        "contain-intrinsic-size",
        "cx",
        "cy",
        "flex-basis",
        "letter-spacing",
        "perspective",
        "perspective-origin",
        "r",
        "row-gap",
        "rx",
        "ry",
        "tab-size",
        "text-indent",
        "text-shadow",
        "translate",
        "vertical-align",
        "word-spacing",
        "x",
        "y",
        /\\b(?:width|height|thickness|offset|origin|padding|border|margin|outline|top|right|bottom|left|(inline|block)-(start|end)|gap|size|position)\\b/g
      ],
      not: {
        // Drop prefixed properties and custom properties
        properties: /^-|-color$/
      }
    });

    ret = sortObject(ret);

    for (let property in ret.by_property) {
      ret.by_property[property] = sortObject(ret.by_property[property]);
    }

    return ret;
  }
  var ast = JSON.parse(css);
  var units = compute(ast);
  return Object.entries(units.zeroes).map(([unit, freq]) => {
    return {unit, freq}
  });
} catch (e) {
  return [];
}
''';

SELECT
  *
FROM (
  SELECT
    client,
    unit.unit,
    CASE
      WHEN unit.unit = '<number>' THEN 'Unitless 0'
      WHEN unit.unit = 'px' THEN 'px'
      ELSE 'other'
    END AS type,
    COUNT(DISTINCT page) AS pages,
    SUM(unit.freq) AS freq,
    SUM(SUM(unit.freq)) OVER (PARTITION BY client) AS total,
    SUM(unit.freq) / SUM(SUM(unit.freq)) OVER (PARTITION BY client) AS pct
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getZeroUnits(css)) AS unit
  WHERE
    date = '2022-07-01' AND -- noqa: CV09
    # Limit the size of the CSS to avoid OOM crashes.
    LENGTH(css) < 0.1 * 1024 * 1024
  GROUP BY
    client,
    unit
)
WHERE
  freq >= 1000
ORDER BY
  pct DESC
