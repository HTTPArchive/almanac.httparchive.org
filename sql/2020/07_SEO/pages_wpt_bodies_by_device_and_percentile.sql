#standardSQL
# percientile data from wpt_bodies per device

# returns all the data we need from _wpt_bodies
CREATE TEMPORARY FUNCTION get_wpt_bodies_info(wpt_bodies_string STRING)
RETURNS STRUCT<
  title_words INT64,
  title_characters INT64,
  links_other_property INT64,
  links_same_site INT64,
  links_same_property INT64,
  visible_words_rendered_count INT64,
  visible_words_raw_count INT64,
  meta_description_words INT64,
  meta_description_characters INT64,
  image_links INT64, 
  text_links INT64
> LANGUAGE js AS '''
var result = {};
try {
    var wpt_bodies = JSON.parse(wpt_bodies_string);
   
    if (Array.isArray(wpt_bodies) || typeof wpt_bodies != 'object') return result;

    if (wpt_bodies.title) {
      if (wpt_bodies.title.rendered) {
        result.title_words = wpt_bodies.title.rendered.primary.words;
        result.title_characters = wpt_bodies.title.rendered.primary.characters;
      }
    }
    if (wpt_bodies.visible_words) {
      result.visible_words_rendered_count = wpt_bodies.visible_words.rendered;
      result.visible_words_raw_count = wpt_bodies.visible_words.raw;
    }

    if (wpt_bodies.anchors && wpt_bodies.anchors.rendered) {
      var anchors_rendered = wpt_bodies.anchors.rendered;

      result.links_other_property = anchors_rendered.other_property;
      result.links_same_site = anchors_rendered.same_site;
      result.links_same_property = anchors_rendered.same_property;
    
      result.image_links = anchors_rendered.image_links;
      result.text_links = anchors_rendered.text_links;
    }

    if (wpt_bodies.meta_description && wpt_bodies.meta_description.rendered && wpt_bodies.meta_description.rendered.primary) {

      result.meta_description_characters = wpt_bodies.meta_description.rendered.primary.characters;
      result.meta_description_words = wpt_bodies.meta_description.rendered.primary.words;

    }

} catch (e) {}
return result;
''';

SELECT
  percentile,
  client,
  COUNT(DISTINCT url) AS total,

  # title
  APPROX_QUANTILES(wpt_bodies_info.title_words, 1000)[OFFSET(percentile * 10)] AS title_words,
  APPROX_QUANTILES(wpt_bodies_info.title_characters, 1000)[OFFSET(percentile * 10)] AS title_characters,

  # meta description
  APPROX_QUANTILES(wpt_bodies_info.meta_description_words, 1000)[OFFSET(percentile * 10)] AS meta_description_words,
  APPROX_QUANTILES(wpt_bodies_info.meta_description_characters, 1000)[OFFSET(percentile * 10)] AS meta_description_characters,

  # links
  APPROX_QUANTILES(wpt_bodies_info.links_other_property, 1000)[OFFSET(percentile * 10)] AS outgoing_links_external,
  APPROX_QUANTILES(wpt_bodies_info.links_same_property+wpt_bodies_info.links_same_site+wpt_bodies_info.links_other_property, 1000)[OFFSET(percentile * 10)] AS outgoing_links,
  APPROX_QUANTILES(wpt_bodies_info.links_same_property+wpt_bodies_info.links_same_site, 1000)[OFFSET(percentile * 10)] AS outgoing_links_internal,

  APPROX_QUANTILES(wpt_bodies_info.image_links, 1000)[OFFSET(percentile * 10)] AS image_links,
  APPROX_QUANTILES(wpt_bodies_info.text_links, 1000)[OFFSET(percentile * 10)] AS text_links,

  # percent of links are image links
  ROUND(APPROX_QUANTILES(SAFE_DIVIDE(wpt_bodies_info.image_links, wpt_bodies_info.image_links + wpt_bodies_info.text_links), 1000)[OFFSET(percentile * 10)], 4) AS image_links_percent,

  # words
  APPROX_QUANTILES(wpt_bodies_info.visible_words_rendered_count, 1000)[OFFSET(percentile * 10)] AS visible_words_rendered,
  APPROX_QUANTILES(wpt_bodies_info.visible_words_raw_count, 1000)[OFFSET(percentile * 10)] AS visible_words_raw

FROM (
  SELECT 
    _TABLE_SUFFIX AS client,
    percentile,
    url,
    get_wpt_bodies_info(JSON_EXTRACT_SCALAR(payload, '$._wpt_bodies')) AS wpt_bodies_info
  FROM
  `httparchive.pages.2020_08_01_*`,
  UNNEST([10, 25, 50, 75, 90]) AS percentile
)
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
