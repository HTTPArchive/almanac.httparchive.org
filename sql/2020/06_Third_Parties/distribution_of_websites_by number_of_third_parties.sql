#standardSQL
# Distribution of websites by number of third party

WITH requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    pageid AS page,
    req_host AS host
  FROM
    `httparchive.summary_requests.2020_08_01_*`
),
third_party AS (
  SELECT
    domain
  FROM
    `httparchive.almanac.third_parties`
  WHERE
    date = '2020-08-01'
),
base AS (
  SELECT
    client,
    page,
    COUNT(domain) AS third_parties_per_page
  FROM
    requests
  LEFT JOIN
    third_party
  ON
    NET.HOST(requests.host) = NET.HOST(third_party.domain)
  GROUP BY
    client,
    page
)

SELECT
  client,
  percentile,
  APPROX_QUANTILES(third_parties_per_page, 1000)[OFFSET(percentile)] AS approx_third_parties_per_page
FROM
  base,
UNNEST(GENERATE_ARRAY(0, 1000, 1)) AS percentile
GROUP BY
  client,
  percentile
ORDER BY
  client,
  percentile
