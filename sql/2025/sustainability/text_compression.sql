CREATE TEMP FUNCTION GETCONTENTENCODING(headers STRING)
RETURNS STRING
LANGUAGE js AS """
  try {
    const parsedHeaders = JSON.parse(headers);
    for (let i = 0; i < parsedHeaders.length; i++) {
      if (parsedHeaders[i].name.toLowerCase() === 'content-encoding') {
        return parsedHeaders[i].value.toLowerCase();
      }
    }
  } catch (e) {}
  return null;
""";

WITH request_data AS (
    SELECT
        client,
        GETCONTENTENCODING(
            JSON_EXTRACT(payload, '$.response.headers')
        ) AS resp_content_encoding
    FROM
        `httparchive.crawl.requests`
    WHERE
        date = '2025-06-01'
),

compression_data AS (
    SELECT
        client,
        CASE
            WHEN resp_content_encoding = 'gzip' THEN 'Gzip'
            WHEN resp_content_encoding = 'br' THEN 'Brotli'
            WHEN resp_content_encoding IS NULL THEN 'no text compression'
            ELSE 'other'
        END AS compression_type,
        COUNT(*) AS num_requests,
        SUM(COUNT(*)) OVER (PARTITION BY client) AS total,
        ROUND(
            COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY client) * 100, 2
        ) AS pct
    FROM
        request_data
    GROUP BY
        client,
        compression_type
)

SELECT
    client,
    compression_type,
    num_requests,
    total,
    pct
FROM compression_data
ORDER BY
    client ASC,
    num_requests DESC
