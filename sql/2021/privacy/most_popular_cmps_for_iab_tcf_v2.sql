#standardSQL
# Counts of CMPs using IAB Transparency & Consent Framework
# cf. https://github.com/InteractiveAdvertisingBureau/GDPR-Transparency-and-Consent-Framework/blob/master/TCFv2/IAB%20Tech%20Lab%20-%20CMP%20API%20v2.md#tcdata

WITH pages_privacy AS (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_EXTRACT_SCALAR(payload, "$._privacy") AS metrics
  FROM
    `httparchive.pages.2021_08_01_*`
)
, pages_iab_tcf_v2 AS (
  SELECT 
    client, 
    JSON_EXTRACT(metrics, "$.iab_tcf_v2") AS metrics
  FROM
    pages_privacy
  WHERE 
    JSON_EXTRACT(metrics, "$.iab_tcf_v2") is not null
)

SELECT 
  client,
  JSON_EXTRACT_SCALAR(metrics, '$.cmpId') cmpId,
  COUNT(0) AS nb_websites,
  COUNT(0) / (SELECT COUNT(0) FROM pages_iab_tcf_v2) pct_websites
FROM
  pages_iab_tcf_v2
WHERE
  JSON_EXTRACT_SCALAR(metrics, '$.cmpId') is not null
GROUP BY
  1, 2
