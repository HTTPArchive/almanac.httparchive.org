#standardSQL

# Number of resources with priority hints.

CREATE TEMPORARY FUNCTION getNumPriorityHints(payload STRING)
RETURNS INT LANGUAGE js AS """
try {
  const $ = JSON.parse(payload)
  const almanac = JSON.parse($._almanac);
  return almanac['priority-hints']['total'];
} catch (e) {
  return -1;
}
""";

SELECT
  client,
  percentile,
  APPROX_QUANTILES(num_priority_hints, 1000)[OFFSET(percentile * 10)] AS num_percentiles
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    getNumPriorityHints(payload) AS num_priority_hints
  FROM
    `httparchive.pages.2022_06_01_*`
),
  UNNEST([10, 25, 50, 75, 90, 95, 100]) AS percentile
GROUP BY
  client,
  percentile
ORDER BY
  client,
  percentile
