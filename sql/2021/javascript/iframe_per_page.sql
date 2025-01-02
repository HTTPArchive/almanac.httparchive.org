SELECT
  client,
  percentile,
  APPROX_QUANTILES(iframe_total, 1000)[
    OFFSET(percentile * 10)
  ] AS iframe_total
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_EXTRACT(JSON_EXTRACT_SCALAR(
      payload,
      '$._javascript'
    ),
    '$.iframe') AS INT64) AS iframe_total
  FROM
    `httparchive.pages.2021_07_01_*`
),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
WHERE
  iframe_total > 0
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
