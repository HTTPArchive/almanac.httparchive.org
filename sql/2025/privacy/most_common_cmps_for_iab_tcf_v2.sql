-- Counts of CMPs using IAB Transparency & Consent Framework
-- cf. https://github.com/InteractiveAdvertisingBureau/GDPR-Transparency-and-Consent-Framework/blob/master/TCFv2/IAB%20Tech%20Lab%20-%20CMP%20API%20v2.md--tcdata
-- CMP vendor list: https://iabeurope.eu/cmp-list/

FROM `httparchive.crawl.pages`
|> WHERE date = '2025-07-01' --AND rank = 1000
|> EXTEND
SAFE.INT64(custom_metrics.privacy.iab_tcf_v2.data.cmpId) AS cmpId,
COUNT(DISTINCT page) OVER (PARTITION BY client) AS total_pages
|> AGGREGATE
COUNT(0) AS number_of_pages,
COUNT(0) / ANY_VALUE(total_pages) AS pct_pages
GROUP BY client, cmpId
|> PIVOT (
  ANY_VALUE(number_of_pages) AS pages_count,
  ANY_VALUE(pct_pages) AS pct
  FOR client IN ('desktop', 'mobile')
)
|> RENAME pct_mobile AS mobile, pct_desktop AS desktop
|> ORDER BY pages_count_mobile + pages_count_desktop DESC
