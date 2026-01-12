#standardSQL
CREATE TEMPORARY FUNCTION getShorthandFirstProperties(css STRING)
RETURNS
ARRAY<STRUCT<property STRING, freq INT64>>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  function compute(ast) {
    let ret = {
      shorthands: {},
      longhands: {},
      longhands_before_shorthands: {},
      shorthands_before_longhands: {},
      values: {}
    };

    const shorthands = {
      "animation": [
        "animation-duration",
        "animation-timing-function",
        "animation-delay",
        "animation-iteration-count",
        "animation-direction",
        "animation-fill-mode",
        "animation-play-state",
        "animation-name"
      ],
      "background": [
        "background-image",
        "background-position-x",
        "background-position-y",
        "background-size",
        "background-repeat-x",
        "background-repeat-y",
        "background-attachment",
        "background-origin",
        "background-clip",
        "background-color"
      ],
      "background-position": [
        "background-position-x",
        "background-position-y"
      ],
      "background-repeat": [
        "background-repeat-x",
        "background-repeat-y"
      ],
      "border": [
        "border-top-color",
        "border-top-style",
        "border-top-width",
        "border-right-color",
        "border-right-style",
        "border-right-width",
        "border-bottom-color",
        "border-bottom-style",
        "border-bottom-width",
        "border-left-color",
        "border-left-style",
        "border-left-width",
        "border-image-source",
        "border-image-slice",
        "border-image-width",
        "border-image-outset",
        "border-image-repeat"
      ],
      "border-block": [
        "border-block-start-color",
        "border-block-start-style",
        "border-block-start-width",
        "border-block-end-color",
        "border-block-end-style",
        "border-block-end-width"
      ],
      "border-block-color": [
        "border-block-start-color",
        "border-block-end-color"
      ],
      "border-block-end": [
        "border-block-end-width",
        "border-block-end-style",
        "border-block-end-color"
      ],
      "border-block-start": [
        "border-block-start-width",
        "border-block-start-style",
        "border-block-start-color"
      ],
      "border-block-style": [
        "border-block-start-style",
        "border-block-end-style"
      ],
      "border-block-width": [
        "border-block-start-width",
        "border-block-end-width"
      ],
      "border-bottom": [
        "border-bottom-width",
        "border-bottom-style",
        "border-bottom-color"
      ],
      "border-color": [
        "border-top-color",
        "border-right-color",
        "border-bottom-color",
        "border-left-color"
      ],
      "border-image": [
        "border-image-source",
        "border-image-slice",
        "border-image-width",
        "border-image-outset",
        "border-image-repeat"
      ],
      "border-inline": [
        "border-inline-start-color",
        "border-inline-start-style",
        "border-inline-start-width",
        "border-inline-end-color",
        "border-inline-end-style",
        "border-inline-end-width"
      ],
      "border-inline-color": [
        "border-inline-start-color",
        "border-inline-end-color"
      ],
      "border-inline-end": [
        "border-inline-end-width",
        "border-inline-end-style",
        "border-inline-end-color"
      ],
      "border-inline-start": [
        "border-inline-start-width",
        "border-inline-start-style",
        "border-inline-start-color"
      ],
      "border-inline-style": [
        "border-inline-start-style",
        "border-inline-end-style"
      ],
      "border-inline-width": [
        "border-inline-start-width",
        "border-inline-end-width"
      ],
      "border-left": [
        "border-left-width",
        "border-left-style",
        "border-left-color"
      ],
      "border-radius": [
        "border-top-left-radius",
        "border-top-right-radius",
        "border-bottom-right-radius",
        "border-bottom-left-radius"
      ],
      "border-right": [
        "border-right-width",
        "border-right-style",
        "border-right-color"
      ],
      "border-style": [
        "border-top-style",
        "border-right-style",
        "border-bottom-style",
        "border-left-style"
      ],
      "border-top": [
        "border-top-width",
        "border-top-style",
        "border-top-color"
      ],
      "border-width": [
        "border-top-width",
        "border-right-width",
        "border-bottom-width",
        "border-left-width"
      ],
      "column-rule": [
        "column-rule-width",
        "column-rule-style",
        "column-rule-color"
      ],
      "columns": [
        "column-width",
        "column-count"
      ],
      "flex": [
        "flex-grow",
        "flex-shrink",
        "flex-basis"
      ],
      "flex-flow": [
        "flex-direction",
        "flex-wrap"
      ],
      "font": [
        "font-style",
        "font-variant-ligatures",
        "font-variant-caps",
        "font-variant-numeric",
        "font-variant-east-asian",
        "font-weight",
        "font-stretch",
        "font-size",
        "line-height",
        "font-family"
      ],
      "font-variant": [
        "font-variant-ligatures",
        "font-variant-caps",
        "font-variant-numeric",
        "font-variant-east-asian"
      ],
      "gap": [
        "row-gap",
        "column-gap"
      ],
      "grid": [
        "grid-template-rows",
        "grid-template-columns",
        "grid-template-areas",
        "grid-auto-flow",
        "grid-auto-rows",
        "grid-auto-columns"
      ],
      "grid-area": [
        "grid-row-start",
        "grid-column-start",
        "grid-row-end",
        "grid-column-end"
      ],
      "grid-column": [
        "grid-column-start",
        "grid-column-end"
      ],
      "grid-gap": [
        "row-gap",
        "column-gap"
      ],
      "grid-row": [
        "grid-row-start",
        "grid-row-end"
      ],
      "grid-template": [
        "grid-template-rows",
        "grid-template-columns",
        "grid-template-areas"
      ],
      "inset": [
        "top",
        "right",
        "bottom",
        "left"
      ],
      "inset-block": [
        "inset-block-start",
        "inset-block-end"
      ],
      "inset-inline": [
        "inset-inline-start",
        "inset-inline-end"
      ],
      "list-style": [
        "list-style-position",
        "list-style-image",
        "list-style-type"
      ],
      "margin": [
        "margin-top",
        "margin-right",
        "margin-bottom",
        "margin-left"
      ],
      "margin-block": [
        "margin-block-start",
        "margin-block-end"
      ],
      "margin-inline": [
        "margin-inline-start",
        "margin-inline-end"
      ],
      "marker": [
        "marker-start",
        "marker-mid",
        "marker-end"
      ],
      "offset": [
        "offset-position",
        "offset-path",
        "offset-distance",
        "offset-rotate",
        "offset-anchor"
      ],
      "outline": [
        "outline-color",
        "outline-style",
        "outline-width"
      ],
      "overflow": [
        "overflow-x",
        "overflow-y"
      ],
      "overscroll-behavior": [
        "overscroll-behavior-x",
        "overscroll-behavior-y"
      ],
      "padding": [
        "padding-top",
        "padding-right",
        "padding-bottom",
        "padding-left"
      ],
      "padding-block": [
        "padding-block-start",
        "padding-block-end"
      ],
      "padding-inline": [
        "padding-inline-start",
        "padding-inline-end"
      ],
      "place-content": [
        "align-content",
        "justify-content"
      ],
      "place-items": [
        "align-items",
        "justify-items"
      ],
      "place-self": [
        "align-self",
        "justify-self"
      ],
      "scroll-margin": [
        "scroll-margin-top",
        "scroll-margin-right",
        "scroll-margin-bottom",
        "scroll-margin-left"
      ],
      "scroll-margin-block": [
        "scroll-margin-block-start",
        "scroll-margin-block-end"
      ],
      "scroll-margin-inline": [
        "scroll-margin-inline-start",
        "scroll-margin-inline-end"
      ],
      "scroll-padding": [
        "scroll-padding-top",
        "scroll-padding-right",
        "scroll-padding-bottom",
        "scroll-padding-left"
      ],
      "scroll-padding-block": [
        "scroll-padding-block-start",
        "scroll-padding-block-end"
      ],
      "scroll-padding-inline": [
        "scroll-padding-inline-start",
        "scroll-padding-inline-end"
      ],
      "text-decoration": [
        "text-decoration-line",
        "text-decoration-style",
        "text-decoration-color"
      ],
      "transition": [
        "transition-property",
        "transition-duration",
        "transition-timing-function",
        "transition-delay"
      ]
    };

    let longhands = {};
    for (let shorthand in shorthands) {
      for (let longhand of shorthands[shorthand]) {
        longhands[longhand] = longhands[longhand] || new Set();
        longhands[longhand].add(shorthand);
      }

      shorthands[shorthand] = new Set(shorthands[shorthand]);
    }

    walkRules(ast, rule => {
      let seen = new Set();

      for (let d of rule.declarations) {
        let {property, value} = d;

        if (property in shorthands) {
          incrementByKey(ret.shorthands, property);

          // Have we seen any of its longhands in this rule?
          let seenLonghands = [...shorthands[property]].filter(p => seen.has(p));
          if (seenLonghands.length > 0) {
            incrementByKey(ret.longhands_before_shorthands, property);
          }

          // If value is simple enough (no functions, strings, repetitions etc), count number of values
          if (!matches(value, [/[("',]/, "inherit", "initial", "unset", "revert"])) {
            let count = value.split(/\\s+|\\s*\\/\\s*/).length;
            ret.values[property] = ret.values[property] || {};
            incrementByKey(ret.values[property], count);
          }

          seen.add(property);
        }

        if (property in longhands) {
          incrementByKey(ret.longhands, property);

          // Have we seen any of its shorthands in this rule?
          let seenLonghands = [...longhands[property]].filter(p => seen.has(p));
          if (seenLonghands.length > 0) {
            incrementByKey(ret.shorthands_before_longhands, property);
          }

          seen.add(property);
        }
      }
    }, {type: "rule"});

    for (let key in ret) {
      if (key !== "values") {
        ret[key].total = sumObject(ret[key]);
      }

      ret[key] = sortObject(ret[key]);
    }

    return ret;
  }

  var ast = JSON.parse(css);
  var props = compute(ast);

  return Object.entries(props.shorthands_before_longhands).filter(([property]) => {
    return property != 'total';
  }).map(([property, freq]) => {
    return {property, freq};
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
  property,
  COUNT(DISTINCT page) AS pages,
  ANY_VALUE(total_pages) AS total_pages,
  COUNT(DISTINCT page) / ANY_VALUE(total_pages) AS pct_pages,
  SUM(freq) AS freq,
  SUM(SUM(freq)) OVER (PARTITION BY client) AS total,
  SUM(freq) / SUM(SUM(freq)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    page,
    property.property,
    property.freq
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getShorthandFirstProperties(css)) AS property
  WHERE
    date = '2022-07-01' -- noqa: CV09
)
JOIN
  totals
USING (client)
GROUP BY
  client,
  property
ORDER BY
  pct DESC
LIMIT 500
