#standardSQL
CREATE TEMPORARY FUNCTION getVendorPrefixProperties(css STRING)
RETURNS ARRAY<STRING>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  function compute(ast) {
    let ret = {
      pseudo_classes: {},
      pseudo_elements: {},
      properties: {},
      functions: {},
      keywords: {},
      media: {}
    };

    walkRules(ast, rule => {
      // Prefixed pseudos
      if (rule.selectors) {
        let pseudos = rule.selectors.flatMap(r => r.match(/::?-[a-z]+-[\\w-]+/g) || []);

        for (let pseudo of pseudos) {
          let type = "pseudo_" + (pseudo.indexOf("::") === 0? "elements" : "classes");
          incrementByKey(ret[type], pseudo);
        }
      }

      if (rule.declarations) {
        walkDeclarations(rule, ({property, value}) => {
          // Prefixed properties
          if (/^-[a-z]+-.+/.test(property)) {
            incrementByKey(ret.properties, property);
          }

          // NOTE(rviscomi): Excluding XL values to avoid UDF timeouts.
          if (value.length < 1000) {
            // -prefix-function()
            for (let call of extractFunctionCalls(value, {names: /^-[a-z]+-.+/})) {
              incrementByKey(ret.functions, call.name);
            }
          }

          // Prefixed keywords
          for (let k of value.matchAll(/(?<![-a-z])-[a-z]+-[a-z-]+(?=;|\\s|,|\\/)/g)) {
            incrementByKey(ret.keywords, k);
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
          }
        }
      }


    });

    for (let type in ret) {
      ret[type] = sortObject(ret[type]);
    }

    return ret;
  }

  let ast = JSON.parse(css);
  let vendorPrefix = compute(ast);
  return Object.entries(vendorPrefix.properties).flatMap(([prop, freq]) => {
    return Array(freq).fill(prop);
  });
} catch (e) {
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
    SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
    COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getVendorPrefixProperties(css)) AS prop
  WHERE
    date = '2021-07-01'
  GROUP BY
    client,
    prop
)
WHERE
  pages >= 1000
ORDER BY
  pct DESC
