-- privacy-sandbox-adoption-by-third-party-on-top-1M.sql
-- Usage of different Privacy Sandbox (PS) feature by each Third Party (TP) on Top 1M publishers
-- Output size is in the order of 40K rows and 84 columns
-- Example: thirdparty.com: {“runAdAuction”: 20} [20 represents number of publishers on which the current TP calls “runAdAuction”]

-- Extracting third-parties observed using PS APIs on a publisher
CREATE TEMP FUNCTION jsonObjectKeys(input STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS """
  if (!input) {
    return [];
  }
  return Object.keys(JSON.parse(input));
""";

-- Extracting PS APIs being called by a given third-party (passed as "key")
CREATE TEMP FUNCTION jsonObjectValues(input STRING, key STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS """
  if (!input) {
    return [];
  }
  const jsonObject = JSON.parse(input);
  const values = jsonObject[key] || [];
  
  function splitByDelimiters(value) {
    const delimiterRegex = new RegExp(',|, |\\n|\\u0000', 'g');
    return value.split(delimiterRegex).map(v => v.trim()).filter(v => v);
  }

  const result = [];
  const replacements = {
    'Ch': 'CH', 'Ua': 'UA', 'Wow64': 'WoW64', 'Dpr': 'DPR', 'Rtt': 'RTT', 'Ect': 'ECT', 'Etc': 'ETC', '-Architecture': '-Arch', '-Arc': '-Arch', '-Archh': '-Arch', 
    '-Factors': '-Factor', '-ETC': '-ECT', '-Modal': '-Model', '-UA-UA': '-UA', '-UAm': '-UA', 'UAmodel': 'UA-Model', 'UAplatform': 'UA-Platform', 'Secch-UA': 'Sec-CH-UA', 
    'CH-Width': 'CH-Viewport-Width', '-UAodel': '-UA-Model', '-Platformua-Platform': '-Platform', '-Platformuser-Agent': '-Platform', '-Version"': '-Version'
  };
  values.forEach(value => {
    if (value.startsWith('accept-ch|')) {
      const parts = splitByDelimiters(value.replace('accept-ch|', ''));
      parts.forEach(part => {
        if (["UA", "Arch", "Bitness", "Full-Version-List", "Mobile", "Model", "Platform", "Platform-Version", "WoW64"].includes(part)) {
          result.push("Sec-CH-UA-" + part);
        } else {
          let formattedPart = part.split('-').map(segment => 
            segment.charAt(0).toUpperCase() + segment.slice(1).toLowerCase()
          ).join('-');
          for (const [key, value] of Object.entries(replacements)) {
            formattedPart = formattedPart.replace(new RegExp(key, 'g'), value);
          }
          result.push(formattedPart);
        }
      });
    } else {
      result.push(value);
    }
  });

  return result;
""";

WITH privacy_sandbox_features AS (
  SELECT
    NET.REG_DOMAIN(page) AS publisher,
    third_party_domain,
    CASE
      WHEN api LIKE '%opics%|%' THEN
        REPLACE(SUBSTR(api, 0, STRPOS(api, '|') - 1) || '-' || SPLIT(api, '|')[SAFE_OFFSET(1)], '|', '-')
      WHEN api LIKE 'attribution-reporting-register-source%' THEN
        SPLIT(api, '|')[OFFSET(0)]
      ELSE
        api
    END AS feature
  FROM `httparchive.all.pages`,
  UNNEST(jsonObjectKeys(JSON_QUERY(custom_metrics, '$.privacy-sandbox.privacySandBoxAPIUsage'))) AS third_party_domain,
  UNNEST(jsonObjectValues(JSON_QUERY(custom_metrics, '$.privacy-sandbox.privacySandBoxAPIUsage'), third_party_domain)) AS api
  WHERE
      date = '2024-06-01' AND
      client = 'desktop' AND
      is_root_page = TRUE AND
      rank <= 1000000
),

grouped_features AS (
  SELECT
    third_party_domain,
    feature,
    COUNT(DISTINCT publisher) AS publisher_count
  FROM privacy_sandbox_features
  GROUP BY third_party_domain, feature
)
SELECT
  third_party_domain,
  SUM(IF(feature = 'runAdAuction', publisher_count, 0)) AS runAdAuction,
  SUM(IF(feature = 'navigator.userAgentData.getHighEntropyValues', publisher_count, 0)) AS navigator_userAgentData_getHighEntropyValues,
  SUM(IF(feature = 'fencedFrameJs', publisher_count, 0)) AS fencedFrameJs,
  SUM(IF(feature = 'attribution-reporting-eligible', publisher_count, 0)) AS attribution_reporting_eligible,
  SUM(IF(feature = 'attribution-reporting-register-source', publisher_count, 0)) AS attribution_reporting_register_source,
  SUM(IF(feature = 'navigator.credentials.get', publisher_count, 0)) AS navigator_credentials_get,
  SUM(IF(feature = 'IdentityProvider.getUserInfo', publisher_count, 0)) AS IdentityProvider_getUserInfo,
  SUM(IF(feature = 'IdentityProvider.close', publisher_count, 0)) AS IdentityProvider_close,
  SUM(IF(feature = 'navigator.login.setStatus', publisher_count, 0)) AS navigator_login_setStatus,
  SUM(IF(feature = 'fencedFrameJs', publisher_count, 0)) AS fencedFrameJs,
  SUM(IF(feature = 'FencedFrameConfig.setSharedStorageContext', publisher_count, 0)) AS FencedFrameConfig_setSharedStorageContext,
  SUM(IF(feature = 'window.fence.getNestedConfigs', publisher_count, 0)) AS window_fence_getNestedConfigs,
  SUM(IF(feature = 'window.fence.reportEvent', publisher_count, 0)) AS window_fence_reportEvent,
  SUM(IF(feature = 'window.fence.setReportEventDataForAutomaticBeacons', publisher_count, 0)) AS window_fence_setReportEventDataForAutomaticBeacons,
  SUM(IF(feature = 'fenced-frame', publisher_count, 0)) AS fenced_frame,
  SUM(IF(feature = 'document.interestCohort', publisher_count, 0)) AS document_interestCohort,
  SUM(IF(feature = 'privateAggregation.contributeToHistogram', publisher_count, 0)) AS privateAggregation_contributeToHistogram,
  SUM(IF(feature = 'privateAggregation.contributeToHistogramOnEvent', publisher_count, 0)) AS privateAggregation_contributeToHistogramOnEvent,
  SUM(IF(feature = 'privateAggregation.enableDebugMode', publisher_count, 0)) AS privateAggregation_enableDebugMode,
  SUM(IF(feature = 'document.hasPrivateToken', publisher_count, 0)) AS document_hasPrivateToken,
  SUM(IF(feature = 'document.hasRedemptionRecord', publisher_count, 0)) AS document_hasRedemptionRecord,
  SUM(IF(feature = 'sec-private-state-token', publisher_count, 0)) AS sec_private_state_token,
  SUM(IF(feature = 'sec-redemption-record', publisher_count, 0)) AS sec_redemption_record,
  SUM(IF(feature = 'joinAdInterestGroup', publisher_count, 0)) AS joinAdInterestGroup,
  SUM(IF(feature = 'leaveAdInterestGroup', publisher_count, 0)) AS leaveAdInterestGroup,
  SUM(IF(feature = 'updateAdInterestGroups', publisher_count, 0)) AS updateAdInterestGroups,
  SUM(IF(feature = 'clearOriginJoinedAdInterestGroups', publisher_count, 0)) AS clearOriginJoinedAdInterestGroups,
  SUM(IF(feature = 'runAdAuction', publisher_count, 0)) AS runAdAuction,
  SUM(IF(feature = 'generateBid', publisher_count, 0)) AS generateBid,
  SUM(IF(feature = 'scoreAd', publisher_count, 0)) AS scoreAd,
  SUM(IF(feature = 'reportWin', publisher_count, 0)) AS reportWin,
  SUM(IF(feature = 'reportResult', publisher_count, 0)) AS reportResult,
  SUM(IF(feature = 'window.sharedStorage.append', publisher_count, 0)) AS window_sharedStorage_append,
  SUM(IF(feature = 'window.sharedStorage.clear', publisher_count, 0)) AS window_sharedStorage_clear,
  SUM(IF(feature = 'window.sharedStorage.delete', publisher_count, 0)) AS window_sharedStorage_delete,
  SUM(IF(feature = 'window.sharedStorage.set', publisher_count, 0)) AS window_sharedStorage_set,
  SUM(IF(feature = 'window.sharedStorage.run', publisher_count, 0)) AS window_sharedStorage_run,
  SUM(IF(feature = 'window.sharedStorage.selectURL', publisher_count, 0)) AS window_sharedStorage_selectURL,
  SUM(IF(feature = 'window.sharedStorage.worklet.addModule', publisher_count, 0)) AS window_sharedStorage_worklet_addModule,
  SUM(IF(feature = 'document.hasStorageAccess', publisher_count, 0)) AS document_hasStorageAccess,
  SUM(IF(feature = 'document.hasUnpartitionedCookieAccess', publisher_count, 0)) AS document_hasUnpartitionedCookieAccess,
  SUM(IF(feature = 'document.requestStorageAccess', publisher_count, 0)) AS document_requestStorageAccess,
  SUM(IF(feature = 'document.requestStorageAccessFor', publisher_count, 0)) AS document_requestStorageAccessFor,
  SUM(IF(feature = 'document.browsingTopics-false', publisher_count, 0)) AS document_browsingTopics_false,
  SUM(IF(feature = 'document.browsingTopics-true', publisher_count, 0)) AS document_browsingTopics_true,
  SUM(IF(feature = 'sec-browsing-topics-false', publisher_count, 0)) AS sec_browsing_topics_false,
  SUM(IF(feature = 'sec-browsing-topics-true', publisher_count, 0)) AS sec_browsing_topics_true,
  SUM(IF(feature = 'navigator.userAgentData.getHighEntropyValues', publisher_count, 0)) AS navigator_UAData_getHighEntropyValues,
  SUM(IF(feature = 'Sec-CH-Bitness', publisher_count, 0)) AS Sec_CH_Bitness,
  SUM(IF(feature = 'Sec-CH-Device-Memory', publisher_count, 0)) AS Sec_CH_Device_Memory,
  SUM(IF(feature = 'Sec-CH-Downlink', publisher_count, 0)) AS Sec_CH_Downlink,
  SUM(IF(feature = 'Sec-CH-DPR', publisher_count, 0)) AS Sec_CH_DPR,
  SUM(IF(feature = 'Sec-CH-ECT', publisher_count, 0)) AS Sec_CH_ECT,
  SUM(IF(feature = 'Sec-CH-Forced-Colors', publisher_count, 0)) AS Sec_CH_Forced_Colors,
  SUM(IF(feature = 'Sec-CH-Height', publisher_count, 0)) AS Sec_CH_Height,
  SUM(IF(feature = 'Sec-CH-Lang', publisher_count, 0)) AS Sec_CH_Lang,
  SUM(IF(feature = 'Sec-CH-Partitioned-Cookies', publisher_count, 0)) AS Sec_CH_Partitioned_Cookies,
  SUM(IF(feature = 'Sec-CH-Prefers-Color-Scheme', publisher_count, 0)) AS Sec_CH_Prefers_Color_Scheme,
  SUM(IF(feature = 'Sec-CH-Prefers-Contrast', publisher_count, 0)) AS Sec_CH_Prefers_Contrast,
  SUM(IF(feature = 'Sec-CH-Prefers-Reduced-Data', publisher_count, 0)) AS Sec_CH_Prefers_Reduced_Data,
  SUM(IF(feature = 'Sec-CH-Prefers-Reduced-Motion', publisher_count, 0)) AS Sec_CH_Prefers_Reduced_Motion,
  SUM(IF(feature = 'Sec-CH-Prefers-Reduced-Transparency', publisher_count, 0)) AS Sec_CH_Prefers_Reduced_Transparency,
  SUM(IF(feature = 'Sec-CH-RTT', publisher_count, 0)) AS Sec_CH_RTT,
  SUM(IF(feature = 'Sec-CH-Save-Data', publisher_count, 0)) AS Sec_CH_Save_Data,
  SUM(IF(feature = 'Sec-CH-UA', publisher_count, 0)) AS Sec_CH_UA,
  SUM(IF(feature = 'Sec-CH-UA-*', publisher_count, 0)) AS Sec_CH_UA_star,
  SUM(IF(feature = 'Sec-CH-UA-Arch', publisher_count, 0)) AS Sec_CH_UA_Arch,
  SUM(IF(feature = 'Sec-CH-UA-Bitness', publisher_count, 0)) AS Sec_CH_UA_Bitness,
  SUM(IF(feature = 'Sec-CH-UA-Browser', publisher_count, 0)) AS Sec_CH_UA_Browser,
  SUM(IF(feature = 'Sec-CH-UA-Form-Factor', publisher_count, 0)) AS Sec_CH_UA_Form_Factor,
  SUM(IF(feature = 'Sec-CH-UA-Full', publisher_count, 0)) AS Sec_CH_UA_Full,
  SUM(IF(feature = 'Sec-CH-UA-Full-Version', publisher_count, 0)) AS Sec_CH_UA_Full_Version,
  SUM(IF(feature = 'Sec-CH-UA-Full-Version-List', publisher_count, 0)) AS Sec_CH_UA_Full_Version_List,
  SUM(IF(feature = 'Sec-CH-UA-Mobile', publisher_count, 0)) AS Sec_CH_UA_Mobile,
  SUM(IF(feature = 'Sec-CH-UA-Model', publisher_count, 0)) AS Sec_CH_UA_Model,
  SUM(IF(feature = 'Sec-CH-UA-Platform', publisher_count, 0)) AS Sec_CH_UA_Platform,
  SUM(IF(feature = 'Sec-CH-UA-Platform-Version', publisher_count, 0)) AS Sec_CH_UA_Platform_Version,
  SUM(IF(feature = 'Sec-CH-UA-Platform-WoW64', publisher_count, 0)) AS Sec_CH_UA_Platform_WoW64,
  SUM(IF(feature = 'Sec-CH-UA-Reduced', publisher_count, 0)) AS Sec_CH_UA_Reduced,
  SUM(IF(feature = 'Sec-CH-UA-UA', publisher_count, 0)) AS Sec_CH_UA_UA,
  SUM(IF(feature = 'Sec-CH-UA-WoW64', publisher_count, 0)) AS Sec_CH_UA_WoW64,
  SUM(IF(feature = 'Sec-CH-Viewport-Height', publisher_count, 0)) AS Sec_CH_Viewport_Height,
  SUM(IF(feature = 'Sec-CH-Viewport-Width', publisher_count, 0)) AS Sec_CH_Viewport_Width
FROM grouped_features
GROUP BY third_party_domain;