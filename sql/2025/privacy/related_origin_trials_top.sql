-- noqa: disable=PRS
-- Pages that participate in the privacy-relayed origin trials

CREATE TEMP FUNCTION `PARSE_ORIGIN_TRIAL`(token STRING) RETURNS STRUCT<
  token STRING,
  origin STRING,
  feature STRING,
  expiry TIMESTAMP,
  is_subdomain BOOL,
  is_third_party BOOL
>
DETERMINISTIC AS (
  (
    WITH decoded_token AS (
      SELECT SAFE_CONVERT_BYTES_TO_STRING(SUBSTR(SAFE.FROM_BASE64(token), 70)) AS decoded
    )

    SELECT
      STRUCT(
        decoded AS token,
        JSON_VALUE(decoded, '$.origin') AS origin,
        JSON_VALUE(decoded, '$.feature') AS feature,
        TIMESTAMP_SECONDS(CAST(JSON_VALUE(decoded, '$.expiry') AS INT64)) AS expiry,
        JSON_VALUE(decoded, '$.isSubdomain') = 'true' AS is_subdomain,
        JSON_VALUE(decoded, '$.isThirdParty') = 'true' AS is_third_party
      )
    FROM decoded_token
  )
);

WITH base_totals AS (
  SELECT
    client,
    COUNT(DISTINCT root_page) AS total_websites
  FROM `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
  GROUP BY client
),

pages AS (
  SELECT
    client,
    root_page,
    custom_metrics.other.`origin-trials` AS ot_metrics,
    custom_metrics.other.almanac AS almanac_metrics
  FROM `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
),

response_headers AS (
  SELECT
    client,
    root_page,
    PARSE_ORIGIN_TRIAL(response_header.value) AS ot
  FROM `httparchive.crawl.requests`,
    UNNEST(response_headers) response_header
  WHERE
    date = '2025-07-01' AND
    is_main_document = TRUE AND
    LOWER(response_header.name) = 'origin-trial'
),

meta_tags AS (
  SELECT
    client,
    root_page,
    PARSE_ORIGIN_TRIAL(SAFE.STRING(meta_node.content)) AS ot
  FROM pages,
    UNNEST(JSON_QUERY_ARRAY(almanac_metrics.`meta-nodes`.nodes)) meta_node
  WHERE
    LOWER(SAFE.STRING(meta_node.`http-equiv`)) = 'origin-trial'
),

ot_from_custom_metric AS (
  SELECT
    client,
    root_page,
    PARSE_ORIGIN_TRIAL(SAFE.STRING(metric.token)) AS ot
  FROM pages,
    UNNEST(JSON_QUERY_ARRAY(ot_metrics)) metric
),

aggregated AS (
  SELECT
    client,
    ot.feature,
    --ot.expiry >= CURRENT_TIMESTAMP() AS is_active,
    COUNT(DISTINCT root_page) AS number_of_websites
  FROM (
    SELECT * FROM response_headers
    UNION ALL
    SELECT * FROM meta_tags
    UNION ALL
    SELECT * FROM ot_from_custom_metric
  )
  GROUP BY
    client,
    feature
    --is_active
)

FROM aggregated
|> JOIN base_totals USING (client)
|> EXTEND number_of_websites / total_websites AS pct_websites
|> DROP total_websites
|> PIVOT(
  ANY_VALUE(number_of_websites) AS websites_count,
  ANY_VALUE(pct_websites) AS pct
  FOR client IN ('desktop', 'mobile')
)
|> RENAME pct_mobile AS mobile, pct_desktop AS desktop
|> ORDER BY websites_count_desktop + websites_count_mobile DESC
