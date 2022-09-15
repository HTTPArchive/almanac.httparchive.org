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
  COUNT(0) AS total_sites,
  COUNTIF(num_priority_hints > 0) AS sites_using_priority_hints,
  COUNTIF(num_priority_hints > 0) / COUNT(0) AS sites_using_priority_hints_pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    getNumPriorityHints(payload) AS num_priority_hints
  FROM
    `httparchive.pages.2022_06_01_*`
)
GROUP BY
  client
ORDER BY
  client
