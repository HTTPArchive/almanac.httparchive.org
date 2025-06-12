#standardSQL
# Counts of purpose declarations on websites using IAB Transparency & Consent Framework
# cf. https://github.com/InteractiveAdvertisingBureau/GDPR-Transparency-and-Consent-Framework/blob/master/TCFv2/IAB%20Tech%20Lab%20-%20CMP%20API%20v2.md#tcdata
# https://stackoverflow.com/a/65054751/7391782
# Warning: fails if there are colons in the keys/values, but these are not expected
CREATE TEMPORARY FUNCTION ExtractKeyValuePairs(input STRING) RETURNS ARRAY<STRUCT<
  key STRING,
  value STRING
>> AS ((
  SELECT
    ARRAY(
      SELECT AS STRUCT
        TRIM(SPLIT(kv, ':')[SAFE_OFFSET(0)]) AS key,
        TRIM(SPLIT(kv, ':')[SAFE_OFFSET(1)]) AS value
      FROM
        t.kv
    )
  FROM
    UNNEST(
      [STRUCT(SPLIT(TRANSLATE(input, '{}"', '')) AS kv)]
    ) t
)
);

WITH pages_iab_tcf_v2 AS (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_QUERY(
      JSON_VALUE(payload, '$._privacy'),
      '$.iab_tcf_v2.data'
    ) AS metrics
  FROM
    `httparchive.pages.2021_07_01_*`
  WHERE
    JSON_QUERY(
      JSON_VALUE(payload, '$._privacy'),
      '$.iab_tcf_v2.data'
    ) IS NOT NULL
)

SELECT
  client,
  field,
  result.key AS key,
  result.value AS value,
  COUNT(0) AS number_of_websites
FROM (
  SELECT
    client,
    'purpose.consents' AS field,
    ExtractKeyValuePairs(JSON_QUERY(metrics, '$.purpose.consents')) AS results
  FROM
    pages_iab_tcf_v2
  UNION ALL
  SELECT
    client,
    'purpose.legitimateInterests' AS field,
    ExtractKeyValuePairs(
      JSON_QUERY(metrics, '$.purpose.legitimateInterests')
    ) AS results
  FROM
    pages_iab_tcf_v2
  UNION ALL
  SELECT
    client,
    'vendor.consents' AS field,
    ExtractKeyValuePairs(JSON_QUERY(metrics, '$.vendor.consents')) AS results
  FROM
    pages_iab_tcf_v2
  UNION ALL
  SELECT
    client,
    'vendor.legitimateInterests' AS field,
    ExtractKeyValuePairs(
      JSON_QUERY(metrics, '$.vendor.legitimateInterests')
    ) AS results
  FROM
    pages_iab_tcf_v2
  UNION ALL
  SELECT
    client,
    'publisher.consents' AS field,
    ExtractKeyValuePairs(JSON_QUERY(metrics, '$.publisher.consents')) AS results
  FROM
    pages_iab_tcf_v2
  UNION ALL
  SELECT
    client,
    'publisher.legitimateInterests' AS field,
    ExtractKeyValuePairs(
      JSON_QUERY(metrics, '$.publisher.legitimateInterests')
    ) AS results
  FROM
    pages_iab_tcf_v2
  UNION ALL
  SELECT
    client,
    'publisher.customPurpose.consents' AS field,
    ExtractKeyValuePairs(
      JSON_QUERY(metrics, '$.publisher.customPurpose.consents')
    ) AS results
  FROM
    pages_iab_tcf_v2
  UNION ALL
  SELECT
    client,
    'publisher.customPurpose.legitimateInterests' AS field,
    ExtractKeyValuePairs(
      JSON_QUERY(
        metrics,
        '$.publisher.customPurpose.legitimateInterests'
      )
    ) AS results
  FROM
    pages_iab_tcf_v2
  UNION ALL
  SELECT
    client,
    'specialFeatureOptins' AS field,
    ExtractKeyValuePairs(JSON_QUERY(metrics, '$.specialFeatureOptins')) AS results
  FROM
    pages_iab_tcf_v2
  UNION ALL
  SELECT
    client,
    'outOfBand.allowedVendors' AS field,
    ExtractKeyValuePairs(
      JSON_QUERY(metrics, '$.outOfBand.allowedVendors')
    ) AS results
  FROM
    pages_iab_tcf_v2
  UNION ALL
  SELECT
    client,
    'outOfBand.disclosedVendors' AS field,
    ExtractKeyValuePairs(
      JSON_QUERY(metrics, '$.outOfBand.disclosedVendors')
    ) AS results
  FROM
    pages_iab_tcf_v2
),
  UNNEST(results) result
GROUP BY
  client,
  field,
  key,
  value
ORDER BY
  client,
  number_of_websites DESC
