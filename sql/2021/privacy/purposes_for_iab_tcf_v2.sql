#standardSQL
# Counts of purpose declarations on websites using IAB Transparency & Consent Framework
# cf. https://github.com/InteractiveAdvertisingBureau/GDPR-Transparency-and-Consent-Framework/blob/master/TCFv2/IAB%20Tech%20Lab%20-%20CMP%20API%20v2.md#tcdata

# https://stackoverflow.com/a/65054751/7391782
# Warning: fails if there are colons in the keys/values, but these are not expected
CREATE TEMPORARY FUNCTION ExtractKeyValuePairs(input STRING)
RETURNS Array<STRUCT<key String,value String>>
AS
((select
  array(
    select as struct 
      trim(split(kv, ':')[SAFE_OFFSET(0)]) as key, 
      trim(split(kv, ':')[SAFE_OFFSET(1)]) as value
    from t.kv kv
  ) 
from unnest([struct(split(translate(input, '{}"', '')) as kv)]) t
)    
);

WITH pages_privacy AS (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_VALUE(payload, "$._privacy") AS metrics
  FROM
    `httparchive.pages.2021_08_01_*`
)
, pages_iab_tcf_v2 AS (
  SELECT 
    client, 
    JSON_QUERY(metrics, "$.iab_tcf_v2.data") AS metrics
  FROM
    pages_privacy
  WHERE 
    JSON_QUERY(metrics, "$.iab_tcf_v2.data") is not null
)

SELECT client, field, result.key, result.value, COUNT(0) nb_websites FROM
(
  SELECT
    client,
    'purpose.consents' field,
    ExtractKeyValuePairs(JSON_QUERY(metrics, '$.purpose.consents')) results,
  FROM
    pages_iab_tcf_v2
  UNION ALL
  SELECT
    client,
    'purpose.legitimateInterests' field,
    ExtractKeyValuePairs(JSON_QUERY(metrics, '$.purpose.legitimateInterests')) results,
  FROM
    pages_iab_tcf_v2
  UNION ALL
  SELECT
    client,
    'vendor.consents' field,
    ExtractKeyValuePairs(JSON_QUERY(metrics, '$.vendor.consents')) results,
  FROM
    pages_iab_tcf_v2
  UNION ALL
  SELECT
    client,
    'vendor.legitimateInterests' field,
    ExtractKeyValuePairs(JSON_QUERY(metrics, '$.vendor.legitimateInterests')) results,
  FROM
    pages_iab_tcf_v2
  UNION ALL
  SELECT
    client,
    'publisher.consents' field,
    ExtractKeyValuePairs(JSON_QUERY(metrics, '$.publisher.consents')) results,
  FROM
    pages_iab_tcf_v2
  UNION ALL
  SELECT
    client,
    'publisher.legitimateInterests' field,
    ExtractKeyValuePairs(JSON_QUERY(metrics, '$.publisher.legitimateInterests')) results,
  FROM
    pages_iab_tcf_v2
  UNION ALL
  SELECT
    client,
    'publisher.customPurpose.consents' field,
    ExtractKeyValuePairs(JSON_QUERY(metrics, '$.publisher.customPurpose.consents')) results,
  FROM
    pages_iab_tcf_v2
  UNION ALL
  SELECT
    client,
    'specialFeatureOptins' field,
    ExtractKeyValuePairs(JSON_QUERY(metrics, '$.specialFeatureOptins')) results,
  FROM
    pages_iab_tcf_v2
  UNION ALL
  SELECT
    client,
    'outOfBand.allowedVendors' field,
    ExtractKeyValuePairs(JSON_QUERY(metrics, '$.outOfBand.allowedVendors')) results,
  FROM
    pages_iab_tcf_v2
  UNION ALL
  SELECT
    client,
    'outOfBand.disclosedVendors' field,
    ExtractKeyValuePairs(JSON_QUERY(metrics, '$.outOfBand.disclosedVendors')) results,
  FROM
    pages_iab_tcf_v2
),
UNNEST(results) result
GROUP BY 1,2,3,4