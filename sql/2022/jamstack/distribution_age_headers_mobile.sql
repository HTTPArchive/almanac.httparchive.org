-- getting ages to calculate median age (or any other percentage threshold)
-- we're using 2022-06-01 run as the baseline because values change every year
WITH headers AS (
  SELECT
    url,
    JSON_EXTRACT_ARRAY(payload, '$.response.headers') AS headers_array
  FROM `httparchive.requests.2022_06_01_mobile`
),

flattened_headers AS (
  SELECT
    url,
    LOWER(JSON_VALUE(flattened_headers, '$.name')) AS header_name,
    JSON_VALUE(flattened_headers, '$.value') AS header_value
  FROM headers
  CROSS JOIN UNNEST(headers.headers_array) AS flattened_headers
),

non_null_ages AS (
  SELECT
    url,
    SAFE_CAST(header_value AS NUMERIC) AS age
  FROM flattened_headers
  WHERE header_name = 'age' AND
    SAFE_CAST(header_value AS NUMERIC) IS NOT NULL
)

SELECT
  round(age / 3600) AS age_hours,
  count(distinct(url)) AS urls
FROM non_null_ages
GROUP BY age_hours
ORDER BY age_hours
