#standardSQL
CREATE TEMPORARY FUNCTION getAnimationNames(css STRING)
RETURNS ARRAY<STRING>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  function compute(ast) {
    let ret = {
      properties: new Set(),
      animation_names: new Set(),
      timing_functions: {},

      // to calculate avg, median etc in the SQL. All durations are normalized to ms.
      durations: {}
    };

    const easings = /step(s|-start|-end)|ease((-in)?(-out)?)|linear|cubic-bezier/;

    function parseDuration(duration) {
      let num = parseFloat(duration);
      let unit = duration.endsWith("ms")? "ms" : "s";
      return unit === "s"? num * 1000 : num;
    }

    walkDeclarations(ast, ({property, value}) => {
      if (property === "transition-property") {
        value.split(/\\s*,\\s*/).forEach(p => ret.properties.add(p));
      }
      else if (property.endsWith("tion-timing-functon")) {
        let names = value.match(/^([a-z-]+)/g);

        for (let name of names) {
          if (/^(jump(-start|-end|-none|-both)|start|end)$/.test(name)) {
            // Drop steps() params
            continue;
          }

          incrementByKey(ret.timing_functions, name);
        }
      }
      else if (property.endsWith("-duration")) {
        incrementByKey(ret.durations, parseDuration(value));
      }
      else if (property === "transition" || property === "animation") {
        // Extract property name and timing function
        let keywords = (value.match(/(^|\\s)(d|r|[cr]?x|[cr]?y|[a-z-]{3,})(?=\\s|$|\\()/g) || []);

        for (let keyword of keywords) {
          keyword = keyword.trim();

          if (/^(jump(-start|-end|-none|-both)|start|end)$/.test(keyword)) {
            // Drop steps() params
            continue;
          }

          if (easings.test(keyword)) {
            incrementByKey(ret.timing_functions, keyword);
          }
          else if (property === "transition") {
            ret.properties.add(keyword);
          }
        }

        // Extract durations
        for (let times of value.matchAll(/(?<duration>[\\d.]+m?s)(\\s+(?<delay>[\\d.]+m?s))?/g)) {
          incrementByKey(ret.durations, parseDuration(times.groups.duration));
        }
      }
    }, {
      properties: /^(transition|animation)(?=$|-)/g,
      not: {
        values: ["inherit", "initial", "unset", "revert", /\bvar\\(--/]
      }
    })

    // Animation names
    walkRules(ast, rule => {
      ret.animation_names.add(rule.name);
    }, {type: "keyframes"});

    ret.properties = [...new Set(ret.properties)];
    ret.animation_names = [...ret.animation_names];
    ret.durations = sortObject(ret.durations);
    ret.timing_functions = sortObject(ret.timing_functions);

    return ret;
  }

  const ast = JSON.parse(css);
  let transitions = compute(ast);
  return transitions.animation_names;
} catch (e) {
  return [];
}
''';

SELECT
  *
FROM (
  SELECT
    client,
    animation_name,
    COUNT(DISTINCT page) AS pages,
    COUNT(0) AS freq,
    SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
    COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
  FROM (
    SELECT
      client,
      page,
      animation_name
    FROM
      `httparchive.almanac.parsed_css`,
      UNNEST(getAnimationNames(css)) AS animation_name
    WHERE
      date = '2020-08-01' AND
      # Limit the size of the CSS to avoid OOM crashes.
      LENGTH(css) < 0.1 * 1024 * 1024
  )
  GROUP BY
    client,
    animation_name
)
WHERE
  pct >= 0.001
ORDER BY
  pct DESC
