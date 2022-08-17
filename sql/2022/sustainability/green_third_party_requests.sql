#standardSQL
# Median number of third-parties & green third-party requests per websites by rank

WITH requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    pageid AS page,
    url
  FROM
    `httparchive.summary_requests.2022_06_01_*`
),

green AS (
  SELECT
    NET.HOST(url) AS host,
    TRUE AS is_green
  FROM
    `httparchive.almanac.green_web_foundation`
  WHERE
    date = '2022-06-01'
),

pages AS (
  SELECT
    _TABLE_SUFFIX AS client,
    pageid AS page,
    rank
  FROM
    `httparchive.summary_pages.2022_06_01_*`
),

third_party AS (
  SELECT
    domain,
    canonicalDomain,
    COUNT(DISTINCT page) AS page_usage
  FROM
    `httparchive.almanac.third_parties` tp
  JOIN
    requests r
  ON NET.HOST(r.url) = NET.HOST(tp.domain)
  WHERE
    date = '2022-06-01' AND
    category NOT IN ('hosting')
  GROUP BY
    domain,
    canonicalDomain
  HAVING
    page_usage >= 50
),

green_tp AS (
  SELECT
    domain,
    canonicalDomain,
  FROM
    `httparchive.almanac.third_parties` tp
  JOIN
    green g
  ON NET.HOST(g.host) = NET.HOST(tp.domain)
  WHERE
    date = '2022-06-01' AND
    category NOT IN ('hosting')
  GROUP BY
    domain,
    canonicalDomain
),

base AS (
  SELECT
    client,
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
    page,
    rank
),

base_green AS (
  SELECT
    client,
    page,
    rank,
    COUNT(canonicalDomain) AS green_third_parties_per_page
  FROM
    requests
  LEFT JOIN
    green_tp
  ON
    NET.HOST(requests.url) = NET.HOST(green_tp.domain)
  INNER JOIN
    pages
  USING
    (client, page)
  GROUP BY
    client,
    page,
    rank
)

SELECT
  client,
  rank_grouping,
  APPROX_QUANTILES(third_parties_per_page, 1000)[OFFSET(500)] AS p50_third_parties_per_page,
  APPROX_QUANTILES(green_third_parties_per_page, 1000)[OFFSET(500)] AS p50_green_third_parties_per_page
FROM
  base,
  UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
JOIN
  base_green
USING (client, page, rank)
WHERE
  rank <= rank_grouping
GROUP BY
  client,
  rank_grouping
ORDER BY
  client,
  rank_grouping
