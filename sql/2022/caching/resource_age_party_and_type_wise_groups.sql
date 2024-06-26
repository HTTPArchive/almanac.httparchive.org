#standardSQL
# Age of resources party, type wise in groups.
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
  client,
  party,
  resource_type,
  COUNT(0) AS requests_total,
  COUNTIF(age_weeks IS NOT NULL) AS requests_with_age,
  COUNTIF(age_weeks < 0) AS age_neg,
  COUNTIF(age_weeks = 0) AS age_0wk,
  COUNTIF(age_weeks >= 1 AND age_weeks <= 7) AS age_1_to_7wk,
  COUNTIF(age_weeks >= 8 AND age_weeks <= 52) AS age_8_to_52wk,
  COUNTIF(age_weeks >= 53 AND age_weeks <= 104) AS age_gt_1y,
  COUNTIF(age_weeks >= 105) AS age_gt_2y,
  SAFE_DIVIDE(COUNTIF(age_weeks < 0), COUNTIF(age_weeks IS NOT NULL)) AS age_neg_pct,
  SAFE_DIVIDE(COUNTIF(age_weeks = 0), COUNTIF(age_weeks IS NOT NULL)) AS age_0wk_pct,
  SAFE_DIVIDE(COUNTIF(age_weeks >= 1 AND age_weeks <= 7), COUNTIF(age_weeks IS NOT NULL)) AS age_1_to_7wk_pct,
  SAFE_DIVIDE(COUNTIF(age_weeks >= 8 AND age_weeks <= 52), COUNTIF(age_weeks IS NOT NULL)) AS age_8_to_52wk_pct,
  SAFE_DIVIDE(COUNTIF(age_weeks >= 53 AND age_weeks <= 104), COUNTIF(age_weeks IS NOT NULL)) AS age_gt_1y_pct,
  SAFE_DIVIDE(COUNTIF(age_weeks >= 105), COUNTIF(age_weeks IS NOT NULL)) AS age_gt_2y_pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    IF(NET.HOST(url) IN (
      SELECT domain FROM `httparchive.almanac.third_parties` WHERE date = '2022-06-01' AND category != 'hosting'
    ), 'third party', 'first party') AS party,
    type AS resource_type,
    ROUND((startedDateTime - toTimestamp(resp_last_modified)) / (60 * 60 * 24 * 7)) AS age_weeks
  FROM
    `httparchive.summary_requests.2022_06_01_*`
  WHERE
    TRIM(resp_last_modified) != ''
)
GROUP BY
  client,
  party,
  resource_type
ORDER BY
  client,
  party,
  resource_type
