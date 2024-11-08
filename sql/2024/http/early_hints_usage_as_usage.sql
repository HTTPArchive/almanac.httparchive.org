CREATE TEMPORARY FUNCTION getEarlyHints(early_hints_header STRING)
RETURNS STRUCT<preconnects INT64, preloads INT64, asTypes ARRAY<STRUCT<key STRING, value INT64>>> LANGUAGE js AS '''
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
      if (hintType === 'preconnect') {
        preconnects++;
      }
      if (hintType === 'preload') {
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
''';

WITH totals AS (
  SELECT
    date,
    is_root_page,
    client,
    COUNT(0) AS total
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
  GROUP BY
    date,
    client,
    is_root_page
)

SELECT
  client,
  is_root_page,
  asTypes.key AS asType,
  COUNT(DISTINCT page) AS num_pages,
  COUNT(DISTINCT page) / total AS pct_pages,
  ARRAY_TO_STRING(ARRAY_AGG(DISTINCT page LIMIT 5), ' ') AS sample_urls
FROM
  `httparchive.all.requests`,
  UNNEST(getEarlyHints(JSON_EXTRACT(payload, '$._early_hint_headers')).asTypes) AS asTypes
JOIN
  totals
USING (date, client, is_root_page)
WHERE
  date = '2024-06-01' AND
  is_main_document AND
  JSON_QUERY(payload, '$._early_hint_headers') != '' AND
  asTypes.key IS NOT NULL
GROUP BY
  client,
  is_root_page,
  total,
  asTypes.key
ORDER BY
  client,
  is_root_page,
  pct_pages DESC
