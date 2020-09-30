#standardSQL
# CSS in JS. WIP
CREATE TEMPORARY FUNCTION getCssInJS(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS ''''''
  try {
    var $ = JSON.parse(payload);
    var css = JSON.parse($._css);

    return Array.isArray(css.css_in_js) && css.css_in_js.length > 0 ? css.css_in_js : [''NONE''];
  } catch (e) {
    return [e.message];
  }
'''''';

SELECT
  url,
  cssInJs
FROM `httparchive.sample_data.pages_mobile_10k`
CROSS JOIN UNNEST(getCssInJS(payload)) AS cssInJs