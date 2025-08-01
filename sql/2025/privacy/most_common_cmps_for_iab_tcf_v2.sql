# Counts of CMPs using IAB Transparency & Consent Framework
# cf. https://github.com/InteractiveAdvertisingBureau/GDPR-Transparency-and-Consent-Framework/blob/master/TCFv2/IAB%20Tech%20Lab%20-%20CMP%20API%20v2.md#tcdata
# CMP vendor list: https://iabeurope.eu/cmp-list/

WITH cmps AS (
  SELECT
    client,
    page,
    JSON_VALUE(custom_metrics, '$.privacy.iab_tcf_v2.data.cmpId') AS cmpId,
    COUNT(DISTINCT page) OVER (PARTITION BY client) AS total_pages
  FROM `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    is_root_page = TRUE
)

SELECT
  client,
  cmpId,
  COUNT(0) / ANY_VALUE(total_pages) AS pct_pages,
  COUNT(0) AS number_of_pages
FROM cmps
GROUP BY
  client,
  cmpId
ORDER BY
  pct_pages DESC
