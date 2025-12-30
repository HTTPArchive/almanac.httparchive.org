#standardSQL
# Internal and external link metrics by quantile and rank
WITH page_metrics AS (
  SELECT
    client,
    page,
    is_root_page,
    IF(rank <= rank_bucket, rank_bucket, NULL) AS rank,
    ANY_VALUE(custom_metrics.wpt_bodies.anchors) AS anchors
  FROM
    httparchive.crawl.pages,
    UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS rank_bucket
  WHERE
    date = '2025-07-01'
  GROUP BY
    client,
    page,
    is_root_page,
    rank
  HAVING
    rank IS NOT NULL
),

metric_details AS (
  SELECT
    client,
    is_root_page,
    percentile,
    rank,
    APPROX_QUANTILES(INT64(anchors.rendered.same_site), 1000)[OFFSET(percentile * 10)] AS outgoing_links_same_site,
    APPROX_QUANTILES(INT64(anchors.rendered.same_property), 1000)[OFFSET(percentile * 10)] AS outgoing_links_same_property,
    APPROX_QUANTILES(INT64(anchors.rendered.other_property), 1000)[OFFSET(percentile * 10)] AS outgoing_links_other_property
  FROM
    page_metrics,
    UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
  GROUP BY
    client,
    is_root_page,
    rank,
    percentile
  ORDER BY
    client,
    is_root_page,
    rank,
    percentile
),

page_counts AS (
  SELECT
    client,
    is_root_page,
    rank,
    COUNT(DISTINCT page) AS total_pages
  FROM
    page_metrics
  GROUP BY
    client,
    is_root_page,
    rank
)

SELECT
  client,
  is_root_page,
  rank,
  total_pages,
  percentile,
  outgoing_links_same_site,
  outgoing_links_same_property,
  outgoing_links_other_property
FROM
  metric_details
LEFT JOIN
  page_counts
USING (client, is_root_page, rank)
ORDER BY
  client,
  is_root_page,
  rank,
  percentile
