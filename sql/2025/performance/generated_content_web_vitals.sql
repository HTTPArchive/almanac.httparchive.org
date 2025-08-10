#standardSQL
CREATE TEMP FUNCTION IS_NON_ZERO(good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  good + needs_improvement + poor > 0
);

CREATE TEMPORARY FUNCTION IS_GOOD(good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  SAFE_DIVIDE(good, (good + needs_improvement + poor)) >= 0.75
);

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
    origin,
    CASE
      WHEN device = 'phone' THEN 'mobile'
      ELSE device
    END AS client,

    fast_inp,
    avg_inp,
    slow_inp,

    fast_lcp,
    avg_lcp,
    slow_lcp,

    small_cls,
    medium_cls,
    large_cls

  FROM
    `chrome-ux-report.materialized.device_summary`
  WHERE
    device IN ('desktop', 'phone') AND
    date IN ('2025-07-01')
),

pages AS (
  SELECT
    client,
    page,
    getGeneratedContent(TO_JSON_STRING(custom_metrics)) AS generated_content
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    is_root_page
)

SELECT
  client,
  generated_content_percent,
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
      IS_GOOD(fast_lcp, avg_lcp, slow_lcp), origin, NULL
    )),
    COUNT(DISTINCT IF(
      IS_NON_ZERO(fast_lcp, avg_lcp, slow_lcp), origin, NULL
    ))
  ) AS pct_lcp_good,

  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
      IS_GOOD(fast_inp, avg_inp, slow_inp), origin, NULL
    )),
    COUNT(DISTINCT IF(
      IS_NON_ZERO(fast_inp, avg_inp, slow_inp), origin, NULL
    ))
  ) AS pct_inp_good,

  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
      IS_GOOD(small_cls, medium_cls, large_cls), origin, NULL
    )),
    COUNT(DISTINCT IF(
      IS_NON_ZERO(small_cls, medium_cls, large_cls), origin, NULL
    ))
  ) AS pct_cls_good,
  COUNT(DISTINCT origin) AS total_origins
FROM (
  SELECT
    client,
    page,
    origin,

    fast_inp,
    avg_inp,
    slow_inp,

    fast_lcp,
    avg_lcp,
    slow_lcp,

    small_cls,
    medium_cls,
    large_cls,

    CASE
      WHEN generated_content.percent >= 0.9 THEN '0.9-1.0'
      WHEN generated_content.percent >= 0.8 THEN '0.8-0.9'
      WHEN generated_content.percent >= 0.7 THEN '0.7-0.8'
      WHEN generated_content.percent >= 0.6 THEN '0.6-0.7'
      WHEN generated_content.percent >= 0.5 THEN '0.5-0.6'
      WHEN generated_content.percent >= 0.4 THEN '0.4-0.5'
      WHEN generated_content.percent >= 0.3 THEN '0.3-0.4'
      WHEN generated_content.percent >= 0.2 THEN '0.2-0.3'
      WHEN generated_content.percent >= 0.1 THEN '0.1-0.2'
      ELSE '0.0-0.1'
    END AS generated_content_percent
  FROM
    pages
  JOIN
    crux
  USING (client, page)
)
WHERE
  generated_content_percent IS NOT NULL
GROUP BY
  client,
  generated_content_percent
ORDER BY
  client,
  generated_content_percent
