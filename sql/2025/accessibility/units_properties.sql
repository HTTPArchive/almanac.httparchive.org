#standardSQL
# Web Almanac — CSS property–unit frequencies (2025 parsed_css)
# Adds 2024-style `property_normalized` while preserving your totals/pcts.

CREATE TEMPORARY FUNCTION getPropertyUnits(css STRING)
RETURNS ARRAY<STRUCT<property STRING, unit STRING, freq INT64>>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  function compute(ast) {
    let ret = { zeroes: {}, by_property: {} };
    const lengths = /(?<![-#\\w])\\b(?<number>-?\\d*\\.?\\d+)(?<unit>%|[a-z]{1,4}\\b|(?=\\s|$|,|\\*|\\/)\\b)/gi;

    walkDeclarations(ast, ({property, value}) => {
      value = removeFunctionCalls(value, {names: ["rgb", "rgba", "hsl", "hsla"]});
      for (let length of value.matchAll(lengths)) {
        let {number, unit} = length.groups;
        ret.by_property[property] = ret.by_property[property] || {};
        if (number === "0") incrementByKey(ret.zeroes, unit || "<number>");
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
        "baseline-shift","box-shadow","vertical-align","clip-path",
        /^column[s-]|^inset\\b/g,
        "contain-intrinsic-size","cx","cy","flex-basis","letter-spacing",
        "perspective","perspective-origin","r","row-gap","rx","ry",
        "tab-size","text-indent","text-shadow","translate","vertical-align",
        "word-spacing","x","y",
        /\\b(?:width|height|thickness|offset|origin|padding|border|margin|outline|top|right|bottom|left|(inline|block)-(start|end)|gap|size|position)\\b/g
      ],
      not: { properties: /^-|-color$/ }
    });

    ret = sortObject(ret);
    for (let property in ret.by_property) ret.by_property[property] = sortObject(ret.by_property[property]);

    return ret;
  }
  const ast = JSON.parse(css);
  const units = compute(ast);
  return Object.entries(units.by_property)
    .flatMap(([property, units]) =>
      Object.entries(units)
        .filter(([unit]) => unit != 'total')
        .map(([unit, freq]) => ({property, unit, freq}))
    );
} catch (e) { return []; }
''';

WITH property_units_data AS (
  SELECT
    pc.client,
    u.property,
    u.unit,
    u.freq
  FROM `httparchive.crawl.parsed_css` AS pc
  -- TABLESAMPLE SYSTEM (0.1 PERCENT)  -- enable for cheap tests only
  CROSS JOIN UNNEST(getPropertyUnits(TO_JSON_STRING(pc.css))) AS u
  WHERE
    pc.date = DATE '2025-07-01'
    AND BYTE_LENGTH(TO_JSON_STRING(pc.css)) < 0.1 * 1024 * 1024  -- ~100 KiB guard
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
),

-- Add 2024-style normalization without changing totals
with_norm AS (
  SELECT
    client,
    property,
    unit,
    freq,
    total,
    pct,
    CASE
      -- Families
      WHEN REGEXP_CONTAINS(property, r'(^|-)padding($|-)') THEN 'padding'
      WHEN REGEXP_CONTAINS(property, r'(^|-)margin($|-)') THEN 'margin'
      WHEN REGEXP_CONTAINS(property, r'^border') THEN 'border'
      WHEN REGEXP_CONTAINS(property, r'(^|-)gap($|-)') THEN 'gap'
      WHEN REGEXP_CONTAINS(property, r'(^|-)inset($|-)') THEN 'inset'
      WHEN REGEXP_CONTAINS(property, r'(^|-)outline($|-)') THEN 'outline'
      -- Singles we want to preserve verbatim
      WHEN property IN ('width','height','flex-basis','row-gap','column-gap','letter-spacing','word-spacing','text-indent','tab-size') THEN property
      -- Fallback: keep original
      ELSE property
    END AS property_normalized
  FROM aggregated_data
)

SELECT
  client,
  property,
  unit,
  freq,
  total,
  pct,
  property_normalized
FROM with_norm
WHERE total >= 1000 AND pct >= 0.01
ORDER BY total DESC, pct DESC;
