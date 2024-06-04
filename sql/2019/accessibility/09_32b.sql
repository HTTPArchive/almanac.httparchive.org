#standardSQL
# 09_32b: % of pages using alt tags
CREATE TEMPORARY FUNCTION hasImages(payload STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var elements = JSON.parse($._element_count);
  return (elements.img || 0) > 0;
} catch (e) {
  return false;
}
''';

SELECT
  client,
  COUNT(0) AS total_sites,
  COUNTIF(has_images) AS total_with_images,
  COUNTIF(has_images AND has_alt_tags) AS total_with_an_alt_tag,

  ROUND(COUNTIF(has_images) * 100 / COUNT(0), 2) AS perc_with_images,
  ROUND(COUNTIF(has_images AND has_alt_tags) * 100 / COUNTIF(has_images), 2) AS perc_with_an_alt_tag
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    hasImages(payload) AS has_images
  FROM
    `httparchive.pages.2019_07_01_*`
)
JOIN (
  SELECT
    client,
    page,
    REGEXP_CONTAINS(body, r'(?i)alt=[\'"]?') AS has_alt_tags
  FROM
    `httparchive.almanac.summary_response_bodies`
  WHERE
    date = '2019-07-01' AND
    firstHtml
)
USING (client, page)
GROUP BY
  client
