#standardSQL
# Percent of websites with third parties by ranking

WITH requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    pageid,
    url
  FROM
    `httparchive.summary_requests.2021_07_01_*`
),

third_party AS (
  SELECT
    domain
  FROM
    `httparchive.almanac.third_parties`
  WHERE
    date = '2021-07-01' AND
    category != 'hosting'
),

pages AS (
  SELECT
    _TABLE_SUFFIX AS client,
    pageid,
    rank
  FROM
    `httparchive.summary_pages.2021_07_01_*`
)

SELECT
  client,
  rank_grouping,
  COUNT(DISTINCT IF(domain IS NOT NULL, pageid, NULL)) AS pages_with_third_party,
  COUNT(DISTINCT pageid) AS total_pages,
  COUNT(DISTINCT IF(domain IS NOT NULL, pageid, NULL)) / COUNT(DISTINCT pageid) AS pct_pages_with_third_party
FROM
  pages
JOIN
  requests
USING (client, pageid)
LEFT JOIN
  third_party
ON NET.HOST(requests.url) = NET.HOST(third_party.domain),
  UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
WHERE
  rank <= rank_grouping
GROUP BY
  client,
  rank_grouping
ORDER BY
  client,
  rank_grouping
