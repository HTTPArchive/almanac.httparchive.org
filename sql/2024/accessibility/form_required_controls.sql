#standardSQL
# Various stats for required form controls (form controls being: input, select, textarea)
CREATE TEMPORARY FUNCTION requiredControls(payload STRING)
RETURNS STRUCT<total INT64, asterisk INT64, required_attribute INT64, aria_required INT64, all_three INT64, asterisk_required INT64, asterisk_aria INT64, required_with_aria INT64> LANGUAGE js AS '''
  try {
    const a11y = JSON.parse(payload);
    const required_form_controls = a11y.required_form_controls

    const total = required_form_controls.length;
    let asterisk = 0;
    let required_attribute = 0;
    let aria_required = 0;

    let all_three = 0;
    let asterisk_required = 0;
    let asterisk_aria = 0;
    let required_with_aria = 0;
    for (const form_control of required_form_controls) {
      if (form_control.has_visible_required_asterisk) {
        asterisk++;
      }
      if (form_control.has_visible_required_asterisk && form_control.has_required) {
        asterisk_required++;
      }
      if (form_control.has_visible_required_asterisk && form_control.has_aria_required) {
        asterisk_aria++;
      }

      if (form_control.has_required) {
        required_attribute++;
      }
      if (form_control.has_required && form_control.has_aria_required) {
        required_with_aria++;
      }

      if (form_control.has_aria_required) {
        aria_required++;
      }


      if (form_control.has_visible_required_asterisk &&
          form_control.has_required &&
          form_control.has_aria_required) {
        all_three++;
      }
    }

    return {
      total,
      asterisk,
      required_attribute,
      aria_required,

      all_three,
      asterisk_required,
      asterisk_aria,
      required_with_aria,
    };
  } catch (e) {
    return {
      total: 0,
      asterisk: 0,
      required_attribute: 0,
      aria_required: 0,

      all_three: 0,
      asterisk_required: 0,
      asterisk_aria: 0,
      required_with_aria: 0,
    };
  }
''';

SELECT
  client,
  is_root_page,
  COUNT(0) AS total_sites,
  COUNTIF(stats.total > 0) AS total_sites_with_required_controls,
  SUM(stats.total) AS total_required_controls,

  SUM(stats.asterisk) AS total_asterisk,
  SUM(stats.asterisk) / SUM(stats.total) AS perc_asterisk,

  SUM(stats.required_attribute) AS total_required_attribute,
  SUM(stats.required_attribute) / SUM(stats.total) AS perc_required_attribute,

  SUM(stats.aria_required) AS total_aria_required,
  SUM(stats.aria_required) / SUM(stats.total) AS perc_aria_required,

  SUM(stats.all_three) AS total_all_three,
  SUM(stats.all_three) / SUM(stats.total) AS perc_all_three,

  SUM(stats.asterisk_required) AS total_asterisk_required,
  SUM(stats.asterisk_required) / SUM(stats.total) AS perc_asterisk_required,

  SUM(stats.asterisk_aria) AS total_asterisk_aria,
  SUM(stats.asterisk_aria) / SUM(stats.total) AS perc_asterisk_aria,

  SUM(stats.required_with_aria) AS total_required_with_aria,
  SUM(stats.required_with_aria) / SUM(stats.total) AS perc_required_with_aria
FROM (
  SELECT
    client,
    is_root_page,
    requiredControls(JSON_EXTRACT_SCALAR(payload, '$._a11y')) AS stats
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
)
GROUP BY
  client,
  is_root_page;
