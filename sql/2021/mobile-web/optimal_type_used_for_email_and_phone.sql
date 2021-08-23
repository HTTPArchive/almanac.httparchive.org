#standardSQL
# Optimal type used for email and phone inputs
CREATE TEMPORARY FUNCTION getInputInfo(payload STRING)
RETURNS ARRAY<STRUCT<detected_type STRING, using_best_type BOOLEAN>> LANGUAGE js AS '''
  const new_line_regex = new RegExp('(?:\\r\\n|\\r|\\n)', 'g');
  function isFuzzyMatch(value, options) {
    value = value.replace(new_line_regex, '').trim().toLowerCase();
    for (let i = 0; i < options.length; i++) {
      if (value.indexOf(options[i]) >= 0) {
        return true;
      }
    }

    return false;
  }

  function nodeContainsTypeSignal(node, options) {
    if (node.id && isFuzzyMatch(node.id, options)) {
      return true;
    }
    if (node.name && isFuzzyMatch(node.name, options)) {
      return true;
    }
    if (node.placeholder && isFuzzyMatch(node.placeholder, options)) {
      return true;
    }
    if (node['aria-label'] && isFuzzyMatch(node['aria-label'], options)) {
      return true;
    }

    return false;
  }

  try {
    const almanac = JSON.parse(payload);
    if (!almanac.input_elements) {
      return [];
    }

    const email_input_signals = ['email', 'e-mail'];
    const tel_input_signals = ['phone', 'mobile', 'tel'];
    return almanac.input_elements.nodes
      .map(function(node) {
        if (node.type !== 'text' && node.type !== 'email' && node.type !== 'tel') {
          return false;
        }

        if (nodeContainsTypeSignal(node, email_input_signals)) {
          return {
            detected_type: 'email',
            using_best_type: node.type === 'email'
          };
        }
        if (nodeContainsTypeSignal(node, tel_input_signals)) {
          return {
            detected_type: 'tel',
            using_best_type: node.type === 'tel'
          };
        }

        return false;
      })
      .filter(v => v !== false);
  } catch (e) {
    return [];
  }
''';

SELECT
  input_info.detected_type AS detected_type,
  input_info.using_best_type AS using_best_type,
  SUM(COUNT(0)) OVER (PARTITION BY input_info.detected_type) AS total_type_occurences,
  SUM(COUNT(DISTINCT url)) OVER (PARTITION BY input_info.detected_type) AS total_sites_with_type,

  COUNT(0) AS total,
  COUNT(DISTINCT url) AS total_sites,

  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY input_info.detected_type) AS perc_inputs,
  COUNT(DISTINCT url) / SUM(COUNT(DISTINCT url)) OVER (PARTITION BY input_info.detected_type) AS perc_sites
FROM
  `httparchive.pages.2021_07_01_mobile`,
  UNNEST(getInputInfo(JSON_EXTRACT_SCALAR(payload, '$._almanac'))) AS input_info
GROUP BY
  input_info.detected_type,
  input_info.using_best_type
