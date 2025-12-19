-- standardSQL
-- Web Almanac — CAPTCHA usage analysis (2025-07-01)
-- Google Sheet: captcha_usage
--
-- Goal
--   Measure adoption of CAPTCHA technologies (reCAPTCHA, hCaptcha) across sites
--   in the HTTP Archive crawl, split by client (desktop/mobile) and root vs non-root pages.
--
-- Units of analysis
--   • Page-level data → rolled up to unique sites (using page URL as identifier).
--   • Results reported by (client, is_root_page).
--
-- Output columns
--   • client                  = crawl client (desktop, mobile)
--   • is_root_page            = TRUE if root page, FALSE otherwise
--   • date                    = crawl date
--   • total_sites             = number of unique sites in this slice
--   • sites_with_captcha      = number of unique sites using reCAPTCHA or hCaptcha
--   • perc_sites_with_captcha = share of sites using reCAPTCHA or hCaptcha (formatted string)
--
-- Data notes
--   • Technologies are stored in the repeated field `technologies`; must UNNEST.
--   • Matching is done on app.technology ∈ { 'reCAPTCHA', 'hCaptcha' }.
--   • SAFE_DIVIDE ensures zero-safe percentage calculation.
--
-- Future extension
--   • To include Cloudflare Turnstile (or others), extend the IN list:
--       IF(app.technology IN ('reCAPTCHA','hCaptcha','Turnstile'), …)
--   • Could also break down per provider by grouping on app.technology.
--
SELECT
  client,
  is_root_page,
  date,  # Date of the analysis
  COUNT(DISTINCT page) AS total_sites,  # Total number of unique sites for the client
  COUNT(DISTINCT IF(app.technology IN ('reCAPTCHA', 'hCaptcha'), page, NULL)) AS sites_with_captcha,  # Number of sites using reCAPTCHA or hCaptcha
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(app.technology IN ('reCAPTCHA', 'hCaptcha'), page, NULL)),
    COUNT(DISTINCT page)
  ) AS perc_sites_with_captcha  # Percentage of sites using reCAPTCHA or hCaptcha
FROM
  `httparchive.crawl.pages`,
  UNNEST(technologies) AS app           -- Unnest the detected technologies
WHERE
  date = '2025-07-01'
GROUP BY
  client,
  is_root_page,
  date
ORDER BY
  client;  # Order results by client domain
