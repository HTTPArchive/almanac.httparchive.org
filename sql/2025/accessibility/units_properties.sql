#standardSQL
# Web Almanac — CSS property–unit frequencies (2025 parsed_css)
#
# Purpose
#   Parse CSS ASTs and count unit usage by property, per client (desktop/mobile).
#   Then report unit shares for properties with sufficient volume.
#
# Data
#   Table: httparchive.crawl.parsed_css
#   Date:  2025-07-01
#   Field: css (JSON-typed AST) — must be stringified before passing to the UDF.
#
# Output columns
#   client   — "desktop" | "mobile"
#   property — CSS property name (e.g., width, margin-top)
#   unit     — unit token detected ("px", "em", "%", "<number>", etc.)
#   freq     — total occurrences for this property+unit
#   total    — total occurrences for this property (all units)
#   pct      — freq / total (0..1)
#
# Notes
#   • UDF input type is STRING → use TO_JSON_STRING(pc.css).
#   • Size guard uses BYTE_LENGTH on the stringified JSON.
#   • Partition filter on pc.date is required for cost.
#   • The regex inside the UDF excludes function args like rgb()/hsl().
#   • Post-filter keeps rows where property volume ≥ 1000 and unit share ≥ 1%.

CREATE TEMPORARY FUNCTION getPropertyUnits(css STRING)
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
        /^column[s-]|^inset\\b/g,
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
  var ast = JSON.parse(css);
  var units = compute(ast);
  return Object.entries(units.by_property).flatMap(([property, units]) => {
    return Object.entries(units).filter(([unit]) => unit != 'total').map(([unit, freq]) => {
      return {property, unit, freq};
    });
  });
} catch (e) {
  return [];
}
''';

WITH property_units_data AS (
  SELECT
    pc.client,
    unit.property,
    unit.unit,
    unit.freq
  FROM `httparchive.crawl.parsed_css` AS pc
  -- TABLESAMPLE SYSTEM (0.1 PERCENT)  -- enable for cheap tests only
  CROSS JOIN UNNEST(getPropertyUnits(TO_JSON_STRING(pc.css))) AS unit
  WHERE
    pc.date = DATE '2025-07-01' AND
    BYTE_LENGTH(TO_JSON_STRING(pc.css)) < 0.1 * 1024 * 1024  -- ~100 KiB guard
),

aggregated_data AS (
  SELECT
    client,
    property,
    unit,
    SUM(freq) AS freq,
    SUM(SUM(freq)) OVER (PARTITION BY client, property) AS total,
    SAFE_DIVIDE(SUM(freq), SUM(SUM(freq)) OVER (PARTITION BY client, property)) AS pct
  FROM property_units_data
  GROUP BY client, property, unit
)

SELECT
  client,
  property,
  unit,
  freq,
  total,
  pct
FROM aggregated_data
WHERE total >= 1000 AND pct >= 0.01
ORDER BY total DESC, pct DESC;
