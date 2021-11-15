#standardSQL
# Pages that use Feature-Policy (based on Blink features)

SELECT DISTINCT
  client,
  feature,
  num_urls,
  total_urls,
  pct_urls AS pct_urls
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20210701' AND
  feature LIKE '%FeaturePolicy%'
ORDER BY
  feature,
  client

# relevant Blink features:

# CameraDisabledByFeaturePolicyEstimate
# FeaturePolicyAllowAttribute
# FeaturePolicyAllowAttributeDeprecatedSyntax
# FeaturePolicyCommaSeparatedDeclarations
# FeaturePolicyHeader
# FeaturePolicyJSAPI
# FeaturePolicyJSAPIAllowedFeaturesDocument
# FeaturePolicyJSAPIAllowedFeaturesIFrame
# FeaturePolicyJSAPIAllowsFeatureDocument
# FeaturePolicyJSAPIAllowsFeatureIFrame
# FeaturePolicyJSAPIAllowsFeatureOriginDocument
# FeaturePolicyJSAPIFeaturesDocument
# FeaturePolicyJSAPIFeaturesIFrame
# FeaturePolicyJSAPIGetAllowlistDocument
# FeaturePolicyJSAPIGetAllowlistIFrame
# FeaturePolicyReport
# FeaturePolicyReportOnlyHeader
# FeaturePolicySemicolonSeparatedDeclarations
# GetUserMediaCameraDisallowedByFeaturePolicyInCrossOriginIframe
# GetUserMediaMicDisallowedByFeaturePolicyInCrossOriginIframe
# MicrophoneDisabledByFeaturePolicyEstimate
