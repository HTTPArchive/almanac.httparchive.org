-- Temporary function to extract content-encoding
CREATE TEMPORARY FUNCTION GET_CONTENT_ENCODING(response_headers ARRAY<STRUCT<name STRING, value STRING>>)
RETURNS STRING AS (
  (
    SELECT
      value
    FROM
      UNNEST(response_headers) AS header
    WHERE
      LOWER(header.name) = 'content-encoding'
    LIMIT 1 -- noqa: AM09
  )
);

SELECT
  date,
  client,
  GET_CONTENT_ENCODING(response_headers) AS content_encoding,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.all.requests`
WHERE
  date = '2024-06-01' AND
  is_main_document
GROUP BY
  client,
  content_encoding
ORDER BY
  pct DESC
