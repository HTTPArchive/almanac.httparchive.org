#standardSQL
# 02_10: Top CSS libraries
SELECT
  _TABLE_SUFFIX AS client,
  app AS library,
  COUNT(0) AS freq,
  total,
  ROUND(COUNT(0) * 100 / total, 2) AS pct
FROM
  `httparchive.technologies.2019_07_01_*`
JOIN (
  SELECT _TABLE_SUFFIX, COUNT(0) AS total
  FROM `httparchive.summary_pages.2019_07_01_*`
  GROUP BY _TABLE_SUFFIX
)
USING (_TABLE_SUFFIX)
WHERE
  app IN (
    'animate.css', 'Ant Design', 'Bootstrap', 'Bulma', 'Clarity', 'ZURB Foundation',
    'Angular Material', 'Material Design Lite', 'Materialize CSS',
    'Milligram', 'Pure CSS', 'Semantic-ui', 'Shapecss', 'tailwindcss', 'UIKit'
  )
GROUP BY
  client,
  total,
  library
ORDER BY
  freq / total DESC
