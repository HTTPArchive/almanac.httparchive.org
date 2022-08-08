#standardSQL

# Distribution of requests being on HTTP/2 vs HTTP/1.1

SELECT
  client,
  percentile,
  COUNT(DISTINCT page) AS num_pages,
  APPROX_QUANTILES(num_pushed, 1000)[OFFSET(percentile * 10)] AS pct_num_pushed,
  APPROX_QUANTILES(transfered_KiB, 1000)[OFFSET(percentile * 10)] AS pct_transfered_KiB
FROM
  (
    SELECT
      client,
      page,
      SUM(respSize / 1024) AS transfered_KiB,
      COUNT(0) AS num_pushed
    FROM
      `httparchive.almanac.requests`
    WHERE
      date = '2022-06-01' AND
      pushed = '1' AND
      (
        LOWER(protocol) = 'http/2' OR
        LOWER(protocol) LIKE '%quic%' OR
        LOWER(protocol) LIKE 'h3%' OR
        LOWER(protocol) = 'http/3'
      )
    GROUP BY
      client,
      page
    ORDER BY
      client ASC
  ),
  UNNEST(GENERATE_ARRAY(1, 100)) AS percentile
GROUP BY
  client,
  percentile
ORDER BY
  client,
  percentile
