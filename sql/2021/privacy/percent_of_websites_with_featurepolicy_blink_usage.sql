SELECT
  client,
  feature,
  num_urls,
  total_urls,
  ROUND(pct_urls * 100, 2) AS pct_urls
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20210801' AND
  feature LIKE '%FeaturePolicy%'
ORDER BY
  feature

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
