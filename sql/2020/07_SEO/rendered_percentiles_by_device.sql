#standardSQL
# percientile data per device

CREATE TEMP FUNCTION getTitleText(almanacJsonString STRING)
RETURNS STRING LANGUAGE js AS '''
try {
  var almanac = JSON.parse(almanacJsonString);
  
  if (almanac['title'] && almanac['title'].length > 0) {
      return almanac['title'][0].text;
  }

  return null; //maybe empty string?
} catch (e) {
  return null; //maybe empty string?
}
''';

CREATE TEMP FUNCTION getDescriptionText(almanacJsonString STRING)
RETURNS STRING LANGUAGE js AS '''
try {
  var almanac = JSON.parse(almanacJsonString);

  var description = almanac['meta-nodes'].find(meta => meta.name && meta.name.toLowerCase() == 'description');

  if (description && description.content) return description.content;

  return null; //maybe empty string?
} catch (e) {
  return null; //maybe empty string?
}
''';

CREATE TEMP FUNCTION getH1Text(almanacJsonString STRING)
RETURNS STRING LANGUAGE js AS '''
try {
  var almanac = JSON.parse(almanacJsonString);
  
  if (almanac['heading'] && almanac['heading'].h1 && almanac['heading'].h1.length > 0) {
      return almanac['heading'].h1[0].text;
  }

  return null; //maybe empty string?
} catch (e) {
  return null; //maybe empty string?
}
''';

SELECT
  percentile,
  client,
  APPROX_QUANTILES(LENGTH(title), 1000)[OFFSET(percentile * 10)] AS title_length,
  APPROX_QUANTILES(LENGTH(description), 1000)[OFFSET(percentile * 10)] AS description_length,
  APPROX_QUANTILES(LENGTH(h1), 1000)[OFFSET(percentile * 10)] AS h1_length,
  APPROX_QUANTILES(visible_words, 1000)[OFFSET(percentile * 10)] AS visible_words_count,
  APPROX_QUANTILES(words_count, 1000)[OFFSET(percentile * 10)] AS words_count,
  APPROX_QUANTILES(word_elements, 1000)[OFFSET(percentile * 10)] AS word_elements,
  APPROX_QUANTILES(header_words_count, 1000)[OFFSET(percentile * 10)] AS header_words_count,
  APPROX_QUANTILES(header_elements, 1000)[OFFSET(percentile * 10)] AS header_elements,
  APPROX_QUANTILES(internal_links, 1000)[OFFSET(percentile * 10)] AS internal_links,
  APPROX_QUANTILES(external_links, 1000)[OFFSET(percentile * 10)] AS external_links,
  APPROX_QUANTILES(hash_links, 1000)[OFFSET(percentile * 10)] AS hash_links,

  APPROX_QUANTILES(jsonld_scripts_count, 1000)[OFFSET(percentile * 10)] AS jsonld_scripts_count,
  APPROX_QUANTILES(jsonld_scripts_error_count, 1000)[OFFSET(percentile * 10)] AS jsonld_scripts_error_count
  
  ### ALSO NEED TO KNOW MAX MIN FOR ALL SO WE KNOW THE RANGE (Y-AXIS)
FROM (
  SELECT
    client,
    getTitleText(almanac) AS title,
    getDescriptionText(almanac) AS description,
    getH1Text(almanac) AS h1,
    CAST(JSON_EXTRACT_SCALAR(almanac, "$['seo-words'].wordsCount") AS INT64) AS words_count,
    CAST(JSON_EXTRACT_SCALAR(almanac, "$['visible-words']") AS INT64) AS visible_words,

    # 2019 word gathering
    CAST(JSON_EXTRACT_SCALAR(almanac, "$['seo-words'].wordElements") AS INT64) AS word_elements,
    CAST(JSON_EXTRACT_SCALAR(almanac, "$['seo-titles'].titleWords") AS INT64) AS header_words_count,
    CAST(JSON_EXTRACT_SCALAR(almanac, "$['seo-titles'].titleElements") AS INT64) AS header_elements,

    CAST(JSON_EXTRACT_SCALAR(almanac, "$['seo-anchor-elements'].internal") AS INT64) AS internal_links,
    CAST(JSON_EXTRACT_SCALAR(almanac, "$['seo-anchor-elements'].external") AS INT64) AS external_links,
    CAST(JSON_EXTRACT_SCALAR(almanac, "$['seo-anchor-elements'].hash") AS INT64) AS hash_links,

    CAST(JSON_EXTRACT_SCALAR(almanac, "$['structured-data'].jsonLdScriptCount") AS INT64) AS jsonld_scripts_count,
    CAST(JSON_EXTRACT_SCALAR(almanac, "$['structured-data'].jsonLdScriptErrorCount") AS INT64) AS jsonld_scripts_error_count
  FROM
  ( 
    SELECT 
    _TABLE_SUFFIX AS client,
    JSON_EXTRACT_SCALAR(payload, '$._almanac') AS almanac
    FROM
    `httparchive.almanac.pages_*`
  )
),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
