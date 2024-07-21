#standardSQL
# Counts of CMPs using IAB Transparency & Consent Framework
# cf. https://github.com/InteractiveAdvertisingBureau/GDPR-Transparency-and-Consent-Framework/blob/master/TCFv2/IAB%20Tech%20Lab%20-%20CMP%20API%20v2.md#tcdata

WITH totals AS (
  SELECT
    client,
    COUNT(0) AS total_websites
  FROM `httparchive.all.pages`
  WHERE
    date = '2024-06-01' AND
    is_root_page = TRUE AND
    rank <= 10000
  GROUP BY client
), cmps AS (
  SELECT
    client,
    JSON_VALUE(JSON_VALUE(payload, '$._privacy'), '$.iab_tcf_v2.data.cmpId') AS cmpId
  FROM `httparchive.all.pages`
  WHERE
    date = '2024-06-01' AND
    is_root_page = TRUE AND
    rank <= 10000 AND
    JSON_VALUE(JSON_VALUE(payload, '$._privacy'), '$.iab_tcf_v2.data.cmpId') IS NOT NULL
)

SELECT
  client,
  cmpId,
  COUNT(0) AS number_of_websites,
  total_websites,
  COUNT(0) / total_websites AS pct_websites
FROM cmps
JOIN totals
USING (client)
GROUP BY
  client,
  total_websites,
  cmpId
ORDER BY
  pct_websites DESC,
  client,
  cmpId
