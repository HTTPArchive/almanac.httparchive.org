#standardSQL
CREATE TEMPORARY FUNCTION getGradientFunctions(css STRING)
RETURNS ARRAY<STRING>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  function compute(ast) {
    let ret = {
      functions: {}, // usage by gradient function
      properties: {}, // usage by property
      max_stops: 0,
      max_stops_gradient: [],
      two_positions: 0,
      hints: 0,
      hard_stops: 0
    };
    let stopCount = [];

    const keywords = [
      "aliceblue", "antiquewhite", "aqua", "aquamarine", "azure", "beige", "bisque", "black", "blanchedalmond", "blue", "blueviolet", "brown", "burlywood", "cadetblue", "chartreuse",
      "chocolate", "coral", "cornflowerblue", "cornsilk", "crimson", "cyan", "darkblue", "darkcyan", "darkgoldenrod", "darkgray", "darkgreen", "darkgrey", "darkkhaki", "darkmagenta",
      "darkolivegreen", "darkorange", "darkorchid", "darkred", "darksalmon", "darkseagreen", "darkslateblue", "darkslategray", "darkslategrey", "darkturquoise", "darkviolet",
      "deeppink", "deepskyblue", "dimgray", "dimgrey", "dodgerblue", "firebrick", "floralwhite", "forestgreen", "fuchsia", "gainsboro", "ghostwhite", "gold", "goldenrod", "gray",
      "green", "greenyellow", "grey", "honeydew", "hotpink", "indianred", "indigo", "ivory", "khaki", "lavender", "lavenderblush", "lawngreen", "lemonchiffon", "lightblue", "lightcoral",
      "lightcyan", "lightgoldenrodyellow", "lightgray", "lightgreen", "lightgrey", "lightpink", "lightsalmon", "lightseagreen", "lightskyblue", "lightslategray", "lightslategrey",
      "lightsteelblue", "lightyellow", "lime", "limegreen", "linen", "magenta", "maroon", "mediumaquamarine", "mediumblue", "mediumorchid", "mediumpurple", "mediumseagreen",
      "mediumslateblue", "mediumspringgreen", "mediumturquoise", "mediumvioletred", "midnightblue", "mintcream", "mistyrose", "moccasin", "navajowhite", "navy", "oldlace",
      "olive", "olivedrab", "orange", "orangered", "orchid", "palegoldenrod", "palegreen", "paleturquoise", "palevioletred", "papayawhip", "peachpuff", "peru", "pink", "plum",
      "powderblue", "purple", "rebeccapurple", "red", "rosybrown", "royalblue", "saddlebrown", "salmon", "sandybrown", "seagreen", "seashell", "sienna", "silver", "skyblue",
      "slateblue", "slategray", "slategrey", "snow", "springgreen", "steelblue", "tan", "teal", "thistle", "tomato", "turquoise", "violet", "wheat", "white", "whitesmoke",
      "yellow", "yellowgreen", "transparent", "currentcolor",
      "ActiveBorder", "ActiveCaption", "AppWorkspace", "Background", "ButtonFace", "ButtonHighlight", "ButtonShadow", "ButtonText", "CaptionText",
      "GrayText", "Highlight", "HighlightText", "InactiveBorder", "InactiveCaption", "InactiveCaptionText", "InfoBackground", "InfoText",
      "Menu", "MenuText", "Scrollbar", "ThreeDDarkShadow", "ThreeDFace", "ThreeDHighlight", "ThreeDLightShadow", "ThreeDShadow", "Window", "WindowFrame", "WindowText"
    ];
    const keywordRegex = RegExp(`\\b(?<!\\-)(?:${keywords.join("|")})\\b`, "gi");

    walkDeclarations(ast, ({property, value}) => {
      if (value.length > 1000) return;
      for (let gradient of extractFunctionCalls(value, {names: /-gradient$/})) {

        let {name, args} = gradient;
        incrementByKey(ret.functions, name);

        incrementByKey(ret.properties, property.indexOf("--") === 0? "--" : property);

        // Light color stop parsing

        // Collapse nested function calls into empty function calls
        for (let i=0, lastIndex; (i = args.indexOf("(", lastIndex + 1)) > -1; ) {
          let a = parsel.gobbleParens(args, i);
          args = args.substring(0, i) + "()" + args.substring(i + a.length);
          lastIndex = i;
        }

        let stops = args.split(/\\s*,\\s*/);

        // Remove first arg if it's params and not a color stop
        if (/^(at|to|from)\\s|ellipse|circle|(?:farthest|closest)-(?:side|corner)|[\\d.]+(deg|grad|rad|turn)/.test(stops[0])) {
          stops.shift();
        }

        stopCount.push(stops.length);

        if (ret.max_stops < stops.length) {
          ret.max_stops = stops.length;
          ret.max_stops_gradient = [];
        }

        if (ret.max_stops === stops.length) {
          ret.max_stops_gradient.push(value.substring(...gradient.pos));
        }

        // The rest will fail if we have variables with fallbacks in the args so let's just skip those altogether for now
        if (/\\bvar\\(/.test(args)) {
          continue;
        }

        // Separate color and position(s)
        stops = stops.map(s => {
          if (/\\s/.test(s)) {
            // Even though the spec doesn't mandate an order, all browsers implement the older grammar
            // with the position after the color, so placing the position before the color must be extremely rare.
            let parts = s.split(/\\s+/);
            return {color: parts[0], pos: parts.slice(1)};
          }

          // We only have one thing, is it a color or a position?
          if (/#[a-f0-9]+|(?:rgba?|hsla?|color)\\(/.test(s) || keywordRegex.test(s)) {
            keywordRegex.lastIndex = 0;
            return {color: s};
          }

          return {pos: s};
        });

        for (let i=0; i<stops.length; i++) {
          let s = stops[i];

          if (s.pos && s.pos.length > 1) {
            ret.two_positions++;
          }

          if (!s.color) {
            // No color, it must be a hint
            ret.hints++;
            continue;
          }

          let prev = stops[i - 1];

          // Calculate hard stops
          if (prev && prev.pos && s.pos && !s.pos.join("").includes("calc()")) {
            let pos = s.pos[0];
            let prevPos =  prev.pos[prev.pos.length === 1? 0 : 1];

            if (parseFloat(pos) === 0 || pos === prevPos) {
              ret.hard_stops++;
            }
          }
        }
      }
    }, {
      properties: /^--|-image$|^background$|^content$/
    });

    // Calculate average and max number of stops
    stopCount = stopCount.sort((a, b) => b - a);
    ret.avg_stops = stopCount.reduce((a, c) => a + c, 0) / stopCount.length;

    let mi = (stopCount.length - 1) / 2;
    ret.median_stops = stopCount.length % 2? stopCount[mi] : (stopCount[Math.floor(mi)] + stopCount[Math.ceil(mi)]) / 2;
    ret.stop_count = stopCount;

    return ret;
  }

  const ast = JSON.parse(css);
  let gradient = compute(ast);
  return Object.keys(gradient.functions);
} catch (e) {
  return [];
}
''';

SELECT
  client,
  function,
  COUNT(DISTINCT page) AS pages,
  total,
  COUNT(DISTINCT page) / total AS pct
FROM (
  SELECT DISTINCT
    client,
    page,
    function
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getGradientFunctions(css)) AS function
  WHERE
    date = '2022-07-01' AND -- noqa: CV09
    function IS NOT NULL
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2022_07_01_*` -- noqa: CV09
  GROUP BY
    client
)
USING (client)
GROUP BY
  client,
  function,
  total
ORDER BY
  pct DESC
