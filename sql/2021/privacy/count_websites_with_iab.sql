#standardSQL
# Counts of pages with IAB Frameworks (Transparency & Consent / US Privacy)

WITH pages_privacy AS (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_EXTRACT_SCALAR(payload, "$._privacy") AS metrics
  FROM
    `httparchive.pages.2021_08_01_*`
)

SELECT 
  *,
  nb_websites_with_iab_tcf_v1 / nb_websites AS pct_websites_with_iab_tcf_v1,
  nb_websites_with_iab_tcf_v2 / nb_websites AS pct_websites_with_iab_tcf_v2,
  nb_websites_with_iab_tcf_any / nb_websites AS pct_websites_with_iab_tcf_any
  nb_websites_with_iab_usp / nb_websites AS pct_websites_with_iab_usp,
  nb_websites_with_iab_any / nb_websites AS pct_websites_with_iab_any
FROM (
  SELECT 
    client,
    COUNT(0) AS nb_websites,
    COUNTIF(JSON_EXTRACT_SCALAR(metrics, "$.iab_tcf_v1") = 1) AS nb_websites_with_iab_tcf_v1,
    COUNTIF(JSON_EXTRACT(metrics, "$.iab_tcf_v2") is not null) AS nb_websites_with_iab_tcf_v2,
    COUNTIF((JSON_EXTRACT_SCALAR(metrics, "$.iab_tcf_v1") = 1) OR 
            (JSON_EXTRACT(metrics, "$.iab_tcf_v2") is not null)) AS nb_websites_with_iab_tcf_any,
    COUNTIF(JSON_EXTRACT(metrics, "$.iab_usp") is not null) AS nb_websites_with_iab_usp,
    COUNTIF((JSON_EXTRACT_SCALAR(metrics, "$.iab_tcf_v1") = 1) OR 
            (JSON_EXTRACT(metrics, "$.iab_tcf_v2") is not null) OR 
            (JSON_EXTRACT(metrics, "$.iab_usp") is not null)) AS nb_websites_with_iab_any,
  FROM
    pages_privacy
  GROUP BY
    client
)