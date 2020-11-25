#standardSQL
# usage of alt text in images

# returns all the data we need from _markup
CREATE TEMPORARY FUNCTION get_markup_info(markup_string STRING)
RETURNS STRUCT<
  total INT64,
  alt_missing INT64, 
  alt_blank INT64,
  alt_present INT64
> LANGUAGE js AS '''
var result = {};
try {
    var markup = JSON.parse(markup_string);

    if (Array.isArray(markup) || typeof markup != 'object') return result;
	
    result.total = markup.images.img.total;
    result.alt_missing = markup.images.img.alt.missing;
    result.alt_blank = markup.images.img.alt.blank;
    result.alt_present = markup.images.img.alt.present;

} catch (e) {}
return result;
''';

SELECT
  client,
  ROUND(SAFE_DIVIDE(COUNTIF(markup_info.total > 0) * 100, COUNT(0)), 2) AS pages_with_img_pct,
  ROUND(SAFE_DIVIDE(COUNTIF(markup_info.alt_missing > 0) * 100, COUNT(0)), 2) AS pages_with_alt_missing_pct,
  ROUND(SAFE_DIVIDE(COUNTIF(markup_info.alt_blank > 0) * 100, COUNT(0)), 2) AS pages_with_alt_blank_pct,
  ROUND(SAFE_DIVIDE(COUNTIF(markup_info.alt_present > 0) * 100, COUNT(0)), 2) AS pages_with_alt_present_pct,
  SUM(markup_info.total) AS img_total,
  ROUND(SAFE_DIVIDE(SUM(markup_info.alt_missing) * 100, SUM(markup_info.total)), 2) AS imgs_alt_missing_pct,
  ROUND(SAFE_DIVIDE(SUM(markup_info.alt_blank) * 100, SUM(markup_info.total)), 2) AS img_alt_blank_pct,
  ROUND(SAFE_DIVIDE(SUM(markup_info.alt_present) * 100, SUM(markup_info.total)), 2) AS img_alt_present_pct
FROM
  (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    get_markup_info(JSON_EXTRACT_SCALAR(payload, '$._markup')) AS markup_info
  FROM
    `httparchive.pages.2020_08_01_*`
  )
GROUP BY
  client
ORDER BY
  client;
