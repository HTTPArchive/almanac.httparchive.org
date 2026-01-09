CREATE TEMPORARY FUNCTION getSpecificityInfo(css STRING)
RETURNS STRUCT<
  ruleCount NUMERIC,
  selectorCount NUMERIC,
  distribution ARRAY<STRUCT<specificity STRING, specificity_cmp STRING, freq INT64>>
>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  function extractSpecificity(ast) {
    let ret = {
      selectorCount: 0,
      ruleCount: 0,
      specificityCount: {},
      maxSpecifity: [0, 0, 0]
    };

    let ss = [0, 0, 0];

    walkRules(ast, rule => {
      ret.ruleCount++;

      for (let selector of rule.selectors) {
        ret.selectorCount++;
        let s = parsel.specificity(selector);
        ss = ss.map((a, i) => a + s[i]);
        let max = Math.max(...s);

        incrementByKey(ret.specificityCount, max <= 5? s + "" : "higher");

        let base = Math.max(...ret.maxSpecifity, ...s);
        if (parsel.specificityToNumber(s, base) > parsel.specificityToNumber(ret.maxSpecifity, base)) {
          ret.maxSpecifity = s;
          ret.maxSpecifitySelector = selector;
        }
      }
    }, {type: "rule"});

    ret.selectorsPerRule = ret.selectorCount / ret.ruleCount;
    ret.avgSpecificity = ss.map(s => s / ret.selectorCount);

    return ret;
  }

  function toComparableString(specificity) {
    if (!specificity) {
      return null;
    }
    if (specificity.split(',').length !== 3) {
      return null;
    }

    // The highest unit of specificity is 9398, so we need 5 digits of padding.
    // Fun fact: the most specific selector in the dataset is 1065,9398,7851!
    return specificity.split(',').map(i => i.padStart(5, '0')).join('');
  }

  const ast = JSON.parse(css);
  let specificity = extractSpecificity(ast);
  let ruleCount = specificity.ruleCount;
  let selectorCount = specificity.selectorCount;
  let distribution = Object.entries(specificity.specificityCount).map(([specificity, freq]) => {
    return {
      specificity,
      freq,
      specificity_cmp: toComparableString(specificity)
    }
  });

  return {
    ruleCount,
    selectorCount,
    distribution
  };
} catch (e) {
  return null;
}
''';

SELECT
  percentile,
  client,
  APPROX_QUANTILES(rule_count, 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS rules_per_stylesheet
FROM (
  SELECT
    client,
    info.ruleCount AS rule_count
  FROM (
    SELECT
      client,
      getSpecificityInfo(css) AS info
    FROM
      `httparchive.almanac.parsed_css`
    WHERE
      date = '2022-07-01' AND -- noqa: CV09
      url NOT IN ('inline', 'block') AND
      # Limit the size of the CSS to avoid OOM crashes. This loses ~20% of stylesheets.
      LENGTH(css) < 0.1 * 1024 * 1024
  )
),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
