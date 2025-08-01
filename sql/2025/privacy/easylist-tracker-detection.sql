CREATE TEMP FUNCTION
CheckDomainInURL(url STRING, domain STRING)
RETURNS INT64
LANGUAGE js AS """
  return url.includes(domain) ? 1 : 0;
""";

-- We need to use the `easylist_adservers.csv` to populate the table to get the list of domains to block
-- https://github.com/easylist/easylist/blob/master/easylist/easylist_adservers.txt
WITH easylist_data AS (
  SELECT string_field_0
  FROM `httparchive.almanac.easylist_adservers`
),

requests_data AS (
  SELECT url
  FROM `httparchive.all.requests`
  WHERE
    date = '2025-07-01' AND
    is_root_page = TRUE
),

block_status AS (
  SELECT
    r.url,
    MAX(
      CASE
        WHEN CheckDomainInURL(r.url, e.string_field_0) = 1 THEN 1
        ELSE 0
      END
    ) AS should_block
  FROM requests_data r
  LEFT JOIN easylist_data e
  ON CheckDomainInURL(r.url, e.string_field_0) = 1
  GROUP BY r.url
)

SELECT
  COUNT(0) AS blocked_url_count
FROM block_status
WHERE should_block = 1;
