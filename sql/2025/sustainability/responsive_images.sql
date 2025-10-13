#standardSQL
# percent of sites using images with srcset w/wo sizes, or picture element

WITH page_data AS (
  SELECT
    client,
    -- Count occurrences in HTML of the main document
    ARRAY_LENGTH(REGEXP_EXTRACT_ALL(COALESCE(response_body, ''), r'(?is)<(?:img|source)[^>]*srcset\s*=')) AS num_srcset_all,
    ARRAY_LENGTH(REGEXP_EXTRACT_ALL(COALESCE(response_body, ''), r'(?is)<(?:img|source)[^>]*sizes\s*=')) AS num_srcset_sizes,
    -- Presence of <picture>
    IF(REGEXP_CONTAINS(COALESCE(response_body, ''), r'(?is)<picture\b'), 1, 0) AS picture_total
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = '2025-06-01' AND
    is_main_document
)

SELECT
  client,
  round(
    safe_divide(
      countif(num_srcset_all > 0),
      count(0)
    ) * 100,
    2
  ) AS pages_with_srcset_pct,
  round(
    safe_divide(
      countif(num_srcset_sizes > 0),
      count(0)
    ) * 100,
    2
  ) AS pages_with_srcset_sizes_pct,
  round(
    safe_divide(
      (
        countif(num_srcset_all > 0) -
        countif(num_srcset_sizes > 0)
      ),
      count(0)
    ) * 100,
    2
  ) AS pages_with_srcset_wo_sizes_pct,
  round(
    safe_divide(
      sum(num_srcset_sizes),
      nullif(sum(num_srcset_all), 0)
    ) * 100,
    2
  ) AS instances_of_srcset_sizes_pct,
  round(
    safe_divide(
      (
        sum(num_srcset_all) -
        sum(num_srcset_sizes)
      ),
      nullif(sum(num_srcset_all), 0)
    ) * 100,
    2
  ) AS instances_of_srcset_wo_sizes_pct,
  round(
    safe_divide(countif(coalesce(picture_total, 0) > 0), count(0)) * 100,
    2
  ) AS pages_with_picture_pct
FROM page_data
GROUP BY
  client
ORDER BY
  client
