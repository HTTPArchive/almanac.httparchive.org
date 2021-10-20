CREATE TEMPORARY FUNCTION getResourceHints(payload STRING)
RETURNS STRUCT<preload INT64, prefetch INT64, preconnect INT64, prerender INT64, `dns-prefetch` INT64, `modulepreload` INT64>
LANGUAGE js AS '''
var hints = ['preload', 'prefetch', 'preconnect', 'prerender', 'dns-prefetch', 'modulepreload'];
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return hints.reduce((results, hint) => {
    // Null values are omitted from BigQuery aggregations.
    // This means only pages with at least one hint are considered.
    results[hint] = almanac['link-nodes'].nodes.filter(link => link.rel.toLowerCase() == hint).length || null;
    return results;
  }, {});
} catch (e) {
  return hints.reduce((results, hint) => {
    results[hint] = null;
    return results;
  }, {});
}
''' ;

CREATE TEMPORARY FUNCTION getGoodCwv(payload STRING)
RETURNS STRUCT<cumulative_layout_shift BOOLEAN, first_contentful_paint BOOLEAN, first_input_delay BOOLEAN, largest_contentful_paint BOOLEAN>
LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var crux = $._CrUX;

  if (crux) {
    return Object.keys(crux.metrics).reduce((acc, n) => ({
      ...acc,
      [n]: crux.metrics[n].histogram[0].density > 0.75
    }), {})
  }  
  
  return {};
} catch (e) {
  return {};
}
''' ;

SELECT
    device,
    CASE
        WHEN hints.preload IS NULL THEN 0
        WHEN hints.preload >= 20 THEN 20
        ELSE hints.preload
    END AS preload,
    COUNT(0) AS freq,
    SUM(COUNT(0)) OVER (PARTITION BY device) AS total,
    COUNTIF(CrUX.largest_contentful_paint) AS good_largest_contentful_paint,
    COUNTIF(CrUX.largest_contentful_paint) / COUNT(0) AS pct_good_largest_contentful_paint
FROM (
    SELECT
        _TABLE_SUFFIX AS device,
        getResourceHints(payload) AS hints,
        getGoodCwv(payload) AS CrUX
    FROM
        `httparchive.pages.2021_07_01_*`
)
WHERE
    CrUX IS NOT NULL
GROUP BY 
    device,
    preload
ORDER BY 
    device,
    preload
