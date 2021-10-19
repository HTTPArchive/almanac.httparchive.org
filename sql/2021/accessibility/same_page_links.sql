#standardSQL
# % sites with links to to the same page, # or javascript:void
# NOTE: same_page.total includes empty hash links (#) but excludes all others (#foobar)
SELECT
  client,
  COUNT(0) AS total_sites,
  COUNTIF(total_anchors > 0) AS sites_with_anchors,

  COUNTIF(same_page > 0) AS has_same_page,
  COUNTIF(hash_only > 0) AS has_hash_only_link,
  COUNTIF(javascript_void > 0) AS has_javascript_void_links,

  COUNTIF(same_page > 0) / COUNTIF(total_anchors > 0) AS pct_has_same_page,
  COUNTIF(hash_only > 0) / COUNTIF(total_anchors > 0) AS pct_has_hash_only_link,
  COUNTIF(javascript_void > 0) / COUNTIF(total_anchors > 0) AS pct_has_javascript_void_links
FROM (
  SELECT
    _TABLE_SUFFIX AS client,

    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._wpt_bodies'), '$.anchors.rendered.same_page.total') AS INT64) AS same_page,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._wpt_bodies'), '$.anchors.rendered.hash_only_link') AS INT64) AS hash_only,
    CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._wpt_bodies'), '$.anchors.rendered.javascript_void_links') AS INT64) AS javascript_void,
    IFNULL(CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._element_count'), '$.a') AS INT64), 0) AS total_anchors
  FROM
    `httparchive.pages.2021_07_01_*`
)
GROUP BY
  client
