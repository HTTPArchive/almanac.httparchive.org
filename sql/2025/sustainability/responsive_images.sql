#standardSQL
# percent of sites using images with srcset w/wo sizes, or picture element

WITH page_data AS (
  SELECT
    client,
    -- Count occurrences in HTML of the main document
    ARRAY_LENGTH(
      REGEXP_EXTRACT_ALL(
        COALESCE(response_body, ''),
        r'(?is)<(?:img|source)[^>]*srcset\s*='
      )
    ) AS num_srcset_all,
    ARRAY_LENGTH(
      REGEXP_EXTRACT_ALL(
        COALESCE(response_body, ''),
        r'(?is)<(?:img|source)[^>]*sizes\s*='
      )
    ) AS num_srcset_sizes,
    -- Presence of <picture>
    IF(
      REGEXP_CONTAINS(COALESCE(response_body, ''), r'(?is)<picture\b'),
      1,
      0
    ) AS picture_total
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = '2025-07-01' AND
    is_main_document
)

SELECT
  client,
  ROUND(
    SAFE_DIVIDE(
      COUNTIF(num_srcset_all > 0),
      COUNT(0)
    ) * 100,
    2
  ) AS pages_with_srcset_pct,
  ROUND(
    SAFE_DIVIDE(
      COUNTIF(num_srcset_sizes > 0),
      COUNT(0)
    ) * 100,
    2
  ) AS pages_with_srcset_sizes_pct,
  ROUND(
    SAFE_DIVIDE(
      (
        COUNTIF(num_srcset_all > 0) -
        COUNTIF(num_srcset_sizes > 0)
      ),
      COUNT(0)
    ) * 100,
    2
  ) AS pages_with_srcset_wo_sizes_pct,
  ROUND(
    SAFE_DIVIDE(
      SUM(num_srcset_sizes),
      NULLIF(SUM(num_srcset_all), 0)
    ) * 100,
    2
  ) AS instances_of_srcset_sizes_pct,
  ROUND(
    SAFE_DIVIDE(
      (
        SUM(num_srcset_all) -
        SUM(num_srcset_sizes)
      ),
      NULLIF(SUM(num_srcset_all), 0)
    ) * 100,
    2
  ) AS instances_of_srcset_wo_sizes_pct,
  ROUND(
    SAFE_DIVIDE(COUNTIF(COALESCE(picture_total, 0) > 0), COUNT(0)) * 100,
    2
  ) AS pages_with_picture_pct
FROM page_data
GROUP BY
  client
ORDER BY
  client
