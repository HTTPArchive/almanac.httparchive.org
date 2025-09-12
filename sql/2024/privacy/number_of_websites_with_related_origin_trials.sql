# Pages that participate in the privacy-relayed origin trials
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

WITH pages AS (
  SELECT
    client,
    page,
    JSON_QUERY(custom_metrics, '$.origin-trials') AS ot_metrics,
    JSON_QUERY(custom_metrics, '$.almanac') AS almanac_metrics
  FROM `httparchive.all.pages`
  WHERE
    date = '2024-06-01' AND
    is_root_page = TRUE
),

response_headers AS (
  SELECT
    client,
    page,
    PARSE_ORIGIN_TRIAL(response_header.value) AS ot  -- may not lowercase this value as it is a base64 string
  FROM `httparchive.all.requests`,
    UNNEST(response_headers) response_header
  WHERE
    date = '2024-06-01' AND
    is_root_page = TRUE AND
    is_main_document = TRUE AND
    LOWER(response_header.name) = 'origin-trial'
),

meta_tags AS (
  SELECT
    client,
    page,
    PARSE_ORIGIN_TRIAL(JSON_VALUE(meta_node, '$.content')) AS ot  -- may not lowercase this value as it is a base64 string
  FROM pages,
    UNNEST(JSON_QUERY_ARRAY(almanac_metrics, '$.meta-nodes.nodes')) meta_node
  WHERE
    LOWER(JSON_VALUE(meta_node, '$.http-equiv')) = 'origin-trial'
),

ot_from_custom_metric AS (
  SELECT
    client,
    page,
    PARSE_ORIGIN_TRIAL(JSON_VALUE(metric, '$.token')) AS ot
  FROM pages,
    UNNEST(JSON_QUERY_ARRAY(ot_metrics)) metric
)

SELECT
  client,
  feature,
  number_of_pages / total_pages AS pct_pages,
  number_of_pages,
  is_active
FROM (
  SELECT
    client,
    ot.feature,
    ot.expiry >= CURRENT_TIMESTAMP() AS is_active,
    COUNT(DISTINCT page) AS number_of_pages
  FROM (
    SELECT * FROM response_headers
    UNION ALL
    SELECT * FROM meta_tags
    UNION ALL
    SELECT * FROM ot_from_custom_metric
  )
  GROUP BY
    client,
    feature,
    is_active
)
LEFT JOIN (
  SELECT
    client,
    COUNT(DISTINCT page) AS total_pages
  FROM pages
  GROUP BY
    client
)
USING (client)
ORDER BY
  number_of_pages DESC
