-- noqa: disable=PRS
-- Counts of countries for publishers using IAB Transparency & Consent Framework
-- cf. https://github.com/InteractiveAdvertisingBureau/GDPR-Transparency-and-Consent-Framework/blob/master/TCFv2/IAB%20Tech%20Lab%20-%20CMP%20API%20v2.md--tcdata
-- "Country code of the country that determines the legislation of
--  reference.  Normally corresponds to the country code of the country
--  in which the publisher's business entity is established."

WITH base_totals AS (
  SELECT
    client,
    COUNT(DISTINCT root_page) AS total_websites
  FROM `httparchive.crawl.pages`
  WHERE date = '2025-07-01' --AND rank = 1000
  GROUP BY client
),

base_data AS (
  SELECT
    client,
    root_page,
    UPPER(SAFE.STRING(custom_metrics.privacy.iab_tcf_v2.data.publisherCC)) AS publisherCC
  FROM `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND --rank = 1000 AND
    JSON_TYPE(custom_metrics.privacy.iab_tcf_v2.data) = 'object'
)

FROM base_data
|> AGGREGATE
  COUNT(DISTINCT root_page) AS number_of_pages
GROUP BY client, publisherCC
|> JOIN base_totals USING (client)
|> EXTEND number_of_pages / total_websites AS pct_of_pages
|> DROP total_websites
|> PIVOT(
  ANY_VALUE(number_of_pages) AS pages_count,
  ANY_VALUE(pct_of_pages) AS pct
  FOR client IN ('desktop', 'mobile')
)
|> RENAME pct_mobile AS mobile, pct_desktop AS desktop
|> ORDER BY pages_count_mobile + pages_count_desktop DESC
