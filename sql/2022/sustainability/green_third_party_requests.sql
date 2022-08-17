#standardSQL
# Distribution of websites by number of third party & green third party requests

WITH requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    pageid AS page,
    url AS pageUrl
  FROM
    `httparchive.summary_requests.2022_06_01_*`
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
  ON NET.HOST(r.pageUrl) = NET.HOST(tp.domain)
  WHERE
    date = '2022-06-01' AND
    category != 'hosting'
  GROUP BY
    domain,
    canonicalDomain,
    category
  HAVING
    page_usage >= 50
),

green_requests AS (
  SELECT
    NET.HOST(url) AS host,
    TRUE AS is_green,
  FROM
    `httparchive.almanac.green_web_foundation` gwf
  JOIN
    requests r
  ON NET.HOST(r.pageUrl) = NET.HOST(gwf.host)
  WHERE
    date = '2022-06-01'
  GROUP BY
    host,
    is_green
),

base AS (
  SELECT
    client,
    page,
    COUNT(DISTINCT canonicalDomain) AS third_parties_per_page
  FROM
    requests
  LEFT JOIN
    third_party
  ON
    NET.HOST(requests.pageUrl) = NET.HOST(third_party.domain)
  GROUP BY
    client,
    page
),

base_green AS (
  SELECT
    client,
    page,
    COUNT(DISTINCT host) AS green_third_parties_per_page
  FROM
    requests
  LEFT JOIN
    green_requests
  ON
    NET.HOST(requests.pageUrl) = NET.HOST(green_requests.host)
  GROUP BY
    client,
    page
)

SELECT
  client,
  percentile,
  APPROX_QUANTILES(third_parties_per_page, 1000)[OFFSET(percentile * 10)] AS approx_third_parties_per_page,
  APPROX_QUANTILES(green_third_parties_per_page, 1000)[OFFSET(percentile * 10)] AS approx_green_third_parties_per_page
FROM
  base,
  UNNEST([10, 25, 50, 75, 90]) AS percentile
JOIN
  base_green
USING (client, page)
GROUP BY
  client,
  percentile
ORDER BY
  client,
  percentile
