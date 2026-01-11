-- Because summary bytesHtmlDoc is a little wrong and always zero in the pages table (see: https://github.com/HTTPArchive/wptagent/issues/47)
-- we need to recalculate it by joining back to the requests table.
-- To optimize performance, we first create a CTE to pre-filter and extract the necessary data
-- from the requests table, then join that CTE in the main query.
-- when fixed, we can revert to just using summary.bytesHtmlDoc directly and remove the join and CTE.
WITH HtmlDocRequests AS (
  SELECT
    page,
    client,
    date,
    -- Extract and cast the response size once inside the CTE
    CAST(JSON_VALUE(summary.respSize) AS INT64) AS respSize_bytes
  FROM
    `httparchive.crawl.requests`
  WHERE
    -- Pre-filter the requests table for efficiency.
    -- This MUST match the date in the main query's WHERE clause.
    date = '2025-07-01' AND
    type = 'html' AND
    is_main_document
)

-- Main query now joins the CTE
SELECT
  percentile,
  p.client,
  p.is_root_page,
  APPROX_QUANTILES(CAST(JSON_VALUE(p.summary.bytesTotal) AS INT64) / 1024, 1000)[OFFSET(percentile * 10)] AS total_kbytes,
  APPROX_QUANTILES(CAST(JSON_VALUE(p.summary.bytesHtml) AS INT64) / 1024, 1000)[OFFSET(percentile * 10)] AS html_kbytes,
  APPROX_QUANTILES(CAST(JSON_VALUE(p.summary.bytesJS) AS INT64) / 1024, 1000)[OFFSET(percentile * 10)] AS js_kbytes,
  APPROX_QUANTILES(CAST(JSON_VALUE(p.summary.bytesCss) AS INT64) / 1024, 1000)[OFFSET(percentile * 10)] AS css_kbytes,
  APPROX_QUANTILES(CAST(JSON_VALUE(p.summary.bytesImg) AS INT64) / 1024, 1000)[OFFSET(percentile * 10)] AS img_kbytes,
  APPROX_QUANTILES(CAST(JSON_VALUE(p.summary.bytesOther) AS INT64) / 1024, 1000)[OFFSET(percentile * 10)] AS other_kbytes,
  -- Use the pre-calculated column from the CTE
  APPROX_QUANTILES(r.respSize_bytes / 1024, 1000)[OFFSET(percentile * 10)] AS html_doc_kbytes,
  APPROX_QUANTILES(CAST(JSON_VALUE(p.summary.bytesFont) AS INT64) / 1024, 1000)[OFFSET(percentile * 10)] AS font_kbytes
FROM
  `httparchive.crawl.pages` p
LEFT JOIN
  -- Join the new CTE on the matching keys
  HtmlDocRequests r
ON
  p.page = r.page AND
  p.client = r.client AND
  p.date = r.date,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
WHERE
  -- This filter on the main 'pages' table is still required
  p.date = '2025-07-01'
GROUP BY
  percentile,
  p.client,
  p.is_root_page
ORDER BY
  p.client,
  p.is_root_page,
  percentile
