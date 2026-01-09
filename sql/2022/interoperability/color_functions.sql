#standardSQL
CREATE TEMPORARY FUNCTION getColorFormats(css STRING)
RETURNS ARRAY<STRUCT<name STRING, value INT64>>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  function compute(ast) {
    let usage = {
      hex: {
        "3": 0, "4": 0,
        "6": 0, "8": 0
      },
      functions: {},
      keywords: {},
      system: {},
      currentcolor: 0,
      transparent: 0,
      args: {commas: 0, nocommas: 0},
      spaces: {},
      p3: {sRGB_in: 0, sRGB_out: 0}
    };

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
      "yellow", "yellowgreen"
    ];

    const system = [
      "ActiveBorder", "ActiveCaption", "AppWorkspace", "Background", "ButtonFace", "ButtonHighlight", "ButtonShadow", "ButtonText", "CaptionText",
      "GrayText", "Highlight", "HighlightText", "InactiveBorder", "InactiveCaption", "InactiveCaptionText", "InfoBackground", "InfoText",
      "Menu", "MenuText", "Scrollbar", "ThreeDDarkShadow", "ThreeDFace", "ThreeDHighlight", "ThreeDLightShadow", "ThreeDShadow", "Window", "WindowFrame", "WindowText"
    ];

    // Lookbehind to prevent matching on e.g. var(--color-red)
    const keywordRegex = RegExp(`\\\\b(?<!\\-)(?:${keywords.join("|")})\\\\b`, "gi");
    const systemRegex = RegExp(`\\\\b(?<!\\-)(?:${system.join("|")})\\\\b`, "gi");
    const functionNames = /^(?:rgba?|hsla?|color|lab|lch|hwb)$/gi;

    function countMatches(haystack, needle) {
      let ret = 0;

      for (let match of haystack.matchAll(needle)) {
        ret++;
      }

      return ret;
    }

    // given an array of display-p3 RGB values in range [0-1],
    // return true if inside sRGB gamut
    function P3inSRGB(coords) {
      let srgb = lin_P3_to_sRGB(linearize_p3(coords));
      // Note, we don't need to apply the sRGB transfer function
      // because it does not affect whether a value is out of gamut
      return srgb.every(c => c >= 0 && c <= 1);
    }

    // given an array of display-p3 RGB values in range [0-1],
    // undo gamma correction to get linear light values
    function linearize_p3 (P3) {
      return P3.map(val => {
        if (val < 0.04045) {
          return val / 12.92;
        }
        return ((val + 0.055) / 1.055) ** 2.4;
      });
    }

    // given an array of linear-light display-p3 RGB values in range [0-1],
    // convert to CIE XYZ and then to linear-light sRGB
    // The two linear operations are combined into a single matrix.
    // The matrix multiply is hard-coded, for efficiency
    function lin_P3_to_sRGB (linP3) {
      let [r, g, b] = linP3;

      return [
        1.2247452561927687 * r + -0.22490435913073928 * g + 1.8500279863609137e-8 * b,
        -0.04205792199232122 * r + 1.0420810071506164 * g + -1.585738278880866e-8 * b,
        -0.019642279587426013 * r + -0.07865491660582305 * g + 1.098537193883219 * b
        ];
    }

    walkDeclarations(ast, ({property, value}) => {
      if (value.length > 1000) return;
      // First remove url() references to avoid them mucking the results
      for (let f of extractFunctionCalls(value, {names: "url"})) {
        let [start, end] = f.pos;
        value = value.substring(0, start) + "url()" + " ".repeat(end - start - 5) + value.substring(end);
      }

      usage.hex[3] += countMatches(value, /#[a-f0-9]{3}\\b/gi);
      usage.hex[4] += countMatches(value, /#[a-f0-9]{4}\\b/gi);
      usage.hex[6] += countMatches(value, /#[a-f0-9]{6}\\b/gi);
      usage.hex[8] += countMatches(value, /#[a-f0-9]{8}\\b/gi);

      for (let f of extractFunctionCalls(value, {names: functionNames})) {
        let {name, args} = f;

        incrementByKey(usage.functions, name);
        incrementByKey(usage.args, (args.indexOf(",") > -1? "" : "no") + "commas");

        if (name === "color") {
          // Let's look at color() more closely
          let match = args.match(/^(?<space>[\\w-]+)\\s+(?<params>[-\\d\\s.%\\/]+)$/);

          if (match) {
            let {space, params} = match.groups;

            incrementByKey(usage.spaces, space);

            if (space === "display-p3") {
              let percents = params.indexOf("%") > -1;
              let coords = params.trim().split(/\\s+/).map(c => parseFloat(c) / (percents? 100 : 1));

              usage.p3["sRGB_" + (P3inSRGB(coords)? "in" : "out")]++;
            }
          }
        }
      }

      for (let match of value.matchAll(keywordRegex)) {
        incrementByKey(usage.keywords, match[0].toLowerCase());
      }

      for (let match of value.matchAll(systemRegex)) {
        incrementByKey(usage.system, system.find(kw => kw.toLowerCase() == match[0].toLowerCase()));
      }

      for (let match of value.matchAll(/\\b(?<!\\-)(?:currentColor|transparent)\\b/gi)) {
        incrementByKey(usage, match[0].toLowerCase());
      }
    }, {
      properties: /^--|color$|^border|^background(-image)?$|\\-shadow$|filter$/
    });

    usage.keywords = sortObject(usage.keywords);
    usage.system = sortObject(usage.system);

    return usage;
  }

  const ast = JSON.parse(css);
  let color = compute(ast);
  return [
    {name: '#rgb', value: color.hex[3]},
    {name: '#rgba', value: color.hex[4]},
    {name: '#rrggbb', value: color.hex[6]},
    {name: '#rrggbbaa', value: color.hex[8]},
    {name: 'rgb()', value: color.functions.rgb},
    {name: 'rgba()', value: color.functions.rgba},
    {name: 'hsl()', value: color.functions.hsl},
    {name: 'hsla()', value: color.functions.hsla},
    {name: 'color()', value: color.functions.color},
    {name: 'lab()', value: color.functions.lab},
    {name: 'lch()', value: color.functions.lch},
    {name: 'hwb()', value: color.functions.hwb},
    {name: 'namedColor', value: Object.values(color.keywords).reduce((total, i) => total += i, 0)},
    {name: 'system', value: Object.values(color.system).reduce((total, i) => total += i, 0)},
    {name: 'currentColor', value: color.currentcolor},
    {name: 'transparent', value: color.transparent}
  ];
} catch (e) {
  return [];
}
''';

WITH totals AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_pages
  FROM
    `httparchive.summary_pages.2022_07_01_*`  -- noqa: CV09
  GROUP BY
    client
)

SELECT
  client,
  name AS format,
  COUNT(DISTINCT page) AS pages,
  ANY_VALUE(total_pages) AS total_pages,
  COUNT(DISTINCT page) / ANY_VALUE(total_pages) AS pct_pages,
  SUM(value) AS freq,
  SUM(SUM(value)) OVER (PARTITION BY client) AS total,
  SUM(value) / SUM(SUM(value)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    page,
    format.name,
    format.value
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getColorFormats(css)) AS format
  WHERE
    date = '2022-07-01' AND -- noqa: CV09
    format.value IS NOT NULL
)
JOIN
  totals
USING (client)
GROUP BY
  client,
  format
ORDER BY
  pct DESC
