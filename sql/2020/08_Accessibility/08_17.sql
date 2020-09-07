#standardSQL
# 08_17: Sites containing elements with role="tab", aria-selected and aria-controls attributes
CREATE TEMPORARY FUNCTION hasTabSelectedControls(payload STRING)
RETURNS BOOL LANGUAGE js AS '''
try {
  const $ = JSON.parse(payload);
  const almanac = JSON.parse($._almanac);

  if (!almanac.attributes_used_on_elements['aria-selected']) {
    return false;
  }

  if (!almanac.attributes_used_on_elements['aria-controls']) {
    return false;
  }

  if (!almanac.nodes_using_role.usage_and_count.tab) {
    return false;
  }

  return true;
} catch (e) {
  return false;
}
''';

SELECT
  client,
  COUNT(0) AS total_sites,

  COUNTIF(has_tab_selected_controls) AS total_with_tab_selected_controls,
  ROUND((COUNTIF(has_tab_selected_controls) / COUNT(0)) * 100, 2) AS pct_with_tab_selected_controls
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    hasTabSelectedControls(payload) AS has_tab_selected_controls
  FROM
    `httparchive.almanac.pages_desktop_*`
)
GROUP BY
  client
