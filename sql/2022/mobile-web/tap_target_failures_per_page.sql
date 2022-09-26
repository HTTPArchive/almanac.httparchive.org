WITH tap_targets AS (
  SELECT
    ARRAY_LENGTH(JSON_QUERY_ARRAY(lighthouse, '$.audits."tap-targets".details.items')) AS failures
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2022-06-01' AND
    client = 'mobile' AND
    SAFE_CAST(JSON_VALUE(lighthouse, '$.audits."tap-targets".score') AS FLOAT64) < 0.9
)

SELECT
  percentile,
  APPROX_QUANTILES(failures, 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS failures_per_page
FROM
  tap_targets,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile
ORDER BY
  percentile
