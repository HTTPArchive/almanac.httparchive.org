#standardSQL

# Linking - fragment URLs (together with SPAs to navigate content)

SELECT
  app,
  ROUND(COUNTIF(CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), "$['seo-anchor-elements'].navigateHash") AS INT64)> 0) * 100 / SUM(COUNT(0)) OVER (), 2)  AS navigate_hash_occurence_percentage
FROM
  `httparchive.pages.2019_07_01_*`
JOIN
  `httparchive.technologies.2019_07_01_*`
USING (_TABLE_SUFFIX, url)
WHERE
  app IN ('React', 'Angular', 'Vue.js')
GROUP BY
  app
