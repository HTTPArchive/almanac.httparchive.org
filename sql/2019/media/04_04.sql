#standardSQL
# 04_04: Inline SVGs
SELECT
  percentile,
  client,
  APPROX_QUANTILES(svg_elements, 1000)[OFFSET(percentile * 10)] AS svg_elements,
  APPROX_QUANTILES(svg_length, 1000)[OFFSET(percentile * 10)] AS svg_length
FROM (
  SELECT
    client,
    COUNT(svg) AS svg_elements,
    SUM(LENGTH(svg)) AS svg_length
  FROM
    `httparchive.almanac.summary_response_bodies`,
    UNNEST(REGEXP_EXTRACT_ALL(body, r'(?i)(<svg.*?/svg>)')) AS svg
  WHERE
    date = '2019-07-01' AND
    firstHtml
  GROUP BY
    client,
    page
),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
