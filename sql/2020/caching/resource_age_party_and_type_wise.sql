#standardSQL
# Age of resources party, type wise.
CREATE TEMPORARY FUNCTION toTimestamp(date_string STRING)
RETURNS INT64 LANGUAGE js AS '''
  try {
    var timestamp = Math.round(new Date(date_string).getTime() / 1000);
    return isNaN(timestamp) || timestamp < 0 ? null : timestamp;
  } catch (e) {
    return null;
  }
''';

SELECT
  percentile,
  _TABLE_SUFFIX AS client,
  IF(NET.HOST(url) IN (
    SELECT domain FROM `httparchive.almanac.third_parties` WHERE date = '2020-08-01' AND category != 'hosting'
  ), 'third party', 'first party') AS party,
  type AS resource_type,
  APPROX_QUANTILES(ROUND((startedDateTime - toTimestamp(resp_last_modified)) / (60 * 60 * 24 * 7)), 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS age_weeks
FROM
  `httparchive.summary_requests.2020_08_01_*`,
  UNNEST([10, 25, 50, 75, 90]) AS percentile
WHERE
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
