#standardSQL
# Counts of websites using a certain privacy-related feature,
# based on searching Document and Script bodies
#  (all those loaded on a page, regardless of the origin)

WITH privacy_custom_metrics_data AS (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_VALUE(payload, '$._privacy') AS metrics
  FROM
    `httparchive.pages.2021_07_01_*`
  WHERE
    JSON_VALUE(payload, '$._privacy') IS NOT NULL
)

SELECT
  *,
  number_of_websites_document_interestCohort / number_of_websites
    AS pct_websites_document_interestCohort,
  number_of_websites_navigator_doNotTrack / number_of_websites
    AS pct_websites_navigator_doNotTrack,
  number_of_websites_navigator_globalPrivacyControl / number_of_websites
    AS pct_websites_navigator_globalPrivacyControl,
  number_of_websites_document_permissionsPolicy / number_of_websites
    AS pct_websites_document_permissionsPolicy,
  number_of_websites_document_featurePolicy / number_of_websites
    AS pct_websites_document_featurePolicy,
  number_of_websites_navigator_mediaDevices_enumerateDevices / number_of_websites
    AS pct_websites_navigator_mediaDevices_enumerateDevices,
  number_of_websites_navigator_mediaDevices_getUserMedia / number_of_websites
    AS pct_websites_navigator_mediaDevices_getUserMedia,
  number_of_websites_navigator_mediaDevices_getDisplayMedia / number_of_websites
    AS pct_websites_navigator_mediaDevices_getDisplayMedia,
  number_of_websites_navigator_mediaDevices_any / number_of_websites
    AS pct_websites_navigator_mediaDevices_any,
  number_of_websites_navigator_geolocation_getCurrentPosition / number_of_websites
    AS pct_websites_navigator_geolocation_getCurrentPosition,
  number_of_websites_navigator_geolocation_watchPosition / number_of_websites
    AS pct_websites_navigator_geolocation_watchPosition,
  number_of_websites_navigator_geolocation_any / number_of_websites
    AS pct_websites_navigator_geolocation_any
FROM (
  SELECT
    client,
    COUNT(0) AS number_of_websites,
    COUNTIF(
      JSON_VALUE(metrics, '$.document_interestCohort') = 'true'
    ) AS number_of_websites_document_interestCohort,
    COUNTIF(
      JSON_VALUE(metrics, '$.navigator_doNotTrack') = 'true'
    ) AS number_of_websites_navigator_doNotTrack,
    COUNTIF(
      JSON_VALUE(metrics, '$.navigator_globalPrivacyControl') = 'true'
    ) AS number_of_websites_navigator_globalPrivacyControl,
    COUNTIF(
      JSON_VALUE(metrics, '$.document_permissionsPolicy') = 'true'
    ) AS number_of_websites_document_permissionsPolicy,
    COUNTIF(
      JSON_VALUE(metrics, '$.document_featurePolicy') = 'true'
    ) AS number_of_websites_document_featurePolicy,

    COUNTIF(
      JSON_VALUE(metrics, '$.media_devices.navigator_mediaDevices_enumerateDevices') = 'true'
    ) AS number_of_websites_navigator_mediaDevices_enumerateDevices,
    COUNTIF(
      JSON_VALUE(metrics, '$.media_devices.navigator_mediaDevices_getUserMedia') = 'true'
    ) AS number_of_websites_navigator_mediaDevices_getUserMedia,
    COUNTIF(
      JSON_VALUE(metrics, '$.media_devices.navigator_mediaDevices_getDisplayMedia') = 'true'
    ) AS number_of_websites_navigator_mediaDevices_getDisplayMedia,

    COUNTIF(
      JSON_VALUE(metrics, '$.media_devices.navigator_mediaDevices_enumerateDevices') = 'true' OR
      JSON_VALUE(metrics, '$.media_devices.navigator_mediaDevices_getUserMedia') = 'true' OR
      JSON_VALUE(metrics, '$.media_devices.navigator_mediaDevices_getDisplayMedia') = 'true'
    ) AS number_of_websites_navigator_mediaDevices_any,

    COUNTIF(
      JSON_VALUE(metrics, '$.geolocation.navigator_geolocation_getCurrentPosition') = 'true'
    ) AS number_of_websites_navigator_geolocation_getCurrentPosition,
    COUNTIF(
      JSON_VALUE(metrics, '$.geolocation.navigator_geolocation_watchPosition') = 'true'
    ) AS number_of_websites_navigator_geolocation_watchPosition,

    COUNTIF(
      JSON_VALUE(metrics, '$.geolocation.navigator_geolocation_getCurrentPosition') = 'true' OR
      JSON_VALUE(metrics, '$.geolocation.navigator_geolocation_watchPosition') = 'true'
    ) AS number_of_websites_navigator_geolocation_any

  FROM
    privacy_custom_metrics_data
  GROUP BY
    client
)
ORDER BY
  client
