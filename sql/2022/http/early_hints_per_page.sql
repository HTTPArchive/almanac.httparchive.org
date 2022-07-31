#standardSQL

# Distribution of number of early hints resources

SELECT
  client,
  percentile,
  COUNT(DISTINCT page) AS num_pages,
  APPROX_QUANTILES(num_reqs, 1000)[OFFSET(percentile * 10)] AS num_reqs,
  APPROX_QUANTILES(early_hints, 1000)[OFFSET(percentile * 10)] AS early_hints,
  APPROX_QUANTILES(pct_early_hints, 1000)[OFFSET(percentile * 10)] AS pct_early_hints
FROM
  (
    SELECT
      client,
      page,
      COUNT(0) AS num_reqs,
      COUNTIF(status = 103) AS early_hints,
      COUNTIF(status = 103) / COUNT(0) AS pct_early_hints
    FROM
      `httparchive.almanac.requests`
    WHERE
      date = '2022-06-01'
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
