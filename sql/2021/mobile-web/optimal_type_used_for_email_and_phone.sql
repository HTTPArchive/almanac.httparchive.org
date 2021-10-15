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
  # is the input field using the best "type" attribute? E.g., type=email for an email
  input_info.using_best_type AS using_best_type_attr,

  # How many times an input requesting this type of data (email or phone) occurs
  total_type_occurences,
  # How many sites have an input requesting this type of data (email or phone)
  total_pages_with_type,

  COUNT(0) AS total,
  COUNT(DISTINCT url) AS total_pages,

  COUNT(0) / total_type_occurences AS pct_inputs,
  COUNT(DISTINCT url) / total_pages_with_type AS pct_pages
FROM
  `httparchive.pages.2021_07_01_mobile`,
  UNNEST(getInputInfo(JSON_EXTRACT_SCALAR(payload, '$._almanac'))) AS input_info
LEFT JOIN (
  SELECT
    input_info.detected_type AS detected_type,
    # How many times an input requesting this type of data (email or phone) occurs
    COUNT(0) AS total_type_occurences,
    # How many sites have an input requesting this type of data (email or phone)
    COUNT(DISTINCT url) AS total_pages_with_type
  FROM
    `httparchive.pages.2021_07_01_mobile`,
    UNNEST(getInputInfo(JSON_EXTRACT_SCALAR(payload, '$._almanac'))) AS input_info
  GROUP BY
    input_info.detected_type
)
USING (detected_type)
GROUP BY
  input_info.detected_type,
  input_info.using_best_type,
  total_type_occurences,
  total_pages_with_type
