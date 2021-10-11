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

SELECT
  client,
  percentile,
  rank_grouping,
  COUNT(DISTINCT page) AS pages,
  APPROX_QUANTILES(outgoing_link_metrics.same_site, 1000)[OFFSET(percentile * 10)] AS outgoing_links_same_site,
  APPROX_QUANTILES(outgoing_link_metrics.same_property, 1000)[OFFSET(percentile * 10)] AS outgoing_links_same_property,
  APPROX_QUANTILES(outgoing_link_metrics.other_property, 1000)[OFFSET(percentile * 10)] AS outgoing_links_other_property
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    getOutgoingLinkMetrics(payload) AS outgoing_link_metrics
  FROM
    `httparchive.pages.2021_07_01_*`
),
UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
LEFT JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    rank
  FROM
    `httparchive.summary_pages.2021_07_01_*`
)
USING
  (client, page),
  UNNEST([1e3, 1e4, 1e5, 1e6, 1e7]) AS rank_grouping
WHERE
  rank <= rank_grouping
GROUP BY
  client,
  rank_grouping,
  percentile
ORDER BY
  client,
  rank_grouping,
  percentile
