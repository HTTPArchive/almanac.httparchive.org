#standardSQL
# Pages that use Privacy Sandbox-related features (based on Blink features)

SELECT DISTINCT
  client,
  feature,
  num_urls,
  total_urls,
  pct_urls AS pct_urls
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20210701' AND (
    feature = 'InterestCohortAPI_interestCohort_Method' OR
    feature = 'V8Navigator_JoinAdInterestGroup_Method' OR
    feature = 'V8Navigator_LeaveAdInterestGroup_Method' OR
    feature = 'V8Navigator_UpdateAdInterestGroups_Method' OR
    feature = 'V8Navigator_RunAdAuction_Method' OR
    feature = 'ConversionRegistration' OR
    feature = 'ImpressionRegistration' OR
    feature = 'ConversionAPIAll' OR
    feature = 'SamePartyCookieAttribute' OR
    feature = 'V8Document_HasTrustToken_Method' OR
    feature = 'HTMLFencedFrameElement'
  )
ORDER BY
  feature,
  client
