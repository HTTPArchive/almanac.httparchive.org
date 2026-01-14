-- noqa: disable=PRS
-- Counts of websites with IAB Frameworks

WITH base_data AS (
  SELECT
    client,
    root_page,
    SAFE.BOOL(custom_metrics.privacy.iab_tcf_v1.present) AS tcfv1,
    SAFE.BOOL(custom_metrics.privacy.iab_tcf_v2.present) AS tcfv2,
    SAFE.BOOL(custom_metrics.privacy.iab_gpp.present) AS gpp,
    SAFE.BOOL(custom_metrics.privacy.iab_usp.present) AS usp,
    SAFE.BOOL(custom_metrics.privacy.iab_tcf_v1.compliant_setup) AS tcfv1_compliant,
    SAFE.BOOL(custom_metrics.privacy.iab_tcf_v2.compliant_setup) AS tcfv2_compliant,
    custom_metrics.privacy.iab_gpp.data IS NOT NULL AS gpp_data
  FROM `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
    --AND rank = 1000
),

aggregated AS (
  SELECT
    client,
    COUNT(DISTINCT root_page) AS total_websites,
    COUNT(DISTINCT IF(tcfv1, root_page, NULL)) AS websites_with_tcfv1,
    COUNT(DISTINCT IF(tcfv2, root_page, NULL)) AS websites_with_tcfv2,
    COUNT(DISTINCT IF(usp, root_page, NULL)) AS websites_with_usp,
    COUNT(DISTINCT IF(tcfv1 OR tcfv2, root_page, NULL)) AS websites_with_tcf,
    COUNT(DISTINCT IF(tcfv1 OR tcfv2 OR usp OR gpp, root_page, NULL)) AS websites_with_any,
    COUNT(DISTINCT IF(tcfv1 AND tcfv1_compliant, root_page, NULL)) AS websites_with_tcfv1_compliant,
    COUNT(DISTINCT IF(tcfv2 AND tcfv2_compliant, root_page, NULL)) AS websites_with_tcfv2_compliant,
    COUNT(DISTINCT IF(gpp, root_page, NULL)) AS websites_with_gpp,
    COUNT(DISTINCT IF(gpp_data, root_page, NULL)) AS websites_with_gpp_data
  FROM base_data
  GROUP BY client
)

FROM aggregated,
  UNNEST([
    STRUCT('tcfv1' AS metric, websites_with_tcfv1 / total_websites AS pct_websites, websites_with_tcfv1 AS number_of_websites),
    STRUCT('tcfv2', websites_with_tcfv2 / total_websites, websites_with_tcfv2),
    STRUCT('usp', websites_with_usp / total_websites, websites_with_usp),
    STRUCT('tcf', websites_with_tcf / total_websites, websites_with_tcf),
    STRUCT('any_framework', websites_with_any / total_websites, websites_with_any),
    STRUCT('tcfv1_compliant', websites_with_tcfv1_compliant / total_websites, websites_with_tcfv1_compliant),
    STRUCT('tcfv2_compliant', websites_with_tcfv2_compliant / total_websites, websites_with_tcfv2_compliant),
    STRUCT('gpp', websites_with_gpp / total_websites, websites_with_gpp),
    STRUCT('gpp_data_available', websites_with_gpp_data / total_websites, websites_with_gpp_data)
  ]) AS metric
|> SELECT client, metric.metric, metric.pct_websites, metric.number_of_websites
|> PIVOT(
  ANY_VALUE(pct_websites) AS pct,
  ANY_VALUE(number_of_websites) AS websites_count
  FOR client IN ('desktop', 'mobile')
)
|> RENAME pct_mobile AS mobile, pct_desktop AS desktop
|> ORDER BY websites_count_desktop + websites_count_mobile DESC
