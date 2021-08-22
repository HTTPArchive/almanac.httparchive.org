#standardSQL
# Most common lengths of alt text
# Note: A value of -1 means there is no alt tag. 0 means it is empty
# Note: Lengths of 2000+ characters are grouped together
SELECT
  client,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_images,
  SUM(COUNTIF(alt_length_clipped >= 0)) OVER (PARTITION BY client) AS total_alt_tags,

  alt_length_clipped AS alt_length,
  COUNT(0) AS occurrences,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_all_occurrences
FROM (
  SELECT
    client,
    LEAST(alt_length, 2000) AS alt_length_clipped
  FROM (
    SELECT
      _TABLE_SUFFIX AS client,
      SAFE_CAST(alt_length_string AS INT64) AS alt_length
    FROM
      `httparchive.pages.2021_07_01_*`,
      UNNEST(
        JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.images.alt_lengths')
      ) AS alt_length_string
  )
  WHERE
    alt_length IS NOT NULL
)
GROUP BY
  client,
  alt_length
ORDER BY
  alt_length ASC
