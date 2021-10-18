#standardSQL
# How many radios and checkboxes are there. How many of those inputs are correctly placed in a fieldset with a legend?
CREATE TEMPORARY FUNCTION totalCheckboxAndRadio(payload STRING)
RETURNS STRUCT<radios INT64, checkboxes INT64, radios_in_fieldsets INT64, checkboxes_in_fieldsets INT64, checkboxes_in_fieldset_with_legend INT64, radios_in_fieldset_with_legend INT64> LANGUAGE js AS '''
  try {
    const a11y = JSON.parse(payload);

    let checkboxes_in_fieldset_with_legend = 0;
    let radios_in_fieldset_with_legend = 0;
    for (const fieldset of a11y.fieldset_radio_checkbox.fieldsets) {
      if (!fieldset.has_legend) {
        continue;
      }

      checkboxes_in_fieldset_with_legend += fieldset.total_checkbox;
      radios_in_fieldset_with_legend += fieldset.total_radio;
    }

    return {
      radios: a11y.fieldset_radio_checkbox.total_radio,
      checkboxes: a11y.fieldset_radio_checkbox.total_checkbox,
      radios_in_fieldsets: a11y.fieldset_radio_checkbox.total_radio_in_fieldsets,
      checkboxes_in_fieldsets: a11y.fieldset_radio_checkbox.total_checkbox_in_fieldsets,

      checkboxes_in_fieldset_with_legend,
      radios_in_fieldset_with_legend,
    };
  } catch (e) {
    return {
      radios: 0,
      checkboxes: 0,
      radios_in_fieldsets: 0,
      checkboxes_in_fieldsets: 0,

      checkboxes_in_fieldset_with_legend: 0,
      radios_in_fieldset_with_legend: 0,
    };
  }
''';

SELECT
  client,
  COUNT(0) AS total_sites,
  COUNTIF(stats.checkboxes > 0 OR stats.radios > 0) AS total_applicable_sites,
  COUNTIF(stats.checkboxes > 0) AS total_with_checkboxes,
  COUNTIF(stats.radios > 0) AS total_with_radios,

  COUNTIF((stats.checkboxes > 0 OR stats.radios > 0) AND stats.checkboxes_in_fieldset_with_legend = 0 AND stats.radios_in_fieldset_with_legend = 0) / COUNTIF(stats.checkboxes > 0 OR stats.radios > 0) AS perc_sites_with_none_in_legend,
  COUNTIF((stats.checkboxes > 0 OR stats.radios > 0) AND stats.checkboxes_in_fieldset_with_legend = stats.checkboxes AND stats.radios_in_fieldset_with_legend = stats.radios) / COUNTIF(stats.checkboxes > 0 OR stats.radios > 0) AS perc_sites_with_all_in_legend,

  SUM(stats.checkboxes_in_fieldset_with_legend) / SUM(stats.checkboxes) AS perc_checkboxes_in_legend,
  SUM(stats.radios_in_fieldset_with_legend) / SUM(stats.radios) AS perc_radios_in_legend
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    totalCheckboxAndRadio(JSON_EXTRACT_SCALAR(payload, '$._a11y')) AS stats
  FROM
    `httparchive.pages.2021_07_01_*`
)
GROUP BY
  client
