#standardSQL
CREATE TEMPORARY FUNCTION hasUnitlessZero(css STRING) RETURNS BOOLEAN LANGUAGE js AS '''
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
  return units.zeroes['<number>'] > 0;
} catch (e) {
  return false;
}
'''
OPTIONS (library="gs://httparchive/lib/css-utils.js");

SELECT
  client,
  COUNT(DISTINCT IF(has_unitless_zero, page, NULL)) AS pages,
  COUNT(DISTINCT page) AS total,
  COUNT(DISTINCT IF(has_unitless_zero, page, NULL)) / COUNT(DISTINCT page) AS pct
FROM (
  SELECT
    client,
    page,
    hasUnitlessZero(css) AS has_unitless_zero
  FROM
    `httparchive.almanac.parsed_css`
  WHERE
    date = '2020-08-01' AND
    # Limit the size of the CSS to avoid OOM crashes.
    LENGTH(css) < 0.1 * 1024 * 1024)
GROUP BY
  client