#standardSQL
# Counts of pages with IAB Frameworks (Transparency & Consent / US Privacy)

SELECT
  *,
  nb_websites_with_iab_tcf_v1 / nb_websites AS pct_websites_with_iab_tcf_v1,
  nb_websites_with_iab_tcf_v2 / nb_websites AS pct_websites_with_iab_tcf_v2,
  nb_websites_with_iab_tcf_v1_compliant / nb_websites_with_iab_tcf_v1 AS pct_websites_with_iab_tcf_v1_compliant,
  nb_websites_with_iab_tcf_v2_compliant / nb_websites_with_iab_tcf_v2 AS pct_websites_with_iab_tcf_v2_compliant,
  nb_websites_with_iab_tcf_any / nb_websites AS pct_websites_with_iab_tcf_any,
  nb_websites_with_iab_usp / nb_websites AS pct_websites_with_iab_usp,
  nb_websites_with_iab_any / nb_websites AS pct_websites_with_iab_any
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS nb_websites,
    COUNTIF(JSON_VALUE(metrics, "$._privacy.iab_tcf_v1.present") = "true") AS nb_websites_with_iab_tcf_v1,
    COUNTIF(JSON_VALUE(metrics, "$._privacy.iab_tcf_v2.present") = "true") AS nb_websites_with_iab_tcf_v2,
    COUNTIF(JSON_VALUE(metrics, "$._privacy.iab_tcf_v1.present") = "true" OR
                       JSON_VALUE(metrics, "$._privacy.iab_tcf_v2.present") = "true") AS nb_websites_with_iab_tcf_any,
    COUNTIF(JSON_VALUE(metrics, "$._privacy.iab_usp.present") = "true") AS nb_websites_with_iab_usp,
    COUNTIF(JSON_VALUE(metrics, "$._privacy.iab_tcf_v1.present") = "true" OR
                       JSON_VALUE(metrics, "$._privacy.iab_tcf_v2.present") = "true" OR
      JSON_VALUE(metrics, "$._privacy.iab_usp.present") = "true") AS nb_websites_with_iab_any,
    COUNTIF(JSON_VALUE(metrics, "$._privacy.iab_tcf_v1.present") = "true" AND
                       JSON_VALUE(metrics, "$._privacy.iab_tcf_v1.compliant_setup") = "true") AS nb_websites_with_iab_tcf_v1_compliant,
    COUNTIF(JSON_VALUE(metrics, "$._privacy.iab_tcf_v2.present") = "true" AND
                       JSON_VALUE(metrics, "$._privacy.iab_tcf_v2.compliant_setup") = "true") AS nb_websites_with_iab_tcf_v2_compliant
  FROM
    `httparchive.pages.2021_07_01_*`
  GROUP BY
    client
)
ORDER BY
  client ASC
