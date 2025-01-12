SELECT
  client,
  percentile,
  APPROX_QUANTILES(xmlhttprequest_total, 1000)[
    OFFSET(percentile * 10)
  ] AS xmlhttprequest_total,
  APPROX_QUANTILES(fetch_total, 1000)[
    OFFSET(percentile * 10)
  ] AS fetch_total,
  APPROX_QUANTILES(beacon_total, 1000)[
    OFFSET(percentile * 10)
  ] AS beacon_total
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_EXTRACT(JSON_EXTRACT_SCALAR(
      payload,
      '$._javascript'
    ),
    '$.ajax_requests.xmlhttprequest') AS xmlhttprequest_total,
    JSON_EXTRACT(JSON_EXTRACT_SCALAR(
      payload,
      '$._javascript'
    ),
    '$.ajax_requests.fetch') AS fetch_total,
    JSON_EXTRACT(JSON_EXTRACT_SCALAR(
      payload,
      '$._javascript'
    ),
    '$.ajax_requests.beacon') AS beacon_total
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
