#standardSQL
# Counts of pages with IAB Frameworks (Transparency & Consent / US Privacy)

WITH pages_privacy AS (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_VALUE(payload, "$._privacy") AS metrics
  FROM
    `httparchive.pages.2021_08_01_*`
)

SELECT 
  *,
  100 * nb_websites_with_iab_tcf_v1 / nb_websites AS pct_websites_with_iab_tcf_v1,
  100 * nb_websites_with_iab_tcf_v2 / nb_websites AS pct_websites_with_iab_tcf_v2,
  100 * nb_websites_with_iab_tcf_v1_compliant / nb_websites_with_iab_tcf_v1 AS pct_websites_with_iab_tcf_v1_compliant,
  100 * nb_websites_with_iab_tcf_v2_compliant / nb_websites_with_iab_tcf_v2 AS pct_websites_with_iab_tcf_v2_compliant,
  100 * nb_websites_with_iab_tcf_any / nb_websites AS pct_websites_with_iab_tcf_any,
  100 * nb_websites_with_iab_usp / nb_websites AS pct_websites_with_iab_usp,
  100 * nb_websites_with_iab_any / nb_websites AS pct_websites_with_iab_any
FROM (
  SELECT 
    client,
    COUNT(0) AS nb_websites,
    COUNTIF(JSON_VALUE(metrics, "$.iab_tcf_v1.present") = "true") AS nb_websites_with_iab_tcf_v1,
    COUNTIF(JSON_VALUE(metrics, "$.iab_tcf_v2.present") = "true") AS nb_websites_with_iab_tcf_v2,
    COUNTIF(JSON_VALUE(metrics, "$.iab_tcf_v1.present") = "true" OR 
            JSON_VALUE(metrics, "$.iab_tcf_v2.present") = "true") AS nb_websites_with_iab_tcf_any,
    COUNTIF(JSON_VALUE(metrics, "$.iab_usp.present") = "true") AS nb_websites_with_iab_usp,
    COUNTIF(JSON_VALUE(metrics, "$.iab_tcf_v1.present") = "true" OR 
            JSON_VALUE(metrics, "$.iab_tcf_v2.present") = "true" OR
            JSON_VALUE(metrics, "$.iab_usp.present") = "true") AS nb_websites_with_iab_any,
    COUNTIF(JSON_VALUE(metrics, "$.iab_tcf_v1.present") = "true" AND
            JSON_VALUE(metrics, "$.iab_tcf_v1.compliant_setup") = "true") AS nb_websites_with_iab_tcf_v1_compliant,
    COUNTIF(JSON_VALUE(metrics, "$.iab_tcf_v2.present") = "true" AND
            JSON_VALUE(metrics, "$.iab_tcf_v2.compliant_setup") = "true") AS nb_websites_with_iab_tcf_v2_compliant,
  FROM
    pages_privacy
  GROUP BY
    client
)