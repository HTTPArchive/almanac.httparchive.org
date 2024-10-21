#standardSQL

# Distribution of number of early hints resources

CREATE TEMPORARY FUNCTION getNumEarlyHints(early_hints_header STRING)
RETURNS STRUCT<num_hints INT, num_resources_hinted INT> LANGUAGE js AS '''
try {

  var num_hints = 0;
  var num_resources_hinted = 0;

  theJSON = JSON.parse(early_hints_header);

  for (var key of Object.keys(theJSON)) {
      if (theJSON[key].startsWith('link:')) {
        num_hints++;
      } else {
        continue;
      };
      num_resources_hinted = num_resources_hinted + theJSON[key].split(',').length;
  }

  return {
    num_hints,
    num_resources_hinted
  };
} catch {
  return {
    num_hints: 0,
    num_resources_hinted: 0
  };
}
''';

SELECT
  client,
  percentile,
  COUNT(DISTINCT page) AS num_pages,
  APPROX_QUANTILES(early_hints.num_hints, 1000)[OFFSET(percentile * 10)] AS num_hints,
  APPROX_QUANTILES(early_hints.num_resources_hinted, 1000)[OFFSET(percentile * 10)] AS num_resources_hinted
FROM
  (
    SELECT
      client,
      page,
      getNumEarlyHints(JSON_EXTRACT(payload, '$._early_hint_headers')) AS early_hints
    FROM
      `httparchive.all.requests`
    WHERE
      date = '2024-06-01' AND
      is_root_page AND
      is_main_document
  ),
  UNNEST(GENERATE_ARRAY(1, 100)) AS percentile
GROUP BY
  client,
  percentile
ORDER BY
  client,
  percentile
