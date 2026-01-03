#standardSQL
-- Button Accessible Name Sources (2025-07-01)
-- Google Sheet: button_name_sources
--
-- Purpose
--   • Analyze how <button> and <input type="submit"> elements derive their
--     accessible names in the a11y tree.
--   • Categorize name sources as attributes (e.g., aria-label, title),
--     related elements (e.g., <label>), or mark as missing.
--
-- Note: the  JavaScript temporary function (UDF) was no longer needed as
-- each accessible name source became its own row.
--
-- Output
--   client                — "desktop" | "mobile"
--   is_root_page          — TRUE if root URL
--   total_buttons         — total number of button elements seen
--   button_name_source    — classified source of accessible name
--   total_with_this_source — number of buttons with that source
--   perc_of_all_buttons   — percentage share of that source among all buttons
SELECT
  client,
  is_root_page,
  SUM(COUNT(0)) OVER (PARTITION BY client, is_root_page) AS total_buttons,
  button_name_source,
  COUNT(0) AS total_with_this_source,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client, is_root_page) AS perc_of_all_buttons
FROM (
  SELECT
    client,
    is_root_page,
    CASE
      WHEN COALESCE(JSON_VALUE(node, '$.accessible_name'), '') = '' THEN 'No accessible name'
      ELSE
        CASE JSON_VALUE(node, '$.accessible_name_sources[0].type')
          WHEN 'attribute' THEN CONCAT('attribute: ', COALESCE(JSON_VALUE(node, '$.accessible_name_sources[0].attribute'), ''))
          WHEN 'relatedElement' THEN CONCAT('relatedElement: ', COALESCE(JSON_VALUE(node, '$.accessible_name_sources[0].attribute'), 'label'))
          ELSE COALESCE(JSON_VALUE(node, '$.accessible_name_sources[0].type'), 'unknown')
        END
    END AS button_name_source
  FROM
    `httparchive.crawl.pages`,
    UNNEST(JSON_QUERY_ARRAY(custom_metrics.a11y.form_control_a11y_tree)) AS node
  WHERE
    date = '2025-07-01' AND
    is_root_page AND
    (
      JSON_VALUE(node, '$.type') = 'button' OR
      (JSON_VALUE(node, '$.type') = 'input' AND JSON_VALUE(node, '$.attributes.type') = 'submit')
    )
)
GROUP BY
  client, is_root_page, button_name_source
ORDER BY
  perc_of_all_buttons DESC;
