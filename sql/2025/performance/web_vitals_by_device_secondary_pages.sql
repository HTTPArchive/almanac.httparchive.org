CREATE TEMPORARY FUNCTION getGoodCwv(summary STRING)
RETURNS STRUCT<cumulative_layout_shift BOOLEAN, first_contentful_paint BOOLEAN, interaction_to_next_paint BOOLEAN, largest_contentful_paint BOOLEAN>
LANGUAGE js AS '''
try {
  var $ = JSON.parse(summary);
  var crux = $.crux;

  if (crux) {
    return Object.keys(crux.metrics).reduce((acc, n) => ({
      ...acc,
      [n]: crux.metrics[n].histogram[0].density >= 0.75
    }), {})
  }

  return null;
} catch (e) {
  return null;
}
''';

SELECT
  client,
  is_root_page,

  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,

  COUNTIF(CrUX.largest_contentful_paint) AS lcp_good,
  COUNTIF(CrUX.largest_contentful_paint IS NOT NULL) AS any_lcp,
  COUNTIF(CrUX.largest_contentful_paint) / COUNTIF(CrUX.largest_contentful_paint IS NOT NULL) AS pct_lcp_good,

  COUNTIF(CrUX.interaction_to_next_paint) AS inp_good,
  COUNTIF(CrUX.interaction_to_next_paint IS NOT NULL) AS any_inp,
  COUNTIF(CrUX.interaction_to_next_paint) / COUNTIF(CrUX.interaction_to_next_paint IS NOT NULL) AS pct_inp_good,

  COUNTIF(CrUX.cumulative_layout_shift) AS cls_good,
  COUNTIF(CrUX.cumulative_layout_shift IS NOT NULL) AS any_cls,
  COUNTIF(CrUX.cumulative_layout_shift) / COUNTIF(CrUX.cumulative_layout_shift IS NOT NULL) AS pct_cls_good,

  COUNTIF(CrUX.first_contentful_paint) AS fcp_good,
  COUNTIF(CrUX.first_contentful_paint IS NOT NULL) AS any_fcp,
  COUNTIF(CrUX.first_contentful_paint) / COUNTIF(CrUX.first_contentful_paint IS NOT NULL) AS pct_fcp_good,

  COUNTIF(CrUX.largest_contentful_paint AND CrUX.interaction_to_next_paint IS NOT FALSE AND CrUX.cumulative_layout_shift) AS cwv_good,
  COUNTIF(CrUX.largest_contentful_paint IS NOT NULL AND CrUX.cumulative_layout_shift IS NOT NULL) AS eligible_cwv,
  COUNTIF(CrUX.largest_contentful_paint AND CrUX.interaction_to_next_paint IS NOT FALSE AND CrUX.cumulative_layout_shift) / COUNTIF(CrUX.largest_contentful_paint IS NOT NULL AND CrUX.cumulative_layout_shift IS NOT NULL) AS pct_cwv_good
FROM (
  SELECT
    client,
    getGoodCwv(TO_JSON_STRING(summary)) AS CrUX,
    is_root_page
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-06-01'

)
WHERE
  CrUX IS NOT NULL
GROUP BY
  client,
  is_root_page
ORDER BY
  client,
  is_root_page
