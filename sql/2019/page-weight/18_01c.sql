#standardSQL
# 18_01c: Average size of each of the resource types.
SELECT
  _TABLE_SUFFIX AS client,
  ROUND(AVG(bytesTotal) / 1024, 2) AS total_kbytes,
  ROUND(AVG(bytesHtml) / 1024, 2) AS html_kbytes,
  ROUND(AVG(bytesJS) / 1024, 2) AS js_kbytes,
  ROUND(AVG(bytesCSS) / 1024, 2) AS css_kbytes,
  ROUND(AVG(bytesImg) / 1024, 2) AS img_kbytes,
  ROUND(AVG(bytesOther) / 1024, 2) AS other_kbytes,
  ROUND(AVG(bytesHtmlDoc) / 1024, 2) AS html_doc_kbytes
FROM
  `httparchive.summary_pages.2019_07_01_*`
GROUP BY
  client
