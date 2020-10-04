#standardSQL
CREATE TEMPORARY FUNCTION getGradientHardStops(css STRING) RETURNS INT64 LANGUAGE js AS '''
try {
  function compute(ast) {
    let ret = {
      functions: {}, // usage by gradient function
      properties: {}, // usage by property
      two_positions: 0,
      hints: 0,
      hard_stops: 0
    };
    let stopCount = [];

    const keywords = [
      "aliceblue","antiquewhite","aqua","aquamarine","azure","beige","bisque","black","blanchedalmond","blue","blueviolet","brown","burlywood","cadetblue","chartreuse",
      "chocolate","coral","cornflowerblue","cornsilk","crimson","cyan","darkblue","darkcyan","darkgoldenrod","darkgray","darkgreen","darkgrey","darkkhaki","darkmagenta",
      "darkolivegreen","darkorange","darkorchid","darkred","darksalmon","darkseagreen","darkslateblue","darkslategray","darkslategrey","darkturquoise","darkviolet",
      "deeppink","deepskyblue","dimgray","dimgrey","dodgerblue","firebrick","floralwhite","forestgreen","fuchsia","gainsboro","ghostwhite","gold","goldenrod","gray",
      "green","greenyellow","grey","honeydew","hotpink","indianred","indigo","ivory","khaki","lavender","lavenderblush","lawngreen","lemonchiffon","lightblue","lightcoral",
      "lightcyan","lightgoldenrodyellow","lightgray","lightgreen","lightgrey","lightpink","lightsalmon","lightseagreen","lightskyblue","lightslategray","lightslategrey",
      "lightsteelblue","lightyellow","lime","limegreen","linen","magenta","maroon","mediumaquamarine","mediumblue","mediumorchid","mediumpurple","mediumseagreen",
      "mediumslateblue","mediumspringgreen","mediumturquoise","mediumvioletred","midnightblue","mintcream","mistyrose","moccasin","navajowhite","navy","oldlace",
      "olive","olivedrab","orange","orangered","orchid","palegoldenrod","palegreen","paleturquoise","palevioletred","papayawhip","peachpuff","peru","pink","plum",
      "powderblue","purple","rebeccapurple","red","rosybrown","royalblue","saddlebrown","salmon","sandybrown","seagreen","seashell","sienna","silver","skyblue",
      "slateblue","slategray","slategrey","snow","springgreen","steelblue","tan","teal","thistle","tomato","turquoise","violet","wheat","white","whitesmoke",
      "yellow","yellowgreen","transparent","currentcolor"
    ];
    const keywordRegex = RegExp(`\\b(?<!\\-)(?:${keywords.join("|")})\\b`, "gi");

    walkDeclarations(ast, ({property, value}) => {
      for (let gradient of extractFunctionCalls(value, {names: /-gradient$/})) {

        let {name, args} = gradient;
        incrementByKey(ret.functions, name);

        incrementByKey(ret.properties, property.indexOf("--") === 0? "--" : property);

        // Light color stop parsing

        // This will fail if we have variables with fallbacks in the args so let's just skip those altogether for now
        if (/\bvar\\(|\bcalc\\(/.test(args)) {
          continue;
        }

        let stops = args.split(/\\s*,\\s*/);

        // Remove first arg if it's params and not a color stop
        if (/^(at|to|from)\\s|ellipse|circle|(?:farthest|closest)-(?:side|corner)|[\\d.]+(deg|grad|rad|turn)/.test(stops[0])) {
          stops.shift();
        }

        // Separate color and position(s)
        stops = stops.map(s => {
          let color = s.match(/#[a-f0-9]+|(?:rgba?|hsla?|color)\\((\\(.*?\\)|.)+?\\)/) && s.match(/#[a-f0-9]+|(?:rgba?|hsla?|color)\\((\\(.*?\\)|.)+?\\)/)[0];

          if (!color) {
            color = s.match(keywordRegex) && s.match(keywordRegex)[0];
          }

          let pos = s.replace(color, "").trim().split(/\\s+/);

          return {color, pos};
        });

        stopCount.push(stops.length);

        for (let i=0; i<stops.length; i++) {
          let s = stops[i];

          if (s.pos.length > 1) {
            ret.two_positions++;
          }

          let prev = stops[i - 1];

          // Calculate hard stops
          if (s.color && prev) {
            // 1 position which is either 0 or the same as the previous one
            if (s.pos.length === 1 && s.pos === prev.pos || parseFloat(s.pos) === 0) {
              ret.hard_stops++;
            }
            // Two positions of which the first is 0 or the same as the last one
            else if (s.pos.length === 2) {
              if (parseFLoat(s.pos[0]) === 0 || prev.pos.length === 2 && s.pos[0] === prev.pos && prev.pos[1] || prev.pos.length === 1 && s.pos[0] === s.pos[0]) {
                ret.hard_stops++;
              }
            }
          }
          else {
            ret.hints++;
          }
        }
      }
    }, {
      properties: /^--|-image$|^background$|^content$/
    });

    // Calculate average and max number of stops
    ret.max_stops = Math.max(...stopCount);
    ret.avg_stops = stopCount.reduce((a, c) => a + c, 0) / stopCount.length;

    return ret;
  }

  const ast = JSON.parse(css);
  let gradient = compute(ast);
  return gradient.hard_stops;
} catch (e) {
  return 0;
}
'''
OPTIONS (library="gs://httparchive/lib/css-utils.js");

SELECT
  client,
  COUNTIF(hard_stops > 0) AS pages,
  total,
  COUNTIF(hard_stops > 0) / total AS pct
FROM (
  SELECT
    client,
    page,
    SUM(getGradientHardStops(css)) AS hard_stops
  FROM
    `httparchive.almanac.parsed_css`
  WHERE
    date = '2020-08-01' AND
    # Limit the size of the CSS to avoid OOM crashes.
    LENGTH(css) < 0.1 * 1024 * 1024
  GROUP BY
    client,
    page)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2020_08_01_*`
  GROUP BY
    client)
USING
  (client)
GROUP BY
  client,
  total