#standardSQL
# Counts of CMPs using IAB Transparency & Consent Framework
# cf. https://github.com/InteractiveAdvertisingBureau/GDPR-Transparency-and-Consent-Framework/blob/master/TCFv2/IAB%20Tech%20Lab%20-%20CMP%20API%20v2.md#tcdata

WITH pages_iab_tcf_v2 AS (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_QUERY(payload, "$._privacy.iab_tcf_v2.data") AS metrics
  FROM
    `httparchive.pages.2021_07_01_*`
  WHERE
    JSON_QUERY(metrics, "$.iab_tcf_v2.data") IS NOT NULL
),

total_nb_pages AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_nb_pages
  FROM
    `httparchive.pages.2021_07_01_*`
  GROUP BY
    client
)

SELECT
  client,
  JSON_VALUE(metrics, '$.cmpId') AS cmpId,
  COUNT(0) AS nb_websites,
  COUNT(0) / MIN(total_nb_pages.total_nb_pages) AS pct_websites
FROM
  pages_iab_tcf_v2
JOIN
  total_nb_pages
USING (client)
WHERE
  JSON_VALUE(metrics, '$.cmpId') IS NOT NULL
GROUP BY
  client,
  cmpId
ORDER BY
  client ASC,
  nb_websites DESC
