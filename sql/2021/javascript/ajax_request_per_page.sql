SELECT
  client,
  percentile,
  APPROX_QUANTILES(ajax_requests_total, 1000)[
    OFFSET(percentile * 10)] AS ajax_requests_total
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_EXTRACT(JSON_EXTRACT_SCALAR(payload,
          '$._javascript'),
        '$.ajax_requests.total') AS INT64) AS ajax_requests_total
  FROM
    `httparchive.pages.2021_07_01_*` ),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
WHERE
  ajax_requests_total > 0
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
