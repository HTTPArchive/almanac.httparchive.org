#standardSQL
# Most common lengths of alt text
# Note: A value of -1 means there is no alt tag. 0 means it is empty
# Note: Lengths of 2000+ characters are grouped together
SELECT
  client,
  is_root_page,
  SUM(COUNT(0)) OVER (PARTITION BY client, is_root_page) AS total_images,
  SUM(COUNTIF(alt_length_clipped >= 0)) OVER (PARTITION BY client, is_root_page) AS total_alt_tags,

  alt_length_clipped AS alt_length,
  COUNT(0) AS occurrences,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client, is_root_page) AS pct_all_occurrences,
  COUNT(0) / NULLIF(SUM(COUNTIF(alt_length_clipped >= 0)) OVER (PARTITION BY client, is_root_page), 0) AS pct_of_alt_tags

FROM (
  SELECT
    client,
    is_root_page,
    LEAST(alt_length, 2000) AS alt_length_clipped
  FROM (
    SELECT
      client,
      is_root_page,
      date,
      SAFE_CAST(alt_length_string AS INT64) AS alt_length
    FROM
      `httparchive.all.pages`,
      UNNEST(
        JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.images.alt_lengths')
      ) AS alt_length_string
  )
  WHERE
    date = '2024-06-01' AND
    alt_length IS NOT NULL AND
    is_root_page IS TRUE
)
GROUP BY
  client,
  is_root_page,
  alt_length
ORDER BY
  client, is_root_page, alt_length ASC;
