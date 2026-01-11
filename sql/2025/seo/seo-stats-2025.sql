#standardSQL
# SEO stats

# Note: Canonical metrics moved to pages-canonical-stats.sql.  Should be removed from here in 2022.

# returns all the data we need from _wpt_bodies
CREATE TEMPORARY FUNCTION getSeoStatsWptBodies(wpt_bodies JSON)
RETURNS STRUCT<

  # tags
  n_titles INT64,
  title_words INT64,
  n_meta_descriptions INT64,
  n_h1 INT64,
  n_h2 INT64,
  n_h3 INT64,
  n_h4 INT64,
  n_non_empty_h1 INT64,
  n_non_empty_h2 INT64,
  n_non_empty_h3 INT64,
  n_non_empty_h4 INT64,
  has_same_h1_title BOOL,

  # robots
  robots_has_robots_meta_tag BOOL,
  robots_has_x_robots_tag BOOL,
  rendering_changed_robots_meta_tag BOOL,

  # canonical
  has_canonicals BOOL,
  has_self_canonical BOOL,
  is_canonicalized BOOL,
  has_http_canonical BOOL,
  has_rendered_canonical BOOL,
  has_raw_canonical BOOL,
  has_canonical_mismatch BOOL,
  rendering_changed_canonical BOOL,
  http_header_changed_canonical BOOL,

  # hreflang
  rendering_changed_hreflang BOOL,
  has_hreflang BOOL,
  has_http_hreflang BOOL,
  has_rendered_hreflang BOOL,
  has_raw_hreflang BOOL,

  # structured data
  has_raw_jsonld_or_microdata BOOL,
  has_rendered_jsonld_or_microdata BOOL,
  rendering_changes_structured_data BOOL,

  # meta robots
  rendered_otherbot_status_index BOOL,
  rendered_otherbot_status_follow BOOL,
  rendered_otherbot_noarchive BOOL,
  rendered_otherbot_nosnippet BOOL,
  rendered_otherbot_unavailable_after BOOL,
  rendered_otherbot_max_snippet BOOL,
  rendered_otherbot_max_image_preview BOOL,
  rendered_otherbot_max_video_preview BOOL,
  rendered_otherbot_notranslate BOOL,
  rendered_otherbot_noimageindex BOOL,
  rendered_otherbot_nocache BOOL,

  rendered_googlebot_status_index BOOL,
  rendered_googlebot_status_follow BOOL,
  rendered_googlebot_noarchive BOOL,
  rendered_googlebot_nosnippet BOOL,
  rendered_googlebot_unavailable_after BOOL,
  rendered_googlebot_max_snippet BOOL,
  rendered_googlebot_max_image_preview BOOL,
  rendered_googlebot_max_video_preview BOOL,
  rendered_googlebot_notranslate BOOL,
  rendered_googlebot_noimageindex BOOL,
  rendered_googlebot_nocache BOOL,

  rendered_googlebot_news_status_index BOOL,
  rendered_googlebot_news_status_follow BOOL,
  rendered_googlebot_news_noarchive BOOL,
  rendered_googlebot_news_nosnippet BOOL,
  rendered_googlebot_news_unavailable_after BOOL,
  rendered_googlebot_news_max_snippet BOOL,
  rendered_googlebot_news_max_image_preview BOOL,
  rendered_googlebot_news_max_video_preview BOOL,
  rendered_googlebot_news_notranslate BOOL,
  rendered_googlebot_news_noimageindex BOOL,
  rendered_googlebot_news_nocache BOOL
> LANGUAGE js AS '''
var result = {};
try {
  if (Array.isArray(wpt_bodies) || typeof wpt_bodies != 'object') return result;

  // checks if two string arrays contain the same strings
  function compareStringArrays(array1, array2) {
      if (!array1 && !array2) return true; // both missing
      if (!array1 && array2.length > 0) return false;
      if (!array2 && array1.length > 0) return false;
      if (array1.length != array2.length) return false;

      array1 = array1.slice();
      array1.sort();
      array2 = array2.slice();
      array2.sort();

      for (var i = 0; i < array1.length; i++) {
          if (array1[i] != array2[i]) {
              return false;
          }
      }

      return true;
  }

  var title = wpt_bodies.title;
  if (title) {
    if (title.rendered) {
      var title_rendered = title.rendered;
      //Number of words in the title tag
      if (title_rendered.primary) {
        result.title_words = title_rendered.primary.words;
      }

      //If the webpage has a title
      result.n_titles = title_rendered.total
    }
  }

  var meta_description = wpt_bodies.meta_description;
  if (meta_description) {

    if (meta_description.rendered) {
      //If the webpage has a meta description
      result.n_meta_descriptions = meta_description.rendered.total;
    }
  }

  var headings = wpt_bodies.headings;
  if (headings) {
    var headings_rendered = headings.rendered;
    if (headings_rendered) {

      //If the webpage has h1
      result.n_h1 = headings_rendered.h1.total;

      //If the webpage has h2
      result.n_h2 = headings_rendered.h2.total;

      //If the webpage has h3
      result.n_h3 = headings_rendered.h3.total;

      //If the webpage has h4
      result.n_h4 = headings_rendered.h4.total;

      //If the webpage has a non empty h1
      result.n_non_empty_h1 = headings_rendered.h1.non_empty_total;

      //If the webpage has a non empty h2
      result.n_non_empty_h2 = headings_rendered.h2.non_empty_total;

      //If the webpage has a non empty h3
      result.n_non_empty_h3 = headings_rendered.h3.non_empty_total;

      //If the webpage has a non empty h4
      result.n_non_empty_h4 = headings_rendered.h4.non_empty_total;


      //If h1 and title tag are the same
      result.has_same_h1_title = headings_rendered.primary.matches_title;
    }
  }

  var robots = wpt_bodies.robots;
  if (robots) {
    result.robots_has_robots_meta_tag = robots.has_robots_meta_tag;
    result.robots_has_x_robots_tag = robots.has_x_robots_tag;

    // added to rendered
    // has_rendered_robots_meta_tag ???
    // added to raw
    // raw and rendered are different

    //rendering_changed_robots_meta_tag
    // if the raw and rendered data are different.
    if (robots.raw && robots.rendered) {
      var rendered = robots.rendered;
      var raw = robots.raw;
      if (
        rendered.otherbot.status_index !== raw.otherbot.status_index ||
        rendered.otherbot.status_follow !== raw.otherbot.status_follow ||
        rendered.googlebot.status_index !== raw.googlebot.status_index ||
        rendered.googlebot.status_follow !== raw.googlebot.status_follow ||
        rendered.googlebot_news.status_index !== raw.googlebot_news.status_index ||
        rendered.googlebot_news.status_follow !== raw.googlebot_news.status_follow ||
        JSON.stringify(rendered.google) !== JSON.stringify(raw.google)
      )
      {
        result.rendering_changed_robots_meta_tag = true;
      }
      else
      {
        result.rendering_changed_robots_meta_tag = false;
      }

      result.rendered_otherbot_status_index = rendered.otherbot.status_index;
      result.rendered_otherbot_status_follow = rendered.otherbot.status_follow;
      result.rendered_otherbot_noarchive = rendered.otherbot.noarchive === true;
      result.rendered_otherbot_nosnippet = rendered.otherbot.nosnippet === true;
      result.rendered_otherbot_unavailable_after = rendered.otherbot.unavailable_after === true;
      result.rendered_otherbot_max_snippet = rendered.otherbot.max_snippet === true;
      result.rendered_otherbot_max_image_preview = rendered.otherbot.max_image_preview === true;
      result.rendered_otherbot_max_video_preview = rendered.otherbot.max_video_preview === true;
      result.rendered_otherbot_notranslate = rendered.otherbot.notranslate === true;
      result.rendered_otherbot_noimageindex = rendered.otherbot.noimageindex === true;
      result.rendered_otherbot_nocache = rendered.otherbot.nocache === true;

      result.rendered_googlebot_status_index = rendered.googlebot.status_index;
      result.rendered_googlebot_status_follow = rendered.googlebot.status_follow;
      result.rendered_googlebot_noarchive = rendered.googlebot.noarchive === true;
      result.rendered_googlebot_nosnippet = rendered.googlebot.nosnippet === true;
      result.rendered_googlebot_unavailable_after = rendered.googlebot.unavailable_after === true;
      result.rendered_googlebot_max_snippet = rendered.googlebot.max_snippet === true;
      result.rendered_googlebot_max_image_preview = rendered.googlebot.max_image_preview === true;
      result.rendered_googlebot_max_video_preview = rendered.googlebot.max_video_preview === true;
      result.rendered_googlebot_notranslate = rendered.googlebot.notranslate === true;
      result.rendered_googlebot_noimageindex = rendered.googlebot.noimageindex === true;
      result.rendered_googlebot_nocache = rendered.googlebot.nocache === true;

      result.rendered_googlebot_news_status_index = rendered.googlebot_news.status_index;
      result.rendered_googlebot_news_status_follow = rendered.googlebot_news.status_follow;
      result.rendered_googlebot_news_noarchive = rendered.googlebot_news.noarchive === true;
      result.rendered_googlebot_news_nosnippet = rendered.googlebot_news.nosnippet === true;
      result.rendered_googlebot_news_unavailable_after = rendered.googlebot_news.unavailable_after === true;
      result.rendered_googlebot_news_max_snippet = rendered.googlebot_news.max_snippet === true;
      result.rendered_googlebot_news_max_image_preview = rendered.googlebot_news.max_image_preview === true;
      result.rendered_googlebot_news_max_video_preview = rendered.googlebot_news.max_video_preview === true;
      result.rendered_googlebot_news_notranslate = rendered.googlebot_news.notranslate === true;
      result.rendered_googlebot_news_noimageindex = rendered.googlebot_news.noimageindex === true;
      result.rendered_googlebot_news_nocache = rendered.googlebot_news.nocache === true;

      // result.rendering_changed_robots_meta_tag = JSON.stringify(robots.raw) === JSON.stringify(robots.rendered);
    }
  }

  var canonicals = wpt_bodies.canonicals;
  if (canonicals) {

    if (canonicals.canonicals && canonicals.canonicals.length) {
      result.has_canonicals = canonicals.canonicals.length > 0;
    }

    if (canonicals.self_canonical) {
      result.has_self_canonical = canonicals.self_canonical;
    }

    if (canonicals.other_canonical) {
      result.is_canonicalized = canonicals.other_canonical;
    }

    if (canonicals.http_header_link_canoncials) {
      result.has_http_canonical = canonicals.http_header_link_canoncials.length > 0;
    }

    result.has_rendered_canonical = false; // used in a NOT so must be set for a simple query to work
    if (canonicals.rendered && canonicals.rendered.html_link_canoncials) {
      result.has_rendered_canonical = canonicals.rendered.html_link_canoncials.length > 0;
    }

    result.has_raw_canonical = false; // used in a NOT so must be set for a simple query to work
    if (canonicals.raw && canonicals.raw.html_link_canoncials) {
      result.has_raw_canonical = canonicals.raw.html_link_canoncials.length > 0;
    }

    if (canonicals.canonical_missmatch) {
      result.has_canonical_mismatch = canonicals.canonical_missmatch;
    }

    if (canonicals.raw && canonicals.rendered) {
      result.rendering_changed_canonical = !compareStringArrays(canonicals.raw.html_link_canoncials, canonicals.rendered.html_link_canoncials);
    }

    if (canonicals.raw && canonicals.http_header_link_canoncials && canonicals.http_header_link_canoncials.length > 0) {
      result.http_header_changed_canonical = !compareStringArrays(canonicals.raw.html_link_canoncials, canonicals.http_header_link_canoncials);
    }
  }

  var hreflangs = wpt_bodies.hreflangs;
  if (hreflangs) {

    if (hreflangs.raw && hreflangs.raw.values && hreflangs.rendered && hreflangs.rendered.values) {
      result.rendering_changed_hreflang = !compareStringArrays(hreflangs.raw.values, hreflangs.rendered.values);
    }

    if (hreflangs.rendered && hreflangs.rendered.values) {
      result.has_hreflang = hreflangs.rendered.values.length > 0;
    }

    if (hreflangs.http_header && hreflangs.http_header.values) {
      result.has_http_hreflang = hreflangs.http_header.values.length > 0;
    }

    result.has_rendered_hreflang = false; // used in a NOT so must be set for a simple query to work
    if (hreflangs.rendered && hreflangs.rendered.values) {
      result.has_rendered_hreflang = hreflangs.rendered.values.length > 0;
    }

    result.has_raw_hreflang = false; // used in a NOT so must be set for a simple query to work
    if (hreflangs.raw && hreflangs.raw.values) {
      result.has_raw_hreflang = hreflangs.raw.values.length > 0;
    }
  }

  var structured_data = wpt_bodies.structured_data;
  if (structured_data) {
    result.has_raw_jsonld_or_microdata = structured_data.raw && structured_data.raw.jsonld_and_microdata_types && structured_data.raw.jsonld_and_microdata_types.length > 0;
    result.has_rendered_jsonld_or_microdata = structured_data.rendered && structured_data.rendered.jsonld_and_microdata_types  && structured_data.rendered.jsonld_and_microdata_types.length > 0;

    if (structured_data.raw && structured_data.rendered) {
      result.rendering_changes_structured_data = JSON.stringify(structured_data.raw) !== JSON.stringify(structured_data.rendered);
    }
  }
} catch (e) {}
return result;
''';

SELECT
  client,
  COUNT(0) AS total,
  is_root_page,
  # meta title inclusion
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.n_titles > 0), COUNT(0)) AS pct_has_title_tag,

  # meta description inclusion
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.n_meta_descriptions > 0), COUNT(0)) AS pct_has_meta_description,

  # H1 inclusion
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.n_h1 > 0), COUNT(0)) AS pct_has_h1,

  # H2 inclusion
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.n_h2 > 0), COUNT(0)) AS pct_has_h2,

  # H3 inclusion
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.n_h3 > 0), COUNT(0)) AS pct_has_h3,

  # H4 inclusion
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.n_h4 > 0), COUNT(0)) AS pct_has_h4,

  # Non-empty H1 inclusion
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.n_non_empty_h1 > 0), COUNT(0)) AS pct_has_non_empty_h1,

  # Non-empty H2 inclusion
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.n_non_empty_h2 > 0), COUNT(0)) AS pct_has_non_empty_h2,

  # Non-empty H3 inclusion
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.n_non_empty_h3 > 0), COUNT(0)) AS pct_has_non_empty_h3,

  # Non-empty H4 inclusion
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.n_non_empty_h4 > 0), COUNT(0)) AS pct_has_non_empty_h4,

  # Same title and H1
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.has_same_h1_title), COUNT(0)) AS pct_has_same_h1_title,

  # Meta Robots inclusion
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.robots_has_robots_meta_tag), COUNT(0)) AS pct_has_meta_robots,

  # HTTP Header Robots inclusion
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.robots_has_x_robots_tag), COUNT(0)) AS pct_has_x_robots_tag,

  # Meta Robots and x-robots inclusion
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.robots_has_robots_meta_tag AND wpt_bodies_info.robots_has_x_robots_tag), COUNT(0)) AS pct_has_meta_robots_and_x_robots_tag,

  # Rendering changed Robots
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendering_changed_robots_meta_tag), COUNT(0)) AS pct_rendering_changed_robots_meta_tag,

  # Pages with canonical
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.has_canonicals), COUNT(0)) AS pct_has_canonical,

  # Pages with self-canonical
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.has_self_canonical), COUNT(0)) AS pct_has_self_canonical,

  # Pages canonicalized
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.is_canonicalized), COUNT(0)) AS pct_is_canonicalized,

  # Pages with canonical in HTTP header
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.has_http_canonical), COUNT(0)) AS pct_http_canonical,

  # Pages with canonical in raw html
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.has_raw_canonical), COUNT(0)) AS pct_has_raw_canonical,

  # Pages with canonical in rendered html
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.has_rendered_canonical), COUNT(0)) AS pct_has_rendered_canonical,

  # Pages with canonical in rendered but not raw html
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.has_rendered_canonical AND NOT wpt_bodies_info.has_raw_canonical), COUNT(0)) AS pct_has_rendered_but_not_raw_canonical,

  # Pages with canonical mismatch
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.has_canonical_mismatch), COUNT(0)) AS pct_has_canonical_mismatch,

  # Pages with canonical conflict between raw and rendered
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendering_changed_canonical), COUNT(0)) AS pct_has_conflict_rendering_changed_canonical,

  # Pages with canonical conflict between raw and http header
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.http_header_changed_canonical), COUNT(0)) AS pct_has_conflict_http_header_changed_canonical,

  # Pages with canonical conflict between raw and http header
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.http_header_changed_canonical OR wpt_bodies_info.rendering_changed_canonical), COUNT(0)) AS pct_has_conflict_http_header_or_rendering_changed_canonical,

  # Pages with hreflang conflict between raw and rendered
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendering_changed_hreflang), COUNT(0)) AS pct_has_conflict_raw_rendered_hreflang,

  # Pages with hreflang
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.has_hreflang), COUNT(0)) AS pct_has_hreflang,

  # Pages with http hreflang
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.has_http_hreflang), COUNT(0)) AS pct_has_http_hreflang,

  # Pages with rendered hreflang
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.has_rendered_hreflang), COUNT(0)) AS pct_has_rendered_hreflang,

  # Pages with raw hreflang
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.has_raw_hreflang), COUNT(0)) AS pct_has_raw_hreflang,

  # Pages with hreflang in rendered but not raw html
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.has_rendered_hreflang AND NOT wpt_bodies_info.has_raw_hreflang), COUNT(0)) AS pct_has_rendered_but_not_raw_hreflang,

  # Pages with raw jsonld or microdata
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.has_raw_jsonld_or_microdata), COUNT(0)) AS pct_has_raw_jsonld_or_microdata,

  # Pages with rendered jsonld or microdata
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.has_rendered_jsonld_or_microdata), COUNT(0)) AS pct_has_rendered_jsonld_or_microdata,

  # Pages with only rendered jsonld or microdata
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.has_rendered_jsonld_or_microdata AND NOT wpt_bodies_info.has_raw_jsonld_or_microdata), COUNT(0)) AS pct_has_only_rendered_jsonld_or_microdata,

  # Pages where rendering changed jsonld or microdata
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendering_changes_structured_data), COUNT(0)) AS pct_rendering_changes_structured_data,

  # http or https
  SAFE_DIVIDE(COUNTIF(protocol = 'https'), COUNT(0)) AS pct_https,

  # meta robots
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendered_otherbot_status_index), COUNT(0)) AS pct_rendered_otherbot_status_index,
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendered_otherbot_status_follow), COUNT(0)) AS pct_rendered_otherbot_status_follow,
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendered_otherbot_noarchive), COUNT(0)) AS pct_rendered_otherbot_noarchive,
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendered_otherbot_nosnippet), COUNT(0)) AS pct_rendered_otherbot_nosnippet,
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendered_otherbot_unavailable_after), COUNT(0)) AS pct_rendered_otherbot_unavailable_after,
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendered_otherbot_max_snippet), COUNT(0)) AS pct_rendered_otherbot_max_snippet,
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendered_otherbot_max_image_preview), COUNT(0)) AS pct_rendered_otherbot_max_image_preview,
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendered_otherbot_max_video_preview), COUNT(0)) AS pct_rendered_otherbot_max_video_preview,
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendered_otherbot_notranslate), COUNT(0)) AS pct_rendered_otherbot_notranslate,
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendered_otherbot_noimageindex), COUNT(0)) AS pct_rendered_otherbot_noimageindex,
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendered_otherbot_nocache), COUNT(0)) AS pct_rendered_otherbot_nocache,
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendered_googlebot_status_index), COUNT(0)) AS pct_rendered_googlebot_status_index,
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendered_googlebot_status_follow), COUNT(0)) AS pct_rendered_googlebot_status_follow,
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendered_googlebot_noarchive), COUNT(0)) AS pct_rendered_googlebot_noarchive,
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendered_googlebot_nosnippet), COUNT(0)) AS pct_rendered_googlebot_nosnippet,
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendered_googlebot_unavailable_after), COUNT(0)) AS pct_rendered_googlebot_unavailable_after,
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendered_googlebot_max_snippet), COUNT(0)) AS pct_rendered_googlebot_max_snippet,
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendered_googlebot_max_image_preview), COUNT(0)) AS pct_rendered_googlebot_max_image_preview,
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendered_googlebot_max_video_preview), COUNT(0)) AS pct_rendered_googlebot_max_video_preview,
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendered_googlebot_notranslate), COUNT(0)) AS pct_rendered_googlebot_notranslate,
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendered_googlebot_noimageindex), COUNT(0)) AS pct_rendered_googlebot_noimageindex,
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendered_googlebot_nocache), COUNT(0)) AS pct_rendered_googlebot_nocache,
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendered_googlebot_news_status_index), COUNT(0)) AS pct_rendered_googlebot_news_status_index,
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendered_googlebot_news_status_follow), COUNT(0)) AS pct_rendered_googlebot_news_status_follow,
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendered_googlebot_news_noarchive), COUNT(0)) AS pct_rendered_googlebot_news_noarchive,
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendered_googlebot_news_nosnippet), COUNT(0)) AS pct_rendered_googlebot_news_nosnippet,
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendered_googlebot_news_unavailable_after), COUNT(0)) AS pct_rendered_googlebot_news_unavailable_after,
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendered_googlebot_news_max_snippet), COUNT(0)) AS pct_rendered_googlebot_news_max_snippet,
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendered_googlebot_news_max_image_preview), COUNT(0)) AS pct_rendered_googlebot_news_max_image_preview,
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendered_googlebot_news_max_video_preview), COUNT(0)) AS pct_rendered_googlebot_news_max_video_preview,
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendered_googlebot_news_notranslate), COUNT(0)) AS pct_rendered_googlebot_news_notranslate,
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendered_googlebot_news_noimageindex), COUNT(0)) AS pct_rendered_googlebot_news_noimageindex,
  SAFE_DIVIDE(COUNTIF(wpt_bodies_info.rendered_googlebot_news_nocache), COUNT(0)) AS pct_rendered_googlebot_news_nocache

FROM (
  SELECT
    client,
    CASE
      WHEN is_root_page = FALSE THEN 'Secondarypage'
      WHEN is_root_page = TRUE THEN 'Homepage'
      ELSE 'No Assigned Page'
    END
      AS is_root_page,
    SPLIT(page, ':')[OFFSET(0)] AS protocol,
    getSeoStatsWptBodies(TO_JSON(custom_metrics.wpt_bodies)) AS wpt_bodies_info
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
)
GROUP BY
  client,
  is_root_page
