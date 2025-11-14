-- Counts of pages with IAB Frameworks
-- TODO: check presence of multiple frameworks per page

WITH privacy_custom_metrics_data AS (
  SELECT
    client,
    COUNT(0) AS number_of_pages,
    COUNTIF(tcfv1) AS number_of_pages_with_tcfv1,
    COUNTIF(tcfv2) AS number_of_pages_with_tcfv2,
    COUNTIF(usp) AS number_of_pages_with_usp,
    COUNTIF(tcfv1 OR tcfv2) AS number_of_pages_with_tcf,
    COUNTIF(tcfv1 OR tcfv2 OR usp OR gpp) AS number_of_pages_with_any,
    COUNTIF(tcfv1 AND tcfv1_compliant) AS number_of_pages_with_tcfv1_compliant,
    COUNTIF(tcfv2 AND tcfv2_compliant) AS number_of_pages_with_tcfv2_compliant,
    COUNTIF(gpp) AS number_of_pages_with_gpp,
    COUNTIF(gpp_data) AS number_of_pages_with_gpp_data
  FROM (
    SELECT
      client,
      SAFE.BOOL(metrics.iab_tcf_v1.present) AS tcfv1,
      SAFE.BOOL(metrics.iab_tcf_v2.present) AS tcfv2,
      SAFE.BOOL(metrics.iab_gpp.present) AS gpp,
      SAFE.BOOL(metrics.iab_usp.present) AS usp,
      SAFE.BOOL(metrics.iab_tcf_v1.compliant_setup) AS tcfv1_compliant,
      SAFE.BOOL(metrics.iab_tcf_v2.compliant_setup) AS tcfv2_compliant,
      metrics.iab_gpp.data IS NOT NULL AS gpp_data
    FROM (
      SELECT
        client,
        custom_metrics.privacy AS metrics
      FROM `httparchive.crawl.pages`
      WHERE
        date = '2025-07-01' AND
        is_root_page = TRUE
    )
  )
  GROUP BY client
)

SELECT
  client,
  metric.metric,
  metric.pct_pages,
  metric.number_of_pages
FROM (
  SELECT
    client,
    ARRAY<STRUCT<
      metric STRING,
      pct_pages FLOAT64,
      number_of_pages INT64
    >>[STRUCT(
      'tcfv1',
      number_of_pages_with_tcfv1 / number_of_pages,
      number_of_pages_with_tcfv1
    ), STRUCT(
      'tcfv2',
      number_of_pages_with_tcfv2 / number_of_pages,
      number_of_pages_with_tcfv2
    ), STRUCT(
      'usp',
      number_of_pages_with_usp / number_of_pages,
      number_of_pages_with_usp
    ), STRUCT(
      'tcf',
      number_of_pages_with_tcf / number_of_pages,
      number_of_pages_with_tcf
    ), STRUCT(
      'any_framework',
      number_of_pages_with_any / number_of_pages,
      number_of_pages_with_any
    ), STRUCT(
      'tcfv1_compliant',
      number_of_pages_with_tcfv1_compliant / number_of_pages,
      number_of_pages_with_tcfv1_compliant
    ), STRUCT(
      'tcfv2_compliant',
      number_of_pages_with_tcfv2_compliant / number_of_pages,
      number_of_pages_with_tcfv2_compliant
    ), STRUCT(
      'gpp',
      number_of_pages_with_gpp / number_of_pages,
      number_of_pages_with_gpp
    ), STRUCT(
      'gpp_data_available',
      number_of_pages_with_gpp_data / number_of_pages,
      number_of_pages_with_gpp_data
    )] AS metrics
  FROM privacy_custom_metrics_data
),
  UNNEST(metrics) AS metric
ORDER BY
  client;
