#standardSQL
# 09_35: % of pages with distracting UX (marquee/blink elements, or animation-iteration-count: infinite)
CREATE TEMPORARY FUNCTION includesInfiniteAnimation(css STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
try {
  var reduceValues = (values, rule) => {
    if (values) {
      return values;
    }
    if ('rules' in rule) {
      return rule.rules.reduce(reduceValues, values);
    }
    if (!('declarations' in rule)) {
      return values;
    }

    return !!rule.declarations.find(d =>
          d.property.toLowerCase() == 'animation-iteration-count' &&
          d.value.toLowerCase() == 'infinite');
  };
  var $ = JSON.parse(css);
  return $.stylesheet.rules.reduce(reduceValues, false);
} catch (e) {
  return false;
}
''';


CREATE TEMPORARY FUNCTION includesMotionElement(payload STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var elements = JSON.parse($._element_count);
  if (Array.isArray(elements) || typeof elements != 'object') return [];
  return !!Object.keys(elements).find(e => e == 'marquee' || e == 'blink');
} catch (e) {
  return false;
}
''';

SELECT
  client,
  COUNTIF(motion) AS motion,
  COUNTIF(animations > 0) AS animations,
  COUNTIF(motion OR animations > 0) AS freq,
  SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS total,
  ROUND(COUNTIF(motion OR animations > 0) * 100 / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client), 2) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    includesMotionElement(payload) AS motion
  FROM
    `httparchive.pages.2019_07_01_*`
)
JOIN (
  SELECT
    client,
    page,
    COUNTIF(includesInfiniteAnimation(css)) AS animations
  FROM
    `httparchive.almanac.parsed_css`
  WHERE
    date = '2019-07-01'
  GROUP BY
    client,
    page
)
USING (client, page)
GROUP BY
  client
ORDER BY
  freq / total DESC,
  client
