#standardSQL
# preload attribute values

SELECT
  client,
  LOWER(preload_value) AS preload_value,
  COUNT(0) AS preload_value_count,
  SAFE_DIVIDE(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY client)) AS preload_value_pct
FROM
  `httparchive.almanac.summary_response_bodies`,
  # extract preload attribute value, or empty if none
  UNNEST(REGEXP_EXTRACT_ALL(body, '<video[^>]*?preload=*(?:\"|\')*(.*?)(?:\"|\'|\\s|>)')) AS preload_value
WHERE
  date = '2021-08-01' AND
  firstHtml
GROUP BY
  client,
  preload_value
HAVING
  preload_value_count > 10
ORDER BY
  client,
  preload_value_count DESC;
