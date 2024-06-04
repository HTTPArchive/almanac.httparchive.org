WITH pages AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    JSON_VALUE(payload, '$._performance.lcp_elem_stats.url') AS url,
    httparchive.core_web_vitals.GET_LAB_TTFB(payload) AS ttfb
  FROM
    `httparchive.pages.2022_06_01_*`
),

requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    page,
    url,
    CAST(JSON_QUERY(payload, '$._created') AS FLOAT64) AS lcp_req_time
  FROM
    `httparchive.requests.2022_06_01_*`
),

delays AS (
  SELECT
    client,
    CAST(lcp_req_time - ttfb AS INT64) AS lcp_resource_delay
  FROM
    pages
  JOIN
    requests
  USING (client, page, url)
  WHERE
    lcp_req_time IS NOT NULL AND
    lcp_req_time > 0 AND
    ttfb IS NOT NULL
)

SELECT
  percentile,
  client,
  APPROX_QUANTILES(lcp_resource_delay, 1000)[OFFSET(percentile * 10)] AS lcp_resource_delay
FROM
  delays,
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
