#standardSQL
# percent of sites using images with srcset w/wo sizes, or picture element

WITH page_data AS (
  SELECT
    client,
    -- Totals from markup custom metric
    CAST(JSON_EXTRACT_SCALAR(TO_JSON_STRING(custom_metrics.markup), '$.images.img.srcset_total') AS INT64) AS img_srcset_total,
    CAST(JSON_EXTRACT_SCALAR(TO_JSON_STRING(custom_metrics.markup), '$.images.source.srcset_total') AS INT64) AS source_srcset_total,
    CAST(JSON_EXTRACT_SCALAR(TO_JSON_STRING(custom_metrics.markup), '$.images.picture.total') AS INT64) AS picture_total,

    -- Sizes totals (may be missing; will be NULL)
    CAST(JSON_EXTRACT_SCALAR(TO_JSON_STRING(custom_metrics.markup), '$.images.img.sizes_total') AS INT64) AS img_sizes_total,
    CAST(JSON_EXTRACT_SCALAR(TO_JSON_STRING(custom_metrics.markup), '$.images.source.sizes_total') AS INT64) AS source_sizes_total
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-06-01' AND is_root_page
)

SELECT
  client,
  round(
    safe_divide(
      countif(coalesce(img_srcset_total, 0) + coalesce(source_srcset_total, 0) > 0),
      count(0)
    ) * 100,
    2
  ) AS pages_with_srcset_pct,
  round(
    safe_divide(
      countif(coalesce(img_sizes_total, 0) + coalesce(source_sizes_total, 0) > 0),
      count(0)
    ) * 100,
    2
  ) AS pages_with_srcset_sizes_pct,
  round(
    safe_divide(
      (
        countif(coalesce(img_srcset_total, 0) + coalesce(source_srcset_total, 0) > 0) -
        countif(coalesce(img_sizes_total, 0) + coalesce(source_sizes_total, 0) > 0)
      ),
      count(0)
    ) * 100,
    2
  ) AS pages_with_srcset_wo_sizes_pct,
  round(
    safe_divide(
      sum(coalesce(img_sizes_total, 0) + coalesce(source_sizes_total, 0)),
      sum(coalesce(img_srcset_total, 0) + coalesce(source_srcset_total, 0))
    ) * 100,
    2
  ) AS instances_of_srcset_sizes_pct,
  round(
    safe_divide(
      (
        sum(coalesce(img_srcset_total, 0) + coalesce(source_srcset_total, 0)) -
        sum(coalesce(img_sizes_total, 0) + coalesce(source_sizes_total, 0))
      ),
      sum(coalesce(img_srcset_total, 0) + coalesce(source_srcset_total, 0))
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
