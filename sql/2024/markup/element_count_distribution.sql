CREATE TEMPORARY FUNCTION get_element_count_info(element_count_string STRING)
RETURNS STRUCT<elements_count INT64, types_count INT64> LANGUAGE js AS '''
var result = {};
try {
    if (!element_count_string) return result;

    var element_count = JSON.parse(element_count_string);

    if (Array.isArray(element_count) || typeof element_count != 'object') return result;

    result.elements_count = Object.values(element_count).reduce((total, freq) => total + (parseInt(freq, 10) || 0), 0);

    result.types_count = Object.keys(element_count).length;

} catch (e) {}
return result;
''';

SELECT
  client,
  percentile,
  COUNT(DISTINCT page) AS total,

  # total number of elements on a page
  APPROX_QUANTILES(element_count_info.elements_count, 1000)[OFFSET(percentile * 10)] AS elements_count,

  # number of types of elements on a page
  APPROX_QUANTILES(element_count_info.types_count, 1000)[OFFSET(percentile * 10)] AS types_count

FROM (
  SELECT
    client,
    percentile,
    page,
    get_element_count_info(JSON_EXTRACT(custom_metrics, '$.element_count')) AS element_count_info
  FROM
    `httparchive.all.pages`,
    UNNEST([10, 25, 50, 75, 90]) AS percentile
  WHERE
    date = '2024-06-01'
)
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
