# Note: using response bodies here instead of parsed CSS.
# The parser doesn't quite support the @layer syntax yet, resulting in errors.
# Because the table is clustered, this query is actually cheaper than querying parsed_css.
WITH layers AS (
  SELECT
    client,
    page,
    url,
    REGEXP_CONTAINS(body, r'\b@layer\b') AS has_layer
  FROM
    `httparchive.almanac.summary_response_bodies`
  WHERE
    date = '2022-06-01' AND
    type = 'css'
), layers_per_page AS (
  SELECT
    client,
    COUNTIF(has_layer) AS layers
  FROM
    layers
  GROUP BY
    client,
    page
)


SELECT
  percentile,
  client,
  APPROX_QUANTILES(layers, 1000)[OFFSET(percentile * 10)] AS layers
FROM
  layers_per_page,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
