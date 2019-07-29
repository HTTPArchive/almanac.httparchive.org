#standardSQL

-- counts the number of usage of FontFace API

WITH
  response_bodies AS (
    SELECT * FROM `httparchive.response_bodies.2019_07_01_desktop`
    UNION ALL
    SELECT * FROM `httparchive.response_bodies.2019_07_01_mobile`
  ),
  temp AS (
    SELECT
      ARRAY_LENGTH(REGEXP_EXTRACT_ALL(body, r"new FontFace\(")) AS fontface,
      ARRAY_LENGTH(REGEXP_EXTRACT_ALL(body, r"new FontFaceSetLoadEvent\(")) AS fontfacesetloadevent,
      url,
      page,
      body
    FROM response_bodies
    WHERE
      STRPOS(body, "FontFace") > 0 OR
      STRPOS(body, "FontFaceSet") > 0 OR
      STRPOS(body, "FontFaceSetLoadEvent") > 0
  ),
  processedTable AS (
    SELECT
      DISTINCT(page),
      SUM(fontface) AS fontface,
      SUM(fontfacesetloadevent) AS fontfacesetloadevent
    FROM temp
    GROUP BY page
  )
SELECT
  SUM(fontface) AS fontface,
  SUM(fontfacesetloadevent) as fontfacesetloadevent
FROM processedTable
