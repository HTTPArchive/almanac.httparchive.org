#standardSQL
CREATE TEMPORARY FUNCTION getGeneratedContent(custom_metrics STRING)
RETURNS STRUCT<percent FLOAT64, sizeInKB FLOAT64> LANGUAGE js AS '''
try {
  const data = JSON.parse(custom_metrics);
  const generatedData = data.other["generated-content"];

  const percent = parseFloat(generatedData.percent);
  const sizeInKB = parseFloat(generatedData.sizeInKB);

  return {
    percent: percent > 0 ? percent : 0,
    sizeInKB: sizeInKB > 0 ? sizeInKB : 0
  };
} catch (e) {
  return null;
}
''';

WITH crux AS (
  SELECT
    CONCAT(origin, '/') AS page,
    CASE
      WHEN device = 'phone' THEN 'mobile'
      ELSE device
    END AS client
  FROM
    `chrome-ux-report.materialized.device_summary`
  WHERE
    device IN ('desktop', 'phone') AND
    -- TODO: Update `date` once CrUX data is available for June 2025.
    date IN ('2025-05-01')
),

pages AS (
  SELECT
    client,
    page,
    getGeneratedContent(TO_JSON_STRING(custom_metrics)) AS generated_content
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-06-01' AND
    is_root_page
)

SELECT
  client,
  percentile,
  APPROX_QUANTILES(generated_content_percent, 1000)[OFFSET(percentile * 10)] AS generated_content_percent,
  APPROX_QUANTILES(generated_content_sizeInKB, 1000)[OFFSET(percentile * 10)] AS generated_content_sizeInKB,
  COUNT(0) AS total
FROM (
  SELECT
    client,
    page,
    generated_content.percent AS generated_content_percent,
    generated_content.sizeInKB AS generated_content_sizeInKB
  FROM
    pages
  JOIN
    crux
  USING (client, page)
),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
WHERE
  generated_content_percent IS NOT NULL AND
  generated_content_sizeInKB IS NOT NULL
GROUP BY
  client,
  percentile
ORDER BY
  client,
  percentile
