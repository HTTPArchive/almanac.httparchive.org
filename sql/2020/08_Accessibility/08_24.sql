#standardSQL
# 08_24: Total anchors with role="button"
SELECT
  client,
  COUNT(0) AS total_sites,
  COUNTIF(total_anchors_follow + total_anchors_nofollow > 0) AS sites_with_anchors,
  COUNTIF(total_anchors_with_role_button > 0) AS sites_with_anchor_role_button,

  # Of sites that have anchors... how many have an anchor with a role="button"
  ROUND((COUNTIF(total_anchors_with_role_button > 0) / COUNTIF(total_anchors_follow + total_anchors_nofollow > 0)) * 100, 2) AS pct_sites_with_anchor_role_button
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, "$._a11y"), "$.total_anchors_with_role_button") AS INT64) AS total_anchors_with_role_button,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, "$._wpt_bodies"), "$.anchors.rendered.crawlable.follow") AS INT64) AS total_anchors_follow,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, "$._wpt_bodies"), "$.anchors.rendered.crawlable.nofollow") AS INT64) AS total_anchors_nofollow
  FROM
    `httparchive.almanac.pages_desktop_*`
)
GROUP BY
  client
