#standardSQL
WITH raw_data AS (
  SELECT
    date,
    page,
    -- 1. TECHNOLOGY FLAGS
    -- CSS Variables: Exclude NULL, {}, '{"summary":{}}', and  'null' string
    (
      custom_metrics.css_variables IS NOT NULL AND
      TO_JSON_STRING(custom_metrics.css_variables) NOT IN ('{}', '{"summary":{}}', 'null')
    ) AS uses_css_vars,

    -- Tailwind: Check the array for the technology
    'Tailwind CSS' IN UNNEST(technologies.technology) AS uses_tailwind,

    -- Content String for Regex
    LOWER(TO_JSON_STRING(custom_metrics.css_variables)) AS vars_str
  FROM
    `httparchive.crawl.pages`
  WHERE
    client = 'mobile' AND
    is_root_page AND
    -- NO RANK FILTER (Analyze the entire long-tail of the web)

    -- Quarterly Dates
    date IN UNNEST([
      DATE '2020-10-01',
      DATE '2021-01-01', DATE '2021-04-01', DATE '2021-07-01', DATE '2021-10-01',
      DATE '2022-01-01', DATE '2022-04-01', DATE '2022-07-01', DATE '2022-10-01', -- noqa: CV09
      DATE '2023-01-01', DATE '2023-04-01', DATE '2023-07-01', DATE '2023-10-01',
      DATE '2024-01-01', DATE '2024-04-01', DATE '2024-07-01', DATE '2024-10-01', -- noqa: CV09
      DATE '2025-01-01', DATE '2025-04-01', DATE '2025-07-01', DATE '2025-10-01'
    ])
),

-- Pre-calculate heuristics
flags AS (
  SELECT
    date,
    page,
    uses_css_vars,
    uses_tailwind,

    -- HEURISTIC BOOLEANS (Only true if uses_css_vars is also true)
    (uses_css_vars AND REGEXP_CONTAINS(vars_str, r'"#6366f1"')) AS has_indigo_500,
    (uses_css_vars AND REGEXP_CONTAINS(vars_str, r'"(#6366f1|#8b5cf6|#a855f7)"')) AS has_ai_purples,
    (uses_css_vars AND REGEXP_CONTAINS(vars_str, r'inter')) AS has_inter,
    (uses_css_vars AND REGEXP_CONTAINS(vars_str, r'roboto')) AS has_roboto,
    (uses_css_vars AND REGEXP_CONTAINS(vars_str, r'system-ui')) AS has_system_ui,
    (uses_css_vars AND REGEXP_CONTAINS(vars_str, r'linear-gradient\(|radial-gradient\(')) AS has_gradient,
    (uses_css_vars AND REGEXP_CONTAINS(vars_str, r'"(2px|4px|6px|8px|12px|16px|0\.25rem|0\.5rem|0\.75rem|1rem|9999px)"')) AS has_radius,
    (uses_css_vars AND REGEXP_CONTAINS(vars_str, r'rgba\(|box-shadow')) AS has_shadow
  FROM
    raw_data
)

SELECT
  FORMAT_DATE('%Y-Q%Q', date) AS year_quarter,

  -- 1. CONTEXT (Denominators)
  COUNT(DISTINCT page) AS total_sites,
  COUNT(DISTINCT IF(uses_css_vars, page, NULL)) AS sites_using_vars,
  COUNT(DISTINCT IF(uses_tailwind, page, NULL)) AS sites_using_tailwind,

  -------------------------------------------------------------------------
  -- 2. "AI PURPLE" SPECTRUM (Indigo/Violet/Purple 500)
  -------------------------------------------------------------------------
  COUNT(DISTINCT IF(has_ai_purples, page, NULL)) AS cnt_ai_purples,
  IEEE_DIVIDE(COUNT(DISTINCT IF(has_ai_purples, page, NULL)), COUNT(DISTINCT page)) AS pct_all_ai_purples,
  IEEE_DIVIDE(COUNT(DISTINCT IF(has_ai_purples, page, NULL)), COUNT(DISTINCT IF(uses_css_vars, page, NULL))) AS pct_vars_ai_purples,
  IEEE_DIVIDE(COUNT(DISTINCT IF(has_ai_purples AND uses_tailwind, page, NULL)), COUNT(DISTINCT IF(uses_tailwind, page, NULL))) AS pct_tw_ai_purples,

  -------------------------------------------------------------------------
  -- 3. SPECIFIC INDIGO 500 (#6366f1 Only)
  -------------------------------------------------------------------------
  COUNT(DISTINCT IF(has_indigo_500, page, NULL)) AS cnt_indigo,
  IEEE_DIVIDE(COUNT(DISTINCT IF(has_indigo_500, page, NULL)), COUNT(DISTINCT page)) AS pct_all_indigo,
  IEEE_DIVIDE(COUNT(DISTINCT IF(has_indigo_500, page, NULL)), COUNT(DISTINCT IF(uses_css_vars, page, NULL))) AS pct_vars_indigo,
  IEEE_DIVIDE(COUNT(DISTINCT IF(has_indigo_500 AND uses_tailwind, page, NULL)), COUNT(DISTINCT IF(uses_tailwind, page, NULL))) AS pct_tw_indigo,

  -------------------------------------------------------------------------
  -- 4. FONTS
  -------------------------------------------------------------------------
  -- Inter
  COUNT(DISTINCT IF(has_inter, page, NULL)) AS cnt_inter,
  IEEE_DIVIDE(COUNT(DISTINCT IF(has_inter, page, NULL)), COUNT(DISTINCT page)) AS pct_all_inter,
  IEEE_DIVIDE(COUNT(DISTINCT IF(has_inter, page, NULL)), COUNT(DISTINCT IF(uses_css_vars, page, NULL))) AS pct_vars_inter,
  IEEE_DIVIDE(COUNT(DISTINCT IF(has_inter AND uses_tailwind, page, NULL)), COUNT(DISTINCT IF(uses_tailwind, page, NULL))) AS pct_tw_inter,

  -- Roboto
  COUNT(DISTINCT IF(has_roboto, page, NULL)) AS cnt_roboto,
  IEEE_DIVIDE(COUNT(DISTINCT IF(has_roboto, page, NULL)), COUNT(DISTINCT page)) AS pct_all_roboto,
  IEEE_DIVIDE(COUNT(DISTINCT IF(has_roboto, page, NULL)), COUNT(DISTINCT IF(uses_css_vars, page, NULL))) AS pct_vars_roboto,
  IEEE_DIVIDE(COUNT(DISTINCT IF(has_roboto AND uses_tailwind, page, NULL)), COUNT(DISTINCT IF(uses_tailwind, page, NULL))) AS pct_tw_roboto,

  -- System UI
  COUNT(DISTINCT IF(has_system_ui, page, NULL)) AS cnt_system,
  IEEE_DIVIDE(COUNT(DISTINCT IF(has_system_ui, page, NULL)), COUNT(DISTINCT page)) AS pct_all_system,
  IEEE_DIVIDE(COUNT(DISTINCT IF(has_system_ui, page, NULL)), COUNT(DISTINCT IF(uses_css_vars, page, NULL))) AS pct_vars_system,
  IEEE_DIVIDE(COUNT(DISTINCT IF(has_system_ui AND uses_tailwind, page, NULL)), COUNT(DISTINCT IF(uses_tailwind, page, NULL))) AS pct_tw_system,

  -------------------------------------------------------------------------
  -- 5. UI ELEMENTS
  -------------------------------------------------------------------------
  -- Gradients
  COUNT(DISTINCT IF(has_gradient, page, NULL)) AS cnt_gradient,
  IEEE_DIVIDE(COUNT(DISTINCT IF(has_gradient, page, NULL)), COUNT(DISTINCT page)) AS pct_all_gradient,
  IEEE_DIVIDE(COUNT(DISTINCT IF(has_gradient, page, NULL)), COUNT(DISTINCT IF(uses_css_vars, page, NULL))) AS pct_vars_gradient,
  IEEE_DIVIDE(COUNT(DISTINCT IF(has_gradient AND uses_tailwind, page, NULL)), COUNT(DISTINCT IF(uses_tailwind, page, NULL))) AS pct_tw_gradient,

  -- Radius
  COUNT(DISTINCT IF(has_radius, page, NULL)) AS cnt_radius,
  IEEE_DIVIDE(COUNT(DISTINCT IF(has_radius, page, NULL)), COUNT(DISTINCT page)) AS pct_all_radius,
  IEEE_DIVIDE(COUNT(DISTINCT IF(has_radius, page, NULL)), COUNT(DISTINCT IF(uses_css_vars, page, NULL))) AS pct_vars_radius,
  IEEE_DIVIDE(COUNT(DISTINCT IF(has_radius AND uses_tailwind, page, NULL)), COUNT(DISTINCT IF(uses_tailwind, page, NULL))) AS pct_tw_radius,

  -- Shadows
  COUNT(DISTINCT IF(has_shadow, page, NULL)) AS cnt_shadow,
  IEEE_DIVIDE(COUNT(DISTINCT IF(has_shadow, page, NULL)), COUNT(DISTINCT page)) AS pct_all_shadow,
  IEEE_DIVIDE(COUNT(DISTINCT IF(has_shadow, page, NULL)), COUNT(DISTINCT IF(uses_css_vars, page, NULL))) AS pct_vars_shadow,
  IEEE_DIVIDE(COUNT(DISTINCT IF(has_shadow AND uses_tailwind, page, NULL)), COUNT(DISTINCT IF(uses_tailwind, page, NULL))) AS pct_tw_shadow

FROM
  flags
GROUP BY
  year_quarter
ORDER BY
  year_quarter;
