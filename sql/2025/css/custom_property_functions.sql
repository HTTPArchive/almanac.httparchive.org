#standardSQL
CREATE TEMPORARY FUNCTION getCustomPropertyFunctions(css JSON)
RETURNS ARRAY<STRING>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  function compute(ast) {
    let ret = {
      properties: {},
      functions: {},
      supports: {},
      "pseudo-classes": {},
      fallback: {
        none: 0,
        literal: 0,
        var: 0
      },
      initial: 0
    };

    walkRules(ast, rule => {
      for (let match of rule.supports.matchAll(/\\(--(?<name>[\\w-]+)\\s*:/g)) {
        incrementByKey(ret.supports, match.groups.name);
      }
    }, {type: "supports"});

    let parsedSelectors = {};

    walkDeclarations(ast, ({property, value}, rule) => {
      if (matches(value, /\\bvar\\(\\s*--/)) {
        if (!property.startsWith("--")) {
          incrementByKey(ret.properties, property);
        }

        for (let call of extractFunctionCalls(value)) {
          if (call.name === "var") {
            let fallback = call.args.split(",").slice(1).join(",");

            if (matches(fallback, /\\bvar\\(\\s*--/)) {
              ret.fallback.var++;
            }
            else if (fallback) {
              ret.fallback.literal++;
            }
            else {
              ret.fallback.none++;
            }
          }
          else if (call.args.includes("var(--")) {
            incrementByKey(ret.functions, call.name);
          }
        }
      }

      if (property.startsWith("--")) {
        if (value === "initial") {
          ret.initial++;
        }

        if (rule.selectors) {
          for (let selector of rule.selectors) {
            let sast = parsedSelectors[selector] = parsedSelectors[selector] || parsel.parse(selector);
            parsel.walk(sast, node => {
              if (node.type === "pseudo-class") {
                incrementByKey(ret["pseudo-classes"], node.name);
              }
            })
          }
        }

      }
    });

    for (let type in ret) {
      ret[type] = sortObject(ret[type]);
    }

    return ret;
  }

  let custom_property = compute(css);
  return Object.keys(custom_property.functions);
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
    LOWER(function) AS function
  FROM
    `httparchive.crawl.parsed_css`
  LEFT JOIN
    UNNEST(getCustomPropertyFunctions(css)) AS function
  WHERE
    function IS NOT NULL AND
    date = '2025-07-01' AND
    rank <= 1000000 AND
    is_root_page -- remove if wanna look at home pages AND inner pages. Old tables only had home pages.
)
JOIN (
  SELECT
    client,
    COUNT(0) AS total
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    rank <= 1000000 AND
    is_root_page -- remove if wanna look at home pages AND inner pages. Old tables only had home pages.
  GROUP BY
    client
)
USING (client)
GROUP BY
  client,
  total,
  function
HAVING
  pages >= 100
ORDER BY
  pct DESC
