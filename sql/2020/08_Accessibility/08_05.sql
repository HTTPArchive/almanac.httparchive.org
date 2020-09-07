#standardSQL
# 08_05: Alt text median, mean, and max (ignoring empty and missing alts)
SELECT
  client,
  COUNT(0) AS total_non_zero_alts,
  APPROX_QUANTILES(alt_length, 100)[SAFE_ORDINAL(50)] AS median,
  MAX(alt_length) AS max,
  AVG(alt_length) AS avg
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(alt_length_string as INT64) AS alt_length
  FROM
    `httparchive.almanac.pages_desktop_*`,
    UNNEST(
      JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._almanac'), "$.images.alt_lengths")
    ) AS alt_length_string
  WHERE alt_length_string > "0" # This string comparison will still remove all numbers less than 1
)
GROUP BY
  client
