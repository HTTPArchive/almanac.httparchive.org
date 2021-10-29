#standardSQL
# Number of third-parties per websites by rank and category

WITH requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    pageid AS page,
    url
  FROM
    `httparchive.summary_requests.2021_07_01_*`
),

pages AS (
  SELECT
    _TABLE_SUFFIX AS client,
    pageid AS page,
    rank
  FROM
    `httparchive.summary_pages.2021_07_01_*`
),

third_party AS (
  SELECT
    domain,
    canonicalDomain,
    category,
    COUNT(DISTINCT page) AS page_usage
  FROM
    `httparchive.almanac.third_parties` tp
  JOIN
    requests r
  ON NET.HOST(r.url) = NET.HOST(tp.domain)
  WHERE
    date = '2021-07-01' AND
    category NOT IN ('hosting')
  GROUP BY
    domain,
    canonicalDomain,
    category
  HAVING
    page_usage >= 50
),

base AS (
  SELECT
    client,
    category,
    page,
    rank,
    COUNT(canonicalDomain) AS third_parties_per_page
  FROM
    requests
  LEFT JOIN
    third_party
  ON
    NET.HOST(requests.url) = NET.HOST(third_party.domain)
  INNER JOIN
    pages
  USING
    (client, page)
  GROUP BY
    client,
    category,
    page,
    rank
)

SELECT
  client,
  category,
  rank_grouping,
  APPROX_QUANTILES(third_parties_per_page, 1000)[OFFSET(500)] AS p50_third_parties_per_page
FROM
  base,
  UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
WHERE
  rank <= rank_grouping
GROUP BY
  client,
  category,
  rank_grouping
ORDER BY
  client,
  category,
  rank_grouping
