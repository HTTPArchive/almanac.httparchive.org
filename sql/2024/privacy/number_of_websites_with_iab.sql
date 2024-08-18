# Counts of pages with IAB Frameworks (Transparency & Consent / US Privacy)

WITH privacy_custom_metrics_data AS (
  SELECT
    client,
    JSON_QUERY(custom_metrics, '$.privacy') AS metrics
  FROM `httparchive.all.pages`
  WHERE
    date = '2024-06-01' AND
    is_root_page = TRUE
)

SELECT
  client,
  number_of_pages_with_iab_tcf_v1 / number_of_pages AS pct_pages_with_iab_tcf_v1,
  number_of_pages_with_iab_tcf_v1,
  number_of_pages_with_iab_tcf_v2 / number_of_pages AS pct_pages_with_iab_tcf_v2,
  number_of_pages_with_iab_tcf_v2,
  number_of_pages_with_iab_usp / number_of_pages AS pct_pages_with_iab_usp,
  number_of_pages_with_iab_usp,
  number_of_pages_with_iab_tcf_any / number_of_pages AS pct_pages_with_iab_tcf_any,
  number_of_pages_with_iab_tcf_any,
  number_of_pages_with_iab_any / number_of_pages AS pct_pages_with_iab_any,
  number_of_pages_with_iab_any,
  number_of_pages_with_iab_tcf_v1_compliant / number_of_pages_with_iab_tcf_v1 AS pct_pages_with_iab_tcf_v1_compliant,
  number_of_pages_with_iab_tcf_v1_compliant,
  number_of_pages_with_iab_tcf_v2_compliant / number_of_pages_with_iab_tcf_v2 AS pct_pages_with_iab_tcf_v2_compliant,
  number_of_pages_with_iab_tcf_v2_compliant
FROM (
  SELECT
    client,
    COUNT(0) AS number_of_pages,
    COUNTIF(JSON_VALUE(metrics, '$.iab_tcf_v1.present') = 'true') AS number_of_pages_with_iab_tcf_v1,
    COUNTIF(JSON_VALUE(metrics, '$.iab_tcf_v2.present') = 'true') AS number_of_pages_with_iab_tcf_v2,
    COUNTIF(JSON_VALUE(metrics, '$.iab_usp.present') = 'true') AS number_of_pages_with_iab_usp,
    COUNTIF(
      JSON_VALUE(metrics, '$.iab_tcf_v1.present') = 'true' OR
      JSON_VALUE(metrics, '$.iab_tcf_v2.present') = 'true'
    ) AS number_of_pages_with_iab_tcf_any,
    COUNTIF(
      JSON_VALUE(metrics, '$.iab_tcf_v1.present') = 'true' OR
      JSON_VALUE(metrics, '$.iab_tcf_v2.present') = 'true' OR
      JSON_VALUE(metrics, '$.iab_usp.present') = 'true'
    ) AS number_of_pages_with_iab_any,
    COUNTIF(
      JSON_VALUE(metrics, '$.iab_tcf_v1.present') = 'true' AND
      JSON_VALUE(metrics, '$.iab_tcf_v1.compliant_setup') = 'true'
    ) AS number_of_pages_with_iab_tcf_v1_compliant,
    COUNTIF(
      JSON_VALUE(metrics, '$.iab_tcf_v2.present') = 'true' AND
      JSON_VALUE(metrics, '$.iab_tcf_v2.compliant_setup') = 'true'
    ) AS number_of_pages_with_iab_tcf_v2_compliant
  FROM privacy_custom_metrics_data
  GROUP BY client
)
