SELECT
  percentile,
  client,
  is_root_page,
  APPROX_QUANTILES(CAST(JSON_VALUE(summary, '$.reqTotal') AS INT64), 1000)[OFFSET(percentile * 10)] AS total_req,
  APPROX_QUANTILES(CAST(JSON_VALUE(summary, '$.reqHtml') AS INT64), 1000)[OFFSET(percentile * 10)] AS html_req,
  APPROX_QUANTILES(CAST(JSON_VALUE(summary, '$.reqJS') AS INT64), 1000)[OFFSET(percentile * 10)] AS js_req,
  APPROX_QUANTILES(CAST(JSON_VALUE(summary, '$.reqCss') AS INT64), 1000)[OFFSET(percentile * 10)] AS css_req,
  APPROX_QUANTILES(CAST(JSON_VALUE(summary, '$.reqImg') AS INT64), 1000)[OFFSET(percentile * 10)] AS img_req,
  APPROX_QUANTILES(CAST(JSON_VALUE(summary, '$.reqJson') AS INT64), 1000)[OFFSET(percentile * 10)] AS json_req,
  APPROX_QUANTILES(CAST(JSON_VALUE(summary, '$.reqOther') AS INT64), 1000)[OFFSET(percentile * 10)] AS other_req,
  APPROX_QUANTILES(CAST(JSON_VALUE(summary, '$.reqFont') AS INT64), 1000)[OFFSET(percentile * 10)] AS font_req
FROM
  `httparchive.crawl.pages`,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
WHERE
  date = '2025-07-01'
GROUP BY
  percentile,
  client,
  is_root_page
ORDER BY
  client,
  is_root_page,
  percentile
