#standardSQL
# 08_06: Most common lengths of alt text (-1 for none. 2000+ grouped together)
SELECT
  client,
  alt_length_clipped AS alt_length,
  COUNT(0) AS occurances
FROM (
  SELECT
    client,
    IF(alt_length >= 2000, 2000, alt_length) AS alt_length_clipped
  FROM (
    SELECT
      _TABLE_SUFFIX AS client,
      CAST(alt_length_string AS INT64) AS alt_length
    FROM
      `httparchive.pages.2020_08_01_*`
      UNNEST(
        JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._almanac'), "$.images.alt_lengths")
      ) AS alt_length_string
  )
)
GROUP BY
  client,
  alt_length
ORDER BY
  alt_length ASC
