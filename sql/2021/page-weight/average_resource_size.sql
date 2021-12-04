SELECT
  _TABLE_SUFFIX AS client,
  AVG(bytesTotal) / 1024 AS total_kbytes,
  AVG(bytesHtml) / 1024 AS html_kbytes,
  AVG(bytesJS) / 1024 AS js_kbytes,
  AVG(bytesCSS) / 1024 AS css_kbytes,
  AVG(bytesImg) / 1024 AS img_kbytes,
  AVG(bytesOther) / 1024 AS other_kbytes,
  AVG(bytesHtmlDoc) / 1024 AS html_doc_kbytes,
  AVG(bytesFont) / 1024 AS font_kbytes
FROM
  `httparchive.summary_pages.2021_07_01_*`
GROUP BY
  client
