SELECT
  client,
  percentile,
  APPROX_QUANTILES((ajax_h1 + resources_h1), 1000)[
    OFFSET(percentile * 10)
  ] AS h1_request,
  APPROX_QUANTILES((ajax_h2 + resources_h2), 1000)[
    OFFSET(percentile * 10)
  ] AS h2_request,
  APPROX_QUANTILES((ajax_h3 + resources_h3), 1000)[
    OFFSET(percentile * 10)
  ] AS h3_request
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_EXTRACT(JSON_EXTRACT_SCALAR(
      payload,
      '$._javascript'
    ),
    '$.requests_protocol.ajax_h1') AS INT64) AS ajax_h1,
    CAST(JSON_EXTRACT(JSON_EXTRACT_SCALAR(
      payload,
      '$._javascript'
    ),
    '$.requests_protocol.resources_h1') AS INT64) AS resources_h1,
    CAST(JSON_EXTRACT(JSON_EXTRACT_SCALAR(
      payload,
      '$._javascript'
    ),
    '$.requests_protocol.ajax_h2') AS INT64) AS ajax_h2,
    CAST(JSON_EXTRACT(JSON_EXTRACT_SCALAR(
      payload,
      '$._javascript'
    ),
    '$.requests_protocol.resources_h2') AS INT64) AS resources_h2,
    CAST(JSON_EXTRACT(JSON_EXTRACT_SCALAR(
      payload,
      '$._javascript'
    ),
    '$.requests_protocol.ajax_h3') AS INT64) AS ajax_h3,
    CAST(JSON_EXTRACT(JSON_EXTRACT_SCALAR(
      payload,
      '$._javascript'
    ),
    '$.requests_protocol.resources_h3') AS INT64) AS resources_h3
  FROM
    `httparchive.pages.2021_07_01_*`
),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
