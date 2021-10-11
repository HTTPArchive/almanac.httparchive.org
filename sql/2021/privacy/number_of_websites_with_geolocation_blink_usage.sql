#standardSQL
# Pages that use geolocation features (based on Blink features)

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
  feature LIKE '%Geolocation%'
ORDER BY
  feature,
  client

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
