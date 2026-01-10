#standardSQL
# page canonical metrics by device

# Note: Contains redundant stats to seo-stats.sql in order to start better segmenting metrics away from monolithic queries.


# JS parsing of custom_metrics
CREATE TEMPORARY FUNCTION getCanonicalMetrics(wpt_bodies JSON)
RETURNS STRUCT<
  has_wpt_bodies BOOL,
  has_canonicals BOOL,
  has_self_canonical BOOL,
  is_canonicalized BOOL,
  has_http_canonical BOOL,
  has_rendered_canonical BOOL,
  has_raw_canonical BOOL,
  has_canonical_mismatch BOOL,
  rendering_changed_canonical BOOL,
  http_header_changed_canonical BOOL,
  has_relative_canonical BOOL,
  has_absolute_canonical BOOL,
  js_error BOOL
> LANGUAGE js AS '''

var result = {has_wpt_bodies: true,
              has_canonicals: false,
              has_self_canonical: false,
              is_canonicalized: false,
              has_http_canonical: false,
              has_rendered_canonical: false,
              has_raw_canonical: false,
              canonical_missmatch: false,
              rendering_changed_canonical: false,
              http_header_changed_canonical: false,
              has_relative_canonical: false,
              has_absolute_canonical: false,
              js_error: false};

  function compareStringArrays(array1, array2) {
      if (!array1 && !array2) return true; // both missing
      if (!Array.isArray(array1) || !Array.isArray(array2)) return false;
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


try {
  if (!wpt_bodies){
      result.has_wpt_bodies = false;
      return result;
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
    if (canonicals.rendered && canonicals.rendered.html_link_canoncials) {
      result.has_rendered_canonical = canonicals.rendered.html_link_canoncials.length > 0;
    }
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

    if (result.has_canonicals){
      result.has_relative_canonical  = [].map.call(canonicals.canonicals, (e) => {return e.startsWith('/')}).indexOf(true) > -1;
      result.has_absolute_canonical  = [].map.call(canonicals.canonicals, (e) => {return e.startsWith('http')}).indexOf(true) > -1;
    }

  }

  return result;

} catch (e) {
  result.js_error = true;
  return result;
}
''';


SELECT
  client,
  COUNT(0) AS total,
  canonical_metrics.js_error AS js_error,

  # Pages with canonical
  SAFE_DIVIDE(COUNTIF(canonical_metrics.has_canonicals), COUNT(0)) AS pct_has_canonical,

  # Pages with self-canonical
  SAFE_DIVIDE(COUNTIF(canonical_metrics.has_self_canonical), COUNT(0)) AS pct_has_self_canonical,

  # Pages canonicalized
  SAFE_DIVIDE(COUNTIF(canonical_metrics.is_canonicalized), COUNT(0)) AS pct_is_canonicalized,

  # Pages with canonical in HTTP header
  SAFE_DIVIDE(COUNTIF(canonical_metrics.has_http_canonical), COUNT(0)) AS pct_http_canonical,

  # Pages with canonical in raw html
  SAFE_DIVIDE(COUNTIF(canonical_metrics.has_raw_canonical), COUNT(0)) AS pct_has_raw_canonical,

  # Pages with canonical in rendered html
  SAFE_DIVIDE(COUNTIF(canonical_metrics.has_rendered_canonical), COUNT(0)) AS pct_has_rendered_canonical,

  # Pages with canonical in rendered but not raw html
  SAFE_DIVIDE(COUNTIF(canonical_metrics.has_rendered_canonical AND NOT canonical_metrics.has_raw_canonical), COUNT(0)) AS pct_has_rendered_but_not_raw_canonical,

  # Pages with canonical mismatch
  SAFE_DIVIDE(COUNTIF(canonical_metrics.has_canonical_mismatch), COUNT(0)) AS pct_has_canonical_mismatch,

  # Pages with canonical conflict between raw and rendered
  SAFE_DIVIDE(COUNTIF(canonical_metrics.rendering_changed_canonical), COUNT(0)) AS pct_has_conflict_rendering_changed_canonical,

  # Pages with canonical conflict between raw and http header
  SAFE_DIVIDE(COUNTIF(canonical_metrics.http_header_changed_canonical), COUNT(0)) AS pct_has_conflict_http_header_changed_canonical,

  # Pages with canonical conflict between raw and http header
  SAFE_DIVIDE(COUNTIF(canonical_metrics.http_header_changed_canonical OR canonical_metrics.rendering_changed_canonical), COUNT(0)) AS pct_has_conflict_http_header_or_rendering_changed_canonical,

  # Pages with canonicals that are absolute
  SAFE_DIVIDE(COUNTIF(canonical_metrics.has_absolute_canonical), COUNTIF(canonical_metrics.has_canonicals)) AS pct_canonicals_absolute,

  # Pages with canonicals that are relative
  SAFE_DIVIDE(COUNTIF(canonical_metrics.has_relative_canonical), COUNTIF(canonical_metrics.has_canonicals)) AS pct_canonicals_relative

FROM (
  SELECT
    client AS client,
    getCanonicalMetrics(custom_metrics.wpt_bodies) AS canonical_metrics
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
)
WHERE
  canonical_metrics.has_wpt_bodies
GROUP BY
  client,
  js_error
