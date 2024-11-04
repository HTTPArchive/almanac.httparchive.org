#standardSQL
# Captcha usage analysis

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
  `httparchive.all.pages`,
  UNNEST(technologies) AS app  # Unnest the technologies array to get individual apps
WHERE
  date = '2024-06-01'
GROUP BY
  client,
  is_root_page,
  date
ORDER BY
  client;  # Order results by client domain
