# Counts of countries for publishers using IAB Transparency & Consent Framework
# cf. https://github.com/InteractiveAdvertisingBureau/GDPR-Transparency-and-Consent-Framework/blob/master/TCFv2/IAB%20Tech%20Lab%20-%20CMP%20API%20v2.md#tcdata
# "Country code of the country that determines the legislation of
#  reference.  Normally corresponds to the country code of the country
#  in which the publisher's business entity is established."

WITH totals AS (
  SELECT
    client,
    COUNT(0) AS total_websites
  FROM `httparchive.all.pages`
  WHERE
    date = '2024-06-01' AND
    is_root_page = TRUE
  GROUP BY client
), cmps AS (
  SELECT
    client,
    JSON_VALUE(custom_metrics, '$.privacy.iab_tcf_v2.data.publisherCC') AS publisherCC,
    COUNT(0) AS number_of_pages
  FROM `httparchive.all.pages`
  WHERE
    date = '2024-06-01' AND
    is_root_page = TRUE AND
    JSON_VALUE(custom_metrics, '$.privacy.iab_tcf_v2.data.publisherCC') IS NOT NULL
  GROUP BY
    client,
    publisherCC
)

SELECT
  client,
  publisherCC,
  number_of_pages / total_websites AS pct_pages,
  number_of_pages
FROM cmps
JOIN totals
USING (client)
ORDER BY
  client,
  pct_pages DESC
