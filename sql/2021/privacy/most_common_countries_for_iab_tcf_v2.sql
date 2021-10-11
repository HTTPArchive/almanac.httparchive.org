#standardSQL
# Counts of countries for publishers using IAB Transparency & Consent Framework
# cf. https://github.com/InteractiveAdvertisingBureau/GDPR-Transparency-and-Consent-Framework/blob/master/TCFv2/IAB%20Tech%20Lab%20-%20CMP%20API%20v2.md#tcdata
# "Country code of the country that determines the legislation of
#  reference.  Normally corresponds to the country code of the country
#  in which the publisher's business entity is established."

WITH totals AS (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total_websites
  FROM
    `httparchive.pages.2021_07_01_*`
  GROUP BY
    _TABLE_SUFFIX
)

SELECT
  _TABLE_SUFFIX AS client,
  LOWER(JSON_VALUE(JSON_VALUE(payload, "$._privacy"), "$.iab_tcf_v2.data.publisherCC")) AS publisherCC,
  COUNT(0) AS number_of_websites,
  total_websites,
  COUNT(0) / total_websites AS pct_websites
FROM
  `httparchive.pages.2021_07_01_*`
JOIN
  totals
USING (_TABLE_SUFFIX)
WHERE
  JSON_VALUE(JSON_VALUE(payload, "$._privacy"), "$.iab_tcf_v2.data.publisherCC") IS NOT NULL
GROUP BY
  client,
  total_websites,
  publisherCC
ORDER BY
  client,
  number_of_websites DESC
