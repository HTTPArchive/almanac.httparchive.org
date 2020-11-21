#standardSQL
# Age of resources party, type wise.
CREATE TEMPORARY FUNCTION toTimestamp(date_string STRING)
RETURNS INT64 LANGUAGE js AS '''
  try {
    var timestamp = Math.round(new Date(date_string).getTime());
    return isNaN(timestamp) || timestamp < 0 ? null : timestamp;
  } catch (e) {
    return null;
  }
''';

SELECT
  percentile,
  client,
  IF(NET.HOST(url) = NET.HOST(page), 'first party', 'third party') AS party,
  type AS resource_type,
  APPROX_QUANTILES(ROUND((startedDateTime - toTimestamp(resp_last_modified)) / (1000 * 60 * 60 * 24 * 7)), 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS age_weeks
FROM 
  `httparchive.almanac.requests`,
  UNNEST([10, 25, 50, 75, 90]) AS percentile
WHERE
  date = '2020-08-01' AND
  TRIM(resp_last_modified) <> ""
GROUP BY
  percentile,
  client,
  party,
  resource_type
ORDER BY
  percentile,
  client,
  party,
  resource_type
