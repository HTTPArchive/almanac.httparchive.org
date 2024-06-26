#standardSQL
# 09_17: % pages using tables with headings
CREATE TEMPORARY FUNCTION getTableInfo(payload STRING)
RETURNS STRUCT<has_table BOOLEAN, has_th BOOLEAN> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var elements = JSON.parse($._element_count);
  if (Array.isArray(elements) || typeof elements != 'object') {
    return {
      has_table: false,
      has_th: false
    };
  }

  return {
    has_table: !!elements.table,
    has_th: !!elements.th
  };
} catch (e) {
  return {
    has_table: false,
    has_th: false
  };
}
''';


SELECT
  client,
  COUNT(0) AS total_pages,

  COUNTIF(table_info.has_table) AS total_using_tables,

  COUNTIF(table_info.has_th) AS total_th,
  COUNTIF(has_columnheader_role) AS total_columnheader,
  COUNTIF(has_rowheader_role) AS total_rowheader,
  COUNTIF(table_info.has_th OR has_rowheader_role OR has_columnheader_role) AS total_using_any,

  ROUND(COUNTIF(table_info.has_table AND table_info.has_th) * 100 / COUNTIF(table_info.has_table), 2) AS perc_with_th,
  ROUND(COUNTIF(table_info.has_table AND has_columnheader_role) * 100 / COUNTIF(table_info.has_table), 2) AS perc_with_columnheader,
  ROUND(COUNTIF(table_info.has_table AND has_rowheader_role) * 100 / COUNTIF(table_info.has_table), 2) AS perc_with_rowheader,
  ROUND(COUNTIF(table_info.has_table AND (table_info.has_th OR has_rowheader_role OR has_columnheader_role)) * 100 / COUNTIF(table_info.has_table), 2) AS perc_with_any
FROM (
  SELECT
    client,
    page,
    REGEXP_CONTAINS(body, r'(?i)\brole=[\'"]?(columnheader)\b') AS has_columnheader_role,
    REGEXP_CONTAINS(body, r'(?i)\brole=[\'"]?(rowheader)\b') AS has_rowheader_role
  FROM
    `httparchive.almanac.summary_response_bodies`
  WHERE
    date = '2019-07-01' AND
    firstHtml
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    getTableInfo(payload) AS table_info
  FROM
    `httparchive.pages.2019_07_01_*`
)
USING (client, page)
GROUP BY
  client
