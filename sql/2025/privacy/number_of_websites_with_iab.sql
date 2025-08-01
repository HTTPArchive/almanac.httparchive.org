# Counts of pages with IAB Frameworks
# TODO: check presence of multiple frameworks per page

WITH privacy_custom_metrics_data AS (
  SELECT
    client,
    JSON_QUERY(custom_metrics, '$.privacy') AS metrics
  FROM `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    is_root_page = TRUE
)

SELECT
  client,
  number_of_pages_with_tcfv1 / number_of_pages AS pct_pages_with_tcfv1,
  number_of_pages_with_tcfv1,
  number_of_pages_with_tcfv2 / number_of_pages AS pct_pages_with_tcfv2,
  number_of_pages_with_tcfv2,
  number_of_pages_with_usp / number_of_pages AS pct_pages_with_usp,
  number_of_pages_with_usp,
  number_of_pages_with_tcf / number_of_pages AS pct_pages_with_tcf,
  number_of_pages_with_tcf,
  number_of_pages_with_any / number_of_pages AS pct_pages_with_any,
  number_of_pages_with_any,
  number_of_pages_with_tcfv1_compliant / number_of_pages AS pct_pages_with_tcfv1_compliant,
  number_of_pages_with_tcfv1_compliant,
  number_of_pages_with_tcfv2_compliant / number_of_pages AS pct_pages_with_tcfv2_compliant,
  number_of_pages_with_tcfv2_compliant,
  number_of_pages_with_gpp / number_of_pages AS pct_pages_with_gpp,
  number_of_pages_with_gpp,
  number_of_pages_with_gpp_data / number_of_pages AS pct_pages_with_gpp_data,
  number_of_pages_with_gpp_data
FROM (
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
      JSON_VALUE(metrics, '$.iab_tcf_v1.present') = 'true' AS tcfv1,
      JSON_VALUE(metrics, '$.iab_tcf_v2.present') = 'true' AS tcfv2,
      JSON_VALUE(metrics, '$.iab_gpp.present') = 'true' AS gpp,
      JSON_VALUE(metrics, '$.iab_usp.present') = 'true' AS usp,
      JSON_VALUE(metrics, '$.iab_tcf_v1.compliant_setup') = 'true' AS tcfv1_compliant,
      JSON_VALUE(metrics, '$.iab_tcf_v2.compliant_setup') = 'true' AS tcfv2_compliant,
      JSON_VALUE(metrics, '$.iab_gpp.data') IS NOT NULL AS gpp_data
    FROM
      privacy_custom_metrics_data
  )
  GROUP BY client
)
