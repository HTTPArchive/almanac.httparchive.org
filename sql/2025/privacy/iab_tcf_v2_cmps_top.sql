-- noqa: disable=PRS
-- Counts of CMPs using IAB Transparency & Consent Framework
-- cf. https://github.com/InteractiveAdvertisingBureau/GDPR-Transparency-and-Consent-Framework/blob/master/TCFv2/IAB%20Tech%20Lab%20-%20CMP%20API%20v2.md--tcdata
-- CMP vendor list: https://iabeurope.eu/cmp-list/

FROM `httparchive.crawl.pages`
|> WHERE date = '2025-07-01' --AND rank = 1000
|> EXTEND
SAFE.INT64(custom_metrics.privacy.iab_tcf_v2.data.cmpId) AS cmpId,
COUNT(DISTINCT root_page) OVER (PARTITION BY client) AS total_websites
|> AGGREGATE
COUNT(DISTINCT root_page) AS number_of_websites,
COUNT(DISTINCT root_page) / ANY_VALUE(total_websites) AS pct_websites
GROUP BY client, cmpId
|> PIVOT (
  ANY_VALUE(number_of_websites) AS websites_count,
  ANY_VALUE(pct_websites) AS pct
  FOR client IN ('desktop', 'mobile')
)
|> RENAME pct_mobile AS mobile, pct_desktop AS desktop
|> ORDER BY websites_count_desktop + websites_count_mobile DESC
