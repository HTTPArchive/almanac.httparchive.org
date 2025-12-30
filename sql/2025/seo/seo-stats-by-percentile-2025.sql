#standardSQL
# SEO stats by percentile

# returns all the data we need from _wpt_bodies
CREATE TEMPORARY FUNCTION get_wpt_bodies_info(wpt_bodies JSON)
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
  text_links INT64,
  hash_link INT64,
  hash_only_link INT64,
  javascript_void_links INT64,
  same_page_jumpto_total INT64,
  same_page_dynamic_total INT64,
  same_page_other_total INT64,

  valid_data BOOL
> LANGUAGE js AS '''

function allPropsAreInt(props) {
  const keys = Object.keys(props);
  for (const key of keys) {
    if (!Number.isInteger(props[key])) {
      return false;
    }
  }

  return true;
}

try {
  var result = {};

  if (Array.isArray(wpt_bodies) || typeof wpt_bodies != 'object') {
    result.valid_data = false;
    return result;
  }

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

    result.hash_link = anchors_rendered.hash_link;
    result.hash_only_link = anchors_rendered.hash_only_link;
    result.javascript_void_links = anchors_rendered.javascript_void_links;
    result.same_page_jumpto_total = anchors_rendered.same_page.jumpto.total;
    result.same_page_dynamic_total = anchors_rendered.same_page.dynamic.total;
    result.same_page_other_total = anchors_rendered.same_page.other.total;
  }

  if (wpt_bodies.meta_description && wpt_bodies.meta_description.rendered && wpt_bodies.meta_description.rendered.primary) {
    result.meta_description_characters = wpt_bodies.meta_description.rendered.primary.characters;
    result.meta_description_words = wpt_bodies.meta_description.rendered.primary.words;
  }

  // There was an invalid value somewhere. Throwout all the results for this page
  if (!allPropsAreInt(result)) {
    return {
      valid_data: false,
    };
  }

  result.valid_data = true;
  return result;
} catch (e) {
  return {
    valid_data: false,
  };
}
''';

SELECT
  percentile,
  client,
  is_root_page,
  COUNT(DISTINCT page) AS total,
  # title
  APPROX_QUANTILES(wpt_bodies_info.title_words, 1000)[OFFSET(percentile * 10)] AS title_words,
  APPROX_QUANTILES(wpt_bodies_info.title_characters, 1000)[OFFSET(percentile * 10)] AS title_characters,

  # meta description
  APPROX_QUANTILES(wpt_bodies_info.meta_description_words, 1000)[OFFSET(percentile * 10)] AS meta_description_words,
  APPROX_QUANTILES(wpt_bodies_info.meta_description_characters, 1000)[OFFSET(percentile * 10)] AS meta_description_characters,

  # links
  APPROX_QUANTILES(wpt_bodies_info.links_other_property, 1000)[OFFSET(percentile * 10)] AS outgoing_links_external,
  APPROX_QUANTILES(wpt_bodies_info.links_same_property + wpt_bodies_info.links_same_site + wpt_bodies_info.links_other_property, 1000)[OFFSET(percentile * 10)] AS outgoing_links,
  APPROX_QUANTILES(wpt_bodies_info.links_same_property + wpt_bodies_info.links_same_site, 1000)[OFFSET(percentile * 10)] AS outgoing_links_internal,

  APPROX_QUANTILES(wpt_bodies_info.image_links, 1000)[OFFSET(percentile * 10)] AS image_links,
  APPROX_QUANTILES(wpt_bodies_info.text_links, 1000)[OFFSET(percentile * 10)] AS text_links,

  APPROX_QUANTILES(wpt_bodies_info.hash_link, 1000)[OFFSET(percentile * 10)] AS hash_links,
  APPROX_QUANTILES(wpt_bodies_info.hash_only_link, 1000)[OFFSET(percentile * 10)] AS hash_only_links,
  APPROX_QUANTILES(wpt_bodies_info.javascript_void_links, 1000)[OFFSET(percentile * 10)] AS javascript_void_links,
  APPROX_QUANTILES(wpt_bodies_info.same_page_jumpto_total, 1000)[OFFSET(percentile * 10)] AS same_page_jumpto_links,
  APPROX_QUANTILES(wpt_bodies_info.same_page_dynamic_total, 1000)[OFFSET(percentile * 10)] AS same_page_dynamic_links,
  APPROX_QUANTILES(wpt_bodies_info.same_page_other_total, 1000)[OFFSET(percentile * 10)] AS same_page_other_links,

  # percent of links are image links
  APPROX_QUANTILES(SAFE_DIVIDE(wpt_bodies_info.image_links, wpt_bodies_info.image_links + wpt_bodies_info.text_links), 1000)[OFFSET(percentile * 10)] AS image_links_percent,

  # words
  APPROX_QUANTILES(wpt_bodies_info.visible_words_rendered_count, 1000)[OFFSET(percentile * 10)] AS visible_words_rendered,
  APPROX_QUANTILES(wpt_bodies_info.visible_words_raw_count, 1000)[OFFSET(percentile * 10)] AS visible_words_raw

FROM (
  SELECT
    client,
    CASE
      WHEN is_root_page = FALSE THEN 'Secondarypage'
      WHEN is_root_page = TRUE THEN 'Homepage'
      ELSE 'No Assigned Page'
    END
      AS is_root_page,
    percentile,
    page,
    get_wpt_bodies_info(custom_metrics.wpt_bodies) AS wpt_bodies_info
  FROM
    `httparchive.crawl.pages`,
    UNNEST([10, 25, 50, 75, 90]) AS percentile
  WHERE
    date = '2025-07-01'
)
WHERE
  wpt_bodies_info.valid_data
GROUP BY
  percentile,
  is_root_page,
  client
ORDER BY
  percentile,
  client
