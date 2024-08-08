#standardSQL
# Pages that use media devices (using Blink features)

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
    feature LIKE '%MediaDevices%' OR
    feature LIKE '%EnumerateDevices%' OR
    feature LIKE '%GetUserMedia%' OR
    feature LIKE '%GetDisplayMedia%' OR
    feature LIKE '%Camera%' OR
    feature LIKE '%Microphone%'
  )
ORDER BY
  feature,
  client

# relevant Blink features:

# MediaDevicesEnumerateDevices
# GetUserMediaSecureOrigin
# GetUserMediaPromise
# GetUserMediaLegacy
# GetUserMediaPrefixed
# GetUserMediaSecureOriginIframe
# GetUserMediaInsecureOrigin
# GetUserMediaInsecureOriginIframe
# V8MediaSession_SetMicrophoneActive_Method
# V8MediaSession_SetCameraActive_Method
# GetDisplayMedia
