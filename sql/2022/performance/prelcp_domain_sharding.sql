WITH requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    page,
    NET.HOST(url) AS host,
    CAST(JSON_QUERY(payload, '$._all_start') AS INT64) AS req_start
  FROM
    `httparchive.requests.2022_06_01_*`
),

lcp AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    httparchive.core_web_vitals.GET_LAB_LCP(payload) AS lcp_time
  FROM
    `httparchive.pages.2022_06_01_*`
),

hosts AS (
  SELECT
    client,
    COUNT(DISTINCT host) AS pre_lcp_hosts,
    ANY_VALUE(lcp_time) AS lcp
  FROM
    lcp
  JOIN
    requests
  USING (client, page)
  WHERE
    req_start <= lcp_time
  GROUP BY
    client,
    page
)

SELECT
  percentile,
  client,
  CASE
    WHEN lcp <= 2500 THEN 'good'
    WHEN lcp > 4000 THEN 'poor'
    ELSE 'needs improvement'
  END AS lcp,
  COUNT(0) AS pages,
  APPROX_QUANTILES(pre_lcp_hosts, 1000)[OFFSET(percentile * 10)] AS pre_lcp_hosts
FROM
  hosts,
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client,
  lcp
ORDER BY
  percentile,
  client,
  lcp
