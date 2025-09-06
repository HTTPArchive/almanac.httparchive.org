-- standardSQL
-- Web Almanac — Pages using :focus-visible in CSS (2025 crawl)
--
-- Denominator: all pages by client on 2025-07-01.
-- Numerator: pages whose parsed CSS contains the pseudo-class ":focus-visible".
-- Notes:
--   • `parsed_css` is partitioned by `date`, so we MUST filter `pc.date`.
--   • `css` is JSON-typed; wrap with TO_JSON_STRING() before passing to JS UDF.
--   • Size guard keeps the UDF light; adjust/remove as needed.

CREATE TEMPORARY FUNCTION getSelectorParts(css_str STRING)
RETURNS STRUCT<
  class          ARRAY<STRING>,
  id             ARRAY<STRING>,
  attribute      ARRAY<STRING>,
  pseudo_class   ARRAY<STRING>,
  pseudo_element ARRAY<STRING>
>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS r"""
try {
  const ast = JSON.parse(css_str || "{}");

  function compute(ast) {
    const ret = {
      "class": {}, "id": {}, "attribute": {},
      "pseudo-class": {}, "pseudo-element": {}
    };
    walkSelectors(ast, selector => {
      const sast = parsel.parse(selector, { list: false });
      parsel.walk(sast, node => {
        if (ret.hasOwnProperty(node.type)) incrementByKey(ret[node.type], node.name);
      }, { subtree: true });
    });
    for (const t in ret) ret[t] = sortObject(ret[t]);
    return ret;
  }

  const parts = compute(ast);
  const toKeys = obj => Object.entries(obj).filter(([_,v]) => !isNaN(v)).map(([k]) => k);
  return {
    class:          toKeys(parts["class"]),
    id:             toKeys(parts["id"]),
    attribute:      toKeys(parts["attribute"]),
    pseudo_class:   toKeys(parts["pseudo-class"]),
    pseudo_element: toKeys(parts["pseudo-element"])
  };
} catch (e) {
  return { class:[], id:[], attribute:[], pseudo_class:[], pseudo_element:[] };
}
""";

WITH pages AS (
  SELECT client, page
  FROM `httparchive.crawl.pages`
  WHERE date = DATE '2025-07-01'
),
css_signals AS (
  SELECT
    pc.client,
    pc.page,
    -- page has :focus-visible if any stylesheet contributes that pseudo-class
    SUM(CASE WHEN pseudo = 'focus-visible' THEN 1 ELSE 0 END) > 0 AS has_focus_visible
  FROM `httparchive.crawl.parsed_css` AS pc
  CROSS JOIN UNNEST(getSelectorParts(TO_JSON_STRING(pc.css)).pseudo_class) AS pseudo
  WHERE pc.date = DATE '2025-07-01'  -- partition filter required
    AND BYTE_LENGTH(TO_JSON_STRING(pc.css)) < 0.1 * 1024 * 1024  -- ~100 KiB guard
  GROUP BY pc.client, pc.page
)
SELECT
  p.client,
  COUNTIF(s.has_focus_visible) AS pages_with_focus_visible,
  COUNT(*)                     AS total_pages,
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(COUNTIF(s.has_focus_visible), COUNT(*))) AS pct_pages_focus_visible
FROM pages p
LEFT JOIN css_signals s USING (client, page)
GROUP BY p.client
ORDER BY SAFE_DIVIDE(COUNTIF(s.has_focus_visible), COUNT(*)) DESC;
