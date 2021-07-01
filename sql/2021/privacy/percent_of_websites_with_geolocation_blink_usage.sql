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
  feature LIKE '%Geolocation%'
ORDER BY
  feature

# relevant Blink features:

# GeolocationGetCurrentPosition
# GeolocationWatchPosition
# GeolocationDisabledByFeaturePolicy
# GeolocationDisallowedByFeaturePolicyInCrossOriginIframe
# GeolocationInsecureOriginIframe
# GeolocationInsecureOrigin
# GeolocationSecureOrigin
# GeolocationSecureOriginIframe
# GeolocationInsecureOriginDeprecatedNotRemoved
# GeolocationInsecureOriginIframeDeprecatedNotRemoved
