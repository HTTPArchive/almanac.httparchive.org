#standardSQL
# Section: Attack Preventions - Bot protection services
# Question: Which bot protection services are used most often on mobile and desktop sites?
# Notes: The Wappalyzer 'Security' category mostly contains bot protection services such as reCAPTCHA and Cloudflare Bot Management
# Issue: Due to some updates to wappalyzer the 'Security' category now also contains 'HSTS' (security header) and 'Really Simple SSL & Security' in significant numbers. Do we want to filter them out?
SELECT
  client,
  t.technology,
  COUNT(0) AS freq,
  total,
  COUNT(0) / total AS pct
FROM
  `httparchive.crawl.pages`,
  UNNEST(technologies) AS t,
  UNNEST(t.categories) AS category
JOIN (
  SELECT
    client,
    COUNT(0) AS total
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    is_root_page
  GROUP BY
    client
)
USING (client)
WHERE
  date = '2025-07-01' AND
  category = 'Security' AND
  is_root_page
GROUP BY
  client,
  total,
  t.technology
ORDER BY
  pct DESC
