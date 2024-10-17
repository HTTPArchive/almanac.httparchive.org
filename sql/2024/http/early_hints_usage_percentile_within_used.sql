CREATE TEMPORARY FUNCTION getEarlyHints(early_hints_header STRING)
RETURNS STRUCT<preconnects INT64, preloads INT64, asTypes ARRAY<STRUCT<key STRING, value INT64>>> LANGUAGE js AS """
try {
  var preconnects = 0;
  var preloads = 0;
  var as = {};

  theJSON = JSON.parse(early_hints_header);
  for (var key of Object.keys(theJSON)) {
    if (!theJSON[key].startsWith('link:')) {
      continue;
    };
    var hints =  theJSON[key].split(',');
    hints.forEach(hint => {

      var attributes =  hint.split(';');
      var fetchType='';
      var hintType='';
      attributes.forEach(attribute => {
        if (attribute.trim().startsWith('rel')) {
          hintType=attribute.trim().slice(4).replaceAll('"', '').replaceAll("'", '');
        }
        if (attribute.trim().startsWith('as')) {
          fetchType=attribute.trim().slice(3).replaceAll('"', '').replaceAll("'", '');
        }
      });
      if (hintType === "preconnect") {
        preconnects++;
      }
      if (hintType === "preload") {
        preloads++;
        as[fetchType] = as[fetchType] ? as[fetchType] + 1 : 1;
      }
    });
  }
  var asArray = [];
  for (var key in as) {
    asArray.push({key: key, value: as[key]});
  }
  return {
    preconnects: preconnects,
    preloads: preloads,
    asTypes: asArray
  };
} catch (e) {
  return {};
}
""";

SELECT
  client,
  is_root_page,
  percentile,
  APPROX_QUANTILES(getEarlyHints(JSON_EXTRACT(payload, '$._early_hint_headers')).preconnects, 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS preconnects,
  APPROX_QUANTILES(getEarlyHints(JSON_EXTRACT(payload, '$._early_hint_headers')).preloads, 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS preloads,
  ARRAY_TO_STRING(ARRAY_AGG(DISTINCT page LIMIT 5), ' ') AS sample_urls
FROM
  `httparchive.all.requests`,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
WHERE
  date = '2024-06-01' AND
  is_main_document AND
  JSON_QUERY(payload, '$._early_hint_headers') != ''
GROUP BY
  client,
  is_root_page,
  percentile
ORDER BY
  client,
  is_root_page,
  percentile
