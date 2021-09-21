#standardSQL
# Counts of websites using a certain privacy-related feature, 
# based on searching Document and Script bodies 
#  (all those loaded on a page, regardless of the origin)

WITH pages_privacy AS (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_VALUE(payload, "$._privacy") AS metrics
  FROM
    `httparchive.pages.2021_07_01_*`
)

SELECT
  *,
  nb_websites_document_interestCohort / nb_websites
  AS pct_websites_document_interestCohort,
  nb_websites_navigator_doNotTrack / nb_websites
  AS pct_websites_navigator_doNotTrack,
  nb_websites_navigator_globalPrivacyControl / nb_websites
  AS pct_websites_navigator_globalPrivacyControl,
  nb_websites_document_permissionsPolicy / nb_websites
  AS pct_websites_document_permissionsPolicy,
  nb_websites_document_featurePolicy / nb_websites
  AS pct_websites_document_featurePolicy,
  nb_websites_navigator_mediaDevices_enumerateDevices / nb_websites
  AS pct_websites_navigator_mediaDevices_enumerateDevices,
  nb_websites_navigator_mediaDevices_getUserMedia / nb_websites
  AS pct_websites_navigator_mediaDevices_getUserMedia,
  nb_websites_navigator_mediaDevices_getDisplayMedia / nb_websites
  AS pct_websites_navigator_mediaDevices_getDisplayMedia,
  nb_websites_navigator_mediaDevices_any / nb_websites
  AS pct_websites_navigator_mediaDevices_any,
  nb_websites_navigator_geolocation_getCurrentPosition / nb_websites
  AS pct_websites_navigator_geolocation_getCurrentPosition,
  nb_websites_navigator_geolocation_watchPosition / nb_websites
  AS pct_websites_navigator_geolocation_watchPosition,
  nb_websites_navigator_geolocation_any / nb_websites
  AS pct_websites_navigator_geolocation_any
FROM (
  SELECT
    client,
    COUNT(0) AS nb_websites,
    COUNTIF(
      JSON_VALUE(metrics, "$.document_interestCohort") = "true"
    ) AS nb_websites_document_interestCohort,
    COUNTIF(
      JSON_VALUE(metrics, "$.navigator_doNotTrack") = "true"
    ) AS nb_websites_navigator_doNotTrack,
    COUNTIF(
      JSON_VALUE(metrics, "$.navigator_globalPrivacyControl") = "true"
    ) AS nb_websites_navigator_globalPrivacyControl,
    COUNTIF(
      JSON_VALUE(metrics, "$.document_permissionsPolicy") = "true"
    ) AS nb_websites_document_permissionsPolicy,
    COUNTIF(
      JSON_VALUE(metrics, "$.document_featurePolicy") = "true"
    ) AS nb_websites_document_featurePolicy,

    COUNTIF(
      JSON_VALUE(metrics, "$.media_devices.navigator_mediaDevices_enumerateDevices") = "true"
    ) AS nb_websites_navigator_mediaDevices_enumerateDevices,
    COUNTIF(
      JSON_VALUE(metrics, "$.media_devices.navigator_mediaDevices_getUserMedia") = "true"
    ) AS nb_websites_navigator_mediaDevices_getUserMedia,
    COUNTIF(
      JSON_VALUE(metrics, "$.media_devices.navigator_mediaDevices_getDisplayMedia") = "true"
    ) AS nb_websites_navigator_mediaDevices_getDisplayMedia,

    COUNTIF(
      JSON_VALUE(metrics, "$.media_devices.navigator_mediaDevices_enumerateDevices") = "true" OR
      JSON_VALUE(metrics, "$.media_devices.navigator_mediaDevices_getUserMedia") = "true" OR
      JSON_VALUE(metrics, "$.media_devices.navigator_mediaDevices_getDisplayMedia") = "true"
    ) AS nb_websites_navigator_mediaDevices_any,

    COUNTIF(
      JSON_VALUE(metrics, "$.geolocation.navigator_geolocation_getCurrentPosition") = "true"
    ) AS nb_websites_navigator_geolocation_getCurrentPosition,
    COUNTIF(
      JSON_VALUE(metrics, "$.geolocation.navigator_geolocation_watchPosition") = "true"
    ) AS nb_websites_navigator_geolocation_watchPosition,

    COUNTIF(
      JSON_VALUE(metrics, "$.geolocation.navigator_geolocation_getCurrentPosition") = "true" OR
      JSON_VALUE(metrics, "$.geolocation.navigator_geolocation_watchPosition") = "true"
    ) AS nb_websites_navigator_geolocation_any

  FROM
    pages_privacy
  GROUP BY
    1
  )
ORDER BY
  client ASC
