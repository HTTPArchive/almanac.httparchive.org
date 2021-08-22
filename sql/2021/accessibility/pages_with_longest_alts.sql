#standardSQL
# Pages with the longest alts
SELECT
  client,
  url,
  largest_alt,
  alt_rank
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    MAX(SAFE_CAST(alt_length_string AS INT64)) AS largest_alt,
    ROW_NUMBER() OVER (PARTITION BY _TABLE_SUFFIX ORDER BY MAX(SAFE_CAST(alt_length_string AS INT64)) DESC) AS alt_rank
  FROM
    `httparchive.pages.2021_07_01_*`,
    UNNEST(
      JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.images.alt_lengths')
    ) AS alt_length_string
  GROUP BY
    client,
    url
)
WHERE
  alt_rank <= 100
ORDER BY
  alt_rank ASC
