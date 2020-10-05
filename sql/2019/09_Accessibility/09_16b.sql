#standardSQL
# 09_16b: % page with forms using invalid/required
CREATE TEMPORARY FUNCTION getTotalInputsUsed(payload STRING)
RETURNS INT64 LANGUAGE js AS '''
  try {
    var $ = JSON.parse(payload);
    if (!$._element_count) {
      return 0;
    }

    var element_count = JSON.parse($._element_count);
    if (!element_count) {
      return 0;
    }

    return (element_count.input || 0) + (element_count.select || 0) + (element_count.textarea || 0);
  } catch (e) {
    return 0;
  }
''';

SELECT
  client,
  COUNT(0) AS total_pages,
  COUNTIF(total_inputs > 0) AS total_pages_with_inputs,
  COUNTIF(uses_aria_invalid) AS total_with_aria_invalid,
  COUNTIF(uses_aria_required) AS total_with_aria_required,
  COUNTIF(uses_required) AS total_with_required,
  COUNTIF(uses_aria_required OR uses_required) AS total_with_either_required,

  ROUND(COUNTIF(total_inputs > 0) * 100 / COUNT(0), 2) AS perc_pages_with_inputs,
  ROUND(COUNTIF(uses_aria_invalid) * 100 / COUNTIF(total_inputs > 0), 2) AS perc_applicable_aria_invalid,
  ROUND(COUNTIF(uses_aria_required) * 100 / COUNTIF(total_inputs > 0), 2) AS perc_applicable_aria_required,
  ROUND(COUNTIF(uses_required) * 100 / COUNTIF(total_inputs > 0), 2) AS perc_applicable_required,
  ROUND(COUNTIF(uses_aria_required OR uses_required) * 100 / COUNTIF(total_inputs > 0), 2) AS perc_applicable_either_required
FROM (
  SELECT
    client,
    page,
    REGEXP_CONTAINS(body, '<input[^>]+aria-invalid\\b') AS uses_aria_invalid,
    REGEXP_CONTAINS(body, '<input[^>]+(aria-required)\\b') AS uses_aria_required,
    REGEXP_CONTAINS(body, '<input[^>]+[^-](required)\\b') AS uses_required
  FROM
    `httparchive.almanac.summary_response_bodies`
  WHERE
    date = '2019-07-01' AND
    firstHtml
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    getTotalInputsUsed(payload) AS total_inputs
  FROM
    `httparchive.pages.2019_07_01_*`
)
USING (client, page)
GROUP BY client
