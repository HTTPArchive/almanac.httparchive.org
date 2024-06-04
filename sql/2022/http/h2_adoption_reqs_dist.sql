#standardSQL

# Distribution of requests being on HTTP/2 vs HTTP/1.1

SELECT
  client,
  http_version_category,
  percentile,
  APPROX_QUANTILES(num_reqs, 1000)[OFFSET(percentile * 10)] AS num_reqs,
  APPROX_QUANTILES(total_reqs, 1000)[OFFSET(percentile * 10)] AS total_reqs,
  APPROX_QUANTILES(pct_reqs, 1000)[OFFSET(percentile * 10)] AS pct_reqs
FROM (
  SELECT
    client,
    page,
    CASE
      WHEN LOWER(protocol) = 'quic' OR LOWER(protocol) LIKE 'h3%' THEN 'HTTP/2+'
      WHEN LOWER(protocol) = 'http/2' OR LOWER(protocol) = 'http/3' THEN 'HTTP/2+'
      ELSE 'non-HTTP/2'
    END AS http_version_category,
    COUNT(0) AS num_reqs,
    SUM(COUNT(0)) OVER (PARTITION BY client, page) AS total_reqs,
    COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client, page) AS pct_reqs
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2022-06-01'
  GROUP BY
    client,
    page,
    http_version_category
  ORDER BY
    client ASC,
    num_reqs
),
  UNNEST(GENERATE_ARRAY(1, 100)) AS percentile
GROUP BY
  client,
  http_version_category,
  percentile
ORDER BY
  client,
  percentile
