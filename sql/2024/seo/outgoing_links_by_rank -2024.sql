#standardSQL
# Internal and external link metrics by quantile and rank

CREATE TEMPORARY FUNCTION getOutgoingLinkMetrics(payload STRING)
RETURNS STRUCT<
  same_site INT64,
  same_property INT64,
  other_property INT64
> LANGUAGE js AS '''
var result = {same_site: 0,
              same_property: 0,
              other_property: 0};

try {
    var $ = JSON.parse(payload);
    var wpt_bodies  = JSON.parse($._wpt_bodies);

    if (!wpt_bodies){
        return result;
    }

    var anchors = wpt_bodies.anchors;

    if (anchors){
      result.same_site = anchors.rendered.same_site;
      result.same_property = anchors.rendered.same_property;
      result.other_property = anchors.rendered.other_property;
    }

} catch (e) {}

return result;
''';

WITH page_metrics AS (
  SELECT
    client,
    page,
    getOutgoingLinkMetrics(payload) AS outgoing_link_metrics,
    JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._wpt_bodies'), '$.is_root_page') AS is_root_page
  FROM
    `httparchive.all.pages` 
  WHERE
    DATE = '2024-06-01'
)

SELECT
  client,
  CASE
    WHEN is_root_page = 'false' THEN 'Secondary Page'
    ELSE 'Homepage'
  END AS page_type,
  percentile,
  rank_grouping,
  CASE
    WHEN rank_grouping = 100000000 THEN 'all'
    ELSE FORMAT("%'d", rank_grouping)
  END AS ranking,
  COUNT(DISTINCT page) AS pages,
  APPROX_QUANTILES(outgoing_link_metrics.same_site, 1000)[OFFSET(percentile * 10)] AS outgoing_links_same_site,
  APPROX_QUANTILES(outgoing_link_metrics.same_property, 1000)[OFFSET(percentile * 10)] AS outgoing_links_same_property,
  APPROX_QUANTILES(outgoing_link_metrics.other_property, 1000)[OFFSET(percentile * 10)] AS outgoing_links_other_property
FROM 
  page_metrics,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile,
  UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS rank_grouping
GROUP BY
  client,
  page_type,
  rank_grouping,
  percentile
ORDER BY
  client,
  page_type,
  rank_grouping,
  percentile