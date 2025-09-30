#standardSQL

CREATE TEMPORARY FUNCTION getPropertyUnits(css JSON)
RETURNS ARRAY<STRUCT<property STRING, unit STRING, freq INT64>>
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
        } else {
          incrementByKey(ret, "<number>");
          incrementByKey(ret.by_property[property], "<number>");
        }

        incrementByKey(ret, "total");
        incrementByKey(ret.by_property[property], "total");
      }
    }, {
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
        properties: /^-|-color$/
      }
    });

    ret = sortObject(ret);

    for (let property in ret.by_property) {
      ret.by_property[property] = sortObject(ret.by_property[property]);
    }

    return ret;
  }
  var units = compute(css);
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
''';

WITH property_units_data AS (
  -- Extracting property units data from CSS
  SELECT
    client,
    unit.property,
    unit.unit,
    unit.freq
  FROM
    `httparchive.crawl.parsed_css`,
    UNNEST(getPropertyUnits(css)) AS unit
  WHERE
    date = '2025-07-01' AND
    LENGTH(TO_JSON_STRING(css)) < 0.1 * 1024 * 1024  -- Limit the size of the CSS to avoid OOM crashes
),

aggregated_data AS (
  -- Aggregating frequency data per client and property
  SELECT
    client,
    property,
    unit,
    SUM(freq) AS freq,
    SUM(SUM(freq)) OVER (PARTITION BY client, property) AS total,
    SAFE_DIVIDE(SUM(freq), SUM(SUM(freq)) OVER (PARTITION BY client, property)) AS pct
  FROM
    property_units_data
  GROUP BY
    client, property, unit
)

SELECT
  client,
  property,
  unit,
  freq,
  total,
  pct
FROM
  aggregated_data
WHERE
  total >= 1000 AND
  pct >= 0.01
ORDER BY
  total DESC,
  pct DESC;
