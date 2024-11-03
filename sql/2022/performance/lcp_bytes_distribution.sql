WITH pages AS (
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_VALUE(payload, '$._metadata.page_id') AS INT64) AS pageid,
    JSON_VALUE(payload, '$._performance.lcp_elem_stats.url') AS url
  FROM
    `httparchive.pages.2022_06_01_*`
),

requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    pageid,
    url,
    respSize / 1024 AS kbytes
  FROM
    `httparchive.summary_requests.2022_06_01_*`
)

SELECT
  percentile,
  client,
  APPROX_QUANTILES(kbytes, 1000)[OFFSET(percentile * 10)] AS kbytes
FROM
  pages
JOIN
  requests
USING (client, pageid, url),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
