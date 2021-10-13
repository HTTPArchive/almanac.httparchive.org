#standardSQL
# Prevalence of mimetype - file extension mismatches among all requests. Non-SVG images are ignored.
WITH mimtype_file_ext_pairs AS (
  SELECT
    client,
    LOWER(mimetype) AS mimetype,
    LOWER(ext) AS file_extension,
    SUM(COUNT(0)) OVER (PARTITION BY client) AS total_requests,
    COUNT(0) AS count_pair
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = "2021-07-01"
  GROUP BY
    client,
    mimetype,
    file_extension
)

SELECT
  client,
  mimetype,
  file_extension,
  total_requests,
  SUM(MIN(count_pair)) OVER (PARTITION BY client) AS count_mismatches,
  SUM(MIN(count_pair)) OVER (PARTITION BY client) / total_requests AS pct_mismatches,
  MIN(count_pair) AS count_pair,
  MIN(count_pair) / SUM(MIN(count_pair)) OVER (PARTITION BY client) AS pct_pair
FROM
  mimtype_file_ext_pairs
WHERE
  mimetype IS NOT NULL AND
  mimetype != "" AND
  file_extension IS NOT NULL AND
  file_extension != "" AND
  mimetype NOT LIKE CONCAT("%", file_extension) AND
  NOT (REGEXP_CONTAINS(mimetype, "(application|text)/(x-)*javascript") AND REGEXP_CONTAINS(file_extension, r"(?i)^m?js$")) AND
  NOT (mimetype = "image/svg+xml" AND REGEXP_CONTAINS(file_extension, r"(?i)^svg$")) AND
  NOT (mimetype = "audio/mpeg" AND REGEXP_CONTAINS(file_extension, r"(?i)^mp3$")) AND
  NOT (STARTS_WITH(mimetype, "image/") AND REGEXP_CONTAINS(file_extension, r"(?i)^(apng|avif|bmp|cur|gif|jpeg|jpg|jfif|ico|pjpeg|pjp|png|tif|tiff|webp)$"))
GROUP BY
  client,
  total_requests,
  mimetype,
  file_extension
ORDER BY
  count_pair DESC
LIMIT 100
