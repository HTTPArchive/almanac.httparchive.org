#standardSQL
CREATE TEMPORARY FUNCTION getPrefixStats(css STRING)
RETURNS ARRAY<STRING>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  function compute() {
    let ret = {
      total: {},
      pseudo_classes: {},
      pseudo_elements: {},
      properties: {},
      functions: {},
      keywords: {},
      media: {}
    };

    ret.total = Object.fromEntries(Object.keys(ret).map(k => [k, 0]));

    walkRules(ast, rule => {
      // Prefixed pseudos
      if (rule.selectors) {
        let pseudos = rule.selectors.flatMap(r => r.match(/::?-[a-z]+-[\\w-]+/g) || []);

        for (let pseudo of pseudos) {
          let type = "pseudo_" + (pseudo.indexOf("::") === 0? "elements" : "classes");
          incrementByKey(ret[type], pseudo);
          ret.total[type]++;
        }
      }

      if (rule.declarations) {
        walkDeclarations(rule, ({property, value}) => {
          if (value.length > 1000) {
            return;
          }

          // Prefixed properties
          if (/^-[a-z]+-.+/.test(property)) {
            incrementByKey(ret.properties, property);
            ret.total.properties++;
          }

          // -prefix-function()
          for (let call of extractFunctionCalls(value, {names: /^-[a-z]+-.+/})) {
            incrementByKey(ret.functions, call.name);
            ret.total.functions++;
          }

          // Prefixed keywords
          if (!matches(property, /(^|-)(transition(-property)?|animation(-name)?)$/)) {
            for (let k of value.matchAll(/(?<![-a-z])-[a-z]+-[a-z-]+(?=$|\\s|,|\\/)/g)) {
              incrementByKey(ret.keywords, k);
              ret.total.keywords++;
            }
          }
        });
      }

      // Prefixed media features
      if (rule.media) {
        let features = rule.media
                  .replace(/\\s+/g, "")
                  .match(/\\(-[a-z]+-[\\w-]+(?=[:\\)])/g);

        if (features) {
          features = features.map(s => s.slice(1));

          for (let feature of features) {
            incrementByKey(ret.media, feature);
            ret.total.media++;
          }
        }
      }
    });

    ret.total.total = sumObject(ret.total);

    for (let type in ret) {
      ret[type] = sortObject(ret[type]);
    }

    return ret;
  }


  let ast = JSON.parse(css);
  let stats = compute(ast).total;
  return Object.entries(stats).flatMap(([prop, freq]) => {
    return Array(freq).fill(prop);
  });
}
catch (e) {
  return [];
}
''';

SELECT
  *
FROM (
  SELECT
    client,
    prop,
    COUNT(DISTINCT page) AS pages,
    COUNT(0) AS freq,
    SUM(COUNT(IF(prop = 'total', NULL, 0))) OVER (PARTITION BY client) AS total,
    COUNT(IF(prop = 'total', NULL, 0)) / SUM(COUNT(IF(prop = 'total', NULL, 0))) OVER (PARTITION BY client) AS pct
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getPrefixStats(css)) AS prop
  WHERE
    date = '2020-08-01'
  GROUP BY
    client,
    prop
)
WHERE
  pages >= 1000
ORDER BY
  pct DESC
