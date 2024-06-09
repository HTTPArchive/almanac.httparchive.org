#standardSQL
# Pages that participate in the privacy-relayed origin trials


CREATE TEMP FUNCTION `DECODE_ORIGIN_TRIAL`(token STRING) RETURNS STRING DETERMINISTIC AS (
  REGEXP_EXTRACT(SAFE_CONVERT_BYTES_TO_STRING(SAFE.FROM_BASE64(token)), r'({".*)')
);

CREATE TEMP FUNCTION `PARSE_ORIGIN_TRIAL`(token STRING)
RETURNS STRUCT<
  token STRING,
  feature STRING,
  origin STRING,
  expiry TIMESTAMP,
  is_subdomain BOOL,
  is_third_party BOOL
> AS (
  STRUCT(
    DECODE_ORIGIN_TRIAL(token) AS token,
    JSON_VALUE(DECODE_ORIGIN_TRIAL(token), '$.origin') AS origin,
    JSON_VALUE(DECODE_ORIGIN_TRIAL(token), '$.feature') AS feature,
    TIMESTAMP_SECONDS(CAST(JSON_VALUE(DECODE_ORIGIN_TRIAL(token), '$.expiry') AS INT64)) AS expiry,
    JSON_VALUE(DECODE_ORIGIN_TRIAL(token), '$.isSubdomain') = 'true' AS is_subdomain,
    JSON_VALUE(DECODE_ORIGIN_TRIAL(token), '$.isThirdParty') = 'true' AS is_third_party
  )
);

WITH pages AS (
  SELECT
    client,
    page,
    custom_metrics
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2022-05-01'
    AND is_root_page
),pages_origin_trials AS (
  SELECT
    client,
    page,
    JSON_QUERY(custom_metrics, '$.origin-trials') AS custom_metrics
  FROM pages
),

response_headers AS (
  SELECT
    client,
    page,
    LOWER(response_header.name) AS header_name,
    response_header.value AS header_value  -- may not lowercase this value as it is a base64 string
  FROM
    `httparchive.all.requests`,
    UNNEST(response_headers) response_header
  WHERE
    date = '2022-06-01'
    AND is_main_document = TRUE
),

meta_tags AS (
  SELECT
    client,
    page,
    LOWER(JSON_VALUE(meta_node, '$.http-equiv')) AS tag_name,
    JSON_VALUE(meta_node, '$.content') AS tag_value  -- may not lowercase this value as it is a base64 string
  FROM (
    SELECT
      client,
      page,
      JSON_QUERY(custom_metrics, '$.almanac') AS custom_metrics
    FROM
      pages
    ),
    UNNEST(JSON_QUERY_ARRAY(custom_metrics, '$.meta-nodes.nodes')) meta_node
  WHERE
    JSON_VALUE(meta_node, '$.http-equiv') IS NOT NULL
),

extracted_origin_trials_from_custom_metric AS (
  SELECT
    client,
    page, -- the home page that was crawled
    PARSE_ORIGIN_TRIAL(JSON_VALUE(metric, '$.token')) AS origin_trials_from_custom_metric
  FROM
    pages_origin_trials, UNNEST(JSON_QUERY_ARRAY(custom_metrics)) metric
),

extracted_origin_trials_from_headers_and_meta_tags AS (
  SELECT
    client,
    page, -- the home page that was crawled
    PARSE_ORIGIN_TRIAL(IF(header_name = 'origin-trial', header_value, tag_value)) AS origin_trials_from_headers_and_meta_tags
  FROM
    response_headers
  FULL OUTER JOIN
    meta_tags
  USING (client, page)
  WHERE
    header_name = 'origin-trial' OR
    tag_name = 'origin-trial'
)


SELECT
  client,
  COALESCE(origin_trials_from_custom_metric.feature, origin_trials_from_headers_and_meta_tags.feature) AS feature,
  COALESCE(origin_trials_from_custom_metric.origin, origin_trials_from_headers_and_meta_tags.origin) AS origin, -- origins with an origin trial
  COUNT(DISTINCT page) AS number_of_websites -- crawled sites containing at leat one origin trial
FROM
  extracted_origin_trials_from_custom_metric
FULL OUTER JOIN
  extracted_origin_trials_from_headers_and_meta_tags
USING (client, page)
WHERE
  COALESCE(
    origin_trials_from_custom_metric.feature,
    origin_trials_from_headers_and_meta_tags.feature) IN (
    'DisableThirdPartySessionStoragePartitioningAfterGeneralPartitioning', -- https://developer.chrome.com/origintrials/#/view_trial/3444127815031586817
    'DisableThirdPartyStoragePartitioning', -- https://developer.chrome.com/origintrials/#/view_trial/-8517432795264450559
    'DisableThirdPartyStoragePartitioning2', -- https://developer.chrome.com/origintrials/#/view_trial/568016503002103809
    'FedCmWithStorageAccessAPI', -- https://developer.chrome.com/origintrials/#/view_trial/4008766618313162753
    'FedCmButtonMode', -- https://developer.chrome.com/origintrials/#/view_trial/2288391560657633281
    'FedCmContinueOnBundle', -- https://developer.chrome.com/origintrials/#/view_trial/1792995601646878721
    'FledgeBiddingAndAuctionServer', -- https://developer.chrome.com/origintrials/#/view_trial/2845149064591310849
    'StorageAccessAPIBeyondCookies', -- https://developer.chrome.com/origintrials/#/view_trial/577023702256844801
    'ThirdPartyCookieDeprecationThirdParty', -- (to be verified) https://developer.chrome.com/origintrials/#/view_trial/3315212275698106369
    'ThirdPartyCookieDeprecationTopLevelSites' -- (to be verified) https://developer.chrome.com/origintrials/#/view_trial/4360047389248061441
  )
GROUP BY
  client,
  feature,
  origin
ORDER BY
  client,
  feature,
  number_of_websites DESC
