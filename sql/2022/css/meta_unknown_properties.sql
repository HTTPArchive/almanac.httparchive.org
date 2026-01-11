#standardSQL
CREATE TEMPORARY FUNCTION getUnknownProperties(css STRING)
RETURNS ARRAY<STRUCT<property STRING, freq INT64>>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  var ast = JSON.parse(css);
  const properties = [
  "align-content", "align-items", "align-self", "alignment-baseline", "all", "animation", "animation-delay", "animation-direction", "animation-duration", "animation-fill-mode", "animation-iteration-count", "animation-name", "animation-play-state", "animation-timing-function", "appearance", "aspect-ratio", "backdrop-filter", "backface-visibility", "background", "background-attachment", "background-blend-mode", "background-clip", "background-color", "background-image", "background-origin", "background-position", "background-position-x", "background-position-y", "background-repeat", "background-repeat-x", "background-repeat-y", "background-size", "baseline-shift", "block-size", "border", "border-block", "border-block-color", "border-block-end", "border-block-end-color", "border-block-end-style", "border-block-end-width", "border-block-start", "border-block-start-color", "border-block-start-style", "border-block-start-width", "border-block-style", "border-block-width", "border-bottom", "border-bottom-color", "border-bottom-left-radius", "border-bottom-right-radius", "border-bottom-style", "border-bottom-width", "border-collapse", "border-color", "border-image", "border-image-outset", "border-image-repeat", "border-image-slice", "border-image-source", "border-image-width", "border-inline", "border-inline-color", "border-inline-end", "border-inline-end-color", "border-inline-end-style", "border-inline-end-width", "border-inline-start", "border-inline-start-color", "border-inline-start-style", "border-inline-start-width", "border-inline-style", "border-inline-width", "border-left", "border-left-color", "border-left-style", "border-left-width", "border-radius", "border-right", "border-right-color", "border-right-style", "border-right-width", "border-spacing", "border-style", "border-top", "border-top-color", "border-top-left-radius", "border-top-right-radius", "border-top-style", "border-top-width", "border-width", "bottom", "box-shadow", "box-sizing",
  "break-after", "break-before", "break-inside", "buffered-rendering", "caption-side", "caret-color", "clear", "clip", "clip-path", "clip-rule", "color", "color-interpolation", "color-interpolation-filters", "color-rendering", "color-scheme", "column-count", "column-fill", "column-gap", "column-rule", "column-rule-color", "column-rule-style", "column-rule-width", "column-span", "column-width", "columns", "contain", "contain-intrinsic-size", "content", "content-visibility", "counter-increment", "counter-reset", "cursor", "cx", "cy", "d", "direction", "display", "dominant-baseline", "empty-cells", "fill", "fill-opacity", "fill-rule", "filter", "flex", "flex-basis", "flex-direction", "flex-flow", "flex-grow", "flex-shrink", "flex-wrap", "float", "flood-color", "flood-opacity", "font", "font-display", "font-family", "font-feature-settings", "font-kerning", "font-optical-sizing", "font-size", "font-size-adjust", "font-stretch", "font-style", "font-variant", "font-variant-caps", "font-variant-east-asian", "font-variant-ligatures", "font-variant-numeric", "font-variation-settings", "font-weight", "gap", "grid", "grid-area", "grid-auto-columns", "grid-auto-flow", "grid-auto-rows", "grid-column", "grid-column-end", "grid-column-gap", "grid-column-start", "grid-gap", "grid-row", "grid-row-end", "grid-row-gap", "grid-row-start", "grid-template", "grid-template-areas", "grid-template-columns", "grid-template-rows", "height", "hyphens", "image-orientation", "image-rendering",
  "inline-size", "inset", "inset-block", "inset-block-end", "inset-block-start", "inset-inline", "inset-inline-end", "inset-inline-start", "isolation", "justify-content", "justify-items", "justify-self", "left", "letter-spacing", "lighting-color", "line-break", "line-height", "line-height-step", "list-style", "list-style-image", "list-style-position", "list-style-type", "margin", "margin-block", "margin-block-end", "margin-block-start", "margin-bottom", "margin-inline", "margin-inline-end", "margin-inline-start", "margin-left", "margin-right", "margin-top", "marker", "marker-end", "marker-mid", "marker-start", "mask", "mask-source-type", "mask-type", "math-style", "math-superscript-shift-style", "max-block-size", "max-height", "max-inline-size", "max-width", "max-zoom", "min-block-size", "min-height", "min-inline-size", "min-width", "min-zoom", "mix-blend-mode", "object-fit", "object-position", "offset", "offset-anchor", "offset-distance", "offset-path", "offset-position",
  "offset-rotate", "opacity", "order", "orientation", "orphans", "outline", "outline-color", "outline-offset", "outline-style", "outline-width", "overflow", "overflow-anchor", "overflow-wrap", "overflow-x", "overflow-y", "overscroll-behavior", "overscroll-behavior-block", "overscroll-behavior-inline", "overscroll-behavior-x", "overscroll-behavior-y", "padding", "padding-block", "padding-block-end", "padding-block-start", "padding-bottom", "padding-inline", "padding-inline-end", "padding-inline-start", "padding-left", "padding-right", "padding-top", "page", "page-break-after", "page-break-before", "page-break-inside", "page-orientation", "paint-order", "perspective", "perspective-origin", "place-content", "place-items", "place-self", "pointer-events", "position", "quotes", "r", "resize", "right", "rotate", "row-gap", "ruby-position", "rx", "ry", "scale", "scroll-behavior", "scroll-margin", "scroll-margin-block", "scroll-margin-block-end", "scroll-margin-block-start", "scroll-margin-bottom", "scroll-margin-inline", "scroll-margin-inline-end", "scroll-margin-inline-start", "scroll-margin-left", "scroll-margin-right", "scroll-margin-top", "scroll-padding", "scroll-padding-block", "scroll-padding-block-end", "scroll-padding-block-start", "scroll-padding-bottom", "scroll-padding-inline", "scroll-padding-inline-end", "scroll-padding-inline-start", "scroll-padding-left", "scroll-padding-right", "scroll-padding-top", "scroll-snap-align", "scroll-snap-stop", "scroll-snap-type",
  "shape-image-threshold", "shape-margin", "shape-outside", "shape-rendering", "size", "speak", "src", "stop-color", "stop-opacity", "stroke", "stroke-dasharray", "stroke-dashoffset", "stroke-linecap", "stroke-linejoin", "stroke-miterlimit", "stroke-opacity", "stroke-width", "tab-size", "table-layout", "text-align", "text-align-last", "text-anchor", "text-combine-upright", "text-decoration", "text-decoration-color", "text-decoration-line", "text-decoration-skip-ink", "text-decoration-style", "text-indent", "text-justify", "text-orientation", "text-overflow", "text-rendering", "text-shadow", "text-size-adjust", "text-transform", "text-underline-position", "top", "touch-action", "transform", "transform-box", "transform-origin", "transform-style", "transition", "transition-delay", "transition-duration", "transition-property", "transition-timing-function", "translate", "unicode-bidi", "unicode-range", "user-select", "user-zoom", "vector-effect", "vertical-align", "visibility", "white-space", "widows", "width", "will-change", "word-break", "word-spacing", "word-wrap", "writing-mode", "x", "y", "z-index", "zoom", "box-decoration-break", "color-adjust", "css-float", "font-synthesis", "font-variant-position", "ime-mode", "ruby-align", "scrollbar-width", "text-emphasis-position", "overflow-block", "overflow-inline", "font-language-override", "font-variant-alternates", "mask-clip", "mask-composite", "mask-image", "mask-mode", "mask-origin", "mask-position-x", "mask-position-y", "mask-repeat", "mask-size", "scrollbar-color", "text-decoration-thickness", "text-emphasis-style", "counter-set", "border-end-end-radius", "border-end-start-radius", "border-start-end-radius", "border-start-start-radius", "text-underline-offset", "text-emphasis-color", "text-emphasis", "mask-position"];

  let ret = {};

  walkDeclarations(ast, ({property}) => {
    // Strip hacks like *property, _property etc and normalize to lowercase
    property = property.replace(/[^a-z-]/g, "").toLowerCase();

    if (!matches(property, [
      ...properties,
      /^-([a-z]*)-/, // prefixed & custom props
    ])) {
      incrementByKey(ret, property);
    }
  });

  return Object.entries(ret).flatMap(([property, freq]) => {
    if (isNaN(+freq)) {
      return [];
    }
    return [{property, freq: +freq}];
  });
} catch (e) {
  return [];
}
''';

SELECT
  *
FROM (
  SELECT DISTINCT
    client,
    property,
    COUNT(DISTINCT page) OVER (PARTITION BY client, property) AS pages,
    COUNT(DISTINCT page) OVER (PARTITION BY client) AS total_pages,
    COUNT(DISTINCT page) OVER (PARTITION BY client, property) / COUNT(DISTINCT page) OVER (PARTITION BY client) AS pct_pages,
    SUM(freq) OVER (PARTITION BY client, property) AS freq,
    SUM(freq) OVER (PARTITION BY client) AS total_freq,
    SUM(freq) OVER (PARTITION BY client, property) / SUM(freq) OVER (PARTITION BY client) AS pct
  FROM (
    SELECT
      client,
      page,
      property.property,
      property.freq
    FROM
      `httparchive.almanac.parsed_css`,
      UNNEST(getUnknownProperties(css)) AS property
    WHERE
      date = '2022-07-01' AND -- noqa: CV09
      LENGTH(property.property) > 1 AND
      # Limit the size of the CSS to avoid OOM crashes.
      LENGTH(css) < 0.1 * 1024 * 1024
  )
)
WHERE
  pct_pages >= 0.01
ORDER BY
  pct_pages DESC
