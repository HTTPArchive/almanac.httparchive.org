# Counts of countries for publishers using IAB Transparency & Consent Framework
# cf. https://github.com/InteractiveAdvertisingBureau/GDPR-Transparency-and-Consent-Framework/blob/master/TCFv2/IAB%20Tech%20Lab%20-%20CMP%20API%20v2.md#tcdata
# "Country code of the country that determines the legislation of
#  reference.  Normally corresponds to the country code of the country
#  in which the publisher's business entity is established."

WITH totals AS (
  SELECT
    client,
    COUNT(DISTINCT root_page) AS total_websites
  FROM `httparchive.crawl.pages`
  WHERE
    date = '2024-06-01' AND
    JSON_TYPE(custom_metrics.privacy.iab_tcf_v2.data) = 'object'
  GROUP BY client
),

cmps AS (
  SELECT
    client,
    --ANY_VALUE(custom_metrics.privacy.iab_tcf_v2.data) AS example,
    STRING(custom_metrics.privacy.iab_tcf_v2.data.publisherCC) AS publisherCC,
    COUNT(DISTINCT root_page) AS number_of_pages
  FROM `httparchive.crawl.pages`
  WHERE
    date = '2024-06-01' AND
    JSON_TYPE(custom_metrics.privacy.iab_tcf_v2.data) = 'object'
  GROUP BY
    client,
    publisherCC
)

SELECT
  client,
  publisherCC,
  --example,
  number_of_pages / total_websites AS pct_of_pages
FROM cmps
JOIN totals
USING (client)
ORDER BY
  client,
  number_of_pages DESC
