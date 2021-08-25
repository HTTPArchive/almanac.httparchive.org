#standardSQL
# Pages that use geolocation features (based on Blink features)

SELECT
  client,
  feature,
  num_urls,
  total_urls,
  ROUND(pct_urls, 2) AS pct_urls
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20210701' AND
  feature LIKE '%Geolocation%'
ORDER BY
  2 ASC, 1 ASC

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
