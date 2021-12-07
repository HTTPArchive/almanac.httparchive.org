#standardSQL
# Captcha usage
SELECT
  client,
  total_sites,
  sites_with_captcha,
  sites_with_captcha / total_sites AS perc_sites_with_captcha
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(DISTINCT url) AS sites_with_captcha
  FROM
    `httparchive.technologies.2021_07_01_*`
  WHERE
    app = "reCAPTCHA" OR app = "hCaptcha"
  GROUP BY
    client
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_sites
  FROM
    `httparchive.summary_pages.2021_07_01_*`
  GROUP BY
    client
)
USING (client)
