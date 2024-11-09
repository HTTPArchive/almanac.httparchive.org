# Rework CSS parsing
CREATE OR REPLACE FUNCTION `httparchive.almanac.PARSE_CSS`(stylesheet STRING) RETURNS STRING LANGUAGE js
OPTIONS (library = ["gs://httparchive/lib/parse-css.js"]) AS R"""
try {
  var css = parse(stylesheet)
  return JSON.stringify(css);
} catch (e) {
  return null;
}
""";

# Origin Trials
CREATE OR REPLACE FUNCTION `httparchive.fn.DECODE_ORIGIN_TRIAL`(token STRING) RETURNS STRING DETERMINISTIC AS (
  SAFE_CONVERT_BYTES_TO_STRING(SUBSTR(SAFE.FROM_BASE64(token), 70))
);

CREATE OR REPLACE FUNCTION `httparchive.fn.PARSE_ORIGIN_TRIAL`(token STRING)
RETURNS STRUCT<
  token STRING,
  origin STRING,
  feature STRING,
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
