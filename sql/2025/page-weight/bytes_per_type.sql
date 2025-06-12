SELECT
  percentile,
  client,
  is_root_page,
  APPROX_QUANTILES(CAST(JSON_VALUE(summary, '$.bytesTotal') AS INT64) / 1024, 1000)[OFFSET(percentile * 10)] AS total_kbytes,
  APPROX_QUANTILES(CAST(JSON_VALUE(summary, '$.bytesHtml') AS INT64) / 1024, 1000)[OFFSET(percentile * 10)] AS html_kbytes,
  APPROX_QUANTILES(CAST(JSON_VALUE(summary, '$.bytesJS') AS INT64) / 1024, 1000)[OFFSET(percentile * 10)] AS js_kbytes,
  APPROX_QUANTILES(CAST(JSON_VALUE(summary, '$.bytesCss') AS INT64) / 1024, 1000)[OFFSET(percentile * 10)] AS css_kbytes,
  APPROX_QUANTILES(CAST(JSON_VALUE(summary, '$.bytesImg') AS INT64) / 1024, 1000)[OFFSET(percentile * 10)] AS img_kbytes,
  APPROX_QUANTILES(CAST(JSON_VALUE(summary, '$.bytesOther') AS INT64) / 1024, 1000)[OFFSET(percentile * 10)] AS other_kbytes,
  APPROX_QUANTILES(CAST(JSON_VALUE(summary, '$.bytesHtmlDoc') AS INT64) / 1024, 1000)[OFFSET(percentile * 10)] AS html_doc_kbytes,
  APPROX_QUANTILES(CAST(JSON_VALUE(summary, '$.bytesFont') AS INT64) / 1024, 1000)[OFFSET(percentile * 10)] AS font_kbytes
FROM
  `httparchive.crawl.pages`,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
WHERE
  date = '2025-06-01'
GROUP BY
  percentile,
  client,
  is_root_page
ORDER BY
  client,
  is_root_page,
  percentile
