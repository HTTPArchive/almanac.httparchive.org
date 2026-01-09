#standardSQL
# Pages using :focus-visible in CSS (2025 crawl)
# Google Sheet: focus_visible
#
# Counts pages per client that include the :focus-visible pseudo-class.
# - Source: httparchive.crawl.parsed_css (2025-07-01)
# - Uses JS UDF (css-utils.js) to extract selector parts
# - css is JSON → wrapped with TO_JSON_STRING() for UDF
# - Outputs: pages_with_focus_visible, total_pages, pct_pages_focus_visible
#
# Changes from 2024:
# - all.parsed_css → crawl.parsed_css
# - 2024-06-01 → 2025-07-01
# - LENGTH(css) → BYTE_LENGTH(TO_JSON_STRING(css))
# - Direct UNNEST instead of LEFT JOIN UNNEST
CREATE TEMPORARY FUNCTION getSelectorParts(css_str STRING)
RETURNS STRUCT<
  class ARRAY<STRING>,
  id ARRAY<STRING>,
  attribute ARRAY<STRING>,
  pseudo_class ARRAY<STRING>,
  pseudo_element ARRAY<STRING>
>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  function compute(ast) {
    let ret = { class:{}, id:{}, attribute:{}, "pseudo-class":{}, "pseudo-element":{} };
    walkSelectors(ast, selector => {
      let sast = parsel.parse(selector, {list: false});
      parsel.walk(sast, node => {
        if (node.type in ret) incrementByKey(ret[node.type], node.name);
      }, {subtree: true});
    });
    for (let type in ret) ret[type] = sortObject(ret[type]);
    return ret;
  }
  function unzip(obj) {
    return Object.entries(obj).filter(([_,v]) => !isNaN(v)).map(([k]) => k);
  }
  const ast = JSON.parse(css_str || "{}");
  const parts = compute(ast);
  return {
    class: unzip(parts.class),
    id: unzip(parts.id),
    attribute: unzip(parts.attribute),
    pseudo_class: unzip(parts['pseudo-class']),
    pseudo_element: unzip(parts['pseudo-element'])
  };
} catch (e) {
  return { class:[], id:[], attribute:[], pseudo_class:[], pseudo_element:[] };
}
''';

SELECT
  client,
  COUNTIF(num_focus_visible > 0) AS pages_with_focus_visible,
  COUNT(0) AS total_pages,
  SAFE_DIVIDE(COUNTIF(num_focus_visible > 0), COUNT(0)) AS pct_pages_focus_visible
FROM (
  SELECT
    client,
    page,
    COUNTIF(pseudo_class = 'focus-visible') AS num_focus_visible
  FROM
    `httparchive.crawl.parsed_css`,
    -- `httparchive.sample_data.parsed_css_10k`,
    UNNEST(getSelectorParts(TO_JSON_STRING(css)).pseudo_class) AS pseudo_class
  WHERE
    BYTE_LENGTH(TO_JSON_STRING(css)) < 0.1 * 1024 * 1024 AND  -- ~100 KiB guard
    date = DATE '2025-07-01' -- Comment out if this is used `httparchive.sample_data.parsed_css_10k`,
  GROUP BY
    client, page
)
GROUP BY
  client
ORDER BY
  pct_pages_focus_visible DESC;
