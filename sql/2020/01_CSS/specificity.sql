#standardSQL
CREATE TEMPORARY FUNCTION getSpecificityInfo(css STRING)
RETURNS STRUCT<
  ruleCount NUMERIC,
  selectorCount NUMERIC,
  selectorsPerRule NUMERIC,
  avgSpecificity STRING,
  maxSpecificity STRING,
  medianSpecificity STRING
> LANGUAGE js AS '''
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

  function getMedian(specificities) {
    const total = Object.values(specificities).reduce((sum, value) => sum + value, 0);
    if (total == 0) {
      return null;
    }
    let cdf = 0;
    const cdfEntries = Object.entries(specificities).map(([specificity, count]) => {
      cdf += count;
      return [specificity, cdf / total];
    });

    for ([specificity, cdf] in cdfEntries) {
      if (cdf >= 0.5) {
        return specificity;
      }
    }

    return null;
  }

  function specificityToString(specificity) {
    return specificity && specificity.join(',');
  }

  function sanitize(value) {
    return isNaN(value) ? null : value;
  }

  const ast = JSON.parse(css);
  let specificity = extractSpecificity(ast);

  return {
    ruleCount: specificity.ruleCount,
    selectorCount: specificity.selectorCount,
    selectorsPerRule: sanitize(specificity.selectorsPerRule),
    avgSpecificity: specificityToString(specificity.avgSpecificity),
    maxSpecificity: specificityToString(specificity.maxSpecificity),
    medianSpecificity: getMedian(specificity.specificityCount)
  };
} catch (e) {
  return {avgSpecificity: e};
}
'''
OPTIONS (library="gs://httparchive/lib/css-utils.js");


  SELECT
    client,
    getSpecificityInfo(css) AS info
  FROM
    `httparchive.almanac.parsed_css_1k`