WITH totals AS (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2022_06_01_*`
  GROUP BY
    _TABLE_SUFFIX
)

SELECT
  _TABLE_SUFFIX AS client,
  COUNT(DISTINCT url) AS pages,
  ANY_VALUE(total) AS total,
  COUNT(DISTINCT url) / ANY_VALUE(total) AS pct_pages
FROM
  `httparchive.pages.2022_06_01_*`,
  UNNEST(JSON_VALUE_ARRAY(JSON_VALUE(payload, '$._markup'), '$.anchors.hrefs_without_special_scheme')) AS href
JOIN
  totals
USING (_TABLE_SUFFIX)
WHERE
  REGEXP_CONTAINS(href, r'^[\'"]?javascript:\s*void\(0\);?[\'"]?$')
GROUP BY
  client
HAVING
  pages > 1000
ORDER BY
  pct_pages DESC
