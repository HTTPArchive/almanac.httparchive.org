#standardSQL
CREATE TEMPORARY FUNCTION getPropertyUnits(css STRING) RETURNS
ARRAY<STRUCT<property STRING, unit STRING, freq INT64>> LANGUAGE js AS '''
try {
  function compute(ast) {
    let ret = {
      by_property: {}
    };

    const lengths = /(?<!-)\\b(?<number>-?\\d*\\.?\\d+)(?<unit>%|[a-z]{1,4}\\b|(?=\\s|$|,|\\*|\\/)\\b)/gi;

    walkDeclarations(ast, ({property, value}) => {
      for (let length of value.matchAll(lengths)) {
        let {number, unit} = length.groups;
        ret.by_property[property] = ret.by_property[property] || {};

        if (unit) {
          incrementByKey(ret, unit);
          incrementByKey(ret.by_property[property], unit);
        }
        else {
          if (number === "0") {
            // Unitless 0
            incrementByKey(ret, "0");
            incrementByKey(ret.by_property[property], "0");
          }
          else {
            incrementByKey(ret, "<number>");
            incrementByKey(ret.by_property[property], "<number>");
          }
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
        "vertical-align",
        /^column[s-]|^inset\\b/g,
        "contain-intrinsic-size",
        "cx",
        "cy",
        "flex",
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
        "translate",
        "vertical-align",
        "word-spacing",
        "x",
        "y",
        /\\b(?:width|height|thickness|offset|origin|padding|border|margin|outline|top|right|bottom|left|(inline|block)-(start|end)|gap|size|position)\\b/g
      ],
      not: {
        // Drop prefixed properties and custom properties
        properties: /^-/
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
  return Object.entries(units.by_property).flatMap(([property, units]) => {
    return Object.entries(units).filter(([unit]) => {
      return unit != 'total';
    }).map(([unit, freq]) => {
      return {property, unit, freq};
    });
  });
} catch (e) {
  return [];
}
'''
OPTIONS (library="gs://httparchive/lib/css-utils.js");

SELECT
  client,
  unit,
  property,
  SUM(freq) AS freq,
  SUM(SUM(freq)) OVER (PARTITION BY client, unit) AS total,
  SUM(freq) / SUM(SUM(freq)) OVER (PARTITION BY client, unit) AS pct
FROM (
  SELECT
    client,
    unit.property,
    unit.unit,
    unit.freq
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getPropertyUnits(css)) AS unit
  WHERE
    date = '2020-08-01' AND
    # Limit the size of the CSS to avoid OOM crashes.
    LENGTH(css) < 0.1 * 1024 * 1024)
GROUP BY
  client,
  unit,
  property
HAVING
  pct >= 0.01
ORDER BY
  client,
  unit,
  pct DESC