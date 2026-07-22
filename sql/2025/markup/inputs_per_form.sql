WITH inputs AS (
  SELECT
    client,
    inputs_per_form
  FROM
    `httparchive.crawl.pages`,
    UNNEST(
      ARRAY(
        SELECT LAX_INT64(item.total)
        FROM UNNEST(JSON_QUERY_ARRAY(custom_metrics.markup.form.elements)) AS item
      )
    ) AS inputs_per_form
  WHERE
    date = '2025-07-01'
)

SELECT
  percentile,
  client,
  APPROX_QUANTILES(inputs_per_form, 1000)[OFFSET(percentile * 10)] AS inputs_per_form
FROM
  inputs,
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
